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
  String get notifMessages => 'Nowe wiadomości';

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
  String get messagesTab => 'Wiadomości';

  @override
  String get wholeTeam => 'Cały zespół';

  @override
  String get newConversation => 'Nowa rozmowa';

  @override
  String get noMessages => 'Brak wiadomości.';

  @override
  String get messageHint => 'Napisz wiadomość';

  @override
  String get earlierMessages => 'Wcześniejsze wiadomości';

  @override
  String get personLeftCompany => 'Ta osoba nie należy już do firmy.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Nowa grupa';

  @override
  String get editGroup => 'Edytuj grupę';

  @override
  String get groupName => 'Nazwa grupy';

  @override
  String get groupMembersHint =>
      'Wybierz osoby do tej grupy. Tylko one zobaczą jej wiadomości.';

  @override
  String get chooseAtLeastOne => 'Wybierz co najmniej jedną osobę.';

  @override
  String get replyAction => 'Odpowiedz';

  @override
  String get translateAction => 'Przetłumacz';

  @override
  String replyingTo(String name) {
    return 'Odpowiedź do: $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Ostatnie wiadomości od: $name';
  }

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
  String get myRequests => 'Moje prośby';

  @override
  String get otherRequests => 'Prośby zespołu';

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
  String get notifySitesTitle => 'Powiadomienia według lokalizacji';

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
  String get deleteGroup => 'Usuń grupę';

  @override
  String get openRequest => 'Zobacz prośbę';

  @override
  String get thisCompany => 'Ta firma';

  @override
  String get withExtras => 'Z pracownikami dorywczymi';

  @override
  String deleteGroupConfirm(String name) {
    return 'Usunąć „$name” i wszystkie wiadomości dla wszystkich?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Z firmy $company: zostanie dodany jako wsparcie i powiadomiony.';
  }
}
