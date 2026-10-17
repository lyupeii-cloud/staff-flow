// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class L10nIt extends L10n {
  L10nIt([String locale = 'it']) : super(locale);

  @override
  String get cancel => 'Annulla';

  @override
  String get save => 'Salva';

  @override
  String get confirm => 'Conferma';

  @override
  String get validate => 'Conferma';

  @override
  String get add => 'Aggiungi';

  @override
  String get rename => 'Rinomina';

  @override
  String get delete => 'Elimina';

  @override
  String get accept => 'Accetta';

  @override
  String get decline => 'Rifiuta';

  @override
  String get close => 'Chiudi';

  @override
  String get retry => 'Riprova';

  @override
  String get name => 'Nome';

  @override
  String get serverUnreachable => 'Impossibile raggiungere il server.';

  @override
  String errorStatus(int status) {
    return 'Errore $status';
  }

  @override
  String get roleOwner => 'Titolare';

  @override
  String get roleManager => 'Responsabile';

  @override
  String get roleEmployee => 'Dipendente';

  @override
  String get roleExtra => 'Collaboratore temporaneo';

  @override
  String get taglineStart => 'I turni del tuo team, ';

  @override
  String get taglineEnd => 'ovunque.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Accedi con Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Accesso con Google non disponibile: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Impossibile accedere con Google: $detail';
  }

  @override
  String get newCompany => 'Nuova azienda';

  @override
  String get timezone => 'Fuso orario';

  @override
  String get create => 'Crea';

  @override
  String get noCompanyTitle => 'Non fai ancora parte di nessuna azienda.';

  @override
  String get noCompanyHint =>
      'Per unirti a quella del tuo datore di lavoro, genera un codice e dallo al tuo responsabile.';

  @override
  String get joinCompany => 'Unisciti a un\'azienda';

  @override
  String get createCompany => 'Crea un\'azienda';

  @override
  String transferOffer(String company) {
    return 'Ti viene proposto di diventare titolare di «$company».';
  }

  @override
  String get someCompany => 'un\'azienda';

  @override
  String get becameOwner => 'Ora sei il titolare.';

  @override
  String get myAccount => 'Il mio account';

  @override
  String get idCopied => 'Identificativo copiato.';

  @override
  String get signOut => 'Esci';

  @override
  String joinInvite(String company, String role) {
    return '«$company» ti invita come $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Ti sei unito a $company.';
  }

  @override
  String get viewPlanning => 'Turni';

  @override
  String get viewTeam => 'Configurazione';

  @override
  String get viewPositions => 'Organigramma';

  @override
  String get readOnlyCompany => 'Azienda in sola lettura.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Lascia questa azienda';

  @override
  String meSuffix(String name) {
    return '$name (tu)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Trasferire l\'azienda a $name?';
  }

  @override
  String get transferConfirmBody =>
      'Dopo l\'accettazione, questa persona diventerà titolare (abbonamento, fatture, responsabili) e tu diventerai responsabile.';

  @override
  String transferSent(String name) {
    return 'Proposta inviata a $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Rimuovere $name?';
  }

  @override
  String get removeConfirmBody => 'Lo storico viene conservato.';

  @override
  String get addPersonTitle => 'Aggiungi una persona';

  @override
  String get addPersonHint =>
      'Chiedile di aprire Staff Flow, il menu dell\'account, «Unisciti a un\'azienda», poi inserisci il codice mostrato.';

  @override
  String get sixDigitCode => 'Codice di 6 cifre';

  @override
  String invitationSent(String name) {
    return 'Invito inviato a $name: deve accettarlo.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Lasciare $company?';
  }

  @override
  String get leaveConfirmBody => 'Non vedrai più i suoi turni.';

  @override
  String get renameCompany => 'Rinomina l\'azienda';

  @override
  String get actionMakeManager => 'Nomina responsabile';

  @override
  String get actionMakeEmployee => 'Torna dipendente';

  @override
  String get actionToEmployee => 'Rendi dipendente';

  @override
  String get actionToExtra => 'Rendi temporaneo';

  @override
  String get actionTransfer => 'Trasferisci la titolarità';

  @override
  String get actionRemove => 'Rimuovi dall\'azienda';

  @override
  String get positions => 'Mansioni';

  @override
  String get sites => 'Sedi';

  @override
  String get positionsHint => 'Cosa fa la persona: cassa, cucina, accoglienza…';

  @override
  String get sitesHint => 'Dove si svolge il turno, se l\'azienda ha più sedi.';

  @override
  String get archived => 'Archiviato';

  @override
  String get archive => 'Archivia';

  @override
  String get reactivate => 'Riattiva';

  @override
  String weekOf(String date) {
    return 'Settimana del $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modifiche pubblicate.',
      one: '1 modifica pubblicata.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Turno';

  @override
  String get display => 'Vista';

  @override
  String get week => 'Settimana';

  @override
  String get month => 'Mese';

  @override
  String get today => 'Oggi';

  @override
  String get onlyMine => 'Solo i miei turni';

  @override
  String get replacePersonMenu => 'Sostituisci una persona…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modifiche non pubblicate',
      one: '1 modifica non pubblicata',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'I dipendenti non le vedono ancora.';

  @override
  String get publish => 'Pubblica';

  @override
  String yourHours(String duration) {
    return 'Le tue ore nel periodo: $duration';
  }

  @override
  String get addShiftThisDay => 'Aggiungi un turno in questo giorno';

  @override
  String get noShift => 'Nessun turno';

  @override
  String get unassigned => 'Non assegnato';

  @override
  String get formerMember => 'Ex membro';

  @override
  String get statusDraft => 'Bozza';

  @override
  String get statusModified => 'Modificato';

  @override
  String get statusDeleted => 'Eliminato';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes';
  }

  @override
  String get editShift => 'Modifica il turno';

  @override
  String get newShift => 'Nuovo turno';

  @override
  String get thisShift => 'Questo turno';

  @override
  String get thisAndFollowing => 'Questo e i successivi';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Giorni',
      one: 'Giorno',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Altro giorno';

  @override
  String get start => 'Inizio';

  @override
  String get end => 'Fine';

  @override
  String get endsNextDay => 'Termina il giorno dopo.';

  @override
  String get person => 'Persona';

  @override
  String get position => 'Mansione';

  @override
  String get site => 'Sede';

  @override
  String get noteOptional => 'Nota (facoltativa)';

  @override
  String get repetition => 'Ripetizione';

  @override
  String get repeatNone => 'Nessuna';

  @override
  String get repeatDaily => 'Ogni giorno';

  @override
  String get repeatWeekly => 'Ogni settimana';

  @override
  String get repeatForPrefix => 'Per ';

  @override
  String get repeatDaysSuffix => ' giorni';

  @override
  String get repeatWeeksSuffix => ' settimane';

  @override
  String get repeatUntilPrefix => 'Fino al ';

  @override
  String get replacePersonTitle => 'Sostituisci una persona';

  @override
  String get replaceFrom => 'Sostituisci';

  @override
  String get replaceBy => 'Con';

  @override
  String dateRange(String from, String to) {
    return 'Dal $from al $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count turni modificati.',
      one: '1 turno modificato.',
      zero: 'Nessun turno modificato.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Sostituisci';

  @override
  String get joinHint =>
      'Dai questo codice al tuo responsabile. Lo inserisce nella sua app e riceverai un invito da accettare.';

  @override
  String get codeExpired => 'Codice scaduto.';

  @override
  String codeValidFor(String time) {
    return 'Valido ancora $time';
  }

  @override
  String get newCode => 'Nuovo codice';

  @override
  String get language => 'Lingua';

  @override
  String get languageAuto => 'Automatica (lingua del dispositivo)';

  @override
  String get syncUpToDate => 'Aggiornato';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Modifiche in attesa: $count';
  }

  @override
  String get syncNow => 'Sincronizza';

  @override
  String syncRejected(String reason) {
    return 'Modifica rifiutata dal server: $reason';
  }

  @override
  String get pendingBadge => 'In attesa';

  @override
  String get offlineUnavailable => 'Non disponibile offline.';

  @override
  String get offlineCached => 'Offline: ultimi dati salvati.';

  @override
  String get savedOffline =>
      'Salvato sul dispositivo, verrà inviato al ritorno della rete.';

  @override
  String get notices => 'Avvisi';

  @override
  String get noNotices => 'Nessun avviso.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name ha sostituito la tua modifica al turno del $date.';
  }

  @override
  String get history => 'Cronologia';

  @override
  String get recentChanges => 'Ultime modifiche';

  @override
  String get undoChange => 'Annulla questa modifica';

  @override
  String get undoDone => 'Modifica annullata.';

  @override
  String get historyCreate => 'Creazione';

  @override
  String get historyUpdate => 'Modifica';

  @override
  String get historyDelete => 'Eliminazione';

  @override
  String get historyUndo => 'Annullamento';

  @override
  String get noHistory => 'Nessuna modifica.';

  @override
  String get pendingNotEditable =>
      'Questo turno non è ancora sincronizzato: riprova quando sei online.';

  @override
  String get myQrCode => 'Il mio codice QR';

  @override
  String get myQrCodeHint =>
      'Un responsabile scansiona questo codice per aggiungerti alla sua azienda; poi confermi tu. Non cambia mai.';

  @override
  String get changeMyName => 'Cambia il mio nome';

  @override
  String get nameShownToTeam =>
      'Questo nome viene mostrato ai colleghi al posto del tuo nome Google.';

  @override
  String googleName(String name) {
    return 'Nome Google: $name';
  }

  @override
  String get useGoogleName => 'Usa il mio nome Google';

  @override
  String renameMemberTitle(String name) {
    return 'Rinomina $name';
  }

  @override
  String get renameMemberHint => 'Questo nome è usato solo in questa azienda.';

  @override
  String get useOwnName => 'Usa il suo nome';

  @override
  String get scanQrCode => 'Scansiona un codice QR';

  @override
  String get scanQrHint =>
      'Inquadra il codice QR mostrato nella sua app (menu dell\'account, «Il mio codice QR»).';

  @override
  String get orEnterCode => 'Oppure inserisci il suo codice a 6 cifre';

  @override
  String get qrInvalid => 'Questo non è un codice QR di Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Fotocamera non disponibile ($error).';
  }

  @override
  String get notificationsTitle => 'Notifiche';

  @override
  String get notifChooseHint =>
      'Scegli per cosa ricevere notifiche. Tutto resta visibile nella campanella.';

  @override
  String get notifPlanning => 'Turni pubblicati o modificati';

  @override
  String get notifRequests => 'Richieste: scambi, ferie, inviti';

  @override
  String get notifMessages => 'Nuovi annunci';

  @override
  String get notifOverlap => 'Turni sovrapposti tra aziende';

  @override
  String get notifConflicts =>
      'Le tue modifiche sostituite da un altro responsabile';

  @override
  String get notifBilling => 'Promemoria dell\'abbonamento';

  @override
  String get pushEnabled => 'Le notifiche sono attive su questo dispositivo.';

  @override
  String get pushOff => 'Le notifiche sono disattivate su questo dispositivo.';

  @override
  String get pushBlocked =>
      'Le notifiche sono bloccate: consentile nelle impostazioni del telefono o del browser.';

  @override
  String get pushUnavailable =>
      'Le notifiche non sono disponibili su questo dispositivo.';

  @override
  String get enablePush => 'Attiva';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: i tuoi turni sono stati pubblicati o modificati.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company vuole aggiungerti al suo team.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name ti propone di diventare proprietario di $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name si è unito a $company.';
  }

  @override
  String get translateAction => 'Traduci';

  @override
  String get deleteAllNotices => 'Elimina tutto';

  @override
  String get deleteAllNoticesConfirm => 'Eliminare tutti gli avvisi?';

  @override
  String get noticeRetention => 'Elimina gli avvisi letti dopo';

  @override
  String get retentionDay => '1 giorno';

  @override
  String get retentionWeek => '1 settimana';

  @override
  String get retentionMonth => '1 mese';

  @override
  String get billingOwnersOnly => 'Attivo solo se possiedi un\'azienda.';

  @override
  String get readOnlyPastDays =>
      'I giorni di oltre un mese fa sono di sola lettura.';

  @override
  String get wholeCompany => 'Tutta l\'azienda';

  @override
  String get sitesLabel => 'Sedi';

  @override
  String get actionSites => 'Sedi…';

  @override
  String managerOf(String name) {
    return '$name è responsabile di';
  }

  @override
  String teamSitesOf(String name) {
    return 'Team di $name';
  }

  @override
  String get notYourSite => 'Questa sede non è sotto la tua responsabilità.';

  @override
  String get chooseYourSite => 'Scegli almeno una sede.';

  @override
  String get viewRequests => 'Richieste';

  @override
  String get newRequest => 'Nuova richiesta';

  @override
  String get requestLeave => 'Ferie';

  @override
  String get requestUnavailability => 'Indisponibilità';

  @override
  String get requestSwap => 'Scambio di turno';

  @override
  String get swapHint =>
      'Per proporre uno scambio, tocca uno dei tuoi prossimi turni nel planning.';

  @override
  String get noRequests => 'Nessuna richiesta per ora.';

  @override
  String get requestsToHandle => 'Da gestire';

  @override
  String get statusPendingPeer => 'In attesa del collega';

  @override
  String get statusPendingManager => 'In attesa del responsabile';

  @override
  String get statusApproved => 'Accettata';

  @override
  String get statusRefused => 'Rifiutata';

  @override
  String get statusCancelled => 'Annullata';

  @override
  String get cancelRequest => 'Annulla la richiesta';

  @override
  String get acceptSwap => 'Prendi questo turno';

  @override
  String get approve => 'Approva';

  @override
  String periodLabel(String from, String to) {
    return 'Dal $from al $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Proposto a $name';
  }

  @override
  String get swapToTeam => 'Tutto il team';

  @override
  String everyWeekdays(String days) {
    return 'Ogni settimana: $days';
  }

  @override
  String get unavailableEveryWeek => 'Giorni in cui non sei mai disponibile:';

  @override
  String get choosePeriod => 'Scegli le date';

  @override
  String get choosePeriodOptional => 'Limita a un periodo (facoltativo)';

  @override
  String get clearPeriod => 'Senza periodo';

  @override
  String get sendRequest => 'Invia la richiesta';

  @override
  String get proposeSwap => 'Proponi uno scambio';

  @override
  String get swapWith => 'Proponi a';

  @override
  String get swapSteps =>
      'Il collega accetta, poi un responsabile approva. Il planning cambia solo dopo.';

  @override
  String get absentThatDay => 'Assenza approvata quel giorno';

  @override
  String get requestSent => 'Richiesta inviata.';

  @override
  String noticeSwapOffer(String name) {
    return '$name ti propone uno dei suoi turni.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name ha rifiutato la tua proposta di scambio.';
  }

  @override
  String get noticeSwapToApprove =>
      'Uno scambio di turno attende la tua approvazione.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name chiede ferie.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name segnala un\'indisponibilità.';
  }

  @override
  String get noticeRequestApproved => 'La tua richiesta è stata accettata.';

  @override
  String get noticeRequestRefused => 'La tua richiesta è stata rifiutata.';

  @override
  String get choosePeer => 'Chi prende questo turno?';

  @override
  String get discardAll => 'Annulla tutto';

  @override
  String get notifySitesHint =>
      'Scegli le sedi di cui ricevi le notifiche delle richieste. Tutte le richieste restano visibili nell\'elenco.';

  @override
  String get pendingRequestTooltip => 'Richiesta in attesa: tocca per aprirla';

  @override
  String get requestsHistory => 'Tutte le richieste';

  @override
  String get revertChange => 'Annulla questa modifica';

  @override
  String get statusExpired => 'Non più valida';

  @override
  String get swapWithHint => 'Tocca per scegliere un collega preciso';

  @override
  String changesDiscarded(String count) {
    return 'Modifiche annullate: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Annullare le $count modifiche non pubblicate?';
  }

  @override
  String get allSchedules => 'Tutti i miei planning';

  @override
  String get busyElsewhere =>
      'Già in servizio in un\'altra azienda in questa fascia';

  @override
  String get overlapTooltip => 'Si sovrappone a un turno di un\'altra azienda';

  @override
  String get overlapWarning =>
      'Alcuni tuoi turni in due aziende si sovrappongono.';

  @override
  String noticeOverlap(String date) {
    return 'Due tuoi turni in aziende diverse si sovrappongono il $date.';
  }

  @override
  String get allMyCompanies => 'Tutte le mie aziende';

  @override
  String get openRequest => 'Vedi la richiesta';

  @override
  String get thisCompany => 'Questa azienda';

  @override
  String get withExtras => 'Con gli extra';

  @override
  String reinforcementHint(String company) {
    return 'Da $company: sarà aggiunto come rinforzo e avvisato.';
  }

  @override
  String get addToGoogle => 'Aggiungi a Google Calendar';

  @override
  String get calendarEnabled => 'Sincronizza i miei turni';

  @override
  String get changeSettings => 'Modifica';

  @override
  String get countryBelgium => 'Belgio';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'Francia';

  @override
  String get countrySwitzerland => 'Svizzera';

  @override
  String get employeesSection => 'Dipendenti';

  @override
  String get emptyNoAlert => 'Vuoto: nessun avviso';

  @override
  String get extrasSection => 'Extra';

  @override
  String get googleCalendar => 'Google Calendar';

  @override
  String get hoursTotals => 'Totali ore';

  @override
  String get legalAlerts => 'Avvisi legali';

  @override
  String get legalAlertsHint =>
      'Avvisi, mai blocchi. Scegli le regole che valgono per te, o nessuna.';

  @override
  String get legalPreset => 'Modello per paese';

  @override
  String get maxConsecutiveLabel => 'Massimo di giorni lavorativi consecutivi';

  @override
  String get maxDayLabel => 'Durata massima al giorno (ore)';

  @override
  String get maxWeekLabel => 'Durata massima a settimana (ore)';

  @override
  String get minRestLabel => 'Riposo minimo tra due turni (ore)';

  @override
  String get noLegalRules => 'Nessun avviso scelto.';

  @override
  String get presetNone => 'Nessuno';

  @override
  String get presetsCheck =>
      'I modelli sono un punto di partenza: verificali secondo il tuo paese e il tuo contratto collettivo.';

  @override
  String get printMine => 'Il mio planning';

  @override
  String get printOwn => 'Solo il proprio planning';

  @override
  String get printPdf => 'Stampa / PDF';

  @override
  String get printRights => 'Cosa possono stampare i dipendenti';

  @override
  String get printTeam => 'Il planning di tutto il team';

  @override
  String get printTeamOption => 'Il planning del team';

  @override
  String get totalsHint =>
      'Bozze incluse. Gli export Excel e CSV usano il planning pubblicato.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value giorni di fila (massimo $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value nella giornata (massimo $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: solo $value di riposo (minimo $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value nella settimana (massimo $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Avvisi legali: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Turni: $count';
  }

  @override
  String get actionMakeDeputy => 'Nomina vice responsabile';

  @override
  String get actionRemoveDeputy => 'Togli il ruolo di vice responsabile';

  @override
  String get busyHere => 'Già in servizio nell\'azienda in questa fascia';

  @override
  String get calendarDenied =>
      'Accesso al calendario negato. Consentilo nelle impostazioni del telefono.';

  @override
  String get calendarLinkHint =>
      'Aggiungilo da Google Calendar su un computer; Google lo aggiorna entro qualche ora.';

  @override
  String get calendarNone =>
      'Nessun calendario modificabile su questo telefono.';

  @override
  String get calendarOnPhoneHint =>
      'Nel tuo calendario Google: visibile subito, sul telefono e in Google Calendar.';

  @override
  String get chooseCalendar => 'Scegli il calendario';

  @override
  String get otherSiteHint =>
      'Dipendente di un\'altra sede: i suoi responsabili saranno avvisati.';

  @override
  String get subManager => 'Vice responsabile';

  @override
  String calendarSynced(String count) {
    return 'Turni nel calendario: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Vice responsabile: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by ha assegnato $name alla sede $site il $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company ti ha aggiunto come rinforzo.';
  }

  @override
  String get companyNotificationsHint =>
      'Disattivate: su questo telefono non suona nulla, ma tutto resta nella campanella.';

  @override
  String get companyNotificationsOn => 'Ricevi le notifiche di questa azienda';

  @override
  String get companyTimezone => 'Fuso orario dell\'azienda';

  @override
  String get companyTimezoneHint =>
      'Tutti gli orari di questa azienda sono in questo fuso (ora legale compresa). I calendari li convertono automaticamente.';

  @override
  String get iosInstallHint =>
      'Su iPhone: tocca Condividi, poi «Aggiungi alla schermata Home» per installare Staff Flow.';

  @override
  String get searchCity => 'Cerca una città';

  @override
  String get thisPhone => 'Questo dispositivo';

  @override
  String companyNotifications(String name) {
    return 'Notifiche: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Orari all\'ora di $zone ($company). Il tuo dispositivo: $here.';
  }

  @override
  String get addPreset => 'Aggiungi la preimpostazione';

  @override
  String get addPresets => 'Crea preimpostazioni';

  @override
  String get appearance => 'Aspetto';

  @override
  String get chooseLogo => 'Scegli un\'immagine PNG';

  @override
  String get customization => 'Personalizzazione';

  @override
  String get editPresets => 'Preimpostazioni';

  @override
  String get enable => 'Riattiva';

  @override
  String get logoHint =>
      'Una piccola immagine PNG (il tuo logo) mostrata sulla scheda dell\'azienda, per tutti i membri.';

  @override
  String get logoPngOnly => 'Scegli un\'immagine PNG di massimo 1 MB.';

  @override
  String get myIdentifier => 'Il mio identificativo';

  @override
  String get myProfile => 'Il mio profilo';

  @override
  String get presetName => 'Nome (es. Mattina)';

  @override
  String get removeLogo => 'Rimuovi l\'immagine';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get shiftPresets => 'Preimpostazioni di orario';

  @override
  String get shiftPresetsHint =>
      'Orari pronti (mattina, sera, notte…): un tocco in un turno compila inizio e fine.';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get awaitingApproval => 'Da approvare';

  @override
  String get placementNeedsApproval =>
      '! Questa persona non è delle tue sedi: il turno attenderà l\'approvazione del tuo superiore o del titolare prima di poter essere pubblicato. Altrimenti scegli qualcun altro.';

  @override
  String get placementAwaiting =>
      'In attesa di approvazione da un superiore o dal titolare.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by vuole pianificare $name, di un\'altra sede, il $date: serve l\'approvazione.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by ha approvato la pianificazione di $name il $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by ha rifiutato la pianificazione di $name il $date.';
  }

  @override
  String get addSubSite => 'Aggiungi una sottosede';

  @override
  String get moveSite => 'Sposta';

  @override
  String get topLevel => 'Primo livello';

  @override
  String moveSiteTitle(String name) {
    return 'Sposta «$name» sotto…';
  }

  @override
  String subSiteOf(String name) {
    return 'Sottosede di $name';
  }

  @override
  String get siteTreeHint =>
      'Fino a 10 livelli, per esempio Regione › Città › Negozio. I primi 3 sono inclusi nell\'abbonamento; oltre serve l\'opzione «Sedi a cascata». Il responsabile di una sede gestisce anche tutto ciò che sta sotto.';

  @override
  String get subSitesOnlyHint => 'Qui aggiungi sottosedi sotto le tue sedi.';

  @override
  String get messagingSetting => 'Bacheca delle notizie';

  @override
  String get messagingSettingHint =>
      'Attivata: il titolare e i responsabili pubblicano annunci (per tutti, un ruolo, una sede o persone scelte); tutti li leggono e possono tradurli. Disattivata: la scheda scompare per tutti.';

  @override
  String get billingTitle => 'Abbonamento';

  @override
  String billingStatusTrial(String date) {
    return 'Prova gratuita fino al $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Pagato fino al $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Sola lettura: senza pagamento, l\'azienda sarà eliminata il $date.';
  }

  @override
  String get billingStatusComped => 'Offerto';

  @override
  String billingStaff(String count) {
    return '$count dipendenti e responsabili (esclusi titolare ed extra)';
  }

  @override
  String get billingMonthly => 'Mensile';

  @override
  String billingYearly(String months) {
    return 'Annuale ($months mesi fatturati)';
  }

  @override
  String get billingCascade => 'Opzione «Sedi a cascata» (livelli 4–10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'Inclusa da $count dipendenti';
  }

  @override
  String billingPay(String amount) {
    return 'Paga $amount';
  }

  @override
  String get billingTestNotice =>
      'Pagamento di prova: non viene addebitato nulla.';

  @override
  String get billingSoon => 'Il pagamento online arriverà presto.';

  @override
  String get billingPaidOk => 'Pagamento registrato.';

  @override
  String get billingInvoices => 'Fatture';

  @override
  String get billingNoInvoices => 'Ancora nessuna fattura.';

  @override
  String get billingManage => 'Gestisci l\'abbonamento';

  @override
  String get billingReadOnlyStaff =>
      'Questa azienda è in sola lettura finché il titolare non rinnova l\'abbonamento.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / mese';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / anno';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: la prova gratuita termina tra meno di 24 ore.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company è in sola lettura per mancato pagamento; eliminazione il $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Promemoria: senza pagamento, $company sarà eliminata il $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company è stata eliminata per mancato pagamento.';
  }

  @override
  String billingCompanyId(String id) {
    return 'ID azienda: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Oggi: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Comprende il resto del mese in corso ($days giorni, pro rata) e poi mesi interi dal giorno 1.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Non ancora collegato. Serve a verificare la tua identità, ad esempio per cambiare account Google.';

  @override
  String telegramLinked(String name) {
    return 'Collegato: $name';
  }

  @override
  String get telegramNoUsername => 'senza nome utente';

  @override
  String get telegramLink => 'Collega il mio Telegram';

  @override
  String get telegramLinkHint =>
      'Si apre Telegram: tocca «Avvia», poi torna qui.';

  @override
  String get telegramUnlink => 'Scollega';

  @override
  String get telegramUnavailable => 'Telegram non è ancora disponibile.';

  @override
  String get telegramShowIn => 'Mostra il mio Telegram in:';

  @override
  String get newQrCode => 'Cambia codice QR';

  @override
  String get newQrCodeConfirm =>
      'Il vecchio codice QR e il vecchio identificativo non funzioneranno più. Il tuo posto nelle aziende non cambia.';

  @override
  String get newQrCodeDone => 'Nuovo codice QR creato.';

  @override
  String get changeGoogle => 'Cambia account Google';

  @override
  String get changeGoogleSub => 'Stesso account, stesso numero, stesse aziende';

  @override
  String changeGoogleSteps(String id) {
    return '1. Collega il tuo Telegram in questo profilo (obbligatorio).\n2. Esci, poi accedi con il nuovo account Google.\n3. Scegli «Ho già un account Staff Flow» e inserisci il tuo identificativo $id.\n4. Inserisci il codice ricevuto su Telegram.\nAccount, numero e aziende restano gli stessi.';
  }

  @override
  String get recoverAccount => 'Ho già un account Staff Flow';

  @override
  String get recoverHint =>
      'Inserisci l\'identificativo del tuo vecchio account (SF-…). Un codice verrà inviato al Telegram collegato a quell\'account.';

  @override
  String get recoverIdLabel => 'Identificativo (SF-…)';

  @override
  String get recoverSend => 'Invia il codice';

  @override
  String get recoverCodeSent => 'Codice inviato su Telegram.';

  @override
  String get recoverCodeLabel => 'Codice ricevuto (6 cifre)';

  @override
  String get recoverConfirm => 'Recupera il mio account';

  @override
  String get recoverDone => 'Fatto: sei tornato nel tuo account.';

  @override
  String get exportData => 'Esporta i miei dati';

  @override
  String get exportDataSub => 'Un file con tutti i tuoi dati personali';

  @override
  String get deleteAccount => 'Elimina il mio account';

  @override
  String get deleteGhost => 'Elimina lasciando un fantasma';

  @override
  String get deleteGhostHint =>
      'Lasci tutte le aziende. Accedi più tardi con lo stesso account Google per ritrovare account e numero.';

  @override
  String get deleteErase => 'Cancella tutto definitivamente';

  @override
  String get deleteEraseHint =>
      'Nome, e-mail, foto, Telegram, messaggi e notifiche vengono cancellati. Non si può annullare.';

  @override
  String get deleteGhostNote =>
      'In entrambi i casi, lo storico delle aziende conserva un «Ghost» anonimo al tuo posto (richieste di ferie, turni passati…) perché titolare e responsabili possano ricostruire gli eventi.';

  @override
  String get deleteOwnerNote =>
      'Sei proprietario di un\'azienda? Trasferiscila prima, o lascia scadere l\'abbonamento.';

  @override
  String get deleteConfirmButton => 'Elimina';

  @override
  String get accountRestored =>
      'Bentornato! Il tuo account è stato riattivato.';

  @override
  String get closedInvoices => 'Fatture delle aziende chiuse';

  @override
  String get downloadAllInvoices => 'Scarica tutte le fatture (ZIP)';

  @override
  String get legalTerms => 'Condizioni d\'uso e di vendita';

  @override
  String get legalPrivacy => 'Informativa sulla privacy';

  @override
  String get billingDetailTitle => 'Dettaglio del pagamento';

  @override
  String billingLineProrata(String days, String total) {
    return 'Resto del mese in corso ($days giorni su $total): abbonamento';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Resto del mese in corso ($days giorni su $total): opzione «sedi annidate»';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Abbonamento, $staff posti: 1 mese';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Abbonamento, $staff posti: 12 mesi al prezzo di $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Opzione «sedi annidate»: $months mesi, senza sconto';
  }

  @override
  String get billingTotal => 'Totale';

  @override
  String billingCovers(String from, String to) {
    return 'Periodo coperto: dal $from al $to';
  }

  @override
  String get billingGraceInvoices =>
      'Questa azienda non viene rinnovata: scarica subito tutte le sue fatture.';

  @override
  String get billingYearLabel => 'Anno';

  @override
  String get sitesNoneChosen => 'Nessuna sede scelta';

  @override
  String get avatarTitle => 'Il mio avatar';

  @override
  String get avatarSub => 'Un\'immagine al posto della tua foto';

  @override
  String get avatarUseGoogle => 'Usa la mia foto Google';

  @override
  String get avatarColor => 'Colore';

  @override
  String get hidePhotosTitle => 'Nascondi le foto Google';

  @override
  String get hidePhotosSub =>
      'In questa azienda ognuno appare con il proprio avatar o la propria iniziale.';

  @override
  String get billingApi => 'Opzione «accesso API»';

  @override
  String billingLineApi(String months) {
    return 'Opzione «accesso API»: $months mesi, senza sconto';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Resto del mese in corso ($days giorni su $total): opzione «accesso API»';
  }

  @override
  String get apiTitle => 'Accesso API (contabilità, CRM)';

  @override
  String get apiSub =>
      'I tuoi software (paghe, contabilità, CRM, pianificazione) leggono i turni pubblicati, le ore e le assenze; con «API Pro» inviano anche turni, dipendenti e annunci.';

  @override
  String get apiNeedsOption =>
      'Opzione a pagamento: aggiungi «Accesso API» o «API Pro» in «Gestisci l\'abbonamento».';

  @override
  String get apiNewKey => 'Nuova chiave';

  @override
  String get apiKeyName => 'Nome della chiave (es.: software paghe)';

  @override
  String get apiKeyCreated =>
      'Copia ora questa chiave e conservala al sicuro: non verrà più mostrata.';

  @override
  String get apiKeyCopy => 'Copia';

  @override
  String get apiKeyCopied => 'Chiave copiata.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Ultimo utilizzo: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Mai usata';

  @override
  String get apiRevoke => 'Revoca';

  @override
  String get apiRevokeConfirm =>
      'I software che usano questa chiave perderanno l\'accesso.';

  @override
  String get apiDocs => 'Documentazione API';

  @override
  String get memberGoogleLink => 'Riconnessione Google del dipendente';

  @override
  String googleLinkHint(String name) {
    return 'Invia questo link a $name. Si apre in un browser (non nell\'app Android), una sola volta, per 24 ore: $name accede con il nuovo account Google e ritrova il suo account. Tutti gli altri suoi dispositivi vengono allora disconnessi.';
  }

  @override
  String get googleLinkCopied => 'Link copiato.';

  @override
  String get switchBanner =>
      'Link di cambio account Google: accedi con il tuo nuovo account Google per ritrovare il tuo account Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Questo link collega un account Staff Flow a un nuovo account Google. Esci prima, poi accedi con il nuovo account Google.';

  @override
  String get switchDone =>
      'Fatto: il tuo account Staff Flow è collegato a questo account Google. Gli altri tuoi dispositivi sono stati disconnessi.';

  @override
  String changeGoogleBot(String bot) {
    return 'La cosa più semplice: in Telegram invia /changegoogle al bot $bot e segui le istruzioni, poi accedi con il nuovo account Google entro 10 minuti.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Senza Telegram: chiedi al titolare o a un responsabile un link di cambio account Google.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name ha creato un link per collegare il tuo account a un nuovo account Google. Se non l\'hai chiesto, avvisa il tuo responsabile.';
  }

  @override
  String get sessionRevoked =>
      'Sei stato disconnesso: il tuo account è ora collegato a un altro account Google.';

  @override
  String telegramLoginHint(String bot) {
    return 'Suggerimento: invia /connexion al bot $bot per ricevere un link e aprire Staff Flow nel browser, senza app né account Google.';
  }

  @override
  String get timeFormat => 'Formato dell\'ora';

  @override
  String get timeFormatAuto => 'Auto';

  @override
  String get people => 'Persone';

  @override
  String get sortNatural => 'Ordine abituale';

  @override
  String get sortName => 'Nome';

  @override
  String get employeeNumber => 'Matricola';

  @override
  String get sfIdLabel => 'ID Staff Flow';

  @override
  String get pickSearch => 'Cerca';

  @override
  String get pickSearchPeople => 'Cerca: nome, matricola, ID SF';

  @override
  String get pickSortTitle => 'Ordina e mostra per';

  @override
  String pickSelected(String count) {
    return 'Selezionati: $count';
  }

  @override
  String get pickCheckAll => 'Seleziona tutti';

  @override
  String get pickClear => 'Deseleziona tutti';

  @override
  String get pickNoResult => 'Nessun risultato';

  @override
  String get pickMultiHint =>
      'Seleziona più persone: verrà creato un turno per ciascuna, tutto in una volta.';

  @override
  String get filterAll => 'Tutti';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'Senza ruolo';

  @override
  String get noSiteGroup => 'Senza sede';

  @override
  String get groupByTitle => 'Raggruppa per';

  @override
  String get groupRole => 'Ruolo';

  @override
  String get groupNone => 'Nessun raggruppamento';

  @override
  String showMore(String count, String left) {
    return 'Mostra altri $count (ne restano $left)';
  }

  @override
  String get findByQr => 'Trova un membro con il suo codice QR';

  @override
  String get qrNotMember =>
      'Questo codice QR non corrisponde a nessuno in questa azienda.';

  @override
  String get memberProfile => 'Matricola e ruolo';

  @override
  String get employeeNumberHint =>
      'Numero interno della tua azienda (facoltativo). L\'ID Staff Flow resta assegnato.';

  @override
  String get usualPosition => 'Ruolo abituale';

  @override
  String get inviteCodeTitle => 'Codice di invito';

  @override
  String get inviteCodeHint =>
      'Inserisci il codice ricevuto dal datore di lavoro o scansiona il codice QR del tuo invito.';

  @override
  String inviteJoined(String company) {
    return 'Sei entrato/a in $company.';
  }

  @override
  String get importTitle => 'Importa dipendenti';

  @override
  String get importIntro =>
      'Importa l\'elenco dei dipendenti da un file Excel o CSV. Ognuno riceve un codice e un codice QR personali: attiva l\'account con un\'app 2FA (o con Google). Nessuno viene aggiunto senza il suo consenso.';

  @override
  String get importTemplate => 'Scarica il modello Excel';

  @override
  String get importTemplateHint =>
      'Colonne: nome, matricola, ruolo, sede. Solo il nome è obbligatorio.';

  @override
  String get importChooseFile => 'Scegli un file (.xlsx o .csv)';

  @override
  String importNew(String count) {
    return 'Nuovi: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Aggiornati: $count';
  }

  @override
  String importSkip(String count) {
    return 'Già invitati: $count';
  }

  @override
  String importErrors(String count) {
    return 'Errori: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Importa ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Le righe con errori verranno ignorate: correggile nel file e importalo di nuovo.';

  @override
  String get importCreated => 'nuovo';

  @override
  String importDone(String count) {
    return 'Inviti creati: $count';
  }

  @override
  String get invitesTitle => 'Inviti in attesa';

  @override
  String get invitesPrint => 'Stampa i codici';

  @override
  String get inviteShowHint =>
      'La persona sceglie «Attiva il mio account» nella schermata di accesso (o «Ho un codice di invito» se ha già un account), poi scansiona questo codice QR o digita questo codice. Valido 90 giorni, una sola volta.';

  @override
  String invitesHint(String count) {
    return 'Inviti in attesa: $count. Tocca una persona per mostrare il suo codice e il codice QR, oppure stampali tutti.';
  }

  @override
  String get inviteSeenByEmail => 'invito visto (e-mail)';

  @override
  String get invitesNone => 'Nessun invito in attesa.';

  @override
  String get haveInviteCode => 'Ho un codice di invito';

  @override
  String get newsTab => 'Notizie';

  @override
  String get newsNew => 'Nuovo annuncio';

  @override
  String get newsEmpty => 'Ancora nessun annuncio.';

  @override
  String get newsEmptyManager =>
      'Ancora nessun annuncio. Pubblica il primo: per tutta l\'azienda, un ruolo, una sede o persone scelte.';

  @override
  String get newsOlder => 'Annunci precedenti';

  @override
  String get newsEdited => 'modificato';

  @override
  String get newsEdit => 'Modifica l\'annuncio';

  @override
  String get newsDeleteTitle => 'Ritirare questo annuncio?';

  @override
  String get newsForEveryone => 'Per tutti';

  @override
  String get newsEveryoneMySites => 'Tutti nelle mie sedi';

  @override
  String newsFor(String names) {
    return 'Per: $names';
  }

  @override
  String newsReadCount(String count) {
    return 'Letto da $count';
  }

  @override
  String newsReadOf(String count, String total) {
    return 'Letto da $count su $total';
  }

  @override
  String get newsTranslated => 'Tradotto automaticamente';

  @override
  String get newsTitleField => 'Titolo (facoltativo)';

  @override
  String get newsBodyField => 'Testo dell\'annuncio';

  @override
  String get newsRecipients => 'Destinatari';

  @override
  String get newsTargetHint =>
      'Seleziona uno o più gruppi: l\'annuncio arriva a ogni persona che corrisponde ad almeno uno.';

  @override
  String get newsPublish => 'Pubblica';

  @override
  String newsSent(String count) {
    return 'Annuncio inviato a $count persona/e.';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Opzione «Accesso API», aggiunta durante l\'abbonamento, dal $from al $to: $months mesi, senza sconto';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Opzione «Sedi a cascata», aggiunta durante l\'abbonamento, dal $from al $to: $months mesi, senza sconto';
  }

  @override
  String get billingRenewalOptions =>
      'Le opzioni selezionate saranno incluse nei prossimi rinnovi. Un\'opzione non selezionata resta attiva fino alla fine del periodo già pagato.';

  @override
  String billingAddonTitle(String option) {
    return 'Aggiungi ora: $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'Il mese in corso per intero, poi ogni mese fino al $date (fine del periodo pagato), senza sconto. L\'opzione è attiva subito dopo il pagamento ed è inclusa nei rinnovi successivi.';
  }

  @override
  String get billingAddonInvoice => 'opzione';

  @override
  String billingAccessRemoved(String name) {
    return '$name non gestisce più l\'abbonamento.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name ora può gestire l\'abbonamento e le fatture.';
  }

  @override
  String get actionBillingRemove => 'Togli la gestione dell\'abbonamento';

  @override
  String get actionBillingGive => 'Consenti di gestire l\'abbonamento';

  @override
  String get billingAccessTag => 'Gestisce l\'abbonamento';

  @override
  String get billingOptionRenewed => 'Rinnovo dell\'opzione ripreso.';

  @override
  String get billingOptionStopped =>
      'Opzione non rinnovata: resta attiva fino alla fine del periodo pagato.';

  @override
  String billingOptionEnds(String date) {
    return 'Attiva fino al $date, non verrà rinnovata (seleziona per mantenerla)';
  }

  @override
  String get billingOptionActive =>
      'Attiva e rinnovata (deseleziona per non rinnovarla)';

  @override
  String get statusCancelRequested => 'Annullamento richiesto';

  @override
  String get requestEndedEarly => 'Terminata in anticipo dalla persona.';

  @override
  String get confirmCancelRequest =>
      'Annullare questa richiesta? I responsabili non la vedranno più.';

  @override
  String get endUnavailability => 'Termina la mia indisponibilità';

  @override
  String get confirmEndUnavailability =>
      'Terminare la tua indisponibilità? Sarai di nuovo disponibile da oggi e i responsabili saranno avvisati.';

  @override
  String get askLeaveCancel => 'Chiedi di annullare queste ferie';

  @override
  String get confirmAskLeaveCancel =>
      'Chiedere di annullare queste ferie? Un responsabile dovrà approvarlo; fino ad allora le ferie restano previste.';

  @override
  String get refuseLeaveCancel => 'Rifiuta l\'annullamento';

  @override
  String get acceptLeaveCancel => 'Accetta l\'annullamento';

  @override
  String get requestsSearchHint => 'Cerca: nome, matricola, ID SF, nota';

  @override
  String get filterType => 'Tipo';

  @override
  String get filterState => 'Stato';

  @override
  String get statePending => 'In attesa';

  @override
  String get stateClosed => 'Rifiutate o annullate';

  @override
  String billingLineSlotsAddon(
    String from,
    String to,
    String start,
    String end,
    String months,
  ) {
    return 'Posti aggiunti, da $from a $to, dal $start al $end: $months mesi, senza sconto';
  }

  @override
  String billingSeats(String used, String limit) {
    return '$used posti pagati · fino a $limit persone con il margine del 5%';
  }

  @override
  String get billingSeatsTitle => 'Numero di posti';

  @override
  String get billingSeatsHint =>
      'Dipendenti e responsabili (esclusi titolare ed extra), a blocchi di 10. 10 posti alla creazione; oltre, un margine del 5%, poi non si può più aggiungere.';

  @override
  String get billingSeatsUnit => 'posti';

  @override
  String billingSeatsAddon(String from, String to) {
    return 'Posti: $from → $to';
  }

  @override
  String billingSeatsRange(String min) {
    return 'Da $min a 5000, a blocchi di 10.';
  }

  @override
  String get printWeek => 'Settimana';

  @override
  String get printMonth => 'Mese';

  @override
  String teamCount(String team, String count) {
    return '$team · $count';
  }

  @override
  String teamCountSeats(String team, String count, String slots) {
    return '$team · $count/$slots';
  }

  @override
  String get rememberMe => 'Resta connesso su questo dispositivo';

  @override
  String get rememberMeHint =>
      'Attivo: come con Google, nessun codice a ogni apertura. Da evitare su un dispositivo condiviso.';

  @override
  String get totpLoginTitle => 'Accesso 2FA';

  @override
  String get totpCompanyCode => 'Codice dell\'azienda';

  @override
  String get totpCompanyCodeHint =>
      '6 caratteri forniti dal datore di lavoro (solo con la matricola).';

  @override
  String get totpBackupCode => 'Codice di riserva';

  @override
  String get totpCode => 'Codice dell\'app';

  @override
  String get totpUseApp => 'Usa l\'app 2FA';

  @override
  String get totpUseBackup => 'Usa un codice di riserva';

  @override
  String get totpSignIn => 'Accedi';

  @override
  String get totpLostPhone =>
      'Telefono perso o app cancellata? Chiedi al tuo responsabile un nuovo codice di attivazione.';

  @override
  String get activateTitle => 'Attiva il mio account';

  @override
  String get activateStep1 => 'Passo 1: il tuo codice di invito';

  @override
  String get activateStep1Hint =>
      'Scansiona il codice QR fornito dal datore di lavoro o digita il codice scritto sotto.';

  @override
  String get activateScan => 'Scansiona il codice QR';

  @override
  String get activateCodeField => 'Codice di invito';

  @override
  String get activateContinue => 'Continua';

  @override
  String activateHello(String name, String company) {
    return 'Ciao $name · $company';
  }

  @override
  String get activateStep2 =>
      'Passo 2: collega un\'app di autenticazione (Google Authenticator, Microsoft Authenticator…). Ti darà un codice a 6 cifre a ogni accesso.';

  @override
  String get activateOpenApp => 'Aggiungi alla mia app di autenticazione';

  @override
  String get activateOrScan =>
      'Oppure, da un altro dispositivo, scansiona questo codice QR con l\'app:';

  @override
  String get activateManualKey => 'Chiave da digitare a mano:';

  @override
  String get activateFirstCode => 'Primo codice mostrato dall\'app';

  @override
  String get activateDone => 'Attiva';

  @override
  String get totpReadyTitle => 'Il tuo account è pronto';

  @override
  String get totpYourId => 'Il tuo identificativo Staff Flow:';

  @override
  String get totpBackupHint =>
      'Codici di riserva (ognuno vale una volta): annotali o conservali in un luogo sicuro. Servono se non hai più l\'app.';

  @override
  String get totpBackupSaved => 'Fatto';

  @override
  String get linkGoogleTitle => 'Collega un account Google';

  @override
  String get linkGoogleHint =>
      'Per creare un\'azienda, collega un account Google al tuo account Staff Flow. Serve solo a proteggere il creatore dell\'azienda e il suo abbonamento: il tuo indirizzo Google non viene mai mostrato ai tuoi dipendenti né ad altri, resta in Staff Flow. Potrai continuare ad accedere con la tua app 2FA.';

  @override
  String get linkGoogleButton => 'Collega il mio account Google';

  @override
  String get linkGoogleBanner =>
      'Accedi con l\'account Google da collegare a Staff Flow.';

  @override
  String get activationCodeAction => 'Nuovo codice di attivazione';

  @override
  String activationCodeTitle(String name) {
    return 'Nuovo codice per $name?';
  }

  @override
  String get activationCodeConfirm =>
      'Il vecchio telefono e la vecchia app 2FA non funzioneranno più. La persona riattiva l\'account con questo codice (valido 7 giorni).';

  @override
  String get activationCodeHint =>
      'La persona sceglie «Attiva il mio account» nella schermata di accesso, poi scansiona questo codice QR o digita questo codice.';

  @override
  String get signupTitle => 'Crea un account';

  @override
  String get signupStep1 => 'Passo 1: il tuo nome';

  @override
  String get signupStep1Hint =>
      'Il nome che vedranno colleghi e datori di lavoro. Niente Google né e-mail: l\'account è protetto da un\'app di autenticazione.';

  @override
  String get signupName => 'Nome e cognome';

  @override
  String signupHello(String name) {
    return 'Ciao $name';
  }

  @override
  String get signupButton => 'Crea un account con un\'app 2FA';

  @override
  String get totpCardTitle => 'Accesso con un\'app 2FA';

  @override
  String totpCardLocal(String id) {
    return 'Il tuo account accede con un\'app di autenticazione. Identificativo: $id';
  }

  @override
  String totpCardOn(String id) {
    return 'Attivo: puoi anche accedere con il tuo identificativo $id e il codice dell\'app, senza Google.';
  }

  @override
  String get totpCardOff =>
      'Prepara un\'app di autenticazione per poter accedere senza Google (ID SF + codice a 6 cifre).';

  @override
  String get totpEnable => 'Attiva';

  @override
  String get totpDisable => 'Rimuovi';

  @override
  String get totpEnableTitle => 'Attiva l\'accesso 2FA';

  @override
  String get totpEnabledTitle => 'Accesso 2FA pronto';

  @override
  String get totpDisableConfirm =>
      'Rimuovere l\'accesso con l\'app 2FA? Accederai solo con Google.';

  @override
  String get googlePrivacyNote =>
      'Il tuo account Google serve solo a proteggere l\'azienda e il suo abbonamento: non viene mai mostrato ai tuoi dipendenti né ad altri.';

  @override
  String get scopeRead => 'Lettura: turni pubblicati, ore, assenze, dipendenti';

  @override
  String get scopeShifts => 'Turni: creare, modificare, eliminare';

  @override
  String get scopePublish => 'Pubblicare i turni';

  @override
  String get scopeMembers => 'Dipendenti: importazione, matricola e ruolo';

  @override
  String get scopeCatalog => 'Ruoli e sedi';

  @override
  String get scopeNews => 'Annunci';

  @override
  String get scopeRequests => 'Richieste: approvare o rifiutare';

  @override
  String get apiScopesTitle => 'Diritti della chiave';

  @override
  String get apiProNeeded =>
      'I diritti di scrittura richiedono l\'opzione «API Pro» (abbonamento pagato).';

  @override
  String billingLinePro(String months) {
    return 'Opzione «API Pro»: $months mesi';
  }

  @override
  String billingLineProAddon(String start, String end, String months) {
    return 'Opzione «API Pro», aggiunta durante l\'abbonamento, dal $start al $end: $months mesi, senza sconto';
  }

  @override
  String billingApiProHint(String price1, String price5) {
    return '«API Pro» (lettura e scrittura, webhook, registri): $price1 / mese per 1 chiave, $price5 / mese per 10 chiavi, senza sconto. Sceglila qui, con il pagamento dell\'abbonamento.';
  }

  @override
  String get whTitle => 'Webhook';

  @override
  String get whSub =>
      'Staff Flow avvisa da solo i tuoi software quando succede qualcosa: turni pubblicati, richiesta, nuovo dipendente, annuncio. Incluso nell\'opzione «API Pro».';

  @override
  String get whNew => 'Nuovo webhook';

  @override
  String get whUrl => 'Indirizzo (https://…)';

  @override
  String get whEvents => 'Eventi inviati';

  @override
  String get whCreated =>
      'Segreto di firma, mostrato una sola volta: il tuo software lo usa per verificare che ogni invio provenga davvero da Staff Flow.';

  @override
  String get whTest => 'Prova';

  @override
  String whTestOk(String status) {
    return 'Ricevuto (codice $status)';
  }

  @override
  String whTestFail(String error) {
    return 'Errore: $error';
  }

  @override
  String get whDisabled => 'Disattivato dopo 10 invii falliti di fila';

  @override
  String get whEnable => 'Riattiva';

  @override
  String get whDelete => 'Elimina';

  @override
  String get whDeleteConfirm => 'Questo webhook non riceverà più nulla.';

  @override
  String get whNone => 'Ancora nessun webhook.';

  @override
  String whLast(String date, String status) {
    return 'Ultimo invio: $date · $status';
  }

  @override
  String get whEvSchedulePublished => 'Turni pubblicati';

  @override
  String get whEvRequestCreated => 'Nuova richiesta';

  @override
  String get whEvRequestDecided => 'Richiesta approvata o rifiutata';

  @override
  String get whEvRequestCancelled => 'Richiesta annullata';

  @override
  String get whEvRequestCancelAsked => 'Annullamento ferie richiesto';

  @override
  String get whEvRequestCancelDecided => 'Annullamento ferie deciso';

  @override
  String get whEvRequestEnded => 'Indisponibilità terminata';

  @override
  String get whEvMemberJoined => 'Nuovo dipendente';

  @override
  String get whEvAnnouncementPublished => 'Annuncio pubblicato';

  @override
  String get whStDelivered => 'ricevuto';

  @override
  String get whStPending => 'in attesa';

  @override
  String get whStFailed => 'errore';

  @override
  String get whStDropped => 'scartato';

  @override
  String get lgTitle => 'Registri';

  @override
  String get lgSub =>
      'Ogni chiamata delle tue chiavi API e dell\'assistente MCP, e ogni invio di webhook. Scorri per cambiare mese.';

  @override
  String get lgSearch => 'Cerca: persona, matricola, azione…';

  @override
  String get lgAllHistory => 'Cerca in tutta la cronologia (archivi inclusi)';

  @override
  String get lgArchived => 'Mese archiviato';

  @override
  String get lgNone => 'Niente in questo mese.';

  @override
  String get lgMore => 'Mostra altro';

  @override
  String get lgExport => 'Scarica un anno (ZIP)';

  @override
  String get lgAllKeys => 'Tutte le chiavi';

  @override
  String get lgSourceApi => 'API';

  @override
  String get lgSourceMcp => 'Assistente MCP';

  @override
  String get lgSourceWebhook => 'Webhook';

  @override
  String get lgKindRead => 'Lettura';

  @override
  String get lgKindWrite => 'Scrittura';

  @override
  String get lgOk => 'Riuscito';

  @override
  String get lgError => 'Errore';

  @override
  String get lgBefore => 'Prima';

  @override
  String get lgAfter => 'Dopo';

  @override
  String lgStats(String today, String month) {
    return 'Oggi: $today · questo mese: $month';
  }

  @override
  String lgLastFailure(String date) {
    return 'Ultimo errore: $date';
  }

  @override
  String get lgActShiftsCreate => 'Turni creati';

  @override
  String get lgActShiftUpdate => 'Turno modificato';

  @override
  String get lgActShiftDelete => 'Turno eliminato';

  @override
  String get lgActPublish => 'Turni pubblicati';

  @override
  String get lgActImport => 'Dipendenti importati';

  @override
  String get lgActProfile => 'Matricola o ruolo modificati';

  @override
  String get lgActPosition => 'Ruolo creato';

  @override
  String get lgActSite => 'Sede creata';

  @override
  String get lgActNews => 'Annuncio pubblicato';

  @override
  String get lgActApprove => 'Richiesta approvata';

  @override
  String get lgActRefuse => 'Richiesta rifiutata';

  @override
  String get lgActRead => 'Lettura';

  @override
  String get lgActWebhook => 'Webhook inviato';

  @override
  String get lgFDay => 'Giorno';

  @override
  String get lgFStart => 'Inizio';

  @override
  String get lgFEnd => 'Fine';

  @override
  String get lgFPerson => 'Persona';

  @override
  String get lgFSite => 'Sede';

  @override
  String get lgFPosition => 'Ruolo';

  @override
  String get lgFNote => 'Nota';

  @override
  String get lgFNumber => 'Matricola';

  @override
  String noticeApiFailing(String key, String count) {
    return 'La chiave API «$key» non è riuscita $count volte in un\'ora: controlla il software che la usa.';
  }

  @override
  String noticeApiNewIp(String key, String ip) {
    return 'La chiave API «$key» è stata usata da un nuovo indirizzo ($ip). Se non sei stato tu, revocala.';
  }

  @override
  String get lgResults => 'Risultati in tutta la cronologia';

  @override
  String get lgAllSources => 'Tutte le origini';

  @override
  String get lgAllKinds => 'Lettura e scrittura';

  @override
  String get lgAllResults => 'Riusciti ed errori';

  @override
  String get lgFDate => 'Data';

  @override
  String get lgFKey => 'Chiave';

  @override
  String get lgFSource => 'Origine';

  @override
  String get lgFStatus => 'Stato';

  @override
  String get totpContinueButton => 'Continua con un\'app 2FA';

  @override
  String get totpIdentHint =>
      'Inserisci il tuo identificativo Staff Flow (SF-…), la tua matricola o il codice di attivazione del datore di lavoro.';

  @override
  String get totpIdentField =>
      'Identificativo, matricola o codice del datore di lavoro';

  @override
  String get totpContinue => 'Continua';

  @override
  String get totpUnknown =>
      'Questo identificativo non esiste. Vuoi creare un account?';

  @override
  String get totpGoogleAccount =>
      'Questo account accede con Google: torna indietro e tocca «Accedi con Google».';

  @override
  String get totpNoAccount => 'Non hai ancora un account? Creane uno';

  @override
  String get totpChange => 'Altro identificativo';

  @override
  String get billingNotInApp =>
      'Gli acquisti non sono disponibili nell\'app mobile.';

  @override
  String get billingActiveOptions => 'Opzioni attive';

  @override
  String get billingNoOptions => 'Nessuna opzione attiva.';

  @override
  String get optionNotActive =>
      'Questa opzione non è attiva per questa azienda.';

  @override
  String get apiProNotActive =>
      'L\'opzione «API Pro» non è attiva per questa azienda.';

  @override
  String get apiKeySaved => 'Chiave salvata.';

  @override
  String get apiKeyIncomplete =>
      'Dai un nome alla chiave e scegli almeno un diritto.';

  @override
  String get billingApiPro1 => 'Opzione «API Pro» (1 chiave)';

  @override
  String get billingApiPro10 => 'Opzione «API Pro» (10 chiavi)';

  @override
  String get billingApiPro10Upgrade => 'Passa a 10 chiavi';

  @override
  String get billingProKeysNext => 'Al prossimo rinnovo';

  @override
  String get billingProKeys1 => '1 chiave';

  @override
  String get billingProKeys10 => '10 chiavi';

  @override
  String billingProKeysWarning(String count) {
    return '$count chiavi sono attive: al rinnovo resterà attiva solo la più vecchia. Sceglierai quale tenere in «Accesso API».';
  }

  @override
  String get billingApiIncluded => 'Lettura inclusa in «API Pro».';

  @override
  String billingLinePro10Addon(String start, String end, String months) {
    return 'Opzione «API Pro», 10 chiavi, aggiunta durante l\'abbonamento, dal $start al $end: $months mesi, senza sconto';
  }

  @override
  String billingLinePro10Upgrade(String start, String end, String months) {
    return 'Passaggio di «API Pro» a 10 chiavi, dal $start al $end: $months mesi (differenza di prezzo), senza sconto';
  }

  @override
  String apiKeysCount(String count, String limit) {
    return 'Chiavi attive: $count / $limit';
  }

  @override
  String get apiKeyDisabled => 'Disattivata: oltre il tuo piano API';

  @override
  String get apiKeyEnable => 'Riattiva';

  @override
  String get apiKeyDisable => 'Metti da parte';

  @override
  String get apiKeyLimitReached =>
      'Il tuo piano non consente altre chiavi: metti da parte una chiave o passa a un piano superiore.';

  @override
  String noticeApiKeysDeletion(String company, String date) {
    return '$company: accesso API interrotto, le chiavi saranno eliminate il $date salvo riattivazione dell\'opzione.';
  }

  @override
  String get billingApiProChoice => 'Opzione «API Pro»';

  @override
  String get billingApiProNone => 'Senza';

  @override
  String get billingApiProNowNote =>
      'Abbonamento in corso: anche il periodo già pagato viene completato con «API Pro», nello stesso pagamento.';
}
