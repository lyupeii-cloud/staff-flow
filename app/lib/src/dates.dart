import 'package:intl/intl.dart';

/// Dates du calendrier, et leur affichage dans la langue de l'application
/// ([locale] : `fr`, `uk`, `en`…).
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime addDays(DateTime d, int n) => DateTime(d.year, d.month, d.day + n);

/// Lundi de la semaine de [d].
DateTime startOfWeek(DateTime d) => addDays(dateOnly(d), 1 - d.weekday);

DateTime startOfMonth(DateTime d) => DateTime(d.year, d.month);

DateTime endOfMonth(DateTime d) => DateTime(d.year, d.month + 1, 0);

bool sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

/// Un lundi quelconque, pour nommer les jours de la semaine.
final _monday = DateTime(2024, 1, 1);

/// « lun. 5 oct. », « Mon, Oct 5 », « пн, 5 жовт. »
String dayLabel(DateTime d, String locale) => DateFormat.MMMEd(locale).format(d);

/// « 5 octobre 2026 »
String longDate(DateTime d, String locale) => DateFormat.yMMMMd(locale).format(d);

/// « Octobre 2026 », avec majuscule (certaines langues écrivent les mois en minuscules).
String monthTitle(DateTime d, String locale) {
  final s = DateFormat.yMMMM(locale).format(d);
  return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

/// Nom court du jour [weekday] (1 = lundi) : « lun. », « Mon », « пн ».
String weekdayShort(int weekday, String locale) =>
    DateFormat.E(locale).format(addDays(_monday, weekday - 1));

/// Initiale du jour [weekday] (1 = lundi) : « L », « M », « П ».
String weekdayLetter(int weekday, String locale) =>
    DateFormat.EEEEE(locale).format(addDays(_monday, weekday - 1)).toUpperCase();

/// « 08:30 » (24 h) ; au-delà de minuit, l'heure du lendemain.
String timeLabel(int minutes) {
  final m = minutes % 1440;
  return '${(m ~/ 60).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
}
