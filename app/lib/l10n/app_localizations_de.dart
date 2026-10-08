// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class L10nDe extends L10n {
  L10nDe([String locale = 'de']) : super(locale);

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get validate => 'Bestätigen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get rename => 'Umbenennen';

  @override
  String get delete => 'Löschen';

  @override
  String get accept => 'Annehmen';

  @override
  String get decline => 'Ablehnen';

  @override
  String get close => 'Schließen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get name => 'Name';

  @override
  String get serverUnreachable => 'Server nicht erreichbar.';

  @override
  String errorStatus(int status) {
    return 'Fehler $status';
  }

  @override
  String get roleOwner => 'Inhaber';

  @override
  String get roleManager => 'Verantwortlicher';

  @override
  String get roleEmployee => 'Mitarbeiter';

  @override
  String get roleExtra => 'Aushilfe';

  @override
  String get taglineStart => 'Die Dienstpläne deines Teams, ';

  @override
  String get taglineEnd => 'überall.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Mit Google anmelden';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google-Anmeldung nicht verfügbar: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google-Anmeldung fehlgeschlagen: $detail';
  }

  @override
  String get newCompany => 'Neues Unternehmen';

  @override
  String get timezone => 'Zeitzone';

  @override
  String get create => 'Erstellen';

  @override
  String get noCompanyTitle => 'Du gehörst noch keinem Unternehmen an.';

  @override
  String get noCompanyHint =>
      'Um dem Unternehmen deines Arbeitgebers beizutreten, erstelle einen Code und gib ihn deinem Verantwortlichen.';

  @override
  String get joinCompany => 'Einem Unternehmen beitreten';

  @override
  String get createCompany => 'Unternehmen erstellen';

  @override
  String transferOffer(String company) {
    return 'Dir wird angeboten, Inhaber von „$company“ zu werden.';
  }

  @override
  String get someCompany => 'ein Unternehmen';

  @override
  String get becameOwner => 'Du bist jetzt Inhaber.';

  @override
  String get myAccount => 'Mein Konto';

  @override
  String get idCopied => 'Kennung kopiert.';

  @override
  String myId(String id) {
    return 'Meine Kennung: $id';
  }

  @override
  String get signOut => 'Abmelden';

  @override
  String joinInvite(String company, String role) {
    return '„$company“ lädt dich ein als: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Du bist $company beigetreten.';
  }

  @override
  String get viewPlanning => 'Dienstplan';

  @override
  String get viewTeam => 'Team';

  @override
  String get viewPositions => 'Positionen';

  @override
  String get readOnlyCompany => 'Unternehmen nur lesbar.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Dieses Unternehmen verlassen';

  @override
  String meSuffix(String name) {
    return '$name (du)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Unternehmen an $name übertragen?';
  }

  @override
  String get transferConfirmBody =>
      'Nach der Annahme wird diese Person Inhaber (Abonnement, Rechnungen, Verantwortliche) und du wirst Verantwortlicher.';

  @override
  String transferSent(String name) {
    return 'Angebot an $name gesendet.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get removeConfirmBody => 'Der Verlauf bleibt erhalten.';

  @override
  String get addPersonTitle => 'Person hinzufügen';

  @override
  String get addPersonHint =>
      'Bitte die Person, Staff Flow zu öffnen, im Kontomenü „Einem Unternehmen beitreten“ zu wählen, und gib den angezeigten Code ein.';

  @override
  String get sixDigitCode => '6-stelliger Code';

  @override
  String invitationSent(String name) {
    return 'Einladung an $name gesendet: Sie muss angenommen werden.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company verlassen?';
  }

  @override
  String get leaveConfirmBody => 'Du siehst den Dienstplan dann nicht mehr.';

  @override
  String get renameCompany => 'Unternehmen umbenennen';

  @override
  String get actionMakeManager => 'Zum Verantwortlichen machen';

  @override
  String get actionMakeEmployee => 'Wieder zum Mitarbeiter machen';

  @override
  String get actionToEmployee => 'Zum Mitarbeiter machen';

  @override
  String get actionToExtra => 'Zur Aushilfe machen';

  @override
  String get actionTransfer => 'Inhaberschaft übertragen';

  @override
  String get actionRemove => 'Aus dem Unternehmen entfernen';

  @override
  String get positions => 'Positionen';

  @override
  String get sites => 'Standorte';

  @override
  String get positionsHint => 'Was die Person macht: Kasse, Küche, Empfang…';

  @override
  String get sitesHint =>
      'Wo die Schicht stattfindet, wenn das Unternehmen mehrere Standorte hat.';

  @override
  String get archived => 'Archiviert';

  @override
  String get archive => 'Archivieren';

  @override
  String get reactivate => 'Reaktivieren';

  @override
  String weekOf(String date) {
    return 'Woche vom $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Änderungen veröffentlicht.',
      one: '1 Änderung veröffentlicht.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Schicht';

  @override
  String get display => 'Ansicht';

  @override
  String get week => 'Woche';

  @override
  String get month => 'Monat';

  @override
  String get today => 'Heute';

  @override
  String get onlyMine => 'Nur meine Schichten';

  @override
  String get replacePersonMenu => 'Person ersetzen…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unveröffentlichte Änderungen',
      one: '1 unveröffentlichte Änderung',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Die Mitarbeiter sehen sie noch nicht.';

  @override
  String get publish => 'Veröffentlichen';

  @override
  String yourHours(String duration) {
    return 'Deine Stunden im Zeitraum: $duration';
  }

  @override
  String get addShiftThisDay => 'Schicht an diesem Tag hinzufügen';

  @override
  String get noShift => 'Keine Schichten';

  @override
  String get unassigned => 'Nicht zugewiesen';

  @override
  String get formerMember => 'Ehemaliges Mitglied';

  @override
  String get statusDraft => 'Entwurf';

  @override
  String get statusModified => 'Geändert';

  @override
  String get statusDeleted => 'Gelöscht';

  @override
  String durationHours(int hours) {
    return '$hours Std.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours Std. $minutes Min.';
  }

  @override
  String get editShift => 'Schicht bearbeiten';

  @override
  String get newShift => 'Neue Schicht';

  @override
  String get thisShift => 'Diese Schicht';

  @override
  String get thisAndFollowing => 'Diese und folgende';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tage',
      one: 'Tag',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Anderer Tag';

  @override
  String get start => 'Beginn';

  @override
  String get end => 'Ende';

  @override
  String get endsNextDay => 'Endet am nächsten Tag.';

  @override
  String get person => 'Person';

  @override
  String get position => 'Position';

  @override
  String get site => 'Standort';

  @override
  String get noteOptional => 'Notiz (optional)';

  @override
  String get repetition => 'Wiederholung';

  @override
  String get repeatNone => 'Keine';

  @override
  String get repeatDaily => 'Jeden Tag';

  @override
  String get repeatWeekly => 'Jede Woche';

  @override
  String get repeatForPrefix => 'Für ';

  @override
  String get repeatDaysSuffix => ' Tage';

  @override
  String get repeatWeeksSuffix => ' Wochen';

  @override
  String get repeatUntilPrefix => 'Bis ';

  @override
  String get replacePersonTitle => 'Person ersetzen';

  @override
  String get replaceFrom => 'Ersetzen';

  @override
  String get replaceBy => 'Durch';

  @override
  String dateRange(String from, String to) {
    return 'Vom $from bis $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schichten geändert.',
      one: '1 Schicht geändert.',
      zero: 'Keine Schicht geändert.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Ersetzen';

  @override
  String get joinHint =>
      'Gib diesen Code deinem Verantwortlichen. Er gibt ihn in seiner App ein, dann erhältst du eine Einladung.';

  @override
  String get codeExpired => 'Code abgelaufen.';

  @override
  String codeValidFor(String time) {
    return 'Noch $time gültig';
  }

  @override
  String get newCode => 'Neuer Code';

  @override
  String get language => 'Sprache';

  @override
  String get languageAuto => 'Automatisch (Gerätesprache)';
}
