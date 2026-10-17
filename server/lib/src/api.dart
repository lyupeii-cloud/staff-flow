import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'account_service.dart';
import 'api_access.dart';
import 'api_log_service.dart';
import 'auth.dart';
import 'billing_service.dart';
import 'company_service.dart';
import 'errors.dart';
import 'google_switch.dart';
import 'join_service.dart';
import 'messages.dart';
import 'import_service.dart';
import 'mcp.dart';
import 'monitor_service.dart';
import 'news_service.dart';
import 'rate_limit.dart';
import 'webhook_service.dart';
import 'notice_service.dart';
import 'notifications.dart';
import 'overlap_service.dart';
import 'models.dart';
import 'planning_service.dart';
import 'platform_service.dart';
import 'request_service.dart';
import 'store.dart';
import 'telegram.dart';
import 'telegram_login.dart';
import 'tools_service.dart';
import 'totp_service.dart';
import 'translator.dart';

/// Construit le gestionnaire HTTP de l'API, sous `/api/v1`.
class Api {
  final Store store;
  final GoogleVerifier google;
  final SessionTokens tokens;
  final CompanyService companies;
  late final NotificationService notifications = NotificationService(store, push: push);
  late final PlanningService planning = PlanningService(store, companies, notifications, now: now)
    ..cascadeAllowed = ((c) => billing.cascadeAllowed(c));
  late final NewsService news = NewsService(store, companies, notifications);
  late final ToolsService tools = ToolsService(store, companies, tokens.derive('exports'));
  late final OverlapService overlaps = OverlapService(store, companies, notifications, now: now);
  late final RequestService requests =
      RequestService(store, companies, planning, notifications, overlaps: overlaps);
  late final JoinService joins = JoinService(store, companies, now: now);
  late final TotpService totp = TotpService(store, companies, notifications, tokens.derive('totp'), now: now);
  late final ImportService imports = ImportService(store, companies, tokens.derive('invites'), now: now, appUrl: appUrl);
  late final NoticeService notices = NoticeService(store, now: now);
  late final PlatformService platform = PlatformService(store, fileValues: platformFile);
  late final TelegramService telegram = TelegramService(store, telegramApi, now: now)
    ..interceptor = (chatId, lang, {text, button}) async =>
        await telegramLogin.onTelegram(chatId, lang, text: text) ||
        await googleSwitch.onTelegram(chatId, lang, text: text, button: button);
  late final TelegramLoginService telegramLogin = TelegramLoginService(store, telegram, now: now, appUrl: appUrl);
  late final GoogleSwitchService googleSwitch = GoogleSwitchService(store, companies, telegram, notifications, now: now);
  late final AccountService accounts = AccountService(store, telegram, tokens.derive('account-export'), now: now, notifications: notifications);
  late final ApiAccessService apiAccess = ApiAccessService(store, companies, tools, now: now);
  late final BillingService billing = BillingService(store, companies, platform, notifications, tokens.derive('invoices'),
      now: now, isAdmin: _isAdmin, testPaymentsForAll: testPaymentsForAll);

  /// Paiement fictif ouvert à tous les propriétaires (tests ; sinon réservé
  /// aux administrateurs).
  final bool testPaymentsForAll;

  /// Webhooks : client HTTP remplaçable ; en test, adresses locales permises
  /// et envois lancés à la main.
  late final WebhookService webhooks = WebhookService(store, apiAccess, tokens.derive('webhooks'),
      client: webhookClient, now: now, allowPrivate: webhookClient != null, autoDeliver: webhookClient == null);
  final http.Client? webhookClient;

  /// Débits : clés API, entreprises, connexions, webhooks.
  late final RateLimiter limiter = RateLimiter(now: now);

  /// Journaux des clés API (appels et webhooks).
  late final ApiLogService apiLogs =
      ApiLogService(store, apiAccess, notifications, platform, tokens.derive('api-logs'), now: now);

  /// Adresses Google des administrateurs de la plateforme (fichier de
  /// configuration du serveur ; jamais modifiables depuis le web).
  final Set<String> adminEmails;

  /// Réglages lus au démarrage dans le fichier `PLATFORM_CONFIG`.
  final Map<String, int>? platformFile;

  /// Dossier des sauvegardes vu par l'API (contrôle de leur fraîcheur).
  final String? backupDir;

  /// Alertes aux administrateurs : erreurs, disque, sauvegardes.
  late final MonitorService monitor = MonitorService(store, telegram, adminEmails, now: now, backupDir: backupDir);

  /// Horloge (UTC), remplaçable dans les tests.
  final DateTime Function() now;

  /// Connexion sans Google (`POST /auth/dev`), pour le développement local
  /// uniquement. Ne jamais l'activer en production.
  final bool devLogin;
  final Set<String> allowedOrigins;

  /// Envoi des notifications (Firebase) ; `null` : avis dans l'application seulement.
  final PushSender? push;

  /// Traduction des messages (LibreTranslate) ; `null` : pas de traduction.
  final Translator? translator;

  /// Bot Telegram ; `null` : Telegram désactivé.
  final TelegramApi? telegramApi;

  /// Adresse de l'application web (liens envoyés par le bot).
  final String appUrl;

  Api({
    required this.store,
    required this.google,
    required this.tokens,
    this.devLogin = false,
    this.allowedOrigins = const {},
    this.push,
    this.translator,
    this.telegramApi,
    this.appUrl = 'https://app.staff-flow.cloud',
    this.adminEmails = const {},
    this.platformFile,
    this.backupDir,
    this.testPaymentsForAll = false,
    this.webhookClient,
    DateTime Function()? now,
  })  : companies = CompanyService(store),
        now = now ?? (() => DateTime.now().toUtc()) {
    store.onAudit = (s, c, action, details) => webhooks.onAudit(s, c, action, details);
    webhooks.allowSend = (c) async =>
        limiter.hit('wh:$c', await platform.value('webhooksPerHour'), const Duration(hours: 1)).ok;
    webhooks.onSent = (companyId, event, url, status, error, took) => apiLogs.record(
        companyId: companyId,
        source: 'webhook',
        kind: 'webhook',
        method: 'POST',
        path: url,
        action: 'webhook.$event',
        details: {'event': event, 'url': url},
        status: status ?? 0,
        errorText: error,
        took: took);
  }

