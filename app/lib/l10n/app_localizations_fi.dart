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
  String get viewTeam => 'Hallinta';

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

  @override
  String get syncUpToDate => 'Ajan tasalla';

  @override
  String get syncOffline => 'Offline-tila';

  @override
  String syncPending(int count) {
    return 'Odottavat muutokset: $count';
  }

  @override
  String get syncNow => 'Synkronoi nyt';

  @override
  String syncRejected(String reason) {
    return 'Palvelin hylkäsi muutoksen: $reason';
  }

  @override
  String get pendingBadge => 'Odottaa';

  @override
  String get offlineUnavailable => 'Ei käytettävissä offline-tilassa.';

  @override
  String get offlineCached => 'Offline-tila: viimeksi tallennetut tiedot.';

  @override
  String get savedOffline =>
      'Tallennettu laitteelle, lähetetään kun verkko palaa.';

  @override
  String get notices => 'Ilmoitukset';

  @override
  String get noNotices => 'Ei ilmoituksia.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name korvasi muutoksesi vuoroon $date.';
  }

  @override
  String get history => 'Historia';

  @override
  String get recentChanges => 'Viimeisimmät muutokset';

  @override
  String get undoChange => 'Peru tämä muutos';

  @override
  String get undoDone => 'Muutos peruttu.';

  @override
  String get historyCreate => 'Luotu';

  @override
  String get historyUpdate => 'Muutettu';

  @override
  String get historyDelete => 'Poistettu';

  @override
  String get historyUndo => 'Peruttu';

  @override
  String get noHistory => 'Ei muutoksia.';

  @override
  String get pendingNotEditable =>
      'Tätä vuoroa ei ole vielä synkronoitu: yritä uudelleen verkossa.';

  @override
  String get myQrCode => 'Oma QR-koodi';

  @override
  String get myQrCodeHint =>
      'Esihenkilö skannaa tämän koodin lisätäkseen sinut yritykseensä; sen jälkeen vahvistat. Koodi ei koskaan muutu.';

  @override
  String get changeMyName => 'Vaihda nimeni';

  @override
  String get nameShownToTeam =>
      'Työkaverisi näkevät tämän nimen Google-nimesi sijaan.';

  @override
  String googleName(String name) {
    return 'Google-nimi: $name';
  }

  @override
  String get useGoogleName => 'Käytä Google-nimeäni';

  @override
  String renameMemberTitle(String name) {
    return 'Nimeä uudelleen: $name';
  }

  @override
  String get renameMemberHint => 'Tätä nimeä käytetään vain tässä yrityksessä.';

  @override
  String get useOwnName => 'Käytä omaa nimeä';

  @override
  String get scanQrCode => 'Skannaa QR-koodi';

  @override
  String get scanQrHint =>
      'Suuntaa kamera henkilön sovelluksessa näkyvään QR-koodiin (tilivalikko, ”Oma QR-koodi”).';

  @override
  String get orEnterCode => 'Tai syötä hänen 6-numeroinen koodinsa';

  @override
  String get qrInvalid => 'Tämä ei ole Staff Flow -QR-koodi.';

  @override
  String cameraUnavailable(String error) {
    return 'Kamera ei ole käytettävissä ($error).';
  }

  @override
  String get notificationsTitle => 'Ilmoitukset';

  @override
  String get notifChooseHint =>
      'Valitse, mistä saat ilmoituksia. Kaikki näkyy edelleen kellossa.';

  @override
  String get notifPlanning => 'Työvuorolista julkaistu tai muutettu';

  @override
  String get notifRequests => 'Pyynnöt: vaihdot, lomat, kutsut';

  @override
  String get notifMessages => 'Uudet viestit';

  @override
  String get notifOverlap => 'Päällekkäiset vuorot eri yrityksissä';

  @override
  String get notifConflicts => 'Toinen esihenkilö korvasi muutoksesi';

  @override
  String get notifBilling => 'Tilausmuistutukset';

  @override
  String get pushEnabled => 'Ilmoitukset ovat käytössä tällä laitteella.';

  @override
  String get pushOff => 'Ilmoitukset ovat pois päältä tällä laitteella.';

  @override
  String get pushBlocked =>
      'Ilmoitukset on estetty: salli ne puhelimen tai selaimen asetuksista.';

  @override
  String get pushUnavailable =>
      'Ilmoitukset eivät ole käytettävissä tällä laitteella.';

  @override
  String get enablePush => 'Ota käyttöön';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: työvuorolistasi on julkaistu tai sitä on muutettu.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company haluaa lisätä sinut tiimiinsä.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name ehdottaa, että sinusta tulee yrityksen $company omistaja.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name liittyi yritykseen $company.';
  }

  @override
  String get messagesTab => 'Viestit';

  @override
  String get wholeTeam => 'Koko tiimi';

  @override
  String get newConversation => 'Uusi keskustelu';

  @override
  String get noMessages => 'Ei vielä viestejä.';

  @override
  String get messageHint => 'Kirjoita viesti';

  @override
  String get earlierMessages => 'Aiemmat viestit';

  @override
  String get personLeftCompany => 'Tämä henkilö ei enää kuulu yritykseen.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Uusi ryhmä';

  @override
  String get editGroup => 'Muokkaa ryhmää';

  @override
  String get groupName => 'Ryhmän nimi';

  @override
  String get groupMembersHint =>
      'Valitse ryhmän jäsenet. Vain he näkevät sen viestit.';

  @override
  String get chooseAtLeastOne => 'Valitse vähintään yksi henkilö.';

  @override
  String get replyAction => 'Vastaa';

  @override
  String get translateAction => 'Käännä';

  @override
  String replyingTo(String name) {
    return 'Vastaus: $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Viimeisimmät viestit: $name';
  }

  @override
  String get deleteAllNotices => 'Poista kaikki';

  @override
  String get deleteAllNoticesConfirm => 'Poistetaanko kaikki ilmoitukset?';

  @override
  String get noticeRetention => 'Poista luetut ilmoitukset';

  @override
  String get retentionDay => '1 päivän jälkeen';

  @override
  String get retentionWeek => '1 viikon jälkeen';

  @override
  String get retentionMonth => '1 kuukauden jälkeen';

  @override
  String get billingOwnersOnly => 'Käytössä vain, jos omistat yrityksen.';

  @override
  String get readOnlyPastDays =>
      'Yli kuukauden takaiset päivät ovat vain luku -tilassa.';

  @override
  String get wholeCompany => 'Koko yritys';

  @override
  String get sitesLabel => 'Toimipisteet';

  @override
  String get actionSites => 'Toimipisteet…';

  @override
  String managerOf(String name) {
    return '$name vastaa';
  }

  @override
  String teamSitesOf(String name) {
    return 'Tiimi: $name';
  }

  @override
  String get notYourSite => 'Tämä toimipiste ei ole vastuullasi.';

  @override
  String get chooseYourSite => 'Valitse vähintään yksi toimipiste.';

  @override
  String get viewRequests => 'Pyynnöt';

  @override
  String get newRequest => 'Uusi pyyntö';

  @override
  String get requestLeave => 'Loma';

  @override
  String get requestUnavailability => 'Estyneisyys';

  @override
  String get requestSwap => 'Vuoronvaihto';

  @override
  String get swapHint =>
      'Tarjotaksesi vaihtoa napauta jotakin tulevaa vuoroasi työvuorolistassa.';

  @override
  String get noRequests => 'Ei vielä pyyntöjä.';

  @override
  String get requestsToHandle => 'Käsiteltävät';

  @override
  String get myRequests => 'Omat pyyntöni';

  @override
  String get otherRequests => 'Tiimin pyynnöt';

  @override
  String get statusPendingPeer => 'Odottaa työkaveria';

  @override
  String get statusPendingManager => 'Odottaa esihenkilöä';

  @override
  String get statusApproved => 'Hyväksytty';

  @override
  String get statusRefused => 'Hylätty';

  @override
  String get statusCancelled => 'Peruttu';

  @override
  String get cancelRequest => 'Peru pyyntö';

  @override
  String get acceptSwap => 'Ota tämä vuoro';

  @override
  String get approve => 'Hyväksy';

  @override
  String periodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Tarjottu: $name';
  }

  @override
  String get swapToTeam => 'Koko tiimi';

  @override
  String everyWeekdays(String days) {
    return 'Joka viikko: $days';
  }

  @override
  String get unavailableEveryWeek =>
      'Päivät, joina et ole koskaan käytettävissä:';

  @override
  String get choosePeriod => 'Valitse päivät';

  @override
  String get choosePeriodOptional => 'Rajaa ajanjaksoon (valinnainen)';

  @override
  String get clearPeriod => 'Ei ajanjaksoa';

  @override
  String get sendRequest => 'Lähetä pyyntö';

  @override
  String get proposeSwap => 'Tarjoa vaihtoa';

  @override
  String get swapWith => 'Tarjoa henkilölle';

  @override
  String get swapSteps =>
      'Työkaveri hyväksyy, sitten esihenkilö vahvistaa. Työvuorolista muuttuu vasta sen jälkeen.';

  @override
  String get absentThatDay => 'Hyväksytty poissaolo sinä päivänä';

  @override
  String get requestSent => 'Pyyntö lähetetty.';

  @override
  String noticeSwapOffer(String name) {
    return '$name tarjoaa sinulle yhtä vuoroistaan.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name hylkäsi vaihtoehdotuksesi.';
  }

  @override
  String get noticeSwapToApprove => 'Vuoronvaihto odottaa hyväksyntääsi.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name pyytää lomaa.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name ilmoittaa olevansa estynyt.';
  }

  @override
  String get noticeRequestApproved => 'Pyyntösi on hyväksytty.';

  @override
  String get noticeRequestRefused => 'Pyyntösi on hylätty.';

  @override
  String get choosePeer => 'Kuka ottaa tämän vuoron?';

  @override
  String get discardAll => 'Peru kaikki';

  @override
  String get notifySitesHint =>
      'Valitse toimipaikat, joista saat ilmoituksia pyynnöistä. Kaikki pyynnöt näkyvät edelleen listassa.';

  @override
  String get notifySitesTitle => 'Ilmoitukset toimipaikoittain';

  @override
  String get pendingRequestTooltip => 'Odottava pyyntö: avaa napauttamalla';

  @override
  String get requestsHistory => 'Kaikki pyynnöt';

  @override
  String get revertChange => 'Peru tämä muutos';

  @override
  String get statusExpired => 'Ei enää ajankohtainen';

  @override
  String get swapWithHint => 'Napauta valitaksesi tietyn työkaverin';

  @override
  String changesDiscarded(String count) {
    return 'Perutut muutokset: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Perutaanko $count julkaisematonta muutosta?';
  }

  @override
  String get allSchedules => 'Kaikki työvuoroni';

  @override
  String get busyElsewhere => 'On jo töissä toisessa yrityksessä tähän aikaan';

  @override
  String get overlapTooltip =>
      'Menee päällekkäin toisen yrityksen vuoron kanssa';

  @override
  String get overlapWarning =>
      'Osa vuoroistasi kahdessa yrityksessä menee päällekkäin.';

  @override
  String noticeOverlap(String date) {
    return 'Kaksi vuoroasi eri yrityksissä menee päällekkäin $date.';
  }

  @override
  String get allMyCompanies => 'Kaikki yritykseni';

  @override
  String get deleteGroup => 'Poista ryhmä';

  @override
  String get openRequest => 'Näytä pyyntö';

  @override
  String get thisCompany => 'Tämä yritys';

  @override
  String get withExtras => 'Keikkalaiset mukaan';

  @override
  String deleteGroupConfirm(String name) {
    return 'Poistetaanko ”$name” ja kaikki viestit kaikilta?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Yrityksestä $company: lisätään vahvistukseksi ja hänelle ilmoitetaan.';
  }

  @override
  String get addToGoogle => 'Lisää Google Kalenteriin';

  @override
  String get calendarEnabled => 'Synkronoi vuoroni';

  @override
  String get calendarHint =>
      'Lisää kaikkien yritystesi vuorot Google Kalenteriin. Ne päivittyvät itsestään, ja voit poistaa tämän käytöstä milloin vain.';

  @override
  String get changeSettings => 'Muokkaa';

  @override
  String get copyCalendarLink => 'Kopioi kalenterin linkki';

  @override
  String get countryBelgium => 'Belgia';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Ranska';

  @override
  String get countrySwitzerland => 'Sveitsi';

  @override
  String get employeesSection => 'Työntekijät';

  @override
  String get emptyNoAlert => 'Tyhjä: ei hälytystä';

  @override
  String get extrasSection => 'Keikkalaiset';

  @override
  String get googleCalendar => 'Google Kalenteri';

  @override
  String get hoursTotals => 'Tuntisummat';

  @override
  String get legalAlerts => 'Lakisääteiset hälytykset';

  @override
  String get legalAlertsHint =>
      'Varoituksia, ei koskaan estoja. Valitse sinua koskevat säännöt tai ei yhtään.';

  @override
  String get legalPreset => 'Maakohtainen malli';

  @override
  String get linkCopied => 'Linkki kopioitu.';

  @override
  String get maxConsecutiveLabel => 'Enimmäismäärä peräkkäisiä työpäiviä';

  @override
  String get maxDayLabel => 'Enimmäiskesto päivässä (tuntia)';

  @override
  String get maxWeekLabel => 'Enimmäiskesto viikossa (tuntia)';

  @override
  String get minRestLabel => 'Vähimmäislepo vuorojen välillä (tuntia)';

  @override
  String get noLegalRules => 'Hälytyksiä ei ole valittu.';

  @override
  String get presetNone => 'Ei mitään';

  @override
  String get presetsCheck =>
      'Mallit ovat lähtökohta: tarkista ne maasi säädösten ja työehtosopimuksen mukaan.';

  @override
  String get printMine => 'Oma työvuorolistani';

  @override
  String get printOwn => 'Vain oma työvuorolista';

  @override
  String get printPdf => 'Tulosta / PDF';

  @override
  String get printRights => 'Mitä työntekijät voivat tulostaa';

  @override
  String get printTeam => 'Koko tiimin työvuorolista';

  @override
  String get printTeamOption => 'Tiimin työvuorolista';

  @override
  String get totalsHint =>
      'Luonnokset mukana. Excel- ja CSV-viennit käyttävät julkaistua listaa.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value päivää peräkkäin (enintään $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value päivässä (enintään $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: vain $value lepoa (vähintään $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value viikossa (enintään $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Lakisääteiset hälytykset: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Vuorot: $count';
  }

  @override
  String get actionMakeDeputy => 'Nimeä varaesihenkilöksi';

  @override
  String get actionRemoveDeputy => 'Poista varaesihenkilön rooli';

  @override
  String get busyHere => 'On jo töissä tässä yrityksessä tähän aikaan';

  @override
  String get calendarByLink => 'Linkillä (Google Kalenteri tietokoneella)';

  @override
  String get calendarDenied =>
      'Kalenterin käyttö estetty. Salli se puhelimen asetuksista.';

  @override
  String get calendarLinkHint =>
      'Lisää Google Kalenterista tietokoneella; Google päivittää sen muutamassa tunnissa.';

  @override
  String get calendarNone => 'Puhelimessa ei ole muokattavaa kalenteria.';

  @override
  String get calendarOnPhone => 'Lisää vuoroni puhelimen kalenteriin';

  @override
  String get calendarOnPhoneHint =>
      'Google-kalenterissasi: näkyy heti puhelimessa ja Google Kalenterissa.';

  @override
  String get chooseCalendar => 'Valitse kalenteri';

  @override
  String get otherSiteHint =>
      'Toisen toimipaikan työntekijä: hänen esihenkilöilleen ilmoitetaan.';

  @override
  String get subManager => 'Varaesihenkilö';

  @override
  String calendarSynced(String count) {
    return 'Vuoroja kalenterissa: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Varaesihenkilö: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by merkitsi henkilön $name toimipaikkaan $site $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company lisäsi sinut vahvistukseksi.';
  }

  @override
  String get companyNotificationsHint =>
      'Pois: tässä puhelimessa ei soi mikään, mutta kaikki jää kelloon.';

  @override
  String get companyNotificationsOn => 'Vastaanota tämän yrityksen ilmoitukset';

  @override
  String get companyTimezone => 'Yrityksen aikavyöhyke';

  @override
  String get companyTimezoneHint =>
      'Kaikki tämän yrityksen ajat ovat tällä vyöhykkeellä (kesäaika mukaan lukien). Kalenterit muuntavat ne automaattisesti.';

  @override
  String get iosInstallHint =>
      'iPhonessa: napauta Jaa ja sitten ”Lisää Koti-valikkoon” asentaaksesi Staff Flow’n.';

  @override
  String get searchCity => 'Hae kaupunkia';

  @override
  String get thisPhone => 'Tämä laite';

  @override
  String companyNotifications(String name) {
    return 'Ilmoitukset: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Ajat aikavyöhykkeellä $zone ($company). Laitteesi: $here.';
  }

  @override
  String get addPreset => 'Lisää esiasetus';

  @override
  String get addPresets => 'Luo esiasetuksia';

  @override
  String get appearance => 'Ulkoasu';

  @override
  String get chooseLogo => 'Valitse PNG-kuva';

  @override
  String get conversationMuted => 'Tämän keskustelun ilmoitukset mykistetty.';

  @override
  String get conversationUnmuted =>
      'Tämän keskustelun ilmoitukset taas päällä.';

  @override
  String get customization => 'Mukautus';

  @override
  String get disableGroup => 'Poista ryhmä käytöstä';

  @override
  String get disableGroupConfirm =>
      'Koko yrityksen ryhmä piilotetaan kaikilta. Voit ottaa sen takaisin käyttöön Viesteissä.';

  @override
  String get editPresets => 'Esiasetukset';

  @override
  String get enable => 'Ota takaisin käyttöön';

  @override
  String get groupDisabled => 'Ryhmä poistettu käytöstä (vain sinä näet sen)';

  @override
  String get logoHint =>
      'Pieni PNG-kuva (logosi) yrityksen välilehdellä kaikille jäsenille.';

  @override
  String get logoPngOnly => 'Valitse enintään 1 Mt:n PNG-kuva.';

  @override
  String get muteConversation => 'Mykistä tämä keskustelu';

  @override
  String get myIdentifier => 'Tunnukseni';

  @override
  String get myProfile => 'Profiilini';

  @override
  String get presetName => 'Nimi (esim. Aamu)';

  @override
  String get removeLogo => 'Poista kuva';

  @override
  String get resetGroup => 'Tyhjennä ryhmä';

  @override
  String get resetGroupConfirm =>
      'Kaikki yrityksen ryhmän viestit poistetaan kaikilta.';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get shiftPresets => 'Vuorojen esiasetukset';

  @override
  String get shiftPresetsHint =>
      'Valmiit ajat (aamu, ilta, yö…): yksi napautus vuorossa täyttää alun ja lopun.';

  @override
  String get themeDark => 'Tumma';

  @override
  String get themeLight => 'Vaalea';

  @override
  String get themeSystem => 'Järjestelmä';

  @override
  String get unmuteConversation => 'Ota tämän keskustelun ilmoitukset käyttöön';

  @override
  String get awaitingApproval => 'Hyväksyttävänä';

  @override
  String get placementNeedsApproval =>
      '! Tämä henkilö ei kuulu toimipaikkoihisi: vuoro odottaa esihenkilösi tai omistajan hyväksyntää ennen julkaisua. Muuten valitse joku muu.';

  @override
  String get placementAwaiting =>
      'Odottaa esihenkilön tai omistajan hyväksyntää.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by haluaa vuorottaa $name toiselta toimipaikalta $date: vaatii hyväksynnän.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by hyväksyi henkilön $name vuorotuksen $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by hylkäsi henkilön $name vuorotuksen $date.';
  }

  @override
  String get addSubSite => 'Lisää alatoimipaikka';

  @override
  String get moveSite => 'Siirrä';

  @override
  String get topLevel => 'Ylin taso';

  @override
  String moveSiteTitle(String name) {
    return 'Siirrä ”$name” kohteen alle…';
  }

  @override
  String subSiteOf(String name) {
    return 'Toimipaikan $name alatoimipaikka';
  }

  @override
  String get siteTreeHint =>
      'Enintään 3 tasoa, esim. Alue › Kaupunki › Myymälä. Toimipaikan esihenkilö hallitsee myös kaikkea sen alla.';

  @override
  String get subSitesOnlyHint =>
      'Täällä lisäät alatoimipaikkoja omien toimipaikkojesi alle.';

  @override
  String get messagingSetting => 'Yrityksen viestit';

  @override
  String get messagingSettingHint =>
      'Päällä: tiimillä on Viestit-välilehti. Pois: kukaan ei näe sitä eikä voi kirjoittaa (vanhat viestit säilyvät).';

  @override
  String get billingTitle => 'Tilaus';

  @override
  String billingStatusTrial(String date) {
    return 'Ilmainen kokeilu $date asti';
  }

  @override
  String billingStatusActive(String date) {
    return 'Maksettu $date asti';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Vain luku: ilman maksua yritys poistetaan $date.';
  }

  @override
  String get billingStatusComped => 'Maksuton';

  @override
  String billingStaff(String count) {
    return '$count työntekijää laskettu (ilman omistajaa ja keikkalaisia)';
  }

  @override
  String get billingMonthly => 'Kuukausittain';

  @override
  String billingYearly(String months) {
    return 'Vuosittain ($months kuukautta laskutetaan)';
  }

  @override
  String get billingCascade => '”Sisäkkäiset toimipaikat” -lisäosa';

  @override
  String billingCascadeIncluded(String count) {
    return 'Sisältyy $count työntekijästä alkaen';
  }

  @override
  String billingPay(String amount) {
    return 'Maksa $amount';
  }

  @override
  String get billingTestNotice => 'Testimaksu: mitään ei veloiteta.';

  @override
  String get billingSoon => 'Verkkomaksu tulossa pian.';

  @override
  String get billingPaidOk => 'Maksu kirjattu.';

  @override
  String get billingInvoices => 'Laskut';

  @override
  String get billingNoInvoices => 'Ei vielä laskuja.';

  @override
  String get billingManage => 'Hallinnoi tilausta';

  @override
  String get billingReadOnlyStaff =>
      'Yritys on vain luku -tilassa, kunnes omistaja uusii tilauksen.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / kk';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / vuosi';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: ilmainen kokeilu päättyy alle 24 tunnin kuluttua.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company on vain luku -tilassa maksamattomuuden vuoksi; poisto $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Muistutus: ilman maksua $company poistetaan $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company poistettiin maksamattomuuden vuoksi.';
  }

  @override
  String billingCompanyId(String id) {
    return 'Yrityksen tunnus: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Tänään: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Sisältää kuluvan kuukauden loppuosan ($days päivää, suhteutettuna) ja sen jälkeen kokonaiset kuukaudet 1. päivästä alkaen.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Ei vielä yhdistetty. Sillä vahvistetaan henkilöllisyytesi, esimerkiksi Google-tiliä vaihdettaessa.';

  @override
  String telegramLinked(String name) {
    return 'Yhdistetty: $name';
  }

  @override
  String get telegramNoUsername => 'ei käyttäjänimeä';

  @override
  String get telegramLink => 'Yhdistä Telegramini';

  @override
  String get telegramLinkHint =>
      'Telegram avautuu: napauta ”Aloita” ja palaa sitten tänne.';

  @override
  String get telegramUnlink => 'Poista yhteys';

  @override
  String get telegramUnavailable => 'Telegram ei ole vielä käytettävissä.';

  @override
  String get telegramShowIn => 'Näytä Telegramini kohteessa:';

  @override
  String get newQrCode => 'Vaihda QR-koodi';

  @override
  String get newQrCodeConfirm =>
      'Vanha QR-koodisi ja vanha tunnuksesi lakkaavat toimimasta. Paikkasi yrityksissä ei muutu.';

  @override
  String get newQrCodeDone => 'Uusi QR-koodi luotu.';

  @override
  String get changeGoogle => 'Vaihda Google-tili';

  @override
  String get changeGoogleSub => 'Sama tili, sama numero, samat yritykset';

  @override
  String changeGoogleSteps(String id) {
    return '1. Yhdistä Telegramisi tässä profiilissa (pakollinen).\n2. Kirjaudu ulos ja sisään uudella Google-tilillä.\n3. Valitse ”Minulla on jo Staff Flow -tili” ja anna tunnuksesi $id.\n4. Anna Telegramissa saamasi koodi.\nTilisi, numerosi ja yrityksesi pysyvät samoina.';
  }

  @override
  String get recoverAccount => 'Minulla on jo Staff Flow -tili';

  @override
  String get recoverHint =>
      'Anna vanhan tilisi tunnus (SF-…). Koodi lähetetään tiliin yhdistettyyn Telegramiin.';

  @override
  String get recoverIdLabel => 'Tunnus (SF-…)';

  @override
  String get recoverSend => 'Lähetä koodi';

  @override
  String get recoverCodeSent => 'Koodi lähetetty Telegramissa.';

  @override
  String get recoverCodeLabel => 'Saatu koodi (6 numeroa)';

  @override
  String get recoverConfirm => 'Palauta tilini';

  @override
  String get recoverDone => 'Valmis: olet taas tililläsi.';

  @override
  String get exportData => 'Vie tietoni';

  @override
  String get exportDataSub => 'Tiedosto kaikista henkilötiedoistasi';

  @override
  String get deleteAccount => 'Poista tilini';

  @override
  String get deleteGhost => 'Poista ja jätä haamu';

  @override
  String get deleteGhostHint =>
      'Poistut kaikista yrityksistäsi. Kirjaudu myöhemmin samalla Google-tilillä saadaksesi tilin ja numeron takaisin.';

  @override
  String get deleteErase => 'Poista kaikki pysyvästi';

  @override
  String get deleteEraseHint =>
      'Nimi, sähköposti, kuva, Telegram, viestit ja ilmoitukset poistetaan. Tätä ei voi perua.';

  @override
  String get deleteGhostNote =>
      'Molemmissa tapauksissa yritysten historiaan jää sinun tilallesi anonyymi ”Ghost” (lomapyynnöt, menneet vuorot…), jotta omistaja ja esihenkilöt voivat jäljittää tapahtumat.';

  @override
  String get deleteOwnerNote =>
      'Omistatko yrityksen? Siirrä se ensin tai anna tilauksen päättyä.';

  @override
  String get deleteConfirmButton => 'Poista';

  @override
  String get accountRestored =>
      'Tervetuloa takaisin! Tilisi on aktivoitu uudelleen.';

  @override
  String get closedInvoices => 'Suljettujen yritysten laskut';

  @override
  String get downloadAllInvoices => 'Lataa kaikki laskut (ZIP)';

  @override
  String get legalTerms => 'Käyttö- ja myyntiehdot';

  @override
  String get legalPrivacy => 'Tietosuojakäytäntö';

  @override
  String get billingDetailTitle => 'Maksun erittely';

  @override
  String billingLineProrata(String days, String total) {
    return 'Kuluvan kuun loppu ($days/$total päivää): tilaus';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Kuluvan kuun loppu ($days/$total päivää): ”sisäkkäiset toimipaikat” -lisä';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Tilaus, $staff työntekijää: 1 kuukausi';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Tilaus, $staff työntekijää: 12 kuukautta $paid kuukauden hinnalla';
  }

  @override
  String billingLineCascade(String months) {
    return '”Sisäkkäiset toimipaikat” -lisä: $months kk, ei alennusta';
  }

  @override
  String get billingTotal => 'Yhteensä';

  @override
  String billingCovers(String from, String to) {
    return 'Kausi: $from–$to';
  }

  @override
  String get billingGraceInvoices =>
      'Tätä yritystä ei uusita: lataa kaikki sen laskut nyt.';

  @override
  String get billingYearLabel => 'Vuosi';

  @override
  String get sitesNoneChosen => 'Toimipaikkaa ei valittu';

  @override
  String get avatarTitle => 'Oma avatar';

  @override
  String get avatarSub => 'Kuva valokuvasi sijaan';

  @override
  String get avatarUseGoogle => 'Käytä Google-kuvaani';

  @override
  String get avatarColor => 'Väri';

  @override
  String get hidePhotosTitle => 'Piilota Google-kuvat';

  @override
  String get hidePhotosSub =>
      'Tässä yrityksessä jokainen näkyy avatarillaan tai alkukirjaimellaan.';

  @override
  String get billingApi => '”API-pääsy”-lisä';

  @override
  String billingLineApi(String months) {
    return '”API-pääsy”-lisä: $months kk, ei alennusta';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Kuluvan kuun loppu ($days/$total päivää): ”API-pääsy”-lisä';
  }

  @override
  String get apiTitle => 'API-pääsy (kirjanpito, CRM)';

  @override
  String get apiSub =>
      'Kirjanpito-, palkka- tai CRM-ohjelmasi lukee julkaistun vuorolistan, tunnit ja poissaolot.';

  @override
  String get apiNeedsOption =>
      'Maksullinen lisä: lisää ”API-pääsy” kohdassa ”Hallitse tilausta”.';

  @override
  String get apiNewKey => 'Uusi avain';

  @override
  String get apiKeyName => 'Avaimen nimi (esim. palkkaohjelma)';

  @override
  String get apiKeyCreated =>
      'Kopioi avain nyt ja säilytä se turvallisesti: sitä ei näytetä uudelleen.';

  @override
  String get apiKeyCopy => 'Kopioi';

  @override
  String get apiKeyCopied => 'Avain kopioitu.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Viimeksi käytetty: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Ei koskaan käytetty';

  @override
  String get apiRevoke => 'Peru';

  @override
  String get apiRevokeConfirm =>
      'Avainta käyttävät ohjelmat menettävät pääsyn.';

  @override
  String get apiDocs => 'API-dokumentaatio';

  @override
  String get memberGoogleLink => 'Linkki Google-tilin vaihtoon';

  @override
  String googleLinkHint(String name) {
    return 'Lähetä tämä linkki henkilölle $name. Se avautuu selaimessa (ei Android-sovelluksessa), kerran, 24 tunnin ajan: $name kirjautuu uudella Google-tilillään ja saa tilinsä takaisin. Kaikki hänen muut laitteensa kirjataan silloin ulos.';
  }

  @override
  String get googleLinkCopied => 'Linkki kopioitu.';

  @override
  String get switchBanner =>
      'Google-tilin vaihtolinkki: kirjaudu uudella Google-tililläsi saadaksesi Staff Flow -tilisi takaisin.';

  @override
  String get switchSignOutFirst =>
      'Tämä linkki yhdistää Staff Flow -tilin uuteen Google-tiliin. Kirjaudu ensin ulos ja sitten sisään uudella Google-tilillä.';

  @override
  String get switchDone =>
      'Valmis: Staff Flow -tilisi on yhdistetty tähän Google-tiliin. Muut laitteesi on kirjattu ulos.';

  @override
  String changeGoogleBot(String bot) {
    return 'Helpointa: lähetä Telegramissa /changegoogle botille $bot ja noudata ohjeita; kirjaudu sitten 10 minuutin kuluessa uudella Google-tilillä.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Ilman Telegramia: pyydä omistajalta tai esihenkilöltä linkki Google-tilin vaihtoon.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name loi linkin, jolla tilisi yhdistetään uuteen Google-tiliin. Jos et pyytänyt tätä, kerro esihenkilöllesi.';
  }
}
