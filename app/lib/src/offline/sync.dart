import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import 'local_db.dart';
import 'ops.dart';

/// Données hors connexion et synchronisation (section 8 du cahier des charges).
///
/// - Lecture : le serveur si possible (et la réponse est gardée), sinon la
///   dernière réponse gardée sur l'appareil.
/// - Écriture : envoyée tout de suite si possible, sinon mise en file
///   d'attente et affichée aussitôt ; la file part dans l'ordre au retour du
///   réseau. Chaque envoi porte une clé d'idempotence : une modification
///   rejouée après une coupure n'est appliquée qu'une fois.
class Sync extends ChangeNotifier {
  final Api api;
  final Database _db;

  final _cache = StoreRef<String, Object?>('cache');
  final _shifts = StoreRef<String, Map<String, Object?>>('shifts');
  final _queue = intMapStoreFactory.store('queue');

  Sync._(this.api, this._db);

  static Future<Sync> open(Api api) async {
    final sync = Sync._(api, await openLocalDb());
    await sync._loadQueue();
    sync._timer = Timer.periodic(const Duration(seconds: 20), (_) => sync._tick());
    return sync;
  }

  /// Le dernier échange avec le serveur a-t-il abouti ?
  bool online = true;

  /// Modifications pas encore envoyées, dans l'ordre (avec leur clé locale).
  final List<(int, PendingOp)> _pending = [];
  List<PendingOp> get queue => [for (final (_, op) in _pending) op];

  /// Dernière modification refusée par le serveur pendant la synchronisation.
  Localized? rejection;

  /// Augmente à chaque fois que des modifications en attente ont été
  /// envoyées : les écrans s'en servent pour se recharger.
  int synced = 0;

  Timer? _timer;
  bool _flushing = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadQueue() async {
    final records = await _queue.find(_db, finder: Finder(sortOrders: [SortOrder(Field.key)]));
    _pending
      ..clear()
      ..addAll([for (final r in records) (r.key, PendingOp.fromJson(r.value.cast()))]);
  }

  void _setOnline(bool value) {
    if (online == value) return;
    online = value;
    notifyListeners();
  }

  // --- Lecture --------------------------------------------------------------

  /// Lit [path] sur le serveur, ou la dernière réponse gardée sous [key].
  Future<dynamic> read(String key, String path) async {
    try {
      final json = await api.send('GET', path);
      await _cache.record(key).put(_db, json);
      _setOnline(true);
      unawaited(flush());
      return json;
    } on OfflineException {
      _setOnline(false);
      final cached = await _cache.record(key).get(_db);
      if (cached == null) rethrow;
      return cached;
    }
  }

  /// Services de la période, modifications en attente comprises. [stale] :
  /// le serveur n'a pas répondu, ce sont les dernières données gardées.
  Future<({List<Shift> shifts, int pending, bool stale})> shifts(
      String companyId, DateTime from, DateTime to) async {
    List<Shift> server;
    var serverPending = 0;
    var stale = false;
    final range = Filter.and([
      Filter.equals('companyId', companyId),
      Filter.greaterThanOrEquals('day', formatDay(from)),
      Filter.lessThanOrEquals('day', formatDay(to)),
    ]);
    try {
      final j = await api.send('GET', '/companies/$companyId/shifts?from=${formatDay(from)}&to=${formatDay(to)}');
      server = [for (final s in j['shifts']) Shift.fromJson(s)];
      serverPending = j['pending'] as int;
      await _db.transaction((tx) async {
        await _shifts.delete(tx, finder: Finder(filter: range));
        for (final s in server) {
          await _shifts.record(s.id).put(tx, {...s.toJson(), 'companyId': companyId});
        }
        await _cache.record('pending:$companyId').put(tx, serverPending);
      });
      _setOnline(true);
      unawaited(flush());
    } on OfflineException {
      _setOnline(false);
      stale = true;
      final records = await _shifts.find(_db, finder: Finder(filter: range));
      server = [for (final r in records) Shift.fromJson(r.value.cast())];
      serverPending = (await _cache.record('pending:$companyId').get(_db) as int?) ?? 0;
    }
    final ops = [for (final op in queue) if (op.companyId == companyId) op];
    final lastPublish = ops.lastIndexWhere((op) => op.kind == 'publish');
    final queuedChanges = ops.skip(lastPublish + 1).where((op) => op.kind != 'publish').length;
    return (
      shifts: [
        for (final s in overlay(server, ops))
          if (!s.day.isBefore(from) && !s.day.isAfter(to)) s,
      ],
      pending: (lastPublish >= 0 ? 0 : serverPending) + queuedChanges,
      stale: stale,
    );
  }

