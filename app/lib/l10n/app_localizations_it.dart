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
  String myId(String id) {
    return 'Il mio identificativo: $id';
  }

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
  String get viewTeam => 'Gestione';

  @override
  String get viewPositions => 'Mansioni';

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
  String get notifMessages => 'Nuovi messaggi';

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
  String get messagesTab => 'Messaggi';

  @override
  String get wholeTeam => 'Tutto il team';

  @override
  String get newConversation => 'Nuova conversazione';

  @override
  String get noMessages => 'Ancora nessun messaggio.';

  @override
  String get messageHint => 'Scrivi un messaggio';

  @override
  String get earlierMessages => 'Messaggi precedenti';

  @override
  String get personLeftCompany =>
      'Questa persona non fa più parte dell\'azienda.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Nuovo gruppo';

  @override
  String get editGroup => 'Modifica gruppo';

  @override
  String get groupName => 'Nome del gruppo';

  @override
  String get groupMembersHint =>
      'Scegli le persone di questo gruppo. Solo loro vedranno i messaggi.';

  @override
  String get chooseAtLeastOne => 'Scegli almeno una persona.';

  @override
  String get replyAction => 'Rispondi';

  @override
  String get translateAction => 'Traduci';

  @override
  String replyingTo(String name) {
    return 'Risposta a $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Ultimi messaggi di $name';
  }

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
  String get myRequests => 'Le mie richieste';

  @override
  String get otherRequests => 'Richieste del team';

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
  String get notifySitesTitle => 'Notifiche per sede';

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
  String get deleteGroup => 'Elimina il gruppo';

  @override
  String get openRequest => 'Vedi la richiesta';

  @override
  String get thisCompany => 'Questa azienda';

  @override
  String get withExtras => 'Con gli extra';

  @override
  String deleteGroupConfirm(String name) {
    return 'Eliminare «$name» e tutti i messaggi per tutti?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Da $company: sarà aggiunto come rinforzo e avvisato.';
  }

  @override
  String get addToGoogle => 'Aggiungi a Google Calendar';

  @override
  String get calendarEnabled => 'Sincronizza i miei turni';

  @override
  String get calendarHint =>
      'Aggiungi i turni di tutte le tue aziende a Google Calendar. Si aggiornano da soli e puoi disattivarlo quando vuoi.';

  @override
  String get changeSettings => 'Modifica';

  @override
  String get copyCalendarLink => 'Copia il link del calendario';

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
  String get linkCopied => 'Link copiato.';

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
  String get calendarByLink => 'Tramite link (Google Calendar da computer)';

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
  String get calendarOnPhone =>
      'Aggiungi i miei turni al calendario del telefono';

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
  String get conversationMuted =>
      'Notifiche disattivate per questa conversazione.';

  @override
  String get conversationUnmuted =>
      'Notifiche riattivate per questa conversazione.';

  @override
  String get customization => 'Personalizzazione';

  @override
  String get disableGroup => 'Disattiva il gruppo';

  @override
  String get disableGroupConfirm =>
      'Il gruppo di tutta l\'azienda sarà nascosto per tutti. Potrai riattivarlo in Messaggi.';

  @override
  String get editPresets => 'Preimpostazioni';

  @override
  String get enable => 'Riattiva';

  @override
  String get groupDisabled => 'Gruppo disattivato (lo vedi solo tu)';

  @override
  String get logoHint =>
      'Una piccola immagine PNG (il tuo logo) mostrata sulla scheda dell\'azienda, per tutti i membri.';

  @override
  String get logoPngOnly => 'Scegli un\'immagine PNG di massimo 1 MB.';

  @override
  String get muteConversation =>
      'Disattiva le notifiche di questa conversazione';

  @override
  String get myIdentifier => 'Il mio identificativo';

  @override
  String get myProfile => 'Il mio profilo';

  @override
  String get presetName => 'Nome (es. Mattina)';

  @override
  String get removeLogo => 'Rimuovi l\'immagine';

  @override
  String get resetGroup => 'Reimposta il gruppo';

  @override
  String get resetGroupConfirm =>
      'Tutti i messaggi del gruppo dell\'azienda saranno cancellati per tutti.';

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
  String get unmuteConversation =>
      'Riattiva le notifiche di questa conversazione';

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
      'Fino a 3 livelli, ad es. Regione › Città › Negozio. Il responsabile di una sede gestisce anche tutto ciò che sta sotto.';

  @override
  String get subSitesOnlyHint => 'Qui aggiungi sottosedi sotto le tue sedi.';

  @override
  String get messagingSetting => 'Messaggistica aziendale';

  @override
  String get messagingSettingHint =>
      'Attiva: il team ha una scheda Messaggi. Disattiva: nessuno la vede né può scrivere (i vecchi messaggi restano).';
}
