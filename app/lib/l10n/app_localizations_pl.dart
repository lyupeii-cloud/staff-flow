// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class L10nPl extends L10n {
  L10nPl([String locale = 'pl']) : super(locale);

  @override
  String get cancel => 'Anuluj';

  @override
  String get save => 'Zapisz';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get validate => 'Potwierdź';

  @override
  String get add => 'Dodaj';

  @override
  String get rename => 'Zmień nazwę';

  @override
  String get delete => 'Usuń';

  @override
  String get accept => 'Akceptuj';

  @override
  String get decline => 'Odrzuć';

  @override
  String get close => 'Zamknij';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get name => 'Nazwa';

  @override
  String get serverUnreachable => 'Brak połączenia z serwerem.';

  @override
  String errorStatus(int status) {
    return 'Błąd $status';
  }

  @override
  String get roleOwner => 'Właściciel';

  @override
  String get roleManager => 'Kierownik';

  @override
  String get roleEmployee => 'Pracownik';

  @override
  String get roleExtra => 'Pracownik tymczasowy';

  @override
  String get taglineStart => 'Grafiki twojego zespołu, ';

  @override
  String get taglineEnd => 'wszędzie.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Zaloguj się przez Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Logowanie przez Google niedostępne: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Nie udało się zalogować przez Google: $detail';
  }

  @override
  String get newCompany => 'Nowa firma';

  @override
  String get timezone => 'Strefa czasowa';

  @override
  String get create => 'Utwórz';

  @override
  String get noCompanyTitle => 'Nie należysz jeszcze do żadnej firmy.';

  @override
  String get noCompanyHint =>
      'Aby dołączyć do firmy pracodawcy, wygeneruj kod i przekaż go kierownikowi.';

  @override
  String get joinCompany => 'Dołącz do firmy';

  @override
  String get createCompany => 'Utwórz firmę';

  @override
  String transferOffer(String company) {
    return 'Otrzymujesz propozycję zostania właścicielem „$company”.';
  }

  @override
  String get someCompany => 'firma';

  @override
  String get becameOwner => 'Jesteś teraz właścicielem.';

  @override
  String get myAccount => 'Moje konto';

  @override
  String get idCopied => 'Identyfikator skopiowany.';

  @override
  String myId(String id) {
    return 'Mój identyfikator: $id';
  }

  @override
  String get signOut => 'Wyloguj się';

  @override
  String joinInvite(String company, String role) {
    return '„$company” zaprasza cię jako: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Dołączono do $company.';
  }

  @override
  String get viewPlanning => 'Grafik';

  @override
  String get viewTeam => 'Zespół';

  @override
  String get viewPositions => 'Stanowiska';

  @override
  String get readOnlyCompany => 'Firma tylko do odczytu.';

  @override
  String get team => 'Zespół';

  @override
  String get leaveCompany => 'Opuść tę firmę';

  @override
  String meSuffix(String name) {
    return '$name (ty)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Przekazać firmę: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Po akceptacji ta osoba zostanie właścicielem (subskrypcja, faktury, kierownicy), a ty zostaniesz kierownikiem.';

  @override
  String transferSent(String name) {
    return 'Wysłano propozycję: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Usunąć: $name?';
  }

  @override
  String get removeConfirmBody => 'Historia zostanie zachowana.';

  @override
  String get addPersonTitle => 'Dodaj osobę';

  @override
  String get addPersonHint =>
      'Poproś, by otworzyła Staff Flow, menu konta, „Dołącz do firmy”, i wpisz wyświetlony kod.';

  @override
  String get sixDigitCode => '6-cyfrowy kod';

  @override
  String invitationSent(String name) {
    return 'Wysłano zaproszenie: $name. Musi je zaakceptować.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Opuścić $company?';
  }

  @override
  String get leaveConfirmBody => 'Nie zobaczysz już jej grafiku.';

  @override
  String get renameCompany => 'Zmień nazwę firmy';

  @override
  String get actionMakeManager => 'Mianuj kierownikiem';

  @override
  String get actionMakeEmployee => 'Przywróć jako pracownika';

  @override
  String get actionToEmployee => 'Zmień na pracownika';

  @override
  String get actionToExtra => 'Zmień na tymczasowego';

  @override
  String get actionTransfer => 'Przekaż własność';

  @override
  String get actionRemove => 'Usuń z firmy';

  @override
  String get positions => 'Stanowiska';

  @override
  String get sites => 'Lokalizacje';

  @override
  String get positionsHint =>
      'Czym zajmuje się osoba: kasa, kuchnia, recepcja…';

  @override
  String get sitesHint =>
      'Gdzie odbywa się zmiana, jeśli firma ma kilka lokalizacji.';

  @override
  String get archived => 'Zarchiwizowane';

  @override
  String get archive => 'Archiwizuj';

  @override
  String get reactivate => 'Przywróć';

  @override
  String weekOf(String date) {
    return 'Tydzień od $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Opublikowano $count zmiany.',
      many: 'Opublikowano $count zmian.',
      few: 'Opublikowano $count zmiany.',
      one: 'Opublikowano $count zmianę.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Zmiana';

  @override
  String get display => 'Widok';

  @override
  String get week => 'Tydzień';

  @override
  String get month => 'Miesiąc';

  @override
  String get today => 'Dzisiaj';

  @override
  String get onlyMine => 'Tylko moje zmiany';

  @override
  String get replacePersonMenu => 'Zastąp osobę…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nieopublikowanej zmiany',
      many: '$count nieopublikowanych zmian',
      few: '$count nieopublikowane zmiany',
      one: '$count nieopublikowana zmiana',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Pracownicy jeszcze ich nie widzą.';

  @override
  String get publish => 'Opublikuj';

  @override
  String yourHours(String duration) {
    return 'Twoje godziny w okresie: $duration';
  }

  @override
  String get addShiftThisDay => 'Dodaj zmianę tego dnia';

  @override
  String get noShift => 'Brak zmian';

  @override
  String get unassigned => 'Nieprzypisana';

  @override
  String get formerMember => 'Były członek';

  @override
  String get statusDraft => 'Szkic';

  @override
  String get statusModified => 'Zmieniona';

  @override
  String get statusDeleted => 'Usunięta';

  @override
  String durationHours(int hours) {
    return '$hours godz.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours godz. $minutes min';
  }

  @override
  String get editShift => 'Edytuj zmianę';

  @override
  String get newShift => 'Nowa zmiana';

  @override
  String get thisShift => 'Tylko ta zmiana';

  @override
  String get thisAndFollowing => 'Ta i następne';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dni',
      one: 'Dzień',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Inny dzień';

  @override
  String get start => 'Początek';

  @override
  String get end => 'Koniec';

  @override
  String get endsNextDay => 'Kończy się następnego dnia.';

  @override
  String get person => 'Osoba';

  @override
  String get position => 'Stanowisko';

  @override
  String get site => 'Lokalizacja';

  @override
  String get noteOptional => 'Notatka (opcjonalnie)';

  @override
  String get repetition => 'Powtarzanie';

  @override
  String get repeatNone => 'Brak';

  @override
  String get repeatDaily => 'Codziennie';

  @override
  String get repeatWeekly => 'Co tydzień';

  @override
  String get repeatForPrefix => 'Przez ';

  @override
  String get repeatDaysSuffix => ' dni';

  @override
  String get repeatWeeksSuffix => ' tyg.';

  @override
  String get repeatUntilPrefix => 'Do ';

  @override
  String get replacePersonTitle => 'Zastąp osobę';

  @override
  String get replaceFrom => 'Zastąp';

  @override
  String get replaceBy => 'Przez';

  @override
  String dateRange(String from, String to) {
    return 'Od $from do $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zmieniono $count zmiany.',
      many: 'Zmieniono $count zmian.',
      few: 'Zmieniono $count zmiany.',
      one: 'Zmieniono $count zmianę.',
      zero: 'Nie zmieniono żadnej zmiany.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Zastąp';

  @override
  String get joinHint =>
      'Przekaż ten kod kierownikowi. Wpisze go w swojej aplikacji, a ty otrzymasz zaproszenie.';

  @override
  String get codeExpired => 'Kod wygasł.';

  @override
  String codeValidFor(String time) {
    return 'Ważny jeszcze $time';
  }

  @override
  String get newCode => 'Nowy kod';

  @override
  String get language => 'Język';

  @override
  String get languageAuto => 'Automatycznie (język urządzenia)';
}
