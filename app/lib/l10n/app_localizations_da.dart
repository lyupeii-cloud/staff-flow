// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class L10nDa extends L10n {
  L10nDa([String locale = 'da']) : super(locale);

  @override
  String get cancel => 'Annuller';

  @override
  String get save => 'Gem';

  @override
  String get confirm => 'Bekræft';

  @override
  String get validate => 'Bekræft';

  @override
  String get add => 'Tilføj';

  @override
  String get rename => 'Omdøb';

  @override
  String get delete => 'Slet';

  @override
  String get accept => 'Accepter';

  @override
  String get decline => 'Afvis';

  @override
  String get close => 'Luk';

  @override
  String get retry => 'Prøv igen';

  @override
  String get name => 'Navn';

  @override
  String get serverUnreachable => 'Serveren kan ikke nås.';

  @override
  String errorStatus(int status) {
    return 'Fejl $status';
  }

  @override
  String get roleOwner => 'Ejer';

  @override
  String get roleManager => 'Ansvarlig';

  @override
  String get roleEmployee => 'Medarbejder';

  @override
  String get roleExtra => 'Afløser';

  @override
  String get taglineStart => 'Dit teams vagtplaner, ';

  @override
  String get taglineEnd => 'overalt.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Log ind med Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Login med Google er ikke tilgængeligt: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Login med Google mislykkedes: $detail';
  }

  @override
  String get newCompany => 'Ny virksomhed';

  @override
  String get timezone => 'Tidszone';

  @override
  String get create => 'Opret';

  @override
  String get noCompanyTitle => 'Du er endnu ikke med i nogen virksomhed.';

  @override
  String get noCompanyHint =>
      'Opret en kode, og giv den til din ansvarlige for at blive en del af din arbejdsgivers virksomhed.';

  @override
  String get joinCompany => 'Bliv en del af en virksomhed';

  @override
  String get createCompany => 'Opret en virksomhed';

  @override
  String transferOffer(String company) {
    return 'Du er blevet tilbudt at blive ejer af “$company”.';
  }

  @override
  String get someCompany => 'en virksomhed';

  @override
  String get becameOwner => 'Du er nu ejer.';

  @override
  String get myAccount => 'Min konto';

  @override
  String get idCopied => 'Id kopieret.';

  @override
  String myId(String id) {
    return 'Mit id: $id';
  }

  @override
  String get signOut => 'Log ud';

  @override
  String joinInvite(String company, String role) {
    return '“$company” inviterer dig som $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Du er nu med i $company.';
  }

  @override
  String get viewPlanning => 'Vagtplan';

  @override
  String get viewTeam => 'Team';

  @override
  String get viewPositions => 'Funktioner';

  @override
  String get readOnlyCompany => 'Virksomheden er skrivebeskyttet.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Forlad denne virksomhed';

  @override
  String meSuffix(String name) {
    return '$name (dig)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Overdrage virksomheden til $name?';
  }

  @override
  String get transferConfirmBody =>
      'Når personen accepterer, bliver vedkommende ejer (abonnement, fakturaer, ansvarlige), og du bliver ansvarlig.';

  @override
  String transferSent(String name) {
    return 'Tilbud sendt til $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Fjern $name?';
  }

  @override
  String get removeConfirmBody => 'Historikken bevares.';

  @override
  String get addPersonTitle => 'Tilføj en person';

  @override
  String get addPersonHint =>
      'Bed personen åbne Staff Flow, kontomenuen, “Bliv en del af en virksomhed”, og indtast koden, der vises.';

  @override
  String get sixDigitCode => '6-cifret kode';

  @override
  String invitationSent(String name) {
    return 'Invitation sendt til $name: den skal accepteres.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Forlad $company?';
  }

  @override
  String get leaveConfirmBody => 'Du vil ikke længere kunne se dens vagtplan.';

  @override
  String get renameCompany => 'Omdøb virksomheden';

  @override
  String get actionMakeManager => 'Gør til ansvarlig';

  @override
  String get actionMakeEmployee => 'Gør til medarbejder igen';

  @override
  String get actionToEmployee => 'Gør til medarbejder';

  @override
  String get actionToExtra => 'Gør til afløser';

  @override
  String get actionTransfer => 'Overdrag ejerskab';

  @override
  String get actionRemove => 'Fjern fra virksomheden';

  @override
  String get positions => 'Funktioner';

  @override
  String get sites => 'Lokationer';

  @override
  String get positionsHint => 'Hvad personen laver: kasse, køkken, reception…';

  @override
  String get sitesHint =>
      'Hvor vagten foregår, hvis virksomheden har flere lokationer.';

  @override
  String get archived => 'Arkiveret';

  @override
  String get archive => 'Arkivér';

  @override
  String get reactivate => 'Genaktivér';

  @override
  String weekOf(String date) {
    return 'Ugen fra $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ændringer offentliggjort.',
      one: '1 ændring offentliggjort.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Vagt';

  @override
  String get display => 'Visning';

  @override
  String get week => 'Uge';

  @override
  String get month => 'Måned';

  @override
  String get today => 'I dag';

  @override
  String get onlyMine => 'Kun mine vagter';

  @override
  String get replacePersonMenu => 'Erstat en person…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ikke-offentliggjorte ændringer',
      one: '1 ikke-offentliggjort ændring',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Medarbejderne kan ikke se dem endnu.';

  @override
  String get publish => 'Offentliggør';

  @override
  String yourHours(String duration) {
    return 'Dine timer i perioden: $duration';
  }

  @override
  String get addShiftThisDay => 'Tilføj en vagt denne dag';

  @override
  String get noShift => 'Ingen vagter';

  @override
  String get unassigned => 'Ikke tildelt';

  @override
  String get formerMember => 'Tidligere medlem';

  @override
  String get statusDraft => 'Kladde';

  @override
  String get statusModified => 'Ændret';

  @override
  String get statusDeleted => 'Slettet';

  @override
  String durationHours(int hours) {
    return '$hours t';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get editShift => 'Redigér vagt';

  @override
  String get newShift => 'Ny vagt';

  @override
  String get thisShift => 'Kun denne vagt';

  @override
  String get thisAndFollowing => 'Denne og de følgende';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dage',
      one: 'Dag',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Anden dag';

  @override
  String get start => 'Start';

  @override
  String get end => 'Slut';

  @override
  String get endsNextDay => 'Slutter næste dag.';

  @override
  String get person => 'Person';

  @override
  String get position => 'Funktion';

  @override
  String get site => 'Lokation';

  @override
  String get noteOptional => 'Note (valgfri)';

  @override
  String get repetition => 'Gentagelse';

  @override
  String get repeatNone => 'Ingen';

  @override
  String get repeatDaily => 'Hver dag';

  @override
  String get repeatWeekly => 'Hver uge';

  @override
  String get repeatForPrefix => 'I ';

  @override
  String get repeatDaysSuffix => ' dage';

  @override
  String get repeatWeeksSuffix => ' uger';

  @override
  String get repeatUntilPrefix => 'Indtil ';

  @override
  String get replacePersonTitle => 'Erstat en person';

  @override
  String get replaceFrom => 'Erstat';

  @override
  String get replaceBy => 'Med';

  @override
  String dateRange(String from, String to) {
    return 'Fra $from til $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vagter ændret.',
      one: '1 vagt ændret.',
      zero: 'Ingen vagter ændret.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Erstat';

  @override
  String get joinHint =>
      'Giv denne kode til din ansvarlige. Når den er indtastet i appen, får du en invitation.';

  @override
  String get codeExpired => 'Koden er udløbet.';

  @override
  String codeValidFor(String time) {
    return 'Gyldig i $time endnu';
  }

  @override
  String get newCode => 'Ny kode';

  @override
  String get language => 'Sprog';

  @override
  String get languageAuto => 'Automatisk (enhedens sprog)';
}
