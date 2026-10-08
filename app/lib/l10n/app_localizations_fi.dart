// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class L10nFi extends L10n {
  L10nFi([String locale = 'fi']) : super(locale);

  @override
  String get cancel => 'Peruuta';

  @override
  String get save => 'Tallenna';

  @override
  String get confirm => 'Vahvista';

  @override
  String get validate => 'Vahvista';

  @override
  String get add => 'Lisää';

  @override
  String get rename => 'Nimeä uudelleen';

  @override
  String get delete => 'Poista';

  @override
  String get accept => 'Hyväksy';

  @override
  String get decline => 'Hylkää';

  @override
  String get close => 'Sulje';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get name => 'Nimi';

  @override
  String get serverUnreachable => 'Palvelimeen ei saada yhteyttä.';

  @override
  String errorStatus(int status) {
    return 'Virhe $status';
  }

  @override
  String get roleOwner => 'Omistaja';

  @override
  String get roleManager => 'Esihenkilö';

  @override
  String get roleEmployee => 'Työntekijä';

  @override
  String get roleExtra => 'Keikkatyöntekijä';

  @override
  String get taglineStart => 'Tiimisi työvuorot, ';

  @override
  String get taglineEnd => 'missä tahansa.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Kirjaudu Googlella';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google-kirjautuminen ei ole käytettävissä: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google-kirjautuminen epäonnistui: $detail';
  }

  @override
  String get newCompany => 'Uusi yritys';

  @override
  String get timezone => 'Aikavyöhyke';

  @override
  String get create => 'Luo';

  @override
  String get noCompanyTitle => 'Et kuulu vielä mihinkään yritykseen.';

  @override
  String get noCompanyHint =>
      'Liity työnantajasi yritykseen luomalla koodi ja antamalla se esihenkilöllesi.';

  @override
  String get joinCompany => 'Liity yritykseen';

  @override
  String get createCompany => 'Luo yritys';

  @override
  String transferOffer(String company) {
    return 'Sinua pyydetään yrityksen ”$company” omistajaksi.';
  }

  @override
  String get someCompany => 'yritys';

  @override
  String get becameOwner => 'Olet nyt omistaja.';

  @override
  String get myAccount => 'Oma tili';

  @override
  String get idCopied => 'Tunnus kopioitu.';

  @override
  String myId(String id) {
    return 'Tunnukseni: $id';
  }

  @override
  String get signOut => 'Kirjaudu ulos';

  @override
  String joinInvite(String company, String role) {
    return '”$company” kutsuu sinut rooliin: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Liityit yritykseen $company.';
  }

  @override
  String get viewPlanning => 'Työvuorot';

  @override
  String get viewTeam => 'Tiimi';

  @override
  String get viewPositions => 'Tehtävät';

  @override
  String get readOnlyCompany => 'Yritys on vain luku -tilassa.';

  @override
  String get team => 'Tiimi';

  @override
  String get leaveCompany => 'Poistu tästä yrityksestä';

  @override
  String meSuffix(String name) {
    return '$name (sinä)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Siirretäänkö yritys: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Hyväksynnän jälkeen hänestä tulee omistaja (tilaus, laskut, esihenkilöt) ja sinusta esihenkilö.';

  @override
  String transferSent(String name) {
    return 'Ehdotus lähetetty: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Poistetaanko $name?';
  }

  @override
  String get removeConfirmBody => 'Historia säilyy.';

  @override
  String get addPersonTitle => 'Lisää henkilö';

  @override
  String get addPersonHint =>
      'Pyydä häntä avaamaan Staff Flow, tilivalikko ja ”Liity yritykseen”, ja syötä näkyvä koodi.';

  @override
  String get sixDigitCode => '6-numeroinen koodi';

  @override
  String invitationSent(String name) {
    return 'Kutsu lähetetty: $name. Se on hyväksyttävä.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Poistutaanko yrityksestä $company?';
  }

  @override
  String get leaveConfirmBody => 'Et näe enää sen työvuoroja.';

  @override
  String get renameCompany => 'Nimeä yritys uudelleen';

  @override
  String get actionMakeManager => 'Tee esihenkilöksi';

  @override
  String get actionMakeEmployee => 'Palauta työntekijäksi';

  @override
  String get actionToEmployee => 'Tee työntekijäksi';

  @override
  String get actionToExtra => 'Tee keikkatyöntekijäksi';

  @override
  String get actionTransfer => 'Siirrä omistajuus';

  @override
  String get actionRemove => 'Poista yrityksestä';

  @override
  String get positions => 'Tehtävät';

  @override
  String get sites => 'Toimipaikat';

  @override
  String get positionsHint =>
      'Mitä henkilö tekee: kassa, keittiö, vastaanotto…';

  @override
  String get sitesHint =>
      'Missä vuoro on, jos yrityksellä on useita toimipaikkoja.';

  @override
  String get archived => 'Arkistoitu';

  @override
  String get archive => 'Arkistoi';

  @override
  String get reactivate => 'Ota uudelleen käyttöön';

  @override
  String weekOf(String date) {
    return 'Viikko alkaen $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count muutosta julkaistu.',
      one: '1 muutos julkaistu.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Vuoro';

  @override
  String get display => 'Näkymä';

  @override
  String get week => 'Viikko';

  @override
  String get month => 'Kuukausi';

  @override
  String get today => 'Tänään';

  @override
  String get onlyMine => 'Vain omat vuoroni';

  @override
  String get replacePersonMenu => 'Vaihda henkilö…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count julkaisematonta muutosta',
      one: '1 julkaisematon muutos',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Työntekijät eivät näe niitä vielä.';

  @override
  String get publish => 'Julkaise';

  @override
  String yourHours(String duration) {
    return 'Tuntisi jaksolla: $duration';
  }

  @override
  String get addShiftThisDay => 'Lisää vuoro tälle päivälle';

  @override
  String get noShift => 'Ei vuoroja';

  @override
  String get unassigned => 'Ei määritetty';

  @override
  String get formerMember => 'Entinen jäsen';

  @override
  String get statusDraft => 'Luonnos';

  @override
  String get statusModified => 'Muutettu';

  @override
  String get statusDeleted => 'Poistettu';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get editShift => 'Muokkaa vuoroa';

  @override
  String get newShift => 'Uusi vuoro';

  @override
  String get thisShift => 'Vain tämä vuoro';

  @override
  String get thisAndFollowing => 'Tämä ja seuraavat';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Päivät',
      one: 'Päivä',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Muu päivä';

  @override
  String get start => 'Alku';

  @override
  String get end => 'Loppu';

  @override
  String get endsNextDay => 'Päättyy seuraavana päivänä.';

  @override
  String get person => 'Henkilö';

  @override
  String get position => 'Tehtävä';

  @override
  String get site => 'Toimipaikka';

  @override
  String get noteOptional => 'Huomautus (valinnainen)';

  @override
  String get repetition => 'Toisto';

  @override
  String get repeatNone => 'Ei toistoa';

  @override
  String get repeatDaily => 'Joka päivä';

  @override
  String get repeatWeekly => 'Joka viikko';

  @override
  String get repeatForPrefix => 'Kesto ';

  @override
  String get repeatDaysSuffix => ' päivää';

  @override
  String get repeatWeeksSuffix => ' viikkoa';

  @override
  String get repeatUntilPrefix => 'Asti ';

  @override
  String get replacePersonTitle => 'Vaihda henkilö';

  @override
  String get replaceFrom => 'Vaihdettava';

  @override
  String get replaceBy => 'Tilalle';

  @override
  String dateRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vuoroa muutettu.',
      one: '1 vuoro muutettu.',
      zero: 'Yhtään vuoroa ei muutettu.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Vaihda';

  @override
  String get joinHint =>
      'Anna tämä koodi esihenkilöllesi. Kun hän syöttää sen sovellukseen, saat kutsun.';

  @override
  String get codeExpired => 'Koodi on vanhentunut.';

  @override
  String codeValidFor(String time) {
    return 'Voimassa vielä $time';
  }

  @override
  String get newCode => 'Uusi koodi';

  @override
  String get language => 'Kieli';

  @override
  String get languageAuto => 'Automaattinen (laitteen kieli)';
}