  // --- Écriture -------------------------------------------------------------

  /// Envoie une modification du planning. Renvoie la réponse du serveur, ou
  /// `null` si elle a été mise en attente (pas de réseau). Une modification
  /// refusée par le serveur lève [ApiException].
  Future<dynamic> submit(String companyId, String kind, String method, String path,
      {Map<String, dynamic>? body, Map<String, dynamic> args = const {}}) async {
    final op = PendingOp(
      id: const Uuid().v4(),
      companyId: companyId,
      kind: kind,
      method: method,
      path: path,
      body: body,
      args: args,
      createdAt: DateTime.now(),
    );
    if (_pending.isEmpty && online) {
      try {
        final result = await api.send(method, path, body: body, idempotencyKey: op.id);
        _setOnline(true);
        return result;
      } on OfflineException {
        _setOnline(false);
      }
    }
    final key = await _queue.add(_db, op.toJson());
    _pending.add((key, op));
    notifyListeners();
    unawaited(flush());
    return null;
  }

  Future<dynamic> createShifts(String companyId, Map<String, dynamic> body) =>
      submit(companyId, 'create', 'POST', '/companies/$companyId/shifts', body: body);

  Future<dynamic> updateShift(String companyId, Shift shift, Map<String, dynamic> patch, {bool series = false}) =>
      submit(companyId, 'update', 'PATCH', '/companies/$companyId/shifts/${shift.id}?scope=${series ? 'series' : 'one'}',
          body: {...patch, 'baseVersion': shift.version}, args: {'shiftId': shift.id, 'series': series});

  Future<dynamic> deleteShift(String companyId, Shift shift, {bool series = false}) => submit(
      companyId,
      'delete',
      'DELETE',
      '/companies/$companyId/shifts/${shift.id}?scope=${series ? 'series' : 'one'}&baseVersion=${shift.version}',
      args: {'shiftId': shift.id, 'series': series});

  Future<dynamic> publish(String companyId) => submit(companyId, 'publish', 'POST', '/companies/$companyId/publish');

  Future<dynamic> replace(String companyId, Map<String, dynamic> body) =>
      submit(companyId, 'replace', 'POST', '/companies/$companyId/shifts/replace', body: body);

  // --- Synchronisation ------------------------------------------------------

  /// Envoie les modifications en attente, dans l'ordre. S'arrête au premier
  /// échec réseau ; une modification refusée par le serveur est retirée et
  /// sa raison gardée dans [rejection].
  Future<void> flush() async {
    if (_flushing || _pending.isEmpty) return;
    _flushing = true;
    var sent = false;
    try {
      while (_pending.isNotEmpty) {
        final (key, op) = _pending.first;
        try {
          await api.send(op.method, op.path, body: op.body, idempotencyKey: op.id);
          _setOnline(true);
        } on OfflineException {
          _setOnline(false);
          break;
        } on ApiException catch (e) {
          rejection = e.describe;
        }
        await _queue.record(key).delete(_db);
        _pending.removeAt(0);
        sent = true;
      }
    } finally {
      _flushing = false;
      if (sent) synced++;
      notifyListeners();
    }
  }

  Future<void> _tick() async {
    if (online && _pending.isEmpty) return;
    if (await api.ping()) {
      _setOnline(true);
      await flush();
    }
  }

  /// Synchroniser tout de suite (bouton de l'indicateur).
  Future<void> syncNow() async {
    if (await api.ping()) {
      _setOnline(true);
      await flush();
      synced++;
    } else {
      _setOnline(false);
    }
    notifyListeners();
  }

  /// Le planning a changé sur le serveur (par exemple une annulation) : les
  /// écrans se rechargent.
  void markChanged() {
    synced++;
    notifyListeners();
  }

  void clearRejection() {
    rejection = null;
    notifyListeners();
  }

  /// À la déconnexion : rien ne doit rester sur l'appareil.
  Future<void> clear() async {
    await _cache.drop(_db);
    await _shifts.drop(_db);
    await _queue.drop(_db);
    _pending.clear();
    notifyListeners();
  }
}