  Handler get handler {
    final v1 = Router(notFoundHandler: _notFound)
      ..post('/auth/google', _loginGoogle)
      ..post('/auth/telegram', (Request r) async => _session(await telegramLogin.redeem(_string(await _body(r), 'token'))))
      // Comptes sans Google : activation par le code de l'employeur, puis application 2FA.
      ..post('/auth/activate', (Request r) async => _json(await totp.start(_string(await _body(r), 'code'), _clientIp(r))))
      ..post('/auth/signup', (Request r) async => _json(await totp.signupStart(_string(await _body(r), 'name'), _clientIp(r))))
      ..post('/auth/activate/confirm', (Request r) async {
        final body = await _body(r);
        final (user, backup) = await totp.confirm(_string(body, 'pending'), _string(body, 'otp'), _clientIp(r));
        await store.audit(actorId: user.id, action: 'auth.login');
        return _json({'token': tokens.issue(user.id, version: user.sessionVersion), 'user': user.toJson(), 'backupCodes': backup});
      })
      ..post('/auth/identify',
          (Request r) async => _json({'next': await totp.identify(_string(await _body(r), 'login'))}))
      ..post('/auth/totp', (Request r) async {
        final body = await _body(r);
        final company = body['company'];
        if (company is! String?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        return _session(await totp.login(_string(body, 'login'), company, _string(body, 'otp'), _clientIp(r)));
      })
      // Jeton renouvelé (connexion gardée sur l'appareil).
      ..post('/auth/refresh', _authed((r, u) async => _json({'token': tokens.issue(u.id, version: u.sessionVersion)})))
      ..post('/me/link-google', _authed((r, u) async => _json({'switchToken': await googleSwitch.selfLink(u)})))
      ..post('/me/totp', _authed((r, u) async => _json(await totp.enableStart(u))))
      ..post('/me/totp/confirm', _authed((r, u) async {
        final body = await _body(r);
        return _json({'backupCodes': await totp.enableConfirm(u, _string(body, 'pending'), _string(body, 'otp'))});
      }))
      ..delete('/me/totp', _authed((r, u) async {
        await totp.disable(u);
        return Response(204);
      }))
      ..post('/companies/<id>/members/<userId>/activation-code', _authed((r, u) async {
        final (code, link) = await totp.reactivation(u, r.params['id']!, r.params['userId']!, appUrl);
        return _json({'code': code, 'link': link});
      }))
      ..get('/me', _authed(_me))
      // Administration de la plateforme (réservée aux administrateurs).
      ..get('/admin/overview', _admin((r, u) async => _json({...await platform.overview(), 'billing': await billing.stats()})))
      ..get('/admin/settings', _admin((r, u) async => _json({'settings': await platform.list()})))
      ..put('/admin/settings/<key>', _admin((r, u) async {
        final value = (await _body(r))['value'];
        if (value is! int) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await platform.set(u, r.params['key']!, value);
        return Response(204);
      }))
      ..delete('/admin/settings/<key>', _admin((r, u) async {
        await platform.set(u, r.params['key']!, null);
        return Response(204);
      }))
      ..get('/admin/log', _admin((r, u) async => _json({'entries': await platform.log()})))
      ..get('/admin/texts', _admin((r, u) async => _json({'texts': await platform.texts()})))
      ..put('/admin/texts/<key>', _admin((r, u) async {
        final value = (await _body(r))['value'];
        if (value is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await platform.setText(u, r.params['key']!, value);
        return Response(204);
      }))
      ..get('/admin/invoices', _admin((r, u) async =>
          _json({'invoices': await billing.adminInvoices(r.url.queryParameters['code'] ?? '')})))
      ..get('/admin/invoices/<invoiceId>/link', _admin((r, u) async {
        final id = int.tryParse(r.params['invoiceId']!);
        if (id == null) throw const ApiError.notFound();
        return _json({'path': '/api/v1/invoices/${billing.adminInvoiceLink(u, id, _lang(r))}'});
      }))
      ..get('/admin/companies', _admin((r, u) async => _json({'companies': await billing.adminCompanies()})))
      ..delete('/admin/companies/<id>', _admin((r, u) async {
        final confirm = (await _body(r))['confirm'];
        if (confirm is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await billing.adminDelete(u, r.params['id']!, confirm);
        return Response(204);
      }))
      ..put('/admin/companies/<id>/comped', _admin((r, u) async {
        final comped = (await _body(r))['comped'];
        if (comped is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await billing.setComped(u, r.params['id']!, comped);
        return Response(204);
      }))
      // Abonnement et factures (propriétaire de l'entreprise).
      ..get('/companies/<id>/billing', _authed((r, u) async {
        final slots = r.url.queryParameters['slots'];
        return _json(await billing.summary(u, r.params['id']!, slots: slots == null ? null : int.tryParse(slots) ?? -1));
      }))
      ..put('/companies/<id>/billing/renewal', _authed((r, u) async {
        final body = await _body(r);
        final option = body['option'], renew = body['renew'];
        if (option is! String || renew is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await billing.setRenewal(u, r.params['id']!, option, renew);
        return Response(204);
      }))
      ..post('/companies/<id>/billing/addon', _authed((r, u) async {
        final body = await _body(r);
        final option = body['option'], slots = body['slots'];
        if (option is! String || slots is! int?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        return _json(await billing.buyAddon(u, r.params['id']!, option, slots: slots));
      }))
      ..put('/companies/<id>/members/<userId>/billing', _authed((r, u) async {
        final enabled = (await _body(r))['enabled'];
        if (enabled is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await billing.setBillingAccess(u, r.params['id']!, r.params['userId']!, enabled);
        return Response(204);
      }))
      ..post('/companies/<id>/billing/checkout', _authed((r, u) async {
        final body = await _body(r);
        if (body['period'] is! String || body['cascade'] is! bool) {
          throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        }
        if (body['api'] != null && body['api'] is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        return _json(await billing.checkout(u, r.params['id']!,
            period: body['period'] as String,
            cascade: body['cascade'] as bool,
            api: body['api'] as bool?,
            slots: body['slots'] is int ? body['slots'] as int : null));
      }))
      ..get('/companies/<id>/invoices/<invoiceId>/link', _authed((r, u) async {
        final id = int.tryParse(r.params['invoiceId']!);
        if (id == null) throw const ApiError.notFound();
        return _json({'path': '/api/v1/invoices/${await billing.invoiceLink(u, r.params['id']!, id, _lang(r))}'});
      }))
      ..get('/companies/<id>/invoices-zip/link', _authed((r, u) async =>
          _json({'path': '/api/v1/invoice-zips/${await billing.zipLink(u, r.params['id']!, _lang(r))}'})))
      ..get('/me/invoices', _authed((r, u) async => _json({'invoices': await billing.archivedInvoices(u)})))
      ..get('/me/invoices-zip/link', _authed((r, u) async =>
          _json({'path': '/api/v1/invoice-zips/${await billing.zipLink(u, null, _lang(r))}'})))
      ..get('/me/invoices/<invoiceId>/link', _authed((r, u) async {
        final id = int.tryParse(r.params['invoiceId']!);
        if (id == null) throw const ApiError.notFound();
        return _json({'path': '/api/v1/invoices/${await billing.archivedInvoiceLink(u, id, _lang(r))}'});
      }))
      ..get('/invoice-zips/<token>', (Request r) async {
        final (name, bytes) = await billing.invoiceZip(r.params['token']!);
        return Response.ok(bytes, headers: {
          'content-type': 'application/zip',
          'content-disposition': 'attachment; filename="$name"',
          'cache-control': 'no-store',
        });
      })
      // Compte : export, suppression, QR code, Telegram, reprise.
      ..get('/me/export/link', _authed((r, u) async =>
          _json({'path': '/api/v1/account-exports/${accounts.exportLink(u)}'})))
      ..get('/account-exports/<token>', (Request r) async {
        final (name, bytes) = await accounts.exportFile(r.params['token']!);
        return Response.ok(bytes, headers: {
          'content-type': 'application/json; charset=utf-8',
          'content-disposition': 'attachment; filename="$name"',
          'cache-control': 'no-store',
        });
      })
      ..post('/me/delete', _authed((r, u) async {
        final erase = (await _body(r))['erase'];
        if (erase is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await accounts.delete(u, erase: erase);
        return Response(204);
      }))
      ..post('/companies/<id>/members/<userId>/google-link', _authed((r, u) async =>
          _json({'path': await googleSwitch.createLink(u, r.params['id']!, r.params['userId']!)})))
      ..post('/me/qr', _authed((r, u) async => _json((await accounts.newQrCode(u)).toJson())))
      ..put('/me/avatar', _authed((r, u) async => _json((await accounts.setAvatar(u, (await _body(r))['avatar'])).toJson())))
      ..put('/companies/<id>/photos', _authed((r, u) async {
        final hidden = (await _body(r))['hidden'];
        if (hidden is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await accounts.hidePhotos(u, r.params['id']!, hidden);
        return Response(204);
      }))
      // Clés API (propriétaire) et lecture par les logiciels de l'entreprise.
      ..get('/companies/<id>/api-keys', _authed((r, u) async {
        final keys = await apiAccess.list(u, r.params['id']!);
        final stats = await apiLogs.keyStats(await apiAccess.owned(u, r.params['id']!));
        return _json({
          'keys': [for (final k in keys) {...k, 'stats': stats[k['id']] ?? {'today': 0, 'month': 0}}]
        });
      }))
      ..get('/companies/<id>/api-logs/months', _authed((r, u) async => _json({'months': await apiLogs.months(u, r.params['id']!)})))
      ..get('/companies/<id>/api-logs', _authed((r, u) async {
        final q = r.url.queryParameters;
        final before = q['before'] == null ? null : int.tryParse(q['before']!);
        return _json(await apiLogs.list(u, r.params['id']!,
            month: q['month'],
            q: q['q'],
            keyId: q['key'],
            source: q['source'],
            kind: q['kind'],
            result: q['result'],
            before: before,
            lang: _lang(r)));
      }))
      ..post('/companies/<id>/api-logs/export', _authed((r, u) async {
        final year = (await _body(r))['year'];
        if (year is! int) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        return _json({'path': '/api/v1/api-log-exports/${await apiLogs.exportLink(u, r.params['id']!, year, _lang(r))}'});
      }))
      ..get('/api-log-exports/<token>', (Request r) async {
        final (name, bytes) = await apiLogs.export(r.params['token']!);
        return Response.ok(bytes, headers: {
          'content-type': 'application/zip',
          'content-disposition': 'attachment; filename="$name"',
          'cache-control': 'no-store',
        });
      })
      ..post('/companies/<id>/api-keys', _authed((r, u) async {
        final body = await _body(r);
        final scopes = body['scopes'];
        if (scopes != null && (scopes is! List || scopes.any((s) => s is! String))) {
          throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        }
        return _json(
            await apiAccess.create(u, r.params['id']!, _string(body, 'name'),
                scopes: scopes == null ? const ['read'] : (scopes as List).cast<String>()),
            status: 201);
      }))
      ..patch('/companies/<id>/api-keys/<keyId>', _authed((r, u) async {
        final body = await _body(r);
        final name = body['name'], scopes = body['scopes'];
        if (name is! String? || (scopes != null && (scopes is! List || scopes.any((s) => s is! String)))) {
          throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        }
        return _json(await apiAccess.update(u, r.params['id']!, r.params['keyId']!,
            name: name, scopes: (scopes as List?)?.cast<String>()));
      }))
      ..delete('/companies/<id>/api-keys/<keyId>', _authed((r, u) async {
        await apiAccess.revoke(u, r.params['id']!, r.params['keyId']!);
        return Response(204);
      }))
      // Webhooks (option « API Pro ») : patron et responsables qui gèrent l'abonnement.
      ..get('/companies/<id>/webhooks', _authed((r, u) async => _json({
            'webhooks': await webhooks.list(u, r.params['id']!),
            'events': WebhookService.events,
          })))
      ..post('/companies/<id>/webhooks', _authed((r, u) async {
        final body = await _body(r);
        return _json(await webhooks.create(u, r.params['id']!, body['url'], body['events']), status: 201);
      }))
      ..patch('/companies/<id>/webhooks/<hookId>', _authed((r, u) async {
        await webhooks.update(u, r.params['id']!, r.params['hookId']!, await _body(r));
        return Response(204);
      }))
      ..delete('/companies/<id>/webhooks/<hookId>', _authed((r, u) async {
        await webhooks.delete(u, r.params['id']!, r.params['hookId']!);
        return Response(204);
      }))
      ..post('/companies/<id>/webhooks/<hookId>/test',
          _authed((r, u) async => _json(await webhooks.test(u, r.params['id']!, r.params['hookId']!))))
      ..get('/ext/company', _apiKey((r, c) async => apiAccess.company(c)))
      ..get('/ext/members', _apiKey((r, c) async => apiAccess.members(c)))
      ..get('/ext/shifts', _apiKey((r, c) async {
        final (from, to) = apiAccess.period(c, r.url.queryParameters);
        return apiAccess.shifts(c, from, to);
      }))
      ..get('/ext/totals', _apiKey((r, c) async {
        final (from, to) = apiAccess.period(c, r.url.queryParameters);
        return apiAccess.totals(c, from, to);
      }))
      // --- API Pro : écriture -------------------------------------------------
      ..post('/ext/shifts', _apiWrite('shifts', (r, k, u) async {
        final body = await _body(r);
        final list = body['shifts'];
        if (list is! List || list.isEmpty || list.length > 2000 || list.any((s) => s is! Map)) {
          throw const ApiError.badRequest('Champ « shifts » : liste de services attendue (2000 au plus).');
        }
        final publish = body['publish'] == true;
        ApiLog.note(r, 'shifts.create', {
          'publish': publish,
          'count': list.length,
          // Ce qui a été demandé (utile si l'envoi est refusé).
          'input': [
            for (final s in list.take(50).cast<Map>())
              [s['person'], s['day'], '${s['start'] ?? ''}–${s['end'] ?? ''}'].whereType<String>().join(' · ')
          ],
        });
        if (publish && !k.scopes.contains('publish')) {
          throw const ApiError(403, 'scope_missing', 'Cette clé n\'a pas le droit « {scope} ».', {'scope': 'publish'});
        }
        final c = k.company.id;
        final created = <String>[];
        await _input(() async {
          for (final raw in list.cast<Map>()) {
            final s = raw.cast<String, dynamic>();
            final shifts = await planning.create(
                u,
                c,
                ShiftInput(
                  start: _minutes(s['start']),
                  end: _minutes(s['end']),
                  userId: await apiAccess.person(c, s['person']),
                  siteId: await apiAccess.catalogItem(c, 'sites', s['site']),
                  positionId: await apiAccess.catalogItem(c, 'positions', s['position']),
                  note: s['note'] as String?,
                ),
                days: [parseDay(_string(s, 'day'))]);
            created.addAll(shifts.map((x) => x.id));
          }
        });
        // Brouillon par défaut : les responsables l'adaptent puis publient.
        final published = publish ? (await planning.publish(u, c)).$1 : 0;
        ApiLog.of(r)?.details['shifts'] = [for (final id in created.take(50)) await apiAccess.shiftView(c, id)];
        return {'created': created, 'published': published, 'status': publish ? 'published' : 'draft'};
      }))
      ..patch('/ext/shifts/<shiftId>', _apiWrite('shifts', (r, k, u) async {
        final s = await _body(r);
        final c = k.company.id;
        final fields = <String, dynamic>{
          if (s.containsKey('day')) 'day': _string(s, 'day'),
          if (s.containsKey('start')) 'start': _minutes(s['start']),
          if (s.containsKey('end')) 'end': _minutes(s['end']),
          if (s.containsKey('person')) 'userId': await apiAccess.person(c, s['person']),
          if (s.containsKey('site')) 'siteId': await apiAccess.catalogItem(c, 'sites', s['site']),
          if (s.containsKey('position')) 'positionId': await apiAccess.catalogItem(c, 'positions', s['position']),
          if (s.containsKey('note')) 'note': s['note'],
        };
        final before = await apiAccess.shiftView(c, r.params['shiftId']!);
        ApiLog.note(r, 'shift.update', {'id': r.params['shiftId'], 'before': before});
        await _input(() => planning.update(u, c, r.params['shiftId']!, ShiftPatch(fields), scope: Scope.one));
        final after = await apiAccess.shiftView(c, r.params['shiftId']!);
        // Le service, puis seulement ce qui a changé.
        ApiLog.note(r, 'shift.update', {
          'shift': after,
          'before': {for (final e in (before ?? const {}).entries) if (after?[e.key] != e.value) e.key: e.value},
          'after': {for (final e in (after ?? const {}).entries) if (before?[e.key] != e.value) e.key: e.value},
        });
        return {'id': r.params['shiftId'], 'status': 'draft'};
      }))
      ..delete('/ext/shifts/<shiftId>', _apiWrite('shifts', (r, k, u) async {
        ApiLog.note(r, 'shift.delete',
            {'id': r.params['shiftId'], 'before': await apiAccess.shiftView(k.company.id, r.params['shiftId']!)});
        await planning.delete(u, k.company.id, r.params['shiftId']!, scope: Scope.one);
        return {'deleted': r.params['shiftId']};
      }))
      ..post('/ext/publish', _apiWrite('publish', (r, k, u) async {
        final published = (await planning.publish(u, k.company.id)).$1;
        ApiLog.note(r, 'schedule.publish', {'published': published});
        return {'published': published};
      }))
      ..post('/ext/members/import', _apiWrite('members', (r, k, u) async {
        final body = await _body(r);
        final rows = body['rows'];
        if (rows is! List || rows.isEmpty || rows.any((x) => x is! Map)) {
          throw const ApiError.badRequest('Champ « rows » : liste de salariés attendue.');
        }
        ApiLog.note(r, 'members.import', {
          'dryRun': body['dryRun'] == true,
          'count': rows.length,
          'people': [for (final x in rows.take(50)) [x['name'], x['number']].whereType<String>().join(' · ')],
        });
        final table = [
          ['Nom', 'Matricule', 'Poste', 'Site'],
          for (final x in rows.cast<Map>())
            [for (final f in ['name', 'number', 'position', 'site']) '${x[f] ?? ''}'],
        ];
        final result = await imports.run(u, k.company.id, table, dryRun: body['dryRun'] == true, lang: _lang(r));
        return {...result, 'invites': await imports.list(u, k.company.id)};
      }))
      ..get('/ext/invites', _apiWrite('members', (r, k, u) async {
        final list = await imports.list(u, k.company.id);
        ApiLog.note(r, 'read.invites', {'count': list.length});
        return list;
      }))
      ..put('/ext/members/<ref>/profile', _apiWrite('members', (r, k, u) async {
        final body = await _body(r);
        final c = k.company.id;
        final userId = (await apiAccess.person(c, r.params['ref']))!;
        Future<Map<String, Object?>> profile() async {
          final p = await store.query(store.db, '''
            SELECT m.employee_number, p.name FROM memberships m LEFT JOIN positions p ON p.id = m.position_id
            WHERE m.company_id = @c::uuid AND m.user_id::text = @u AND m.left_at IS NULL''', {'c': c, 'u': userId});
          return p.isEmpty ? {} : {'employeeNumber': p.first[0], 'position': p.first[1]};
        }

        final before = await profile();
        ApiLog.note(r, 'member.profile', {'person': await apiAccess.personLabel(c, userId), 'before': before});
        await companies.setMemberProfile(u, c, userId,
            employeeNumber: body['employeeNumber'] as String?,
            positionId: await apiAccess.catalogItem(c, 'positions', body['position'], create: true));
        ApiLog.of(r)?.details['after'] = await profile();
        return {'person': r.params['ref']};
      }))
      ..post('/ext/positions', _apiWrite('catalog', (r, k, u) async {
        final name = _string(await _body(r), 'name');
        ApiLog.note(r, 'position.create', {'name': name});
        return (await planning.addCatalogItem(u, k.company.id, CatalogKind.positions, name)).toJson();
      }))
      ..post('/ext/sites', _apiWrite('catalog', (r, k, u) async {
        final body = await _body(r);
        ApiLog.note(r, 'site.create', {'name': body['name'], if (body['parent'] != null) 'parent': body['parent']});
        final parent = await apiAccess.catalogItem(k.company.id, 'sites', body['parent']);
        return (await planning.addCatalogItem(u, k.company.id, CatalogKind.sites, _string(body, 'name'), parentId: parent))
            .toJson();
      }))
      ..post('/ext/news', _apiWrite('news', (r, k, u) async {
        final body = await _body(r);
        final audience = body['audience'] ?? {'everyone': true};
        ApiLog.note(r, 'announcement.publish', {'title': body['title'], 'audience': audience});
        if (body['title'] is! String? || audience is! Map) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        return news.publish(u, k.company.id,
            title: body['title'] as String?, body: _string(body, 'body'), audience: audience.cast<String, dynamic>());
      }))
      ..get('/ext/requests', _apiWrite('requests', (r, k, u) async {
        final list = await requests.pending(u, k.company.id);
        ApiLog.note(r, 'read.requests', {'count': list.length});
        return list;
      }))
      ..post('/ext/requests/<requestId>/<decision>', _apiWrite('requests', (r, k, u) async {
        final decision = r.params['decision'];
        if (decision != 'approve' && decision != 'refuse') throw const ApiError.notFound();
        final mine = await store.query(store.db, '''
          SELECT requester_id::text, kind, start_day, end_day FROM requests WHERE id::text = @i AND company_id = @c::uuid''',
            {'i': r.params['requestId'], 'c': k.company.id});
        ApiLog.note(r, 'request.$decision', {
          'id': r.params['requestId'],
          if (mine.isNotEmpty) ...{
            'person': await apiAccess.personLabel(k.company.id, mine.first[0] as String?),
            'kind': mine.first[1],
            if (mine.first[2] != null) 'from': formatDay(mine.first[2] as DateTime),
            if (mine.first[3] != null) 'to': formatDay(mine.first[3] as DateTime),
          },
        });
        if (mine.isEmpty) throw const ApiError.notFound('Demande introuvable.');
        return requests.decide(u, r.params['requestId']!, approve: decision == 'approve');
      }))
      ..get('/ext/absences', _apiKey((r, c) async {
        final (from, to) = apiAccess.period(c, r.url.queryParameters);
        return apiAccess.absences(c, from, to);
      }))
      ..post('/me/telegram/link', _authed((r, u) async => _json({'url': await telegram.linkUrl(u)})))
      ..delete('/me/telegram', _authed((r, u) async {
        await telegram.unlink(u);
        return Response(204);
      }))
      ..put('/companies/<id>/telegram', _authed((r, u) async {
        final show = (await _body(r))['show'];
        if (show is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await accounts.showTelegram(u, r.params['id']!, show);
        return Response(204);
      }))
      ..post('/me/recover', _authed((r, u) async =>
          _json(await accounts.recoverStart(u, _string(await _body(r), 'publicId')))))
      ..post('/me/recover/confirm', _authed((r, u) async =>
          _session(await accounts.recoverConfirm(u, _string(await _body(r), 'code')))))
      ..get('/invoices/<token>', (Request r) async {
        final (name, bytes) = await billing.invoicePdf(r.params['token']!);
        return Response.ok(bytes, headers: {
          'content-type': 'application/pdf',
          'content-disposition': 'attachment; filename="$name"',
          'cache-control': 'no-store',
        });
      })
      ..get('/admin/quote', _admin((r, u) async {
        final staff = int.tryParse(r.url.queryParameters['staff'] ?? '');
        if (staff == null || staff < 0 || staff > 1000000) {
          throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        }
        return _json(await platform.quote(staff, cascade: r.url.queryParameters['cascade'] == '1'));
      }))
      ..patch('/me', _authed(_updateMe))
      ..post('/companies', _authed(_createCompany))
      ..get('/companies/<id>', _authed(_getCompany))
      ..patch('/companies/<id>', _authed(_updateCompany))
      ..get('/companies/<id>/members', _authed(_members))
      ..put('/companies/<id>/members/<userId>/role', _authed(_setRole))
      ..put('/companies/<id>/members/<userId>/name', _authed(_renameMember))
      ..put('/companies/<id>/members/<userId>/sites', _authed(_setMemberSites))
      ..put('/companies/<id>/members/<userId>/profile', _authed(_setMemberProfile))
      // Importation de salariés et invitations personnelles.
      ..get('/import-template', (Request r) {
        final lang = r.url.queryParameters['lang'] ?? negotiateLanguage(r.headers['accept-language']);
        return Response.ok(imports.template(supportedLanguages.contains(lang) ? lang : 'en'), headers: {
          'content-type': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          'content-disposition': 'attachment; filename="staff-flow-import.xlsx"',
        });
      })
      ..post('/companies/<id>/imports', _authed((r, u) async {
        final body = await _body(r);
        final file = body['file'], name = body['fileName'], dryRun = body['dryRun'];
        if (file is! String || name is! String || dryRun is! bool) {
          throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        }
        final List<int> bytes;
        try {
          bytes = base64Decode(file);
        } on FormatException {
          throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        }
        return _json(await imports.run(u, r.params['id']!, ImportService.readFile(bytes, name),
            dryRun: dryRun, lang: _lang(r)));
      }))
      ..get('/companies/<id>/invites', _authed((r, u) async => _json({'invites': await imports.list(u, r.params['id']!)})))
      ..delete('/companies/<id>/invites/<inviteId>', _authed((r, u) async {
        await imports.delete(u, r.params['id']!, r.params['inviteId']!);
        return Response(204);
      }))
      ..post('/companies/<id>/invites/sheet-link',
          _authed((r, u) async => _json({'path': await imports.sheetLink(u, r.params['id']!, _lang(r))})))
      ..get('/invite-sheets/<token>', (Request r) async => Response.ok(await imports.sheet(r.params['token']!),
          headers: {'content-type': 'text/html; charset=utf-8', 'cache-control': 'no-store'}))
      ..post('/invites/redeem', _authed((r, u) async {
        final code = (await _body(r))['code'];
        if (code is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        final (companyId, name) = await imports.redeem(u, code);
        return _json({'companyId': companyId, 'companyName': name});
      }))
      ..delete('/companies/<id>/members/<userId>', _authed(_removeMember))
      ..post('/companies/<id>/transfer', _authed(_proposeTransfer))
      ..delete('/companies/<id>/transfer', _authed(_cancelTransfer))
      ..post('/transfers/<id>/accept', _authed((r, u) => _answerTransfer(r, u, accept: true)))
      ..post('/transfers/<id>/decline', _authed((r, u) => _answerTransfer(r, u, accept: false)))
      // Ajout par code à 6 chiffres
      ..post('/join-codes', _authed(_createJoinCode))
      ..post('/companies/<id>/join', _authed(_redeemJoinCode))
      ..post('/companies/<id>/invite', _authed(_inviteByQr))
      ..post('/join-requests/<id>/accept', _authed((r, u) => _answerJoin(r, u, accept: true)))
      ..post('/join-requests/<id>/decline', _authed((r, u) => _answerJoin(r, u, accept: false)))
      // Planning
      ..get('/companies/<id>/<kind|sites|positions>', _authed(_catalog))
      ..post('/companies/<id>/<kind|sites|positions>', _authed(_addCatalogItem))
      ..patch('/companies/<id>/<kind|sites|positions>/<itemId>', _authed(_updateCatalogItem))
      ..get('/companies/<id>/shifts', _authed(_shifts))
      ..post('/companies/<id>/shifts', _authed(_createShifts))
      ..post('/companies/<id>/shifts/replace', _authed(_replace))
      ..patch('/companies/<id>/shifts/<shiftId>', _authed(_updateShift))
      ..delete('/companies/<id>/shifts/<shiftId>', _authed(_deleteShift))
      ..post('/companies/<id>/publish', _authed(_publish))
      ..post('/companies/<id>/discard', _authed((r, u) async =>
          _json({'discarded': await planning.discard(u, r.params['id']!)})))
      // Supérieur ou patron : placement d'un salarié d'un autre site.
      ..post('/companies/<id>/shifts/<shiftId>/approval', _authed((r, u) async {
        final body = await _body(r);
        if (body['approve'] is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await planning.decidePlacement(u, r.params['id']!, r.params['shiftId']!, approve: body['approve'] as bool);
        return Response(204);
      }))
      ..post('/companies/<id>/shifts/<shiftId>/revert', _authed((r, u) async =>
          _json({'reverted': await planning.revert(u, r.params['id']!, r.params['shiftId']!)})))
      ..put('/companies/<id>/notify-sites', _authed(_notifySites))
      ..put('/companies/<id>/presets', _authed((r, u) async =>
          _json({'presets': await companies.setPresets(u, r.params['id']!, (await _body(r))['presets'])})))
      ..put('/companies/<id>/messaging', _authed((r, u) async {
        final body = await _body(r);
        if (body['enabled'] is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await news.setEnabled(u, r.params['id']!, body['enabled'] as bool);
        return Response(204);
      }))
      // Image de l'entreprise : PNG envoyé en base64 (null pour l'enlever).
      ..put('/companies/<id>/logo', _authed((r, u) async {
        final body = await _body(r);
        final png = body['png'];
        if (png != null && png is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        List<int>? bytes;
        try {
          bytes = png == null ? null : base64Decode(png as String);
        } on FormatException {
          throw const ApiError.badRequest('Image PNG de 1 Mo au plus attendue.');
        }
        return _json({'logoVersion': await companies.setLogo(u, r.params['id']!, bytes)});
      }))
      ..get('/companies/<id>/logo', _authed((r, u) async {
        final png = await companies.logo(u, r.params['id']!);
        if (png == null) throw const ApiError.notFound();
        return Response.ok(png, headers: {'content-type': 'image/png', 'cache-control': 'private, max-age=31536000'});
      }))
      ..put('/companies/<id>/notifications', _authed((r, u) async {
        final body = await _body(r);
        if (body['enabled'] is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await companies.open(u, r.params['id']!);
        await store.setNotificationsOn(r.params['id']!, u.id, body['enabled'] as bool);
        return Response(204);
      }))
      // Fuseaux horaires du monde (base IANA de PostgreSQL), avec leur décalage actuel.
      ..get('/timezones', _authed((r, u) async {
        final rows = await store.query(store.db, '''
          SELECT name, extract(epoch FROM utc_offset)::int / 60 FROM pg_timezone_names
          WHERE name ~ '^(Africa|America|Antarctica|Asia|Atlantic|Australia|Europe|Indian|Pacific)/' AND name !~ '^posix'
          ORDER BY name''', const {});
        return _json({'timezones': [for (final row in rows) {'name': row[0], 'offset': row[1]}]});
      }))
      // Plusieurs employeurs : tous ses plannings, personnes déjà en service ailleurs
      ..get('/me/shifts', _authed(_myShifts))
      // Outils du responsable : alertes légales, totaux, exports, agenda
      ..get('/companies/<id>/alerts', _authed((r, u) async {
        final (from, to) = _period(r);
        return _json({'alerts': await tools.alerts(u, r.params['id']!, from, to)});
      }))
      ..get('/companies/<id>/totals', _authed((r, u) async {
        final (from, to) = _period(r);
        return _json({
          'totals': await tools.totals(u, r.params['id']!, from, to,
              published: r.url.queryParameters['published'] == '1'),
        });
      }))
      ..post('/companies/<id>/exports', _authed((r, u) async {
        final token = await tools.exportLink(u, r.params['id']!, await _body(r), (r.url.queryParameters['lang'] ?? negotiateLanguage(r.headers['accept-language'])));
        return _json({'path': '/api/v1/exports/$token'});
      }))
      ..get('/exports/<token>', (Request r) async {
            final (type, name, bytes) = await tools.export(r.params['token']!);
            return Response.ok(bytes, headers: {
              'content-type': type,
              if (!type.startsWith('text/html')) 'content-disposition': 'attachment; filename="$name"',
              'cache-control': 'no-store',
            });
          })
      ..put('/me/calendar', _authed((r, u) async {
        final body = await _body(r);
        if (body['enabled'] is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        final token = await tools.setCalendar(u, body['enabled'] as bool);
        return _json({'path': token == null ? null : '/api/v1/calendar/$token.ics'});
      }))
      ..get('/calendar/<file>', (Request r) async {
            final file = r.params['file']!;
            final ics = await tools.calendar(file.endsWith('.ics') ? file.substring(0, file.length - 4) : file, now());
            return Response.ok(ics, headers: {'content-type': 'text/calendar; charset=utf-8', 'cache-control': 'no-store'});
          })
      ..get('/companies/<id>/busy', _authed(_busy))
      // Historique, annulation, avis
      ..get('/companies/<id>/history', _authed(_history))
      ..post('/companies/<id>/history/<entryId>/undo', _authed(_undo))
      ..get('/notices', _authed(_notices))
      ..post('/notices/read', _authed(_readNotices))
      ..delete('/notices', _authed(_deleteNotices))
      ..put('/me/notice-retention', _authed(_setRetention))
      // Notifications sur l'appareil
      ..put('/devices', _authed(_registerDevice))
      ..post('/devices/forget', _authed(_forgetDevice))
      ..get('/me/notifications', _authed(_getPrefs))
      ..patch('/me/notifications', _authed(_setPrefs))
      // Fil d'actualités
      ..get('/companies/<id>/news', _authed((r, u) async {
        final before = r.url.queryParameters['before'];
        return _json(await news.list(u, r.params['id']!, before: before == null ? null : DateTime.tryParse(before)));
      }))
      ..post('/companies/<id>/news', _authed((r, u) async {
        final body = await _body(r);
        final title = body['title'], text = body['body'], audience = body['audience'];
        if (title is! String? || text is! String || audience is! Map<String, dynamic>) {
          throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        }
        return _json(await news.publish(u, r.params['id']!, title: title, body: text, audience: audience), status: 201);
      }))
      ..patch('/companies/<id>/news/<newsId>', _authed((r, u) async {
        final body = await _body(r);
        final title = body['title'], text = body['body'];
        if (title is! String? || text is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        await news.edit(u, r.params['id']!, r.params['newsId']!, title: title, body: text);
        return Response(204);
      }))
      ..delete('/companies/<id>/news/<newsId>', _authed((r, u) async {
        await news.delete(u, r.params['id']!, r.params['newsId']!);
        return Response(204);
      }))
      ..post('/companies/<id>/news/read', _authed((r, u) async {
        await news.markRead(u, r.params['id']!);
        return Response(204);
      }))
      ..post('/companies/<id>/news/<newsId>/translate', _authed((r, u) async {
        final t = translator;
        if (t == null) throw const ApiError(409, 'translation_unavailable', 'Traduction momentanément indisponible.');
        final lang = (await _body(r))['lang'];
        if (lang is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        return _json(await news.translate(u, r.params['id']!, r.params['newsId']!, lang, t));
      }))
      // Demandes : échange, congé, indisponibilité
      ..get('/companies/<id>/requests', _authed(_requests))
      ..get('/requests/<id>', _authed((r, u) async => _json(await requests.one(u, r.params['id']!))))
      ..post('/companies/<id>/requests', _authed(_createRequest))
      ..get('/companies/<id>/absences', _authed(_absences))
      ..post('/requests/<id>/accept', _authed((r, u) async => _json(await requests.accept(u, r.params['id']!))))
      ..post('/requests/<id>/decline', _authed((r, u) async {
        await requests.decline(u, r.params['id']!);
        return Response(204);
      }))
      ..post('/requests/<id>/approve', _authed((r, u) async {
        final text = await r.readAsString();
        final peer = text.trim().isEmpty ? null : (jsonDecode(text) as Map?)?['peerId'];
        return _json(await requests.decide(u, r.params['id']!, approve: true, peerId: peer is String ? peer : null));
      }))
      ..post('/requests/<id>/refuse', _authed((r, u) async => _json(await requests.decide(u, r.params['id']!, approve: false))))
      ..post('/requests/<id>/end', _authed((r, u) async => _json(await requests.endUnavailability(u, r.params['id']!))))
      ..post('/requests/<id>/ask-cancel', _authed((r, u) async => _json(await requests.askLeaveCancel(u, r.params['id']!))))
      ..post('/requests/<id>/cancel-decision', _authed((r, u) async {
        final approve = (await _body(r))['approve'];
        if (approve is! bool) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
        return _json(await requests.decideLeaveCancel(u, r.params['id']!, approve: approve));
      }))
      ..post('/requests/<id>/cancel', _authed((r, u) async {
        await requests.cancel(u, r.params['id']!);
        return Response(204);
      }))
      // Renforts : salariés et extras de ses autres entreprises
      ..get('/companies/<id>/reinforcements', _authed((r, u) async =>
          _json({'people': await companies.reinforcements(u, r.params['id']!)})))
      ..post('/companies/<id>/reinforcements', _authed(_addReinforcement));
    if (devLogin) v1.post('/auth/dev', _loginDev);

    late final Handler app;
    final root = Router(notFoundHandler: _notFound)
      ..get('/health', (Request _) async {
        try {
          await store.query(store.db, 'SELECT 1');
          return _json({'status': 'ok'});
        } catch (_) {
          return _json({'status': 'database_down'}, status: 503);
        }
      })
      // Connecteur MCP : les outils appellent l'API /ext avec la même clé.
      ..add('POST', '/api/v1/mcp', (Request r) => McpServer(app, apiAccess).handle(r))
      ..add('GET', '/api/v1/mcp', (Request r) => McpServer(app, apiAccess).handle(r))
      ..mount('/api/v1/', v1.call);

    app = const Pipeline()
        .addMiddleware(_cors())
        .addMiddleware(_errors())
        .addMiddleware(_authThrottle())
        .addHandler(root.call);
    return app;
  }

  // --- Connexion -----------------------------------------------------------

  String _lang(Request r) => r.url.queryParameters['lang'] ?? negotiateLanguage(r.headers['accept-language']);

  Future<Response> _loginGoogle(Request req) async {
    final body = await _body(req);
    final idToken = body['idToken'];
    if (idToken is! String || idToken.isEmpty) throw const ApiError.badRequest('idToken manquant.');
    final id = await google.verify(idToken);
    final switched = await googleSwitch.onLogin(
        sub: id.sub, email: id.email, name: id.name, photo: id.picture, locale: id.locale, link: body['switchToken'] as String?);
    if (switched != null) return _session(switched, switched: true);
    final restored = await store.isGhost(id.sub);
    return _session(
        await store.upsertGoogleUser(sub: id.sub, email: id.email, name: id.name, photoUrl: id.picture, locale: id.locale),
        restored: restored);
  }

  Future<Response> _loginDev(Request req) async {
    final body = await _body(req);
    final email = body['email'];
    if (email is! String || !email.contains('@')) throw const ApiError.badRequest('email manquant.');
    final name = (body['name'] as String?) ?? email.split('@').first;
    // `locale` simule la langue d'un compte Google.
    final switched = await googleSwitch.onLogin(
        sub: 'dev:$email', email: email, name: name, link: body['switchToken'] as String?);
    if (switched != null) return _session(switched, switched: true);
    final restored = await store.isGhost('dev:$email');
    return _session(
        await store.upsertGoogleUser(sub: 'dev:$email', email: email, name: name, locale: body['locale'] as String?),
        restored: restored);
  }

  /// [restored] : compte supprimé en fantôme, réactivé par cette connexion.
  /// [switched] : compte rattaché à ce nouveau compte Google à la connexion.
  Future<Response> _session(User user, {bool restored = false, bool switched = false}) async {
    await store.audit(actorId: user.id, action: restored ? 'account.restore' : 'auth.login');
    return _json({
      'token': tokens.issue(user.id, version: user.sessionVersion),
      'user': user.toJson(),
      if (restored) 'restored': true,
      if (switched) 'switched': true,
    });
  }

  // --- Utilisateur ---------------------------------------------------------

  Future<Response> _me(Request req, User user) async => _json({
        'user': user.toJson(),
        'companies': [for (final m in await store.membershipsOf(user.id)) m.toJson()],
        'pendingTransfers': [
          for (final t in await store.pendingTransfersFor(user.id)) t.toJson(),
        ],
        'pendingJoinRequests': [
          for (final j in await (imports.claimByEmail(user).then((_) => joins.pendingFor(user)))) j.toJson(),
        ],
        'unreadNotices': await notices.unreadCount(user.id),
        'notificationPrefs': await notifications.prefs(user.id),
        'noticeRetention': await notices.retention(user.id),
        'unreadNews': await news.unreadByCompany(user.id),
        'totp': await totp.enabled(user.id),
        if (_isAdmin(user)) 'isAdmin': true,
        'telegram': await telegram.of(user.id),
        'telegramBot': await telegram.botName().catchError((Object _) => null),
        'calendarPath': switch (await tools.calendarToken(user.id)) {
          null => null,
          final token => '/api/v1/calendar/$token.ics',
        },
      });

  /// La personne choisit le nom affiché partout (vide : celui de Google).
  Future<Response> _updateMe(Request req, User user) async {
    final body = await _body(req);
    final name = body['name'];
    if (name is! String?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final updated = await store.setCustomName(user.id, CompanyService.personName(name));
    await store.audit(actorId: user.id, action: 'user.name', details: {'name': updated.name});
    return _json(updated.toJson());
  }

  // --- Entreprises ---------------------------------------------------------

  Future<Response> _createCompany(Request req, User user) async {
    // Créer une entreprise (et la payer) : réservé aux comptes Google.
    if (TotpService.isLocal(user)) {
      throw const ApiError(409, 'google_required', 'Reliez un compte Google pour créer une entreprise.');
    }
    final body = await _body(req);
    final company = await billing.start(
        user, await companies.create(user, name: _string(body, 'name'), timezone: _string(body, 'timezone')));
    return _json(Membership(company, Role.owner).toJson(), status: 201);
  }

  Future<Response> _getCompany(Request req, User user) async {
    final (company, role) = await companies.open(user, req.params['id']!);
    return _json(Membership(company, role).toJson());
  }

  Future<Response> _updateCompany(Request req, User user) async {
    final body = await _body(req);
    final rules = body.containsKey('legalRules') ? ToolsService.cleanRules(body['legalRules']) : null;
    final company = await companies.update(user, req.params['id']!,
        name: body['name'] as String?,
        timezone: body['timezone'] as String?,
        legalRules: body.containsKey('legalRules') ? () => rules : null,
        printScope: body['printScope'] as String?);
    return _json(company.toJson());
  }

  Future<Response> _members(Request req, User user) async => _json({
        'members': [for (final m in await companies.members(user, req.params['id']!)) m.toJson()],
      });

  Future<Response> _setRole(Request req, User user) async {
    final body = await _body(req);
    final role = _role(_string(body, 'role'));
    await companies.setRole(user, req.params['id']!, req.params['userId']!, role, sites: _optionalIds(body['sites']));
    return Response(204);
  }

  Future<Response> _renameMember(Request req, User user) async {
    final body = await _body(req);
    final name = body['name'];
    if (name is! String?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    await companies.renameMember(user, req.params['id']!, req.params['userId']!, name);
    return Response(204);
  }

  Future<Response> _setMemberProfile(Request req, User user) async {
    final body = await _body(req);
    final number = body['employeeNumber'], position = body['positionId'];
    if (number is! String? || position is! String?) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    await companies.setMemberProfile(user, req.params['id']!, req.params['userId']!,
        employeeNumber: number, positionId: position);
    return Response(204);
  }

  Future<Response> _removeMember(Request req, User user) async {
    await companies.removeMember(user, req.params['id']!, req.params['userId']!);
    return Response(204);
  }

  // --- Transfert de propriété ---------------------------------------------

  Future<Response> _proposeTransfer(Request req, User user) async {
    final body = await _body(req);
    final t = await companies.proposeTransfer(user, req.params['id']!, _string(body, 'toUserId'));
    await notifications.notify([t.toUserId],
        companyId: t.companyId, kind: 'transfer_offer', data: {'byName': user.name});
    return _json(t.toJson(), status: 201);
  }

  Future<Response> _cancelTransfer(Request req, User user) async {
    await companies.cancelTransfer(user, req.params['id']!);
    return Response(204);
  }

  Future<Response> _answerTransfer(Request req, User user, {required bool accept}) async {
    await companies.answerTransfer(user, req.params['id']!, accept: accept);
    return Response(204);
  }

  // --- Ajout par code à 6 chiffres ---------------------------------------

  Future<Response> _createJoinCode(Request req, User user) async {
    final (code, expires) = await joins.createCode(user);
    return _json({'code': code, 'expiresAt': expires.toIso8601String()}, status: 201);
  }

  Future<Response> _redeemJoinCode(Request req, User user) async {
    final body = await _body(req);
    final (request, invited) = await joins.redeem(user, req.params['id']!,
        code: _string(body, 'code'),
        role: _role((body['role'] as String?) ?? 'employee'),
        sites: _optionalIds(body['sites']),
        ip: _clientIp(req));
    await _notifyInvite(request, invited, user);
    return _json({'request': request.toJson(), 'user': invited.toJson()}, status: 201);
  }

  Future<Response> _inviteByQr(Request req, User user) async {
    final body = await _body(req);
    final (request, invited) = await joins.inviteByQr(user, req.params['id']!,
        qr: _string(body, 'qr'),
        role: _role((body['role'] as String?) ?? 'employee'),
        sites: _optionalIds(body['sites']),
        ip: _clientIp(req));
    await _notifyInvite(request, invited, user);
    return _json({'request': request.toJson(), 'user': invited.toJson()}, status: 201);
  }

  Future<void> _notifyInvite(JoinRequest request, User invited, User manager) =>
      notifications.notify([invited.id],
          companyId: request.company.id,
          kind: 'join_invite',
          data: {'requestId': request.id, 'role': request.role.name, 'byName': manager.name});

  Future<Response> _answerJoin(Request req, User user, {required bool accept}) async {
    final companyId = await joins.answer(user, req.params['id']!, accept: accept);
    if (accept) {
      // Les responsables le voient tout de suite (et peuvent le placer au planning).
      final managers = [
        for (final m in await store.members(companyId))
          if (m.role.canManage && m.user.id != user.id) m.user.id,
      ];
      await notifications.notify(managers,
          companyId: companyId, kind: 'member_joined', data: {'name': user.name});
    }
    return Response(204);
  }

  // --- Planning -----------------------------------------------------------

  static CatalogKind _kind(Request req) => CatalogKind.values.byName(req.params['kind']!);

  Future<Response> _catalog(Request req, User user) async => _json({
        'items': [
          for (final i in await planning.catalog(user, req.params['id']!, _kind(req))) i.toJson(),
        ],
      });

  Future<Response> _addCatalogItem(Request req, User user) async {
    final body = await _body(req);
    final parent = body['parentId'];
    if (parent != null && parent is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final item = await planning.addCatalogItem(user, req.params['id']!, _kind(req), _string(body, 'name'),
        parentId: parent as String?);
    return _json(item.toJson(), status: 201);
  }

  Future<Response> _updateCatalogItem(Request req, User user) async {
    final body = await _body(req);
    final parent = body['parentId'];
    if (parent != null && parent is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    await planning.updateCatalogItem(user, req.params['id']!, _kind(req), req.params['itemId']!,
        name: body['name'] as String?,
        archived: body['archived'] as bool?,
        move: body.containsKey('parentId'),
        parentId: parent as String?);
    return Response(204);
  }

  Future<Response> _shifts(Request req, User user) async {
    final q = req.url.queryParameters;
    final from = q['from'], to = q['to'];
    if (from == null || to == null) throw const ApiError.badRequest('Paramètres from et to requis.');
    final (shifts, pending) = await planning.shifts(user, req.params['id']!, from, to);
    return _json({'shifts': [for (final s in shifts) s.toJson()], 'pending': pending});
  }

  Future<Response> _createShifts(Request req, User user) async {
    final body = await _body(req);
    final days = body['days'];
    if (days is! List || days.any((d) => d is! String)) {
      throw const ApiError.badRequest('Champ « days » : liste de dates attendue.');
    }
    final repeat = body['repeat'];
    final userIds = body['userIds'];
    if (userIds != null && (userIds is! List || userIds.any((u) => u is! String?))) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    final created = await _input(() => planning.create(user, req.params['id']!, _shiftInput(body),
        days: [for (final d in days) parseDay(d as String)],
        repeat: repeat is Map<String, dynamic> ? Repeat.fromJson(repeat) : null,
        userIds: userIds == null ? null : [for (final u in userIds) u as String?]));
    return _json({'shifts': [for (final s in created) s.toJson()]}, status: 201);
  }

  Future<Response> _updateShift(Request req, User user) async {
    final body = await _body(req);
    final baseVersion = body.remove('baseVersion');
    final count = await _input(() => planning.update(
        user, req.params['id']!, req.params['shiftId']!, ShiftPatch(body),
        scope: _scope(req), baseVersion: baseVersion as int?));
    return _json({'updated': count});
  }

  Future<Response> _deleteShift(Request req, User user) async {
    final count = await planning.delete(user, req.params['id']!, req.params['shiftId']!,
        scope: _scope(req), baseVersion: int.tryParse(req.url.queryParameters['baseVersion'] ?? ''));
    return _json({'deleted': count});
  }

  Future<Response> _history(Request req, User user) async {
    final q = req.url.queryParameters;
    final entries = await planning.history(user, req.params['id']!,
        shiftId: q['shiftId'], limit: int.tryParse(q['limit'] ?? '') ?? 100);
    return _json({'entries': [for (final e in entries) e.toJson()]});
  }

  Future<Response> _undo(Request req, User user) async {
    final id = int.tryParse(req.params['entryId']!);
    if (id == null) throw const ApiError.notFound();
    return _json({'changed': await planning.undo(user, req.params['id']!, id)});
  }

  Future<Response> _notices(Request req, User user) async =>
      _json({'notices': [for (final n in await notices.list(user.id)) n.toJson()]});

  Future<Response> _readNotices(Request req, User user) async {
    await notices.markAllRead(user.id);
    return Response(204);
  }

  Future<Response> _deleteNotices(Request req, User user) async {
    await notices.deleteAll(user.id);
    return Response(204);
  }

  Future<Response> _setRetention(Request req, User user) async {
    await notices.setRetention(user.id, _string(await _body(req), 'value'));
    return Response(204);
  }

  // --- Messagerie ------------------------------------------------------------

  Future<Response> _addReinforcement(Request req, User user) async {
    final body = await _body(req);
    final companyId = req.params['id']!;
    final userId = _string(body, 'userId');
    await companies.addReinforcement(user, companyId, userId);
    await notifications.notify([userId], companyId: companyId, kind: 'reinforcement_added', data: {'byName': user.name});
    return Response(204);
  }

  /// `?pending=1` : toutes les demandes en attente ; sinon une page de
  /// l'historique (`limit`, `before`).
  Future<Response> _requests(Request req, User user) async {
    final q = req.url.queryParameters;
    final id = req.params['id']!;
    if (q['pending'] == '1') return _json({'requests': await requests.pending(user, id)});
    final before = q['before'];
    if (before != null && DateTime.tryParse(before) == null) throw const ApiError.badRequest('Dates invalides.');
    return _json({
      'requests': await requests.list(user, id,
          before: before,
          limit: int.tryParse(q['limit'] ?? '') ?? 10,
          query: q['q'],
          kind: {'swap', 'leave', 'unavailability'}.contains(q['kind']) ? q['kind'] : null,
          state: {'pending', 'approved', 'closed'}.contains(q['state']) ? q['state'] : null),
    });
  }

  /// Période `from`–`to` d'une requête (jours AAAA-MM-JJ).
  static (String, String) _period(Request r) {
    final q = r.url.queryParameters;
    final from = q['from'], to = q['to'];
    if (from == null || to == null) throw const ApiError.badRequest('Paramètres from et to requis.');
    return (from, to);
  }

  Future<Response> _myShifts(Request req, User user) async {
    final q = req.url.queryParameters;
    final from = q['from'], to = q['to'];
    if (from == null || to == null) throw const ApiError.badRequest('Paramètres from et to requis.');
    try {
      return _json({'shifts': await overlaps.myShifts(user, from, to)});
    } on FormatException {
      throw const ApiError.badRequest('Dates invalides.');
    }
  }

  Future<Response> _busy(Request req, User user) async {
    final q = req.url.queryParameters;
    final start = int.tryParse(q['start'] ?? ''), end = int.tryParse(q['end'] ?? '');
    final days = (q['days'] ?? '').split(',').where((d) => d.isNotEmpty).toList();
    if (start == null || end == null) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    try {
      return _json({
        'userIds': await overlaps.busyElsewhere(user, req.params['id']!, days, start, end),
        'here': await overlaps.busyHere(user, req.params['id']!, days, start, end, q['exclude']),
      });
    } on FormatException {
      throw const ApiError.badRequest('Dates invalides.');
    }
  }

  Future<Response> _notifySites(Request req, User user) async {
    final body = await _body(req);
    final sites = body['sites'];
    if (sites != null && (sites is! List || sites.any((s) => s is! String))) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    await companies.setNotifySites(user, req.params['id']!, sites == null ? null : (sites as List).cast<String>());
    return Response(204);
  }

  Future<Response> _createRequest(Request req, User user) async =>
      _json(await requests.create(user, req.params['id']!, await _body(req)), status: 201);

  Future<Response> _absences(Request req, User user) async {
    final q = req.url.queryParameters;
    final from = q['from'], to = q['to'];
    if (from == null || to == null) throw const ApiError.badRequest('Paramètres from et to requis.');
    try {
      parseDay(from);
      parseDay(to);
    } on FormatException {
      throw const ApiError.badRequest('Dates invalides.');
    }
    return _json({'absences': await requests.absences(user, req.params['id']!, from, to)});
  }

  static List<String>? _optionalIds(Object? value) => value == null ? null : _ids(value);

  Future<Response> _setMemberSites(Request req, User user) async {
    final body = await _body(req);
    await companies.setSites(user, req.params['id']!, req.params['userId']!, _optionalIds(body['sites']));
    return Response(204);
  }

  static List<String> _ids(Object? value) {
    if (value is! List || value.any((v) => v is! String)) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    return value.cast<String>();
  }

  Future<Response> _registerDevice(Request req, User user) async {
    final body = await _body(req);
    await notifications.registerDevice(
        user.id, _string(body, 'token'), _string(body, 'platform'), body['language'] as String?);
    return Response(204);
  }

  /// À la déconnexion : l'appareil ne reçoit plus rien pour ce compte.
  Future<Response> _forgetDevice(Request req, User user) async {
    await notifications.forgetDevice(user.id, _string(await _body(req), 'token'));
    return Response(204);
  }

  Future<Response> _getPrefs(Request req, User user) async => _json(await notifications.prefs(user.id));

  Future<Response> _setPrefs(Request req, User user) async =>
      _json(await notifications.setPrefs(user.id, await _body(req)));

  Future<Response> _replace(Request req, User user) async {
    final body = await _body(req);
    final count = await planning.replace(user, req.params['id']!,
        fromUserId: _string(body, 'fromUserId'),
        toUserId: _string(body, 'toUserId'),
        from: _string(body, 'from'),
        to: _string(body, 'to'));
    return _json({'replaced': count});
  }

  Future<Response> _publish(Request req, User user) async {
    final (count, users) = await planning.publish(user, req.params['id']!);
    // Une seule notification par personne concernée (section 4).
    await notifications.notify(users.where((u) => u != user.id),
        companyId: req.params['id'], kind: 'schedule_published');
    await overlaps.notifyNew(req.params['id']!, users);
    return _json({'published': count, 'notifiedUsers': users.length});
  }

  static ShiftInput _shiftInput(Map<String, dynamic> body) => ShiftInput(
        start: body['start'] as int,
        end: body['end'] as int,
        userId: body['userId'] as String?,
        siteId: body['siteId'] as String?,
        positionId: body['positionId'] as String?,
        note: body['note'] as String?,
      );

  static Scope _scope(Request req) =>
      req.url.queryParameters['scope'] == 'series' ? Scope.series : Scope.one;

  /// Un champ du mauvais type dans le corps devient une erreur 400.
  static Future<T> _input<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on TypeError {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
  }

  static Role _role(String value) {
    try {
      return Role.parse(value);
    } on FormatException {
      throw ApiError.badRequest('Rôle inconnu : {value}', {'value': value});
    }
  }

  /// Adresse du client : Caddy la transmet dans X-Forwarded-For.
  static String _clientIp(Request req) {
    final forwarded = req.headers['x-forwarded-for'];
    if (forwarded != null && forwarded.isNotEmpty) return forwarded.split(',').first.trim();
    final info = req.context['shelf.io.connection_info'];
    return info is HttpConnectionInfo ? info.remoteAddress.address : 'inconnue';
  }

  // --- Outils --------------------------------------------------------------

  static Response _notFound(Request req) => _json(
      const ApiError.notFound('Route inconnue.').toJson(negotiateLanguage(req.headers['accept-language'])),
      status: 404);

  /// Administrateur : adresse inscrite dans la configuration du serveur, et
  /// compte Google réel (jamais une connexion de développement en production).
  bool _isAdmin(User user) =>
      adminEmails.contains(user.email.toLowerCase()) && (devLogin || !user.googleSub.startsWith('dev:'));

  /// Réservé aux administrateurs ; pour les autres, l'adresse n'existe pas.
  Handler _admin(Future<Response> Function(Request, User) handler) => _authed((req, user) {
        if (!_isAdmin(user)) throw const ApiError.notFound();
        return handler(req, user);
      });

  /// Lecture par clé API : JSON (`{"data": …}`), ou CSV avec `?format=csv`.
  /// Appel par clé API, noté au journal de l'entreprise (réussi ou non).
  Handler _logged(String kind, Handler inner) => (Request req) async {
        final log = ApiLog();
        final watch = Stopwatch()..start();
        var status = 500;
        Object? error;
        try {
          final res = await inner(req.change(context: {'apiLog': log}));
          status = res.statusCode;
          return res.change(headers: log.headers);
        } on ApiError catch (e) {
          status = e.status;
          error = e;
          rethrow;
        } finally {
          // Les lectures des routes d'écriture (invitations, demandes en attente) comptent comme lectures.
          await apiLogs.capture(req, log, req.method == 'GET' ? 'read' : kind, status, error, watch.elapsed,
              ip: _clientIp(req));
        }
      };

  /// Débit d'une clé : par minute (lecture ou écriture), par jour, et pour
  /// toute l'entreprise. Au-delà : 429 avec l'attente avant de réessayer.
  Future<void> _throttle(Request req, ApiKey key, {required bool write}) async {
    final v = await platform.values();
    final checks = [
      limiter.hit('k${write ? 'w' : 'r'}:${key.id}', v[write ? 'apiWritePerMinute' : 'apiReadPerMinute']!,
          const Duration(minutes: 1)),
      limiter.hit('kd:${key.id}', v['apiKeyPerDay']!, const Duration(days: 1)),
      limiter.hit('c:${key.company.id}', v['apiCompanyPerMinute']!, const Duration(minutes: 1)),
    ];
    final refused = checks.where((c) => !c.ok).firstOrNull;
    final shown = refused ?? checks.first;
    ApiLog.of(req)?.headers.addAll(shown.headers);
    if (refused != null) {
      throw ApiError(429, 'rate_limited', 'Trop de requêtes : réessayez dans {seconds} s.',
          {'seconds': refused.headers['retry-after']!}, refused.headers);
    }
  }

  Handler _apiKey(Future<Object?> Function(Request, Company) handler) => _logged('read', (Request req) async {
        final key = await apiAccess.key(req.headers['authorization'] ?? req.headers['x-api-key']);
        ApiLog.of(req)?.key = key;
        await _throttle(req, key, write: false);
        final q = req.url.queryParameters;
        ApiLog.note(req, 'read.${req.url.pathSegments.last}', {
          if (q['from'] != null) 'from': q['from'],
          if (q['to'] != null) 'to': q['to'],
        });
        if (!key.scopes.contains(ApiAccessService.readScope)) {
          throw const ApiError(403, 'scope_missing', 'Cette clé n\'a pas le droit « {scope} ».', {'scope': 'read'});
        }
        final data = await handler(req, key.company);
        if (data is List) ApiLog.of(req)?.details['count'] = data.length;
        if (req.url.queryParameters['format'] == 'csv' && data is List) {
          return Response.ok(ApiAccessService.csv(data.cast<Map<String, Object?>>()),
              headers: {'content-type': 'text/csv; charset=utf-8', 'cache-control': 'no-store'});
        }
        return _json({'data': data});
      });

  /// Écriture par clé API (« API Pro ») : droit [scope], au nom du créateur de la clé.
  Handler _apiWrite(String scope, Future<Object?> Function(Request, ApiKey, User) handler) =>
      _logged('write', (Request req) async {
        final key = await apiAccess.key(req.headers['authorization'] ?? req.headers['x-api-key']);
        ApiLog.of(req)?.key = key;
        await _throttle(req, key, write: req.method != 'GET');
        final actor = await apiAccess.actorFor(key, scope);
        final data = await handler(req, key, actor);
        await store.audit(companyId: key.company.id, actorId: actor.id, action: 'api.write', details: {
          'key': key.name,
          'method': req.method,
          'path': req.url.path,
        });
        return _json({'data': data}, status: req.method == 'POST' ? 201 : 200);
      });

  /// Minutes depuis minuit : nombre, ou « HH:MM ».
  static int _minutes(Object? v) {
    if (v is int && v >= 0 && v < 1440) return v;
    if (v is String) {
      final m = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(v.trim());
      if (m != null && int.parse(m[1]!) < 24 && int.parse(m[2]!) < 60) return int.parse(m[1]!) * 60 + int.parse(m[2]!);
    }
    throw const ApiError.badRequest('Heures invalides.');
  }

  Handler _authed(Future<Response> Function(Request, User) handler) => (Request req) async {
        final header = req.headers['authorization'] ?? '';
        if (!header.startsWith('Bearer ')) throw const ApiError.unauthorized();
        final (userId, version) = tokens.verifyVersioned(header.substring(7));
        final user = await store.findActiveUser(userId);
        if (user == null) throw const ApiError.unauthorized('Compte introuvable.');
        // Compte rattaché à un autre compte Google : les anciennes sessions sont fermées.
        if (user.sessionVersion != version) throw const ApiError.unauthorized('Session expirée, reconnectez-vous.');
        final key = req.headers['idempotency-key'];
        if (key == null || req.method == 'GET') return handler(req, user);
        return _once(user, key, () => handler(req, user));
      };

  /// Requête rejouée par l'application après une coupure réseau : si la même
  /// clé a déjà été traitée pour cet utilisateur, on renvoie la même réponse
  /// sans refaire la modification.
  Future<Response> _once(User user, String key, Future<Response> Function() run) async {
    final seen = await store.query(store.db,
        'SELECT status, body FROM idempotency_keys WHERE user_id = @u::uuid AND key = @k',
        {'u': user.id, 'k': key});
    if (seen.isNotEmpty) {
      return Response(seen.first[0] as int,
          body: seen.first[1] as String,
          headers: {'content-type': 'application/json; charset=utf-8', 'idempotent-replay': 'true'});
    }
    // Seules les réussites sont mémorisées : une requête refusée est
    // simplement réévaluée si elle revient.
    final res = await run();
    final body = await res.readAsString();
    if (res.statusCode < 300) await _remember(user, key, res.statusCode, body);
    return res.change(body: body);
  }

  Future<void> _remember(User user, String key, int status, String body) async {
    await store.query(store.db, '''
      INSERT INTO idempotency_keys (user_id, key, status, body) VALUES (@u::uuid, @k, @s, @b)
      ON CONFLICT DO NOTHING''', {'u': user.id, 'k': key, 's': status, 'b': body});
    await store.query(store.db,
        "DELETE FROM idempotency_keys WHERE created_at < now() - interval '7 days'");
  }

  /// Codes devinables (2FA, activation, invitation, Telegram) : nombre
  /// d'essais par minute et par adresse IP.
  Middleware _authThrottle() => (inner) => (req) async {
        final p = req.url.path;
        if (req.method == 'POST' &&
            // Google signe ses jetons : rien à deviner, pas de limite.
            ((p.startsWith('api/v1/auth/') && !p.endsWith('/dev') && !p.endsWith('/refresh') && !p.endsWith('/google')) ||
                p.endsWith('/redeem') ||
                p.endsWith('/join'))) {
          final r = limiter.hit('ip:${_clientIp(req)}', await platform.value('authPerMinute'), const Duration(minutes: 1));
          if (!r.ok) {
            throw ApiError(429, 'too_many_attempts', 'Trop d\'essais : réessayez dans {seconds} s.',
                {'seconds': r.headers['retry-after']!}, r.headers);
          }
        }
        return inner(req);
      };

  Middleware _errors() => (inner) => (req) async {
        try {
          return await inner(req);
        } on ApiError catch (e) {
          return _json(e.toJson(negotiateLanguage(req.headers['accept-language'])), status: e.status)
              .change(headers: e.headers);
        } catch (e, stack) {
          if (e is HijackException) rethrow;
          print('Erreur ${req.method} /${req.url.path} : $e\n$stack');
          monitor.error(e);
          return _json(const ApiError(500, 'internal', 'Erreur du serveur.')
              .toJson(negotiateLanguage(req.headers['accept-language'])), status: 500);
        }
      };

  Middleware _cors() => (inner) => (req) async {
        final origin = req.headers['origin'];
        final headers = origin != null && allowedOrigins.contains(origin)
            ? {
                'access-control-allow-origin': origin,
                'access-control-allow-methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
                'access-control-allow-headers': 'authorization, content-type, accept-language, idempotency-key',
                'vary': 'origin',
              }
            : <String, String>{};
        if (req.method == 'OPTIONS') return Response(204, headers: headers);
        final res = await inner(req);
        return res.change(headers: headers);
      };

  /// Corps JSON : 1 Mo au plus (4 Mo pour un fichier d'import, 2 Mo pour un logo).
  static Future<Map<String, dynamic>> _body(Request req) async {
    final path = req.url.path;
    final max = path.endsWith('/imports') ? 4 << 20 : (path.endsWith('/logo') ? 2 << 20 : 1 << 20);
    if ((req.contentLength ?? 0) > max) throw const ApiError(413, 'too_large', 'Requête trop volumineuse.');
    final bytes = <int>[];
    await for (final chunk in req.read()) {
      bytes.addAll(chunk);
      if (bytes.length > max) throw const ApiError(413, 'too_large', 'Requête trop volumineuse.');
    }
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is Map<String, dynamic>) return decoded;
    } on FormatException {
      // traité ci-dessous
    }
    throw const ApiError.badRequest('Corps JSON attendu.');
  }

  static String _string(Map<String, dynamic> body, String key) {
    final value = body[key];
    if (value is! String) throw ApiError.badRequest('Champ « {field} » manquant.', {'field': key});
    return value;
  }

  static Response _json(Object body, {int status = 200}) => Response(status,
      body: jsonEncode(body), headers: {'content-type': 'application/json; charset=utf-8'});
}
