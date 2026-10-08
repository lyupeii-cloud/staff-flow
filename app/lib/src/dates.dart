/// Petits outils de dates en français, sans dépendance.
library;

const weekdayShort = ['lun.', 'mar.', 'mer.', 'jeu.', 'ven.', 'sam.', 'dim.'];
const weekdayLetter = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
const monthNames = [
  'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
  'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
];

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime addDays(DateTime d, int n) => DateTime(d.year, d.month, d.day + n);

/// Lundi de la semaine de [d].
DateTime startOfWeek(DateTime d) => addDays(dateOnly(d), 1 - d.weekday);

DateTime startOfMonth(DateTime d) => DateTime(d.year, d.month);

DateTime endOfMonth(DateTime d) => DateTime(d.year, d.month + 1, 0);

bool sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

/// « lun. 5 oct. »
String dayLabel(DateTime d) => '${weekdayShort[d.weekday - 1]} ${d.day} ${monthNames[d.month - 1].substring(0, 3)}.';

/// « lundi 5 octobre 2026 »-like, plus court : « 5 octobre 2026 »
String longDate(DateTime d) => '${d.day} ${monthNames[d.month - 1]} ${d.year}';

/// « 08:30 » ; au-delà de minuit, l'heure du lendemain.
String timeLabel(int minutes) {
  final m = minutes % 1440;
  return '${(m ~/ 60).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
}

/// « 7 h 30 »
String durationLabel(int minutes) {
  final h = minutes ~/ 60, m = minutes % 60;
  return m == 0 ? '$h h' : '$h h ${m.toString().padLeft(2, '0')}';
}
