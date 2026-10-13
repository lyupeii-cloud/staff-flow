/// Compteurs de débit en mémoire (une seule instance de l'API) : fenêtre
/// glissante découpée en tranches, pour les clés API, les entreprises, les
/// adresses IP des connexions et les envois de webhooks.
class RateLimiter {
  final DateTime Function() now;

  RateLimiter({required this.now});

  final _windows = <String, _Window>{};
  var _lastSweep = 0;

  /// Compte un appel sous [key] ; `null` si accepté (avec ce qu'il reste),
  /// sinon l'attente avant de réessayer.
  RateResult hit(String key, int limit, Duration window) {
    final t = now().millisecondsSinceEpoch;
    _sweep(t);
    final w = _windows.putIfAbsent(key, () => _Window(window));
    final used = w.count(t);
    if (used >= limit) return RateResult(false, limit, 0, w.retryAfter(t));
    w.add(t);
    return RateResult(true, limit, limit - used - 1, Duration.zero);
  }

  /// Oublie les compteurs restés inactifs (toutes les 10 minutes).
  void _sweep(int t) {
    if (t - _lastSweep < 600000) return;
    _lastSweep = t;
    _windows.removeWhere((_, w) => w.idle(t));
  }
}

class RateResult {
  final bool ok;
  final int limit, remaining;
  final Duration retryAfter;

  const RateResult(this.ok, this.limit, this.remaining, this.retryAfter);

  Map<String, String> get headers => {
        'x-ratelimit-limit': '$limit',
        'x-ratelimit-remaining': '$remaining',
        if (!ok) 'retry-after': '${retryAfter.inSeconds < 1 ? 1 : retryAfter.inSeconds}',
      };
}

/// Fenêtre de [span] découpée en 12 tranches.
class _Window {
  final Duration span;
  final int _slice;
  final _counts = <int, int>{};

  _Window(this.span) : _slice = span.inMilliseconds ~/ 12;

  int _start(int t) => t - span.inMilliseconds;

  int count(int t) {
    _counts.removeWhere((s, _) => s * _slice <= _start(t));
    return _counts.values.fold(0, (a, b) => a + b);
  }

  void add(int t) => _counts.update(t ~/ _slice, (c) => c + 1, ifAbsent: () => 1);

  /// Quand la plus ancienne tranche sort de la fenêtre.
  Duration retryAfter(int t) {
    if (_counts.isEmpty) return Duration.zero;
    final oldest = _counts.keys.reduce((a, b) => a < b ? a : b);
    final wait = oldest * _slice + span.inMilliseconds - t;
    return Duration(milliseconds: wait < 0 ? 0 : wait);
  }

  bool idle(int t) => count(t) == 0;
}
