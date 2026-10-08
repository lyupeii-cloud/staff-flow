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
  String get viewTeam => 'Team';

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
}
