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
  String get viewTeam => 'Konfiguracja';

  @override
  String get viewPositions => 'Struktura';

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

  @override
  String get syncUpToDate => 'Aktualne';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Oczekujące zmiany: $count';
  }

  @override
  String get syncNow => 'Synchronizuj';

  @override
  String syncRejected(String reason) {
    return 'Serwer odrzucił zmianę: $reason';
  }

  @override
  String get pendingBadge => 'Oczekuje';

  @override
  String get offlineUnavailable => 'Niedostępne offline.';

  @override
  String get offlineCached => 'Offline: ostatnio zapisane dane.';

  @override
  String get savedOffline =>
      'Zapisano na urządzeniu, zostanie wysłane po powrocie sieci.';

  @override
  String get notices => 'Powiadomienia';

  @override
  String get noNotices => 'Brak powiadomień.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name zastąpił(a) Twoją zmianę zmiany z $date.';
  }

  @override
  String get history => 'Historia';

  @override
  String get recentChanges => 'Ostatnie zmiany';

  @override
  String get undoChange => 'Cofnij tę zmianę';

  @override
  String get undoDone => 'Zmiana cofnięta.';

  @override
  String get historyCreate => 'Utworzenie';

  @override
  String get historyUpdate => 'Edycja';

  @override
  String get historyDelete => 'Usunięcie';

  @override
  String get historyUndo => 'Cofnięcie';

  @override
  String get noHistory => 'Brak zmian.';

  @override
  String get pendingNotEditable =>
      'Ta zmiana nie jest jeszcze zsynchronizowana: spróbuj ponownie online.';

  @override
  String get myQrCode => 'Mój kod QR';

  @override
  String get myQrCodeHint =>
      'Kierownik skanuje ten kod, aby dodać cię do swojej firmy; potem potwierdzasz. Kod nigdy się nie zmienia.';

  @override
  String get changeMyName => 'Zmień moje imię';

  @override
  String get nameShownToTeam =>
      'To imię widzą twoi współpracownicy zamiast imienia z Google.';

  @override
  String googleName(String name) {
    return 'Imię w Google: $name';
  }

  @override
  String get useGoogleName => 'Użyj imienia z Google';

  @override
  String renameMemberTitle(String name) {
    return 'Zmień nazwę: $name';
  }

  @override
  String get renameMemberHint => 'To imię jest używane tylko w tej firmie.';

  @override
  String get useOwnName => 'Użyj własnego imienia';

  @override
  String get scanQrCode => 'Zeskanuj kod QR';

  @override
  String get scanQrHint =>
      'Skieruj aparat na kod QR wyświetlony w aplikacji tej osoby (menu konta, „Mój kod QR”).';

  @override
  String get orEnterCode => 'Lub wpisz jej 6-cyfrowy kod';

  @override
  String get qrInvalid => 'To nie jest kod QR Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Aparat niedostępny ($error).';
  }

  @override
  String get notificationsTitle => 'Powiadomienia';

  @override
  String get notifChooseHint =>
      'Wybierz, o czym chcesz dostawać powiadomienia. Wszystko pozostaje widoczne pod dzwonkiem.';

  @override
  String get notifPlanning => 'Grafik opublikowany lub zmieniony';

  @override
  String get notifRequests => 'Prośby: zamiany, urlopy, zaproszenia';

  @override
  String get notifMessages => 'Nowe ogłoszenia';

  @override
  String get notifOverlap => 'Nakładające się zmiany w różnych firmach';

  @override
  String get notifConflicts =>
      'Twoje zmiany zastąpione przez innego kierownika';

  @override
  String get notifBilling => 'Przypomnienia o subskrypcji';

  @override
  String get pushEnabled => 'Powiadomienia są włączone na tym urządzeniu.';

  @override
  String get pushOff => 'Powiadomienia są wyłączone na tym urządzeniu.';

  @override
  String get pushBlocked =>
      'Powiadomienia są zablokowane: zezwól na nie w ustawieniach telefonu lub przeglądarki.';

  @override
  String get pushUnavailable =>
      'Powiadomienia nie są dostępne na tym urządzeniu.';

  @override
  String get enablePush => 'Włącz';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: twój grafik został opublikowany lub zmieniony.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company chce dodać cię do swojego zespołu.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name proponuje, abyś został właścicielem $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name dołączył do $company.';
  }

  @override
  String get translateAction => 'Przetłumacz';

  @override
  String get deleteAllNotices => 'Usuń wszystko';

  @override
  String get deleteAllNoticesConfirm => 'Usunąć wszystkie powiadomienia?';

  @override
  String get noticeRetention => 'Usuwaj przeczytane powiadomienia po';

  @override
  String get retentionDay => '1 dniu';

  @override
  String get retentionWeek => '1 tygodniu';

  @override
  String get retentionMonth => '1 miesiącu';

  @override
  String get billingOwnersOnly =>
      'Działa tylko, jeśli jesteś właścicielem firmy.';

  @override
  String get readOnlyPastDays =>
      'Dni sprzed ponad miesiąca są tylko do odczytu.';

  @override
  String get wholeCompany => 'Cała firma';

  @override
  String get sitesLabel => 'Lokalizacje';

  @override
  String get actionSites => 'Lokalizacje…';

  @override
  String managerOf(String name) {
    return '$name zarządza';
  }

  @override
  String teamSitesOf(String name) {
    return 'Zespół: $name';
  }

  @override
  String get notYourSite =>
      'Ta lokalizacja nie jest pod twoją odpowiedzialnością.';

  @override
  String get chooseYourSite => 'Wybierz co najmniej jedną lokalizację.';

  @override
  String get viewRequests => 'Prośby';

  @override
  String get newRequest => 'Nowa prośba';

  @override
  String get requestLeave => 'Urlop';

  @override
  String get requestUnavailability => 'Niedostępność';

  @override
  String get requestSwap => 'Zamiana zmian';

  @override
  String get swapHint =>
      'Aby zaproponować zamianę, dotknij jednej ze swoich przyszłych zmian w grafiku.';

  @override
  String get noRequests => 'Na razie brak próśb.';

  @override
  String get requestsToHandle => 'Do załatwienia';

  @override
  String get statusPendingPeer => 'Czeka na współpracownika';

  @override
  String get statusPendingManager => 'Czeka na kierownika';

  @override
  String get statusApproved => 'Zaakceptowana';

  @override
  String get statusRefused => 'Odrzucona';

  @override
  String get statusCancelled => 'Anulowana';

  @override
  String get cancelRequest => 'Anuluj prośbę';

  @override
  String get acceptSwap => 'Przejmij tę zmianę';

  @override
  String get approve => 'Zatwierdź';

  @override
  String periodLabel(String from, String to) {
    return 'Od $from do $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Zaproponowano: $name';
  }

  @override
  String get swapToTeam => 'Cały zespół';

  @override
  String everyWeekdays(String days) {
    return 'Co tydzień: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dni, w które nigdy nie jesteś dostępny:';

  @override
  String get choosePeriod => 'Wybierz daty';

  @override
  String get choosePeriodOptional => 'Ogranicz do okresu (opcjonalnie)';

  @override
  String get clearPeriod => 'Bez okresu';

  @override
  String get sendRequest => 'Wyślij prośbę';

  @override
  String get proposeSwap => 'Zaproponuj zamianę';

  @override
  String get swapWith => 'Zaproponuj';

  @override
  String get swapSteps =>
      'Współpracownik akceptuje, potem kierownik zatwierdza. Grafik zmienia się dopiero wtedy.';

  @override
  String get absentThatDay => 'Zatwierdzona nieobecność tego dnia';

  @override
  String get requestSent => 'Prośba wysłana.';

  @override
  String noticeSwapOffer(String name) {
    return '$name proponuje ci jedną ze swoich zmian.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name odrzucił twoją propozycję zamiany.';
  }

  @override
  String get noticeSwapToApprove =>
      'Zamiana zmian czeka na twoje zatwierdzenie.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name prosi o urlop.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name zgłasza niedostępność.';
  }

  @override
  String get noticeRequestApproved => 'Twoja prośba została zaakceptowana.';

  @override
  String get noticeRequestRefused => 'Twoja prośba została odrzucona.';

  @override
  String get choosePeer => 'Kto przejmie tę zmianę?';

  @override
  String get discardAll => 'Anuluj wszystko';

  @override
  String get notifySitesHint =>
      'Wybierz lokalizacje, z których otrzymujesz powiadomienia o prośbach. Wszystkie prośby pozostają widoczne na liście.';

  @override
  String get pendingRequestTooltip =>
      'Oczekująca prośba: dotknij, aby otworzyć';

  @override
  String get requestsHistory => 'Wszystkie prośby';

  @override
  String get revertChange => 'Cofnij tę zmianę';

  @override
  String get statusExpired => 'Nieaktualna';

  @override
  String get swapWithHint => 'Dotknij, aby wybrać konkretnego współpracownika';

  @override
  String changesDiscarded(String count) {
    return 'Anulowane zmiany: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Anulować $count nieopublikowanych zmian?';
  }

  @override
  String get allSchedules => 'Wszystkie moje grafiki';

  @override
  String get busyElsewhere => 'Pracuje już w tym czasie w innej firmie';

  @override
  String get overlapTooltip => 'Nakłada się na zmianę w innej firmie';

  @override
  String get overlapWarning =>
      'Niektóre twoje zmiany w dwóch firmach nakładają się.';

  @override
  String noticeOverlap(String date) {
    return 'Dwie twoje zmiany w różnych firmach nakładają się $date.';
  }

  @override
  String get allMyCompanies => 'Wszystkie moje firmy';

  @override
  String get openRequest => 'Zobacz prośbę';

  @override
  String get thisCompany => 'Ta firma';

  @override
  String get withExtras => 'Z pracownikami dorywczymi';

  @override
  String reinforcementHint(String company) {
    return 'Z firmy $company: zostanie dodany jako wsparcie i powiadomiony.';
  }

  @override
  String get addToGoogle => 'Dodaj do Kalendarza Google';

  @override
  String get calendarEnabled => 'Synchronizuj moje zmiany';

  @override
  String get changeSettings => 'Zmień';

  @override
  String get countryBelgium => 'Belgia';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Francja';

  @override
  String get countrySwitzerland => 'Szwajcaria';

  @override
  String get employeesSection => 'Pracownicy';

  @override
  String get emptyNoAlert => 'Puste: bez ostrzeżenia';

  @override
  String get extrasSection => 'Dorywczy';

  @override
  String get googleCalendar => 'Kalendarz Google';

  @override
  String get hoursTotals => 'Sumy godzin';

  @override
  String get legalAlerts => 'Ostrzeżenia prawne';

  @override
  String get legalAlertsHint =>
      'Tylko ostrzeżenia, nigdy blokady. Wybierz zasady, które cię dotyczą, albo żadne.';

  @override
  String get legalPreset => 'Szablon kraju';

  @override
  String get maxConsecutiveLabel => 'Maksymalna liczba dni pracy z rzędu';

  @override
  String get maxDayLabel => 'Maksymalny czas dziennie (godziny)';

  @override
  String get maxWeekLabel => 'Maksymalny czas tygodniowo (godziny)';

  @override
  String get minRestLabel => 'Minimalny odpoczynek między zmianami (godziny)';

  @override
  String get noLegalRules => 'Nie wybrano ostrzeżeń.';

  @override
  String get presetNone => 'Brak';

  @override
  String get presetsCheck =>
      'Szablony to punkt wyjścia: sprawdź je zgodnie z przepisami swojego kraju i układem zbiorowym.';

  @override
  String get printMine => 'Mój grafik';

  @override
  String get printOwn => 'Tylko własny grafik';

  @override
  String get printPdf => 'Drukuj / PDF';

  @override
  String get printRights => 'Co mogą drukować pracownicy';

  @override
  String get printTeam => 'Grafik całego zespołu';

  @override
  String get printTeamOption => 'Grafik zespołu';

  @override
  String get totalsHint =>
      'Z wersjami roboczymi. Eksport do Excela i CSV używa opublikowanego grafiku.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dni z rzędu (maksymalnie $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value w ciągu dnia (maksymalnie $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: tylko $value odpoczynku (minimum $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value w tygodniu (maksymalnie $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Ostrzeżenia prawne: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Zmiany: $count';
  }

  @override
  String get actionMakeDeputy => 'Mianuj zastępcą kierownika';

  @override
  String get actionRemoveDeputy => 'Odbierz rolę zastępcy';

  @override
  String get busyHere => 'Pracuje już w firmie w tym czasie';

  @override
  String get calendarDenied =>
      'Odmówiono dostępu do kalendarza. Zezwól na niego w ustawieniach telefonu.';

  @override
  String get calendarLinkHint =>
      'Dodaj z Kalendarza Google na komputerze; Google aktualizuje go w ciągu kilku godzin.';

  @override
  String get calendarNone => 'Brak edytowalnego kalendarza na tym telefonie.';

  @override
  String get calendarOnPhoneHint =>
      'W twoim kalendarzu Google: widoczne od razu, w telefonie i w Kalendarzu Google.';

  @override
  String get chooseCalendar => 'Wybierz kalendarz';

  @override
  String get otherSiteHint =>
      'Pracownik innej lokalizacji: jego kierownicy zostaną powiadomieni.';

  @override
  String get subManager => 'Zastępca kierownika';

  @override
  String calendarSynced(String count) {
    return 'Zmiany w kalendarzu: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Zastępca kierownika: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by przydzielił $name do lokalizacji $site $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company dodała cię jako wsparcie.';
  }

  @override
  String get companyNotificationsHint =>
      'Wyłączone: na tym telefonie nic nie dzwoni, ale wszystko zostaje w dzwonku.';

  @override
  String get companyNotificationsOn => 'Otrzymuj powiadomienia z tej firmy';

  @override
  String get companyTimezone => 'Strefa czasowa firmy';

  @override
  String get companyTimezoneHint =>
      'Wszystkie godziny tej firmy są w tej strefie (z czasem letnim). Kalendarze przeliczają je automatycznie.';

  @override
  String get iosInstallHint =>
      'Na iPhonie: dotknij Udostępnij, a potem „Do ekranu początkowego”, aby zainstalować Staff Flow.';

  @override
  String get searchCity => 'Szukaj miasta';

  @override
  String get thisPhone => 'To urządzenie';

  @override
  String companyNotifications(String name) {
    return 'Powiadomienia: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Godziny według czasu $zone ($company). Twoje urządzenie: $here.';
  }

  @override
  String get addPreset => 'Dodaj szablon';

  @override
  String get addPresets => 'Utwórz szablony';

  @override
  String get appearance => 'Wygląd';

  @override
  String get chooseLogo => 'Wybierz obraz PNG';

  @override
  String get customization => 'Personalizacja';

  @override
  String get editPresets => 'Szablony';

  @override
  String get enable => 'Włącz ponownie';

  @override
  String get logoHint =>
      'Mały obraz PNG (twoje logo) widoczny na karcie firmy dla wszystkich jej członków.';

  @override
  String get logoPngOnly => 'Wybierz obraz PNG do 1 MB.';

  @override
  String get myIdentifier => 'Mój identyfikator';

  @override
  String get myProfile => 'Mój profil';

  @override
  String get presetName => 'Nazwa (np. Rano)';

  @override
  String get removeLogo => 'Usuń obraz';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get shiftPresets => 'Szablony godzin';

  @override
  String get shiftPresetsHint =>
      'Gotowe godziny (rano, wieczór, noc…): jedno dotknięcie w zmianie wypełnia początek i koniec.';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get awaitingApproval => 'Do zatwierdzenia';

  @override
  String get placementNeedsApproval =>
      '! Ta osoba nie należy do Twoich placówek: zmiana poczeka na zatwierdzenie przez przełożonego lub właściciela, zanim będzie można ją opublikować. W przeciwnym razie wybierz kogoś innego.';

  @override
  String get placementAwaiting =>
      'Czeka na zatwierdzenie przez przełożonego lub właściciela.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by chce zaplanować $name z innej placówki na $date: wymaga zatwierdzenia.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by zatwierdził(a) zaplanowanie $name na $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by odrzucił(a) zaplanowanie $name na $date.';
  }

  @override
  String get addSubSite => 'Dodaj podplacówkę';

  @override
  String get moveSite => 'Przenieś';

  @override
  String get topLevel => 'Najwyższy poziom';

  @override
  String moveSiteTitle(String name) {
    return 'Przenieś „$name” pod…';
  }

  @override
  String subSiteOf(String name) {
    return 'Podplacówka $name';
  }

  @override
  String get siteTreeHint =>
      'Do 10 poziomów, np. Region › Miasto › Sklep. Pierwsze 3 są w subskrypcji; dalej potrzebna jest opcja „Lokalizacje kaskadowe”. Kierownik lokalizacji zarządza też wszystkim poniżej.';

  @override
  String get subSitesOnlyHint =>
      'Tutaj dodajesz podplacówki pod swoimi placówkami.';

  @override
  String get messagingSetting => 'Aktualności firmy';

  @override
  String get messagingSettingHint =>
      'Włączone: właściciel i kierownicy publikują ogłoszenia (dla wszystkich, stanowiska, lokalizacji lub wybranych osób); każdy je czyta i może przetłumaczyć. Wyłączone: karta znika dla wszystkich.';

  @override
  String get billingTitle => 'Subskrypcja';

  @override
  String billingStatusTrial(String date) {
    return 'Bezpłatny okres próbny do $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Opłacono do $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Tylko do odczytu: bez płatności firma zostanie usunięta $date.';
  }

  @override
  String get billingStatusComped => 'Bezpłatna';

  @override
  String billingStaff(String count) {
    return '$count pracowników i kierowników (bez właściciela i dorywczych)';
  }

  @override
  String get billingMonthly => 'Miesięcznie';

  @override
  String billingYearly(String months) {
    return 'Rocznie (opłata za $months mies.)';
  }

  @override
  String get billingCascade => 'Opcja „Lokalizacje kaskadowe” (poziomy 4–10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'W cenie od $count pracowników';
  }

  @override
  String billingPay(String amount) {
    return 'Zapłać $amount';
  }

  @override
  String get billingTestNotice => 'Płatność testowa: nic nie jest pobierane.';

  @override
  String get billingSoon => 'Płatność online będzie dostępna wkrótce.';

  @override
  String get billingPaidOk => 'Płatność zarejestrowana.';

  @override
  String get billingInvoices => 'Faktury';

  @override
  String get billingNoInvoices => 'Brak faktur.';

  @override
  String get billingManage => 'Zarządzaj subskrypcją';

  @override
  String get billingReadOnlyStaff =>
      'Ta firma jest tylko do odczytu, dopóki właściciel nie odnowi subskrypcji.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / mies.';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / rok';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: bezpłatny okres próbny kończy się za mniej niż 24 godziny.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company jest tylko do odczytu z powodu braku płatności; usunięcie $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Przypomnienie: bez płatności $company zostanie usunięta $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company została usunięta z powodu braku płatności.';
  }

  @override
  String billingCompanyId(String id) {
    return 'ID firmy: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Dzisiaj: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Obejmuje resztę bieżącego miesiąca ($days dni, proporcjonalnie), a potem pełne miesiące od 1. dnia.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Jeszcze nie połączono. Służy do potwierdzania tożsamości, np. przy zmianie konta Google.';

  @override
  String telegramLinked(String name) {
    return 'Połączono: $name';
  }

  @override
  String get telegramNoUsername => 'bez nazwy użytkownika';

  @override
  String get telegramLink => 'Połącz mój Telegram';

  @override
  String get telegramLinkHint =>
      'Otworzy się Telegram: dotknij „Start”, a potem wróć tutaj.';

  @override
  String get telegramUnlink => 'Odłącz';

  @override
  String get telegramUnavailable => 'Telegram nie jest jeszcze dostępny.';

  @override
  String get telegramShowIn => 'Pokazuj mój Telegram w:';

  @override
  String get newQrCode => 'Zmień kod QR';

  @override
  String get newQrCodeConfirm =>
      'Stary kod QR i stary identyfikator przestaną działać. Twoje miejsce w firmach się nie zmienia.';

  @override
  String get newQrCodeDone => 'Utworzono nowy kod QR.';

  @override
  String get changeGoogle => 'Zmień konto Google';

  @override
  String get changeGoogleSub => 'To samo konto, ten sam numer, te same firmy';

  @override
  String changeGoogleSteps(String id) {
    return '1. Połącz Telegram w tym profilu (wymagane).\n2. Wyloguj się, a następnie zaloguj nowym kontem Google.\n3. Wybierz „Mam już konto Staff Flow” i wpisz swój identyfikator $id.\n4. Wpisz kod otrzymany na Telegramie.\nTwoje konto, numer i firmy pozostają bez zmian.';
  }

  @override
  String get recoverAccount => 'Mam już konto Staff Flow';

  @override
  String get recoverHint =>
      'Wpisz identyfikator starego konta (SF-…). Kod zostanie wysłany na Telegram połączony z tym kontem.';

  @override
  String get recoverIdLabel => 'Identyfikator (SF-…)';

  @override
  String get recoverSend => 'Wyślij kod';

  @override
  String get recoverCodeSent => 'Kod wysłano na Telegram.';

  @override
  String get recoverCodeLabel => 'Otrzymany kod (6 cyfr)';

  @override
  String get recoverConfirm => 'Odzyskaj moje konto';

  @override
  String get recoverDone => 'Gotowe: wróciłeś do swojego konta.';

  @override
  String get exportData => 'Eksportuj moje dane';

  @override
  String get exportDataSub => 'Plik ze wszystkimi Twoimi danymi osobowymi';

  @override
  String get deleteAccount => 'Usuń moje konto';

  @override
  String get deleteGhost => 'Usuń, zostawiając ducha';

  @override
  String get deleteGhostHint =>
      'Opuszczasz wszystkie firmy. Zaloguj się później tym samym kontem Google, aby odzyskać konto i numer.';

  @override
  String get deleteErase => 'Usuń wszystko na zawsze';

  @override
  String get deleteEraseHint =>
      'Imię, e-mail, zdjęcie, Telegram, wiadomości i powiadomienia zostaną usunięte. Nie można tego cofnąć.';

  @override
  String get deleteGhostNote =>
      'W obu przypadkach historia firm zachowuje w Twoim miejscu anonimowego „Ghost” (wnioski urlopowe, dawne zmiany…), aby właściciel i kierownicy mogli odtworzyć zdarzenia.';

  @override
  String get deleteOwnerNote =>
      'Jesteś właścicielem firmy? Najpierw ją przekaż albo pozwól, by subskrypcja wygasła.';

  @override
  String get deleteConfirmButton => 'Usuń';

  @override
  String get accountRestored =>
      'Witaj ponownie! Twoje konto zostało reaktywowane.';

  @override
  String get closedInvoices => 'Faktury zamkniętych firm';

  @override
  String get downloadAllInvoices => 'Pobierz wszystkie faktury (ZIP)';

  @override
  String get legalTerms => 'Warunki korzystania i sprzedaży';

  @override
  String get legalPrivacy => 'Polityka prywatności';

  @override
  String get billingDetailTitle => 'Szczegóły płatności';

  @override
  String billingLineProrata(String days, String total) {
    return 'Reszta bieżącego miesiąca ($days z $total dni): subskrypcja';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Reszta bieżącego miesiąca ($days z $total dni): opcja „zagnieżdżone lokalizacje”';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Subskrypcja, $staff miejsc: 1 miesiąc';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Subskrypcja, $staff miejsc: 12 miesięcy w cenie $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Opcja „zagnieżdżone lokalizacje”: $months mies., bez rabatu';
  }

  @override
  String get billingTotal => 'Razem';

  @override
  String billingCovers(String from, String to) {
    return 'Okres: od $from do $to';
  }

  @override
  String get billingGraceInvoices =>
      'Ta firma nie zostanie przedłużona: pobierz teraz wszystkie jej faktury.';

  @override
  String get billingYearLabel => 'Rok';

  @override
  String get sitesNoneChosen => 'Nie wybrano lokalizacji';

  @override
  String get avatarTitle => 'Mój awatar';

  @override
  String get avatarSub => 'Obrazek zamiast Twojego zdjęcia';

  @override
  String get avatarUseGoogle => 'Użyj mojego zdjęcia Google';

  @override
  String get avatarColor => 'Kolor';

  @override
  String get hidePhotosTitle => 'Ukryj zdjęcia Google';

  @override
  String get hidePhotosSub =>
      'W tej firmie każdy jest widoczny z awatarem lub inicjałem.';

  @override
  String get billingApi => 'Opcja „dostęp API”';

  @override
  String billingLineApi(String months) {
    return 'Opcja „dostęp API”: $months mies., bez rabatu';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Reszta bieżącego miesiąca ($days z $total dni): opcja „dostęp API”';
  }

  @override
  String get apiTitle => 'Dostęp API (księgowość, CRM)';

  @override
  String get apiSub =>
      'Twoje programy (płace, księgowość, CRM, planowanie) odczytują opublikowany grafik, godziny i nieobecności; z „API Pro” mogą też wysyłać grafiki, pracowników i ogłoszenia.';

  @override
  String get apiNeedsOption =>
      'Opcja płatna: dodaj „Dostęp API” lub „API Pro” w „Zarządzaj subskrypcją”.';

  @override
  String get apiNewKey => 'Nowy klucz';

  @override
  String get apiKeyName => 'Nazwa klucza (np. program płacowy)';

  @override
  String get apiKeyCreated =>
      'Skopiuj ten klucz teraz i przechowuj go bezpiecznie: nie zostanie ponownie wyświetlony.';

  @override
  String get apiKeyCopy => 'Kopiuj';

  @override
  String get apiKeyCopied => 'Klucz skopiowany.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Ostatnie użycie: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Nigdy nieużywany';

  @override
  String get apiRevoke => 'Unieważnij';

  @override
  String get apiRevokeConfirm =>
      'Programy używające tego klucza stracą dostęp.';

  @override
  String get apiDocs => 'Dokumentacja API';

  @override
  String get memberGoogleLink => 'Ponowne logowanie Google pracownika';

  @override
  String googleLinkHint(String name) {
    return 'Wyślij ten link osobie $name. Otwiera się w przeglądarce (nie w aplikacji na Androida), tylko raz, przez 24 godziny: $name loguje się nowym kontem Google i odzyskuje swoje konto. Wszystkie pozostałe urządzenia zostają wtedy wylogowane.';
  }

  @override
  String get googleLinkCopied => 'Link skopiowany.';

  @override
  String get switchBanner =>
      'Link do zmiany konta Google: zaloguj się nowym kontem Google, aby odzyskać konto Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Ten link łączy konto Staff Flow z nowym kontem Google. Najpierw się wyloguj, a potem zaloguj nowym kontem Google.';

  @override
  String get switchDone =>
      'Gotowe: Twoje konto Staff Flow jest połączone z tym kontem Google. Pozostałe urządzenia zostały wylogowane.';

  @override
  String changeGoogleBot(String bot) {
    return 'Najprościej: w Telegramie wyślij /changegoogle do bota $bot i postępuj zgodnie z instrukcjami, a następnie w ciągu 10 minut zaloguj się nowym kontem Google.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Bez Telegramu: poproś właściciela lub kierownika o link do zmiany konta Google.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name utworzył(a) link do połączenia Twojego konta z nowym kontem Google. Jeśli o to nie prosiłeś, powiadom swojego kierownika.';
  }

  @override
  String get sessionRevoked =>
      'Wylogowano: Twoje konto jest teraz połączone z innym kontem Google.';

  @override
  String telegramLoginHint(String bot) {
    return 'Wskazówka: wyślij /connexion do bota $bot, aby dostać link i otworzyć Staff Flow w przeglądarce, bez aplikacji i konta Google.';
  }

  @override
  String get timeFormat => 'Format godziny';

  @override
  String get timeFormatAuto => 'Auto';

  @override
  String get people => 'Osoby';

  @override
  String get sortNatural => 'Zwykła kolejność';

  @override
  String get sortName => 'Imię i nazwisko';

  @override
  String get employeeNumber => 'Numer pracownika';

  @override
  String get sfIdLabel => 'ID Staff Flow';

  @override
  String get pickSearch => 'Szukaj';

  @override
  String get pickSearchPeople => 'Szukaj: imię, numer pracownika, ID SF';

  @override
  String get pickSortTitle => 'Sortuj i pokazuj według';

  @override
  String pickSelected(String count) {
    return 'Zaznaczone: $count';
  }

  @override
  String get pickCheckAll => 'Zaznacz wszystkich';

  @override
  String get pickClear => 'Odznacz wszystkich';

  @override
  String get pickNoResult => 'Brak wyników';

  @override
  String get pickMultiHint =>
      'Zaznacz kilka osób: dla każdej zostanie utworzona zmiana, wszystko naraz.';

  @override
  String get filterAll => 'Wszystkie';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'Bez stanowiska';

  @override
  String get noSiteGroup => 'Bez lokalizacji';

  @override
  String get groupByTitle => 'Grupuj według';

  @override
  String get groupRole => 'Rola';

  @override
  String get groupNone => 'Bez grupowania';

  @override
  String showMore(String count, String left) {
    return 'Pokaż jeszcze $count (zostało $left)';
  }

  @override
  String get findByQr => 'Znajdź członka po jego kodzie QR';

  @override
  String get qrNotMember => 'Ten kod QR nie pasuje do nikogo w tej firmie.';

  @override
  String get memberProfile => 'Numer pracownika i stanowisko';

  @override
  String get employeeNumberHint =>
      'Własny numer Twojej firmy (opcjonalnie). ID Staff Flow pozostaje przypisane.';

  @override
  String get usualPosition => 'Zwykłe stanowisko';

  @override
  String get inviteCodeTitle => 'Kod zaproszenia';

  @override
  String get inviteCodeHint =>
      'Wpisz kod otrzymany od pracodawcy albo zeskanuj kod QR zaproszenia.';

  @override
  String inviteJoined(String company) {
    return 'Dołączyłeś(-aś) do $company.';
  }

  @override
  String get importTitle => 'Importuj pracowników';

  @override
  String get importIntro =>
      'Zaimportuj listę pracowników z pliku Excel lub CSV. Każdy otrzyma osobisty kod i kod QR: aktywuje konto aplikacją 2FA (lub przez Google). Nikt nie zostanie dodany bez zgody.';

  @override
  String get importTemplate => 'Pobierz szablon Excel';

  @override
  String get importTemplateHint =>
      'Kolumny: imię i nazwisko, numer pracownika, stanowisko, lokalizacja. Wymagane jest tylko imię i nazwisko.';

  @override
  String get importChooseFile => 'Wybierz plik (.xlsx lub .csv)';

  @override
  String importNew(String count) {
    return 'Nowi: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Zaktualizowano: $count';
  }

  @override
  String importSkip(String count) {
    return 'Już zaproszeni: $count';
  }

  @override
  String importErrors(String count) {
    return 'Błędy: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Importuj ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Wiersze z błędami zostaną pominięte: popraw je w pliku i zaimportuj ponownie.';

  @override
  String get importCreated => 'nowy';

  @override
  String importDone(String count) {
    return 'Utworzono zaproszeń: $count';
  }

  @override
  String get invitesTitle => 'Oczekujące zaproszenia';

  @override
  String get invitesPrint => 'Drukuj kody';

  @override
  String get inviteShowHint =>
      'Osoba wybiera „Aktywuj moje konto” na ekranie logowania (albo „Mam kod zaproszenia”, jeśli ma już konto), a potem skanuje ten kod QR lub wpisuje ten kod. Ważny 90 dni, jednorazowo.';

  @override
  String invitesHint(String count) {
    return 'Oczekujące zaproszenia: $count. Dotknij osoby, aby pokazać jej kod i kod QR, albo wydrukuj wszystkie.';
  }

  @override
  String get inviteSeenByEmail => 'zaproszenie widoczne (e-mail)';

  @override
  String get invitesNone => 'Brak oczekujących zaproszeń.';

  @override
  String get haveInviteCode => 'Mam kod zaproszenia';

  @override
  String get newsTab => 'Aktualności';

  @override
  String get newsNew => 'Nowe ogłoszenie';

  @override
  String get newsEmpty => 'Na razie brak ogłoszeń.';

  @override
  String get newsEmptyManager =>
      'Na razie brak ogłoszeń. Opublikuj pierwsze: dla całej firmy, stanowiska, lokalizacji lub wybranych osób.';

  @override
  String get newsOlder => 'Starsze ogłoszenia';

  @override
  String get newsEdited => 'edytowano';

  @override
  String get newsEdit => 'Edytuj ogłoszenie';

  @override
  String get newsDeleteTitle => 'Usunąć to ogłoszenie?';

  @override
  String get newsForEveryone => 'Dla wszystkich';

  @override
  String get newsEveryoneMySites => 'Wszyscy w moich lokalizacjach';

  @override
  String newsFor(String names) {
    return 'Dla: $names';
  }

  @override
  String newsReadCount(String count) {
    return 'Przeczytało: $count';
  }

  @override
  String newsReadOf(String count, String total) {
    return 'Przeczytało $count z $total';
  }

  @override
  String get newsTranslated => 'Przetłumaczono automatycznie';

  @override
  String get newsTitleField => 'Tytuł (opcjonalnie)';

  @override
  String get newsBodyField => 'Treść ogłoszenia';

  @override
  String get newsRecipients => 'Odbiorcy';

  @override
  String get newsTargetHint =>
      'Zaznacz jedną lub kilka grup: ogłoszenie trafi do każdego, kto pasuje do którejkolwiek z nich.';

  @override
  String get newsPublish => 'Opublikuj';

  @override
  String newsSent(String count) {
    return 'Ogłoszenie wysłano do $count os.';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Opcja „Dostęp API”, dodana w trakcie subskrypcji, od $from do $to: $months mies., bez rabatu';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Opcja „Lokalizacje kaskadowe”, dodana w trakcie subskrypcji, od $from do $to: $months mies., bez rabatu';
  }

  @override
  String get billingRenewalOptions =>
      'Zaznaczone opcje zostaną uwzględnione w kolejnych odnowieniach. Odznaczona opcja działa do końca już opłaconego okresu.';

  @override
  String billingAddonTitle(String option) {
    return 'Dodaj teraz: $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'Cały bieżący miesiąc, potem każdy miesiąc do $date (koniec opłaconego okresu), bez rabatu. Opcja działa od razu po płatności i jest uwzględniana w kolejnych odnowieniach.';
  }

  @override
  String get billingAddonInvoice => 'opcja';

  @override
  String billingAccessRemoved(String name) {
    return '$name nie zarządza już subskrypcją.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name może teraz zarządzać subskrypcją i fakturami.';
  }

  @override
  String get actionBillingRemove => 'Odbierz zarządzanie subskrypcją';

  @override
  String get actionBillingGive => 'Zezwól na zarządzanie subskrypcją';

  @override
  String get billingAccessTag => 'Zarządza subskrypcją';

  @override
  String get billingOptionRenewed => 'Wznowiono odnawianie opcji.';

  @override
  String get billingOptionStopped =>
      'Opcja nie zostanie odnowiona: działa do końca opłaconego okresu.';

  @override
  String billingOptionEnds(String date) {
    return 'Aktywna do $date, nie zostanie odnowiona (zaznacz, aby ją zachować)';
  }

  @override
  String get billingOptionActive =>
      'Aktywna i odnawiana (odznacz, aby jej nie odnawiać)';

  @override
  String get statusCancelRequested => 'Poproszono o anulowanie';

  @override
  String get requestEndedEarly => 'Zakończone wcześniej przez tę osobę.';

  @override
  String get confirmCancelRequest =>
      'Anulować tę prośbę? Kierownicy nie będą jej już widzieć.';

  @override
  String get endUnavailability => 'Zakończ moją niedostępność';

  @override
  String get confirmEndUnavailability =>
      'Zakończyć Twoją niedostępność? Od dziś będziesz znów dostępny(-a), a kierownicy zostaną powiadomieni.';

  @override
  String get askLeaveCancel => 'Poproś o anulowanie tego urlopu';

  @override
  String get confirmAskLeaveCancel =>
      'Poprosić o anulowanie tego urlopu? Kierownik musi to zatwierdzić; do tego czasu urlop pozostaje w planie.';

  @override
  String get refuseLeaveCancel => 'Odrzuć anulowanie';

  @override
  String get acceptLeaveCancel => 'Zaakceptuj anulowanie';

  @override
  String get requestsSearchHint =>
      'Szukaj: imię, numer pracownika, ID SF, notatka';

  @override
  String get filterType => 'Typ';

  @override
  String get filterState => 'Stan';

  @override
  String get statePending => 'Oczekujące';

  @override
  String get stateClosed => 'Odrzucone lub anulowane';

  @override
  String billingLineSlotsAddon(
    String from,
    String to,
    String start,
    String end,
    String months,
  ) {
    return 'Dodane miejsca, z $from do $to, od $start do $end: $months mies., bez rabatu';
  }

  @override
  String billingSeats(String used, String limit) {
    return 'Opłacone miejsca: $used · do $limit osób z zapasem 5%';
  }

  @override
  String get billingSeatsTitle => 'Liczba miejsc';

  @override
  String get billingSeatsHint =>
      'Pracownicy i kierownicy (bez właściciela i pracowników dorywczych), w blokach po 10. 10 miejsc przy tworzeniu; powyżej zapas 5%, potem nie można dodawać.';

  @override
  String get billingSeatsUnit => 'miejsc';

  @override
  String billingSeatsAddon(String from, String to) {
    return 'Miejsca: $from → $to';
  }

  @override
  String billingSeatsRange(String min) {
    return 'Od $min do 5000, w blokach po 10.';
  }

  @override
  String get printWeek => 'Tydzień';

  @override
  String get printMonth => 'Miesiąc';

  @override
  String teamCount(String team, String count) {
    return '$team · $count';
  }

  @override
  String teamCountSeats(String team, String count, String slots) {
    return '$team · $count/$slots';
  }

  @override
  String get rememberMe => 'Pozostań zalogowany na tym urządzeniu';

  @override
  String get rememberMeHint =>
      'Włączone: jak z Google, bez kodu przy każdym otwarciu. Unikaj na wspólnym urządzeniu.';

  @override
  String get totpLoginTitle => 'Logowanie 2FA';

  @override
  String get totpCompanyCode => 'Kod firmy';

  @override
  String get totpCompanyCodeHint =>
      '6 znaków od pracodawcy (tylko z numerem pracownika).';

  @override
  String get totpBackupCode => 'Kod zapasowy';

  @override
  String get totpCode => 'Kod z aplikacji';

  @override
  String get totpUseApp => 'Użyj aplikacji 2FA';

  @override
  String get totpUseBackup => 'Użyj kodu zapasowego';

  @override
  String get totpSignIn => 'Zaloguj się';

  @override
  String get totpLostPhone =>
      'Zgubiony telefon lub usunięta aplikacja? Poproś kierownika o nowy kod aktywacji.';

  @override
  String get activateTitle => 'Aktywuj moje konto';

  @override
  String get activateStep1 => 'Krok 1: Twój kod zaproszenia';

  @override
  String get activateStep1Hint =>
      'Zeskanuj kod QR od pracodawcy albo wpisz kod podany pod nim.';

  @override
  String get activateScan => 'Zeskanuj kod QR';

  @override
  String get activateCodeField => 'Kod zaproszenia';

  @override
  String get activateContinue => 'Dalej';

  @override
  String activateHello(String name, String company) {
    return 'Witaj, $name · $company';
  }

  @override
  String get activateStep2 =>
      'Krok 2: połącz aplikację uwierzytelniającą (Google Authenticator, Microsoft Authenticator…). Będzie podawać 6-cyfrowy kod przy każdym logowaniu.';

  @override
  String get activateOpenApp => 'Dodaj do mojej aplikacji uwierzytelniającej';

  @override
  String get activateOrScan =>
      'Albo z innego urządzenia zeskanuj ten kod QR aplikacją:';

  @override
  String get activateManualKey => 'Klucz do wpisania ręcznie:';

  @override
  String get activateFirstCode => 'Pierwszy kod z aplikacji';

  @override
  String get activateDone => 'Aktywuj';

  @override
  String get totpReadyTitle => 'Twoje konto jest gotowe';

  @override
  String get totpYourId => 'Twój identyfikator Staff Flow:';

  @override
  String get totpBackupHint =>
      'Kody zapasowe (każdy jednorazowy): zapisz je lub przechowuj w bezpiecznym miejscu. Przydadzą się, jeśli nie masz już aplikacji.';

  @override
  String get totpBackupSaved => 'Zapisane';

  @override
  String get linkGoogleTitle => 'Połącz konto Google';

  @override
  String get linkGoogleHint =>
      'Aby utworzyć firmę, połącz konto Google ze swoim kontem Staff Flow. Służy ono wyłącznie do ochrony twórcy firmy i jej subskrypcji: Twój adres Google nigdy nie jest pokazywany pracownikom ani nikomu innemu, pozostaje w Staff Flow. Nadal możesz logować się aplikacją 2FA.';

  @override
  String get linkGoogleButton => 'Połącz moje konto Google';

  @override
  String get linkGoogleBanner =>
      'Zaloguj się kontem Google, które chcesz połączyć ze Staff Flow.';

  @override
  String get activationCodeAction => 'Nowy kod aktywacji';

  @override
  String activationCodeTitle(String name) {
    return 'Nowy kod dla $name?';
  }

  @override
  String get activationCodeConfirm =>
      'Stary telefon i stara aplikacja 2FA przestaną działać. Osoba ponownie aktywuje konto tym kodem (ważny 7 dni).';

  @override
  String get activationCodeHint =>
      'Osoba wybiera „Aktywuj moje konto” na ekranie logowania, a potem skanuje ten kod QR lub wpisuje ten kod.';

  @override
  String get signupTitle => 'Utwórz konto';

  @override
  String get signupStep1 => 'Krok 1: Twoje imię i nazwisko';

  @override
  String get signupStep1Hint =>
      'Imię i nazwisko, które zobaczą współpracownicy i pracodawcy. Bez Google i bez e-maila: konto chroni aplikacja uwierzytelniająca.';

  @override
  String get signupName => 'Imię i nazwisko';

  @override
  String signupHello(String name) {
    return 'Witaj, $name';
  }

  @override
  String get signupButton => 'Utwórz konto z aplikacją 2FA';

  @override
  String get totpCardTitle => 'Logowanie aplikacją 2FA';

  @override
  String totpCardLocal(String id) {
    return 'Twoje konto loguje się aplikacją uwierzytelniającą. Identyfikator: $id';
  }

  @override
  String totpCardOn(String id) {
    return 'Włączone: możesz też logować się identyfikatorem $id i kodem z aplikacji, bez Google.';
  }

  @override
  String get totpCardOff =>
      'Przygotuj aplikację uwierzytelniającą, aby logować się bez Google (ID SF + 6-cyfrowy kod).';

  @override
  String get totpEnable => 'Włącz';

  @override
  String get totpDisable => 'Usuń';

  @override
  String get totpEnableTitle => 'Włącz logowanie 2FA';

  @override
  String get totpEnabledTitle => 'Logowanie 2FA gotowe';

  @override
  String get totpDisableConfirm =>
      'Usunąć logowanie aplikacją 2FA? Będziesz logować się tylko przez Google.';

  @override
  String get googlePrivacyNote =>
      'Twoje konto Google służy wyłącznie do ochrony firmy i jej subskrypcji: nigdy nie jest pokazywane pracownikom ani nikomu innemu.';

  @override
  String get scopeRead =>
      'Odczyt: opublikowany grafik, godziny, nieobecności, pracownicy';

  @override
  String get scopeShifts => 'Grafik: tworzenie, zmiana, usuwanie zmian';

  @override
  String get scopePublish => 'Publikowanie grafiku';

  @override
  String get scopeMembers =>
      'Pracownicy: import, numer pracownika i stanowisko';

  @override
  String get scopeCatalog => 'Stanowiska i lokalizacje';

  @override
  String get scopeNews => 'Ogłoszenia';

  @override
  String get scopeRequests => 'Wnioski: zatwierdzanie lub odrzucanie';

  @override
  String get apiScopesTitle => 'Uprawnienia klucza';

  @override
  String get apiProNeeded =>
      'Uprawnienia zapisu wymagają opcji „API Pro” (opłacona subskrypcja).';

  @override
  String billingLinePro(String months) {
    return 'Opcja „API Pro”: $months mies.';
  }

  @override
  String billingLineProAddon(String start, String end, String months) {
    return 'Opcja „API Pro”, dodana w trakcie subskrypcji, od $start do $end: $months mies., bez rabatu';
  }

  @override
  String billingApiProHint(String price1, String price5) {
    return '„API Pro” (odczyt i zapis, webhooki, dzienniki): $price1 / mies. za 1 klucz, $price5 / mies. za 10 kluczy, bez rabatu. Z opłaconą subskrypcją: dodaj poniżej.';
  }

  @override
  String get whTitle => 'Webhooki';

  @override
  String get whSub =>
      'Staff Flow sam powiadamia Twoje programy, gdy coś się dzieje: opublikowany grafik, wniosek, nowy pracownik, ogłoszenie. W ramach opcji „API Pro”.';

  @override
  String get whNew => 'Nowy webhook';

  @override
  String get whUrl => 'Adres (https://…)';

  @override
  String get whEvents => 'Wysyłane zdarzenia';

  @override
  String get whCreated =>
      'Sekret podpisu, pokazywany tylko raz: Twój program sprawdza nim, że każda wysyłka naprawdę pochodzi ze Staff Flow.';

  @override
  String get whTest => 'Wypróbuj';

  @override
  String whTestOk(String status) {
    return 'Odebrano (kod $status)';
  }

  @override
  String whTestFail(String error) {
    return 'Błąd: $error';
  }

  @override
  String get whDisabled => 'Wyłączony po 10 nieudanych wysyłkach z rzędu';

  @override
  String get whEnable => 'Włącz ponownie';

  @override
  String get whDelete => 'Usuń';

  @override
  String get whDeleteConfirm => 'Ten webhook nie będzie już nic otrzymywał.';

  @override
  String get whNone => 'Brak webhooków.';

  @override
  String whLast(String date, String status) {
    return 'Ostatnia wysyłka: $date · $status';
  }

  @override
  String get whEvSchedulePublished => 'Grafik opublikowany';

  @override
  String get whEvRequestCreated => 'Nowy wniosek';

  @override
  String get whEvRequestDecided => 'Wniosek zatwierdzony lub odrzucony';

  @override
  String get whEvRequestCancelled => 'Wniosek anulowany';

  @override
  String get whEvRequestCancelAsked => 'Prośba o anulowanie urlopu';

  @override
  String get whEvRequestCancelDecided => 'Decyzja o anulowaniu urlopu';

  @override
  String get whEvRequestEnded => 'Niedostępność zakończona';

  @override
  String get whEvMemberJoined => 'Nowy pracownik';

  @override
  String get whEvAnnouncementPublished => 'Ogłoszenie opublikowane';

  @override
  String get whStDelivered => 'odebrano';

  @override
  String get whStPending => 'oczekuje';

  @override
  String get whStFailed => 'błąd';

  @override
  String get whStDropped => 'anulowano';

  @override
  String get lgTitle => 'Dzienniki';

  @override
  String get lgSub =>
      'Każde wywołanie Twoich kluczy API i asystenta MCP oraz każda wysyłka webhooka. Przesuń, aby zmienić miesiąc.';

  @override
  String get lgSearch => 'Szukaj: osoba, numer pracownika, akcja…';

  @override
  String get lgAllHistory => 'Szukaj w całej historii (z archiwami)';

  @override
  String get lgArchived => 'Miesiąc w archiwum';

  @override
  String get lgNone => 'Nic w tym miesiącu.';

  @override
  String get lgMore => 'Pokaż więcej';

  @override
  String get lgExport => 'Pobierz rok (ZIP)';

  @override
  String get lgAllKeys => 'Wszystkie klucze';

  @override
  String get lgSourceApi => 'API';

  @override
  String get lgSourceMcp => 'Asystent MCP';

  @override
  String get lgSourceWebhook => 'Webhook';

  @override
  String get lgKindRead => 'Odczyt';

  @override
  String get lgKindWrite => 'Zapis';

  @override
  String get lgOk => 'Udane';

  @override
  String get lgError => 'Błąd';

  @override
  String get lgBefore => 'Przed';

  @override
  String get lgAfter => 'Po';

  @override
  String lgStats(String today, String month) {
    return 'Dziś: $today · w tym miesiącu: $month';
  }

  @override
  String lgLastFailure(String date) {
    return 'Ostatni błąd: $date';
  }

  @override
  String get lgActShiftsCreate => 'Zmiany utworzone';

  @override
  String get lgActShiftUpdate => 'Zmiana edytowana';

  @override
  String get lgActShiftDelete => 'Zmiana usunięta';

  @override
  String get lgActPublish => 'Grafik opublikowany';

  @override
  String get lgActImport => 'Pracownicy zaimportowani';

  @override
  String get lgActProfile => 'Zmieniono numer lub stanowisko';

  @override
  String get lgActPosition => 'Stanowisko utworzone';

  @override
  String get lgActSite => 'Lokalizacja utworzona';

  @override
  String get lgActNews => 'Ogłoszenie opublikowane';

  @override
  String get lgActApprove => 'Wniosek zatwierdzony';

  @override
  String get lgActRefuse => 'Wniosek odrzucony';

  @override
  String get lgActRead => 'Odczyt';

  @override
  String get lgActWebhook => 'Webhook wysłany';

  @override
  String get lgFDay => 'Dzień';

  @override
  String get lgFStart => 'Początek';

  @override
  String get lgFEnd => 'Koniec';

  @override
  String get lgFPerson => 'Osoba';

  @override
  String get lgFSite => 'Lokalizacja';

  @override
  String get lgFPosition => 'Stanowisko';

  @override
  String get lgFNote => 'Notatka';

  @override
  String get lgFNumber => 'Numer pracownika';

  @override
  String noticeApiFailing(String key, String count) {
    return 'Klucz API „$key” zawiódł $count razy w ciągu godziny: sprawdź program, który go używa.';
  }

  @override
  String noticeApiNewIp(String key, String ip) {
    return 'Klucz API „$key” został użyty z nowego adresu ($ip). Jeśli to nie Ty, unieważnij go.';
  }

  @override
  String get lgResults => 'Wyniki z całej historii';

  @override
  String get lgAllSources => 'Wszystkie źródła';

  @override
  String get lgAllKinds => 'Odczyt i zapis';

  @override
  String get lgAllResults => 'Udane i błędy';

  @override
  String get lgFDate => 'Data';

  @override
  String get lgFKey => 'Klucz';

  @override
  String get lgFSource => 'Źródło';

  @override
  String get lgFStatus => 'Status';

  @override
  String get totpContinueButton => 'Kontynuuj z aplikacją 2FA';

  @override
  String get totpIdentHint =>
      'Wpisz swój identyfikator Staff Flow (SF-…), numer pracownika lub kod aktywacyjny od pracodawcy.';

  @override
  String get totpIdentField =>
      'Identyfikator, numer pracownika lub kod pracodawcy';

  @override
  String get totpContinue => 'Dalej';

  @override
  String get totpUnknown => 'Taki identyfikator nie istnieje. Utworzyć konto?';

  @override
  String get totpGoogleAccount =>
      'To konto loguje się przez Google: wróć i dotknij „Zaloguj się przez Google”.';

  @override
  String get totpNoAccount => 'Nie masz konta? Utwórz je';

  @override
  String get totpChange => 'Inny identyfikator';

  @override
  String get billingNotInApp => 'Zakupy nie są dostępne w aplikacji mobilnej.';

  @override
  String get billingActiveOptions => 'Aktywne opcje';

  @override
  String get billingNoOptions => 'Brak aktywnych opcji.';

  @override
  String get optionNotActive => 'Ta opcja nie jest aktywna dla tej firmy.';

  @override
  String get apiProNotActive =>
      'Opcja „API Pro” nie jest aktywna dla tej firmy.';

  @override
  String get apiKeySaved => 'Klucz zapisany.';

  @override
  String get apiKeyIncomplete =>
      'Nadaj kluczowi nazwę i wybierz co najmniej jedno uprawnienie.';

  @override
  String get billingApiPro1 => 'Opcja „API Pro” (1 klucz)';

  @override
  String get billingApiPro10 => 'Opcja „API Pro” (10 kluczy)';

  @override
  String get billingApiPro10Upgrade => 'Przejdź na 10 kluczy';

  @override
  String get billingProKeysNext => 'Przy następnym odnowieniu';

  @override
  String get billingProKeys1 => '1 klucz';

  @override
  String get billingProKeys10 => '10 kluczy';

  @override
  String billingProKeysWarning(String count) {
    return 'Aktywnych kluczy: $count. Przy odnowieniu aktywny zostanie tylko najstarszy. Wybierzesz, który zachować, w „Dostęp API”.';
  }

  @override
  String get billingApiIncluded => 'Odczyt wliczony w „API Pro”.';

  @override
  String billingLinePro10Addon(String start, String end, String months) {
    return 'Opcja „API Pro”, 10 kluczy, dodana w trakcie subskrypcji, od $start do $end: $months mies., bez rabatu';
  }

  @override
  String billingLinePro10Upgrade(String start, String end, String months) {
    return 'Przejście „API Pro” na 10 kluczy, od $start do $end: $months mies. (różnica ceny), bez rabatu';
  }

  @override
  String apiKeysCount(String count, String limit) {
    return 'Aktywne klucze: $count / $limit';
  }

  @override
  String get apiKeyDisabled => 'Wyłączony: ponad Twój plan API';

  @override
  String get apiKeyEnable => 'Włącz ponownie';

  @override
  String get apiKeyDisable => 'Odłóż';

  @override
  String get apiKeyLimitReached =>
      'Twój plan nie pozwala na więcej kluczy: odłóż klucz lub przejdź na wyższy plan.';

  @override
  String noticeApiKeysDeletion(String company, String date) {
    return '$company: dostęp API zatrzymany, klucze zostaną usunięte $date, chyba że opcja zostanie wznowiona.';
  }
}
