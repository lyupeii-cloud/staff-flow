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
  String get viewTeam => 'Management';

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

  @override
  String get syncUpToDate => 'Aktuell';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Ausstehende Änderungen: $count';
  }

  @override
  String get syncNow => 'Synchronisieren';

  @override
  String syncRejected(String reason) {
    return 'Änderung vom Server abgelehnt: $reason';
  }

  @override
  String get pendingBadge => 'Ausstehend';

  @override
  String get offlineUnavailable => 'Offline nicht verfügbar.';

  @override
  String get offlineCached => 'Offline: zuletzt gespeicherte Daten.';

  @override
  String get savedOffline =>
      'Auf dem Gerät gespeichert, wird gesendet, sobald das Netz zurück ist.';

  @override
  String get notices => 'Hinweise';

  @override
  String get noNotices => 'Keine Hinweise.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name hat deine Änderung der Schicht vom $date ersetzt.';
  }

  @override
  String get history => 'Verlauf';

  @override
  String get recentChanges => 'Letzte Änderungen';

  @override
  String get undoChange => 'Diese Änderung rückgängig machen';

  @override
  String get undoDone => 'Änderung rückgängig gemacht.';

  @override
  String get historyCreate => 'Erstellt';

  @override
  String get historyUpdate => 'Geändert';

  @override
  String get historyDelete => 'Gelöscht';

  @override
  String get historyUndo => 'Rückgängig gemacht';

  @override
  String get noHistory => 'Keine Änderungen.';

  @override
  String get pendingNotEditable =>
      'Diese Schicht ist noch nicht synchronisiert: versuche es online erneut.';

  @override
  String get myQrCode => 'Mein QR-Code';

  @override
  String get myQrCodeHint =>
      'Eine Führungskraft scannt diesen Code, um Sie zu ihrem Unternehmen hinzuzufügen; danach bestätigen Sie. Er ändert sich nie.';

  @override
  String get changeMyName => 'Meinen Namen ändern';

  @override
  String get nameShownToTeam =>
      'Dieser Name wird Ihren Kollegen statt Ihres Google-Namens angezeigt.';

  @override
  String googleName(String name) {
    return 'Google-Name: $name';
  }

  @override
  String get useGoogleName => 'Meinen Google-Namen verwenden';

  @override
  String renameMemberTitle(String name) {
    return '$name umbenennen';
  }

  @override
  String get renameMemberHint =>
      'Dieser Name wird nur in diesem Unternehmen verwendet.';

  @override
  String get useOwnName => 'Eigenen Namen verwenden';

  @override
  String get scanQrCode => 'QR-Code scannen';

  @override
  String get scanQrHint =>
      'Richten Sie die Kamera auf den QR-Code in der App der Person (Kontomenü, „Mein QR-Code“).';

  @override
  String get orEnterCode => 'Oder geben Sie den 6-stelligen Code ein';

  @override
  String get qrInvalid => 'Das ist kein Staff-Flow-QR-Code.';

  @override
  String cameraUnavailable(String error) {
    return 'Kamera nicht verfügbar ($error).';
  }

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get notifChooseHint =>
      'Wählen Sie, worüber Sie benachrichtigt werden. Alles bleibt in der Glocke sichtbar.';

  @override
  String get notifPlanning => 'Dienstplan veröffentlicht oder geändert';

  @override
  String get notifRequests => 'Anfragen: Tausch, Urlaub, Einladungen';

  @override
  String get notifMessages => 'Neue Mitteilungen';

  @override
  String get notifOverlap => 'Überschneidende Schichten zwischen Unternehmen';

  @override
  String get notifConflicts =>
      'Ihre Änderungen von einer anderen Führungskraft ersetzt';

  @override
  String get notifBilling => 'Abo-Erinnerungen';

  @override
  String get pushEnabled =>
      'Benachrichtigungen sind auf diesem Gerät aktiviert.';

  @override
  String get pushOff => 'Benachrichtigungen sind auf diesem Gerät deaktiviert.';

  @override
  String get pushBlocked =>
      'Benachrichtigungen sind blockiert: Erlauben Sie sie in den Einstellungen des Telefons oder Browsers.';

  @override
  String get pushUnavailable =>
      'Benachrichtigungen sind auf diesem Gerät nicht verfügbar.';

  @override
  String get enablePush => 'Aktivieren';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: Ihr Dienstplan wurde veröffentlicht oder geändert.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company möchte Sie in sein Team aufnehmen.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name bietet Ihnen an, Inhaber von $company zu werden.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name ist $company beigetreten.';
  }

  @override
  String get translateAction => 'Übersetzen';

  @override
  String get deleteAllNotices => 'Alle löschen';

  @override
  String get deleteAllNoticesConfirm => 'Alle Hinweise löschen?';

  @override
  String get noticeRetention => 'Gelesene Hinweise löschen nach';

  @override
  String get retentionDay => '1 Tag';

  @override
  String get retentionWeek => '1 Woche';

  @override
  String get retentionMonth => '1 Monat';

  @override
  String get billingOwnersOnly =>
      'Nur aktiv, wenn Ihnen ein Unternehmen gehört.';

  @override
  String get readOnlyPastDays =>
      'Tage, die mehr als einen Monat zurückliegen, sind schreibgeschützt.';

  @override
  String get wholeCompany => 'Ganzes Unternehmen';

  @override
  String get sitesLabel => 'Standorte';

  @override
  String get actionSites => 'Standorte…';

  @override
  String managerOf(String name) {
    return '$name verantwortet';
  }

  @override
  String teamSitesOf(String name) {
    return 'Team von $name';
  }

  @override
  String get notYourSite =>
      'Dieser Standort liegt nicht in Ihrer Verantwortung.';

  @override
  String get chooseYourSite => 'Wählen Sie mindestens einen Standort.';

  @override
  String get viewRequests => 'Anfragen';

  @override
  String get newRequest => 'Neue Anfrage';

  @override
  String get requestLeave => 'Urlaub';

  @override
  String get requestUnavailability => 'Nichtverfügbarkeit';

  @override
  String get requestSwap => 'Schichttausch';

  @override
  String get swapHint =>
      'Um einen Tausch anzubieten, tippen Sie im Plan auf eine Ihrer kommenden Schichten.';

  @override
  String get noRequests => 'Noch keine Anfragen.';

  @override
  String get requestsToHandle => 'Zu bearbeiten';

  @override
  String get statusPendingPeer => 'Wartet auf Kollegen';

  @override
  String get statusPendingManager => 'Wartet auf Verantwortliche';

  @override
  String get statusApproved => 'Genehmigt';

  @override
  String get statusRefused => 'Abgelehnt';

  @override
  String get statusCancelled => 'Storniert';

  @override
  String get cancelRequest => 'Anfrage zurückziehen';

  @override
  String get acceptSwap => 'Schicht übernehmen';

  @override
  String get approve => 'Genehmigen';

  @override
  String periodLabel(String from, String to) {
    return 'Vom $from bis $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Angeboten an $name';
  }

  @override
  String get swapToTeam => 'Ganzes Team';

  @override
  String everyWeekdays(String days) {
    return 'Jede Woche: $days';
  }

  @override
  String get unavailableEveryWeek => 'Tage, an denen Sie nie verfügbar sind:';

  @override
  String get choosePeriod => 'Daten wählen';

  @override
  String get choosePeriodOptional => 'Auf einen Zeitraum begrenzen (optional)';

  @override
  String get clearPeriod => 'Ohne Zeitraum';

  @override
  String get sendRequest => 'Anfrage senden';

  @override
  String get proposeSwap => 'Tausch anbieten';

  @override
  String get swapWith => 'Anbieten an';

  @override
  String get swapSteps =>
      'Der Kollege nimmt an, dann genehmigt ein Verantwortlicher. Erst danach ändert sich der Plan.';

  @override
  String get absentThatDay => 'Genehmigte Abwesenheit an diesem Tag';

  @override
  String get requestSent => 'Anfrage gesendet.';

  @override
  String noticeSwapOffer(String name) {
    return '$name bietet Ihnen eine Schicht an.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name hat Ihr Tauschangebot abgelehnt.';
  }

  @override
  String get noticeSwapToApprove =>
      'Ein Schichttausch wartet auf Ihre Freigabe.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name beantragt Urlaub.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name meldet sich als nicht verfügbar.';
  }

  @override
  String get noticeRequestApproved => 'Ihre Anfrage wurde genehmigt.';

  @override
  String get noticeRequestRefused => 'Ihre Anfrage wurde abgelehnt.';

  @override
  String get choosePeer => 'Wer übernimmt diese Schicht?';

  @override
  String get discardAll => 'Alles verwerfen';

  @override
  String get notifySitesHint =>
      'Wählen Sie die Standorte, für die Sie Benachrichtigungen zu Anfragen erhalten. Alle Anfragen bleiben in der Liste sichtbar.';

  @override
  String get pendingRequestTooltip =>
      'Offene Anfrage: tippen, um sie zu öffnen';

  @override
  String get requestsHistory => 'Alle Anfragen';

  @override
  String get revertChange => 'Diese Änderung rückgängig machen';

  @override
  String get statusExpired => 'Hinfällig';

  @override
  String get swapWithHint => 'Tippen, um einen bestimmten Kollegen zu wählen';

  @override
  String changesDiscarded(String count) {
    return 'Verworfene Änderungen: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Die $count nicht veröffentlichten Änderungen verwerfen?';
  }

  @override
  String get allSchedules => 'Alle meine Pläne';

  @override
  String get busyElsewhere =>
      'Arbeitet zu dieser Zeit schon in einem anderen Unternehmen';

  @override
  String get overlapTooltip =>
      'Überschneidet sich mit einer Schicht in einem anderen Unternehmen';

  @override
  String get overlapWarning =>
      'Einige Ihrer Schichten in zwei Unternehmen überschneiden sich.';

  @override
  String noticeOverlap(String date) {
    return 'Zwei Ihrer Schichten in verschiedenen Unternehmen überschneiden sich am $date.';
  }

  @override
  String get allMyCompanies => 'Alle meine Unternehmen';

  @override
  String get openRequest => 'Anfrage ansehen';

  @override
  String get thisCompany => 'Dieses Unternehmen';

  @override
  String get withExtras => 'Mit Aushilfen';

  @override
  String reinforcementHint(String company) {
    return 'Aus $company: wird als Verstärkung hinzugefügt und benachrichtigt.';
  }

  @override
  String get addToGoogle => 'Zu Google Kalender hinzufügen';

  @override
  String get calendarEnabled => 'Meine Schichten synchronisieren';

  @override
  String get changeSettings => 'Ändern';

  @override
  String get countryBelgium => 'Belgien';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Frankreich';

  @override
  String get countrySwitzerland => 'Schweiz';

  @override
  String get employeesSection => 'Angestellte';

  @override
  String get emptyNoAlert => 'Leer: keine Warnung';

  @override
  String get extrasSection => 'Aushilfen';

  @override
  String get googleCalendar => 'Google Kalender';

  @override
  String get hoursTotals => 'Stundensummen';

  @override
  String get legalAlerts => 'Gesetzliche Warnungen';

  @override
  String get legalAlertsHint =>
      'Nur Warnungen, nie Sperren. Wählen Sie die Regeln, die bei Ihnen gelten, oder keine.';

  @override
  String get legalPreset => 'Ländervorlage';

  @override
  String get maxConsecutiveLabel => 'Maximal aufeinanderfolgende Arbeitstage';

  @override
  String get maxDayLabel => 'Höchstdauer pro Tag (Stunden)';

  @override
  String get maxWeekLabel => 'Höchstdauer pro Woche (Stunden)';

  @override
  String get minRestLabel => 'Mindestruhe zwischen zwei Schichten (Stunden)';

  @override
  String get noLegalRules => 'Keine Warnung gewählt.';

  @override
  String get presetNone => 'Keine';

  @override
  String get presetsCheck =>
      'Vorlagen sind ein Ausgangspunkt: Prüfen Sie sie nach den Regeln Ihres Landes und Ihrem Tarifvertrag.';

  @override
  String get printMine => 'Mein Dienstplan';

  @override
  String get printOwn => 'Nur ihren eigenen Dienstplan';

  @override
  String get printPdf => 'Drucken / PDF';

  @override
  String get printRights => 'Was Angestellte drucken dürfen';

  @override
  String get printTeam => 'Den Dienstplan des ganzen Teams';

  @override
  String get printTeamOption => 'Den Dienstplan des Teams';

  @override
  String get totalsHint =>
      'Entwürfe inbegriffen. Excel- und CSV-Exporte verwenden den veröffentlichten Plan.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value Tage am Stück (höchstens $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value am Tag (höchstens $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: nur $value Ruhezeit (mindestens $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value in der Woche (höchstens $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Gesetzliche Warnungen: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Schichten: $count';
  }

  @override
  String get actionMakeDeputy => 'Zur stellvertretenden Leitung ernennen';

  @override
  String get actionRemoveDeputy => 'Stellvertretung entziehen';

  @override
  String get busyHere => 'Arbeitet zu dieser Zeit schon in diesem Unternehmen';

  @override
  String get calendarDenied =>
      'Kalenderzugriff verweigert. Erlauben Sie ihn in den Telefoneinstellungen.';

  @override
  String get calendarLinkHint =>
      'Am Computer in Google Kalender hinzufügen; Google aktualisiert ihn innerhalb einiger Stunden.';

  @override
  String get calendarNone => 'Kein bearbeitbarer Kalender auf diesem Telefon.';

  @override
  String get calendarOnPhoneHint =>
      'In Ihrem Google-Kalender: sofort sichtbar, auf dem Telefon und in Google Kalender.';

  @override
  String get chooseCalendar => 'Kalender wählen';

  @override
  String get otherSiteHint =>
      'Angestellte/r eines anderen Standorts: die Verantwortlichen werden benachrichtigt.';

  @override
  String get subManager => 'Stellvertretende Leitung';

  @override
  String calendarSynced(String count) {
    return 'Schichten im Kalender: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Stellvertretende Leitung: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by hat $name am $date am Standort $site eingeplant.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company hat Sie als Verstärkung hinzugefügt.';
  }

  @override
  String get companyNotificationsHint =>
      'Aus: auf diesem Telefon klingelt nichts, aber alles bleibt in der Glocke.';

  @override
  String get companyNotificationsOn =>
      'Benachrichtigungen dieses Unternehmens erhalten';

  @override
  String get companyTimezone => 'Zeitzone des Unternehmens';

  @override
  String get companyTimezoneHint =>
      'Alle Zeiten dieses Unternehmens gelten in dieser Zeitzone (Sommerzeit inbegriffen). Kalender rechnen sie automatisch um.';

  @override
  String get iosInstallHint =>
      'Auf dem iPhone: Tippen Sie auf Teilen und dann auf „Zum Home-Bildschirm“, um Staff Flow zu installieren.';

  @override
  String get searchCity => 'Stadt suchen';

  @override
  String get thisPhone => 'Dieses Gerät';

  @override
  String companyNotifications(String name) {
    return 'Benachrichtigungen: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Zeiten in der Zeit von $zone ($company). Ihr Gerät: $here.';
  }

  @override
  String get addPreset => 'Vorlage hinzufügen';

  @override
  String get addPresets => 'Vorlagen erstellen';

  @override
  String get appearance => 'Darstellung';

  @override
  String get chooseLogo => 'PNG-Bild wählen';

  @override
  String get customization => 'Personalisierung';

  @override
  String get editPresets => 'Vorlagen';

  @override
  String get enable => 'Wieder aktivieren';

  @override
  String get logoHint =>
      'Ein kleines PNG-Bild (Ihr Logo) auf dem Unternehmens-Tab, für alle Mitglieder.';

  @override
  String get logoPngOnly => 'Wählen Sie ein PNG-Bild von höchstens 1 MB.';

  @override
  String get myIdentifier => 'Meine Kennung';

  @override
  String get myProfile => 'Mein Profil';

  @override
  String get presetName => 'Name (z. B. Früh)';

  @override
  String get removeLogo => 'Bild entfernen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get shiftPresets => 'Schichtvorlagen';

  @override
  String get shiftPresetsHint =>
      'Fertige Zeiten (Früh, Spät, Nacht …): ein Tippen in einer Schicht füllt Beginn und Ende aus.';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeSystem => 'System';

  @override
  String get awaitingApproval => 'Freizugeben';

  @override
  String get placementNeedsApproval =>
      '! Diese Person gehört nicht zu Ihren Standorten: Die Schicht wartet auf die Freigabe Ihres Vorgesetzten oder des Inhabers, bevor sie veröffentlicht werden kann. Sonst wählen Sie jemand anderen.';

  @override
  String get placementAwaiting =>
      'Wartet auf Freigabe durch einen Vorgesetzten oder den Inhaber.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by möchte $name von einem anderen Standort am $date einplanen: Freigabe nötig.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by hat die Einplanung von $name am $date freigegeben.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by hat die Einplanung von $name am $date abgelehnt.';
  }

  @override
  String get addSubSite => 'Unterstandort hinzufügen';

  @override
  String get moveSite => 'Verschieben';

  @override
  String get topLevel => 'Oberste Ebene';

  @override
  String moveSiteTitle(String name) {
    return '„$name“ verschieben unter…';
  }

  @override
  String subSiteOf(String name) {
    return 'Unterstandort von $name';
  }

  @override
  String get siteTreeHint =>
      'Bis zu 10 Ebenen, z. B. Region › Stadt › Filiale. Die ersten 3 sind im Abonnement enthalten; darüber hinaus brauchen Sie die Option „Verschachtelte Standorte“. Wer einen Standort leitet, verwaltet auch alles darunter.';

  @override
  String get subSitesOnlyHint =>
      'Hier fügen Sie Unterstandorte unter Ihren eigenen Standorten hinzu.';

  @override
  String get messagingSetting => 'Newsfeed';

  @override
  String get messagingSettingHint =>
      'An: Inhaber und Verantwortliche veröffentlichen Mitteilungen (für alle, eine Position, einen Standort oder ausgewählte Personen); alle lesen sie und können sie übersetzen. Aus: Der Tab verschwindet für alle.';

  @override
  String get billingTitle => 'Abonnement';

  @override
  String billingStatusTrial(String date) {
    return 'Kostenlose Testphase bis $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Bezahlt bis $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Schreibgeschützt: Ohne Zahlung wird das Unternehmen am $date gelöscht.';
  }

  @override
  String get billingStatusComped => 'Kostenlos';

  @override
  String billingStaff(String count) {
    return '$count Mitarbeitende gezählt (ohne Inhaber und Aushilfen)';
  }

  @override
  String get billingMonthly => 'Monatlich';

  @override
  String billingYearly(String months) {
    return 'Jährlich ($months Monate berechnet)';
  }

  @override
  String get billingCascade =>
      'Option „Verschachtelte Standorte“ (Ebenen 4–10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'Ab $count Mitarbeitenden inklusive';
  }

  @override
  String billingPay(String amount) {
    return '$amount bezahlen';
  }

  @override
  String get billingTestNotice => 'Testzahlung: Es wird nichts abgebucht.';

  @override
  String get billingSoon => 'Online-Zahlung folgt bald.';

  @override
  String get billingPaidOk => 'Zahlung erfasst.';

  @override
  String get billingInvoices => 'Rechnungen';

  @override
  String get billingNoInvoices => 'Noch keine Rechnungen.';

  @override
  String get billingManage => 'Abonnement verwalten';

  @override
  String get billingReadOnlyStaff =>
      'Dieses Unternehmen ist schreibgeschützt, bis der Inhaber das Abonnement verlängert.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / Monat';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / Jahr';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: Die kostenlose Testphase endet in weniger als 24 Stunden.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company ist wegen Nichtzahlung schreibgeschützt; Löschung am $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Erinnerung: Ohne Zahlung wird $company am $date gelöscht.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company wurde wegen Nichtzahlung gelöscht.';
  }

  @override
  String billingCompanyId(String id) {
    return 'Unternehmens-ID: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Heute: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Enthält den Rest des laufenden Monats ($days Tage, anteilig), danach volle Monate ab dem 1.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Noch nicht verknüpft. Es dient zur Bestätigung Ihrer Identität, zum Beispiel beim Wechsel des Google-Kontos.';

  @override
  String telegramLinked(String name) {
    return 'Verknüpft: $name';
  }

  @override
  String get telegramNoUsername => 'ohne Benutzernamen';

  @override
  String get telegramLink => 'Mein Telegram verknüpfen';

  @override
  String get telegramLinkHint =>
      'Telegram öffnet sich: Tippen Sie auf „Starten“ und kommen Sie dann hierher zurück.';

  @override
  String get telegramUnlink => 'Trennen';

  @override
  String get telegramUnavailable => 'Telegram ist noch nicht verfügbar.';

  @override
  String get telegramShowIn => 'Mein Telegram anzeigen in:';

  @override
  String get newQrCode => 'QR-Code ändern';

  @override
  String get newQrCodeConfirm =>
      'Ihr alter QR-Code und Ihre alte Kennung funktionieren nicht mehr. Ihr Platz in Ihren Unternehmen bleibt gleich.';

  @override
  String get newQrCodeDone => 'Neuer QR-Code erstellt.';

  @override
  String get changeGoogle => 'Google-Konto wechseln';

  @override
  String get changeGoogleSub =>
      'Gleiches Konto, gleiche Nummer, gleiche Unternehmen';

  @override
  String changeGoogleSteps(String id) {
    return '1. Verknüpfen Sie Ihr Telegram in diesem Profil (erforderlich).\n2. Melden Sie sich ab und mit dem neuen Google-Konto wieder an.\n3. Wählen Sie „Ich habe bereits ein Staff-Flow-Konto“ und geben Sie Ihre Kennung $id ein.\n4. Geben Sie den Code aus Telegram ein.\nIhr Konto, Ihre Nummer und Ihre Unternehmen bleiben gleich.';
  }

  @override
  String get recoverAccount => 'Ich habe bereits ein Staff-Flow-Konto';

  @override
  String get recoverHint =>
      'Geben Sie die Kennung Ihres alten Kontos ein (SF-…). Ein Code wird an das mit diesem Konto verknüpfte Telegram gesendet.';

  @override
  String get recoverIdLabel => 'Kennung (SF-…)';

  @override
  String get recoverSend => 'Code senden';

  @override
  String get recoverCodeSent => 'Code per Telegram gesendet.';

  @override
  String get recoverCodeLabel => 'Erhaltener Code (6 Ziffern)';

  @override
  String get recoverConfirm => 'Mein Konto zurückholen';

  @override
  String get recoverDone => 'Erledigt: Sie sind wieder in Ihrem Konto.';

  @override
  String get exportData => 'Meine Daten exportieren';

  @override
  String get exportDataSub => 'Eine Datei mit all Ihren persönlichen Daten';

  @override
  String get deleteAccount => 'Mein Konto löschen';

  @override
  String get deleteGhost => 'Löschen und einen Geist behalten';

  @override
  String get deleteGhostHint =>
      'Sie verlassen alle Unternehmen. Melden Sie sich später mit demselben Google-Konto an, um Konto und Nummer zurückzuerhalten.';

  @override
  String get deleteErase => 'Alles endgültig löschen';

  @override
  String get deleteEraseHint =>
      'Name, E-Mail, Foto, Telegram, Nachrichten und Benachrichtigungen werden gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get deleteGhostNote =>
      'In beiden Fällen behält der Verlauf der Unternehmen an Ihrer Stelle einen anonymen „Ghost“ (Urlaubsanträge, vergangene Schichten …), damit Inhaber und Verantwortliche die Ereignisse nachvollziehen können.';

  @override
  String get deleteOwnerNote =>
      'Inhaber eines Unternehmens? Übertragen Sie es zuerst oder lassen Sie das Abonnement auslaufen.';

  @override
  String get deleteConfirmButton => 'Löschen';

  @override
  String get accountRestored =>
      'Willkommen zurück! Ihr Konto wurde reaktiviert.';

  @override
  String get closedInvoices => 'Rechnungen geschlossener Unternehmen';

  @override
  String get downloadAllInvoices => 'Alle Rechnungen herunterladen (ZIP)';

  @override
  String get legalTerms => 'Nutzungs- und Verkaufsbedingungen';

  @override
  String get legalPrivacy => 'Datenschutzerklärung';

  @override
  String get billingDetailTitle => 'Zahlungsdetails';

  @override
  String billingLineProrata(String days, String total) {
    return 'Rest des laufenden Monats ($days von $total Tagen): Abonnement';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Rest des laufenden Monats ($days von $total Tagen): Option „verschachtelte Standorte“';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Abonnement, $staff Beschäftigte: 1 Monat';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Abonnement, $staff Beschäftigte: 12 Monate zum Preis von $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Option „verschachtelte Standorte“: $months Monate, ohne Rabatt';
  }

  @override
  String get billingTotal => 'Gesamt';

  @override
  String billingCovers(String from, String to) {
    return 'Abgedeckter Zeitraum: $from bis $to';
  }

  @override
  String get billingGraceInvoices =>
      'Dieses Unternehmen wird nicht verlängert: Laden Sie jetzt alle Rechnungen herunter.';

  @override
  String get billingYearLabel => 'Jahr';

  @override
  String get sitesNoneChosen => 'Kein Standort gewählt';

  @override
  String get avatarTitle => 'Mein Avatar';

  @override
  String get avatarSub => 'Ein Bild anstelle Ihres Fotos';

  @override
  String get avatarUseGoogle => 'Mein Google-Foto verwenden';

  @override
  String get avatarColor => 'Farbe';

  @override
  String get hidePhotosTitle => 'Google-Fotos ausblenden';

  @override
  String get hidePhotosSub =>
      'In diesem Unternehmen erscheint jede Person mit ihrem Avatar oder ihrer Initiale.';

  @override
  String get billingApi => 'Option „API-Zugang“';

  @override
  String billingLineApi(String months) {
    return 'Option „API-Zugang“: $months Monate, ohne Rabatt';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Rest des laufenden Monats ($days von $total Tagen): Option „API-Zugang“';
  }

  @override
  String get apiTitle => 'API-Zugang (Buchhaltung, CRM)';

  @override
  String get apiSub =>
      'Ihre Buchhaltungs-, Lohn- oder CRM-Software liest den veröffentlichten Plan, die Stunden und Abwesenheiten.';

  @override
  String get apiNeedsOption =>
      'Kostenpflichtige Option: Fügen Sie „API-Zugang“ unter „Abonnement verwalten“ hinzu.';

  @override
  String get apiNewKey => 'Neuer Schlüssel';

  @override
  String get apiKeyName => 'Name des Schlüssels (z. B. Lohnsoftware)';

  @override
  String get apiKeyCreated =>
      'Kopieren Sie diesen Schlüssel jetzt und bewahren Sie ihn sicher auf: Er wird nicht erneut angezeigt.';

  @override
  String get apiKeyCopy => 'Kopieren';

  @override
  String get apiKeyCopied => 'Schlüssel kopiert.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Zuletzt verwendet: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Nie verwendet';

  @override
  String get apiRevoke => 'Widerrufen';

  @override
  String get apiRevokeConfirm =>
      'Software, die diesen Schlüssel nutzt, verliert den Zugriff.';

  @override
  String get apiDocs => 'API-Dokumentation';

  @override
  String get memberGoogleLink => 'Google-Neuanmeldung der Person';

  @override
  String googleLinkHint(String name) {
    return 'Senden Sie diesen Link an $name. Er öffnet sich in einem Browser (nicht in der Android-App), einmalig und 24 Stunden lang: $name meldet sich mit dem neuen Google-Konto an und erhält das eigene Konto zurück. Alle anderen Geräte werden dann abgemeldet.';
  }

  @override
  String get googleLinkCopied => 'Link kopiert.';

  @override
  String get switchBanner =>
      'Link zum Wechsel des Google-Kontos: Melden Sie sich mit Ihrem neuen Google-Konto an, um Ihr Staff-Flow-Konto zurückzuerhalten.';

  @override
  String get switchSignOutFirst =>
      'Dieser Link verknüpft ein Staff-Flow-Konto mit einem neuen Google-Konto. Melden Sie sich zuerst ab und dann mit dem neuen Google-Konto an.';

  @override
  String get switchDone =>
      'Erledigt: Ihr Staff-Flow-Konto ist mit diesem Google-Konto verknüpft. Ihre anderen Geräte wurden abgemeldet.';

  @override
  String changeGoogleBot(String bot) {
    return 'Am einfachsten: Senden Sie in Telegram /changegoogle an den Bot $bot, folgen Sie seinen Anweisungen und melden Sie sich dann innerhalb von 10 Minuten mit dem neuen Google-Konto an.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Ohne Telegram: Bitten Sie den Inhaber oder eine Führungskraft um einen Link zum Wechsel des Google-Kontos.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name hat einen Link erstellt, um Ihr Konto mit einem neuen Google-Konto zu verknüpfen. Wenn Sie das nicht angefragt haben, informieren Sie Ihre Führungskraft.';
  }

  @override
  String get sessionRevoked =>
      'Sie wurden abgemeldet: Ihr Konto ist jetzt mit einem anderen Google-Konto verknüpft.';

  @override
  String telegramLoginHint(String bot) {
    return 'Tipp: Senden Sie /connexion an den Bot $bot, um einen Link zu erhalten und Staff Flow im Browser zu öffnen – ohne App und ohne Google-Konto.';
  }

  @override
  String get timeFormat => 'Uhrzeitformat';

  @override
  String get timeFormatAuto => 'Auto';

  @override
  String get people => 'Personen';

  @override
  String get sortNatural => 'Standardreihenfolge';

  @override
  String get sortName => 'Name';

  @override
  String get employeeNumber => 'Personalnummer';

  @override
  String get sfIdLabel => 'Staff-Flow-ID';

  @override
  String get pickSearch => 'Suchen';

  @override
  String get pickSearchPeople => 'Suchen: Name, Personalnummer, SF-ID';

  @override
  String get pickSortTitle => 'Sortieren und anzeigen nach';

  @override
  String pickSelected(String count) {
    return 'Ausgewählt: $count';
  }

  @override
  String get pickCheckAll => 'Alle auswählen';

  @override
  String get pickClear => 'Auswahl aufheben';

  @override
  String get pickNoResult => 'Keine Ergebnisse';

  @override
  String get pickMultiHint =>
      'Mehrere Personen auswählen: Für jede wird eine Schicht erstellt, alles auf einmal.';

  @override
  String get filterAll => 'Alle';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'Ohne Position';

  @override
  String get noSiteGroup => 'Ohne Standort';

  @override
  String get groupByTitle => 'Gruppieren nach';

  @override
  String get groupRole => 'Rolle';

  @override
  String get groupNone => 'Keine Gruppierung';

  @override
  String showMore(String count, String left) {
    return '$count weitere anzeigen (noch $left)';
  }

  @override
  String get findByQr => 'Mitglied per QR-Code finden';

  @override
  String get qrNotMember =>
      'Dieser QR-Code passt zu niemandem in diesem Unternehmen.';

  @override
  String get memberProfile => 'Personalnummer und Position';

  @override
  String get employeeNumberHint =>
      'Eigene Nummer Ihres Unternehmens (optional). Die Staff-Flow-ID bleibt bestehen.';

  @override
  String get usualPosition => 'Übliche Position';

  @override
  String get inviteCodeTitle => 'Einladungscode';

  @override
  String get inviteCodeHint =>
      'Geben Sie den Code ein, den Sie von Ihrem Arbeitgeber erhalten haben, oder scannen Sie den QR-Code Ihrer Einladung.';

  @override
  String inviteJoined(String company) {
    return 'Sie sind $company beigetreten.';
  }

  @override
  String get importTitle => 'Mitarbeitende importieren';

  @override
  String get importIntro =>
      'Importieren Sie Ihre Mitarbeiterliste aus einer Excel- oder CSV-Datei. Jede Person erhält eine Einladung: Mit ihrer Google-E-Mail sieht sie sie gleich bei der Anmeldung; sonst geben Sie ihr den Code oder QR-Code. Niemand wird ohne Zustimmung hinzugefügt.';

  @override
  String get importTemplate => 'Excel-Vorlage herunterladen';

  @override
  String get importTemplateHint =>
      'Spalten: Name, Google-E-Mail, Personalnummer, Position, Standort. Nur der Name ist Pflicht.';

  @override
  String get importChooseFile => 'Datei wählen (.xlsx oder .csv)';

  @override
  String importNew(String count) {
    return 'Neu: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Aktualisiert: $count';
  }

  @override
  String importSkip(String count) {
    return 'Bereits eingeladen: $count';
  }

  @override
  String importErrors(String count) {
    return 'Fehler: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Importieren ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Zeilen mit Fehlern werden übersprungen: Korrigieren Sie sie in der Datei und importieren Sie sie erneut.';

  @override
  String get importCreated => 'neu';

  @override
  String importDone(String count) {
    return 'Einladungen erstellt: $count';
  }

  @override
  String get invitesTitle => 'Offene Einladungen';

  @override
  String get invitesPrint => 'Codes drucken';

  @override
  String get inviteShowHint =>
      'Die Person scannt diesen QR-Code oder gibt diesen Code in Staff Flow ein (Kontomenü, „Ich habe einen Einladungscode“). 90 Tage gültig, einmalig.';

  @override
  String invitesHint(String count) {
    return 'Offene Einladungen: $count. Tippen Sie auf eine Person, um ihren Code und QR-Code anzuzeigen, oder drucken Sie alle.';
  }

  @override
  String get inviteSeenByEmail => 'Einladung gesehen (E-Mail)';

  @override
  String get invitesNone => 'Keine offenen Einladungen.';

  @override
  String get haveInviteCode => 'Ich habe einen Einladungscode';

  @override
  String get newsTab => 'Neuigkeiten';

  @override
  String get newsNew => 'Neue Mitteilung';

  @override
  String get newsEmpty => 'Noch keine Mitteilungen.';

  @override
  String get newsEmptyManager =>
      'Noch keine Mitteilungen. Veröffentlichen Sie die erste: für das ganze Unternehmen, eine Position, einen Standort oder ausgewählte Personen.';

  @override
  String get newsOlder => 'Ältere Mitteilungen';

  @override
  String get newsEdited => 'bearbeitet';

  @override
  String get newsEdit => 'Mitteilung bearbeiten';

  @override
  String get newsDeleteTitle => 'Diese Mitteilung entfernen?';

  @override
  String get newsForEveryone => 'Für alle';

  @override
  String get newsEveryoneMySites => 'Alle an meinen Standorten';

  @override
  String newsFor(String names) {
    return 'Für: $names';
  }

  @override
  String newsReadCount(String count) {
    return 'Gelesen von $count';
  }

  @override
  String newsReadOf(String count, String total) {
    return 'Gelesen von $count von $total';
  }

  @override
  String get newsTranslated => 'Automatisch übersetzt';

  @override
  String get newsTitleField => 'Titel (optional)';

  @override
  String get newsBodyField => 'Text der Mitteilung';

  @override
  String get newsRecipients => 'Empfänger';

  @override
  String get newsTargetHint =>
      'Wählen Sie eine oder mehrere Gruppen: Die Mitteilung geht an jede Person, die zu einer davon gehört.';

  @override
  String get newsPublish => 'Veröffentlichen';

  @override
  String newsSent(String count) {
    return 'Mitteilung an $count Person(en) gesendet.';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Option „API-Zugang“, während des Abonnements hinzugefügt, vom $from bis $to: $months Monate, ohne Rabatt';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Option „Verschachtelte Standorte“, während des Abonnements hinzugefügt, vom $from bis $to: $months Monate, ohne Rabatt';
  }

  @override
  String get billingRenewalOptions =>
      'Angehakte Optionen sind in Ihren nächsten Verlängerungen enthalten. Eine nicht angehakte Option bleibt bis zum Ende des bereits bezahlten Zeitraums aktiv.';

  @override
  String billingAddonTitle(String option) {
    return 'Jetzt hinzufügen: $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'Der laufende Monat ganz, dann jeder Monat bis $date (Ende des bezahlten Zeitraums), ohne Rabatt. Die Option ist sofort nach der Zahlung aktiv und in den nächsten Verlängerungen enthalten.';
  }

  @override
  String get billingAddonInvoice => 'Option';

  @override
  String billingAccessRemoved(String name) {
    return '$name verwaltet das Abonnement nicht mehr.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name kann jetzt das Abonnement und die Rechnungen verwalten.';
  }

  @override
  String get actionBillingRemove => 'Abonnementverwaltung entziehen';

  @override
  String get actionBillingGive => 'Abonnement verwalten lassen';

  @override
  String get billingAccessTag => 'Verwaltet das Abonnement';

  @override
  String get billingOptionRenewed =>
      'Verlängerung der Option wieder aufgenommen.';

  @override
  String get billingOptionStopped =>
      'Option wird nicht verlängert: Sie bleibt bis zum Ende des bezahlten Zeitraums aktiv.';

  @override
  String billingOptionEnds(String date) {
    return 'Aktiv bis $date, wird nicht verlängert (anhaken, um sie zu behalten)';
  }

  @override
  String get billingOptionActive =>
      'Aktiv und wird verlängert (Haken entfernen, um sie nicht zu verlängern)';
}
