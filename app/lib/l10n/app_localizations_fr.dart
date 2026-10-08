// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get validate => 'Valider';

  @override
  String get add => 'Ajouter';

  @override
  String get rename => 'Renommer';

  @override
  String get delete => 'Supprimer';

  @override
  String get accept => 'Accepter';

  @override
  String get decline => 'Refuser';

  @override
  String get close => 'Fermer';

  @override
  String get retry => 'Réessayer';

  @override
  String get name => 'Nom';

  @override
  String get serverUnreachable => 'Serveur injoignable.';

  @override
  String errorStatus(int status) {
    return 'Erreur $status';
  }

  @override
  String get roleOwner => 'Propriétaire';

  @override
  String get roleManager => 'Responsable';

  @override
  String get roleEmployee => 'Salarié';

  @override
  String get roleExtra => 'Extra';

  @override
  String get taglineStart => 'Les plannings de votre équipe, ';

  @override
  String get taglineEnd => 'partout.';

  @override
  String get googleNotConfigured =>
      'Connexion Google non configurée (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Se connecter avec Google';

  @override
  String get devSection => 'Développement';

  @override
  String get emailLabel => 'Adresse e-mail';

  @override
  String get devSignIn => 'Connexion de test';

  @override
  String googleUnavailable(String detail) {
    return 'Connexion Google indisponible : $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Connexion Google impossible : $detail';
  }

  @override
  String get newCompany => 'Nouvelle entreprise';

  @override
  String get timezone => 'Fuseau horaire';

  @override
  String get create => 'Créer';

  @override
  String get noCompanyTitle => 'Vous ne faites partie d\'aucune entreprise.';

  @override
  String get noCompanyHint =>
      'Pour rejoindre celle de votre employeur, générez un code et donnez-le à votre responsable.';

  @override
  String get joinCompany => 'Rejoindre une entreprise';

  @override
  String get createCompany => 'Créer une entreprise';

  @override
  String transferOffer(String company) {
    return 'On vous propose de devenir propriétaire de « $company ».';
  }

  @override
  String get someCompany => 'une entreprise';

  @override
  String get becameOwner => 'Vous êtes maintenant propriétaire.';

  @override
  String get myAccount => 'Mon compte';

  @override
  String get idCopied => 'Identifiant copié.';

  @override
  String myId(String id) {
    return 'Mon identifiant : $id';
  }

  @override
  String get signOut => 'Se déconnecter';

  @override
  String joinInvite(String company, String role) {
    return '« $company » vous invite comme $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Vous avez rejoint $company.';
  }

  @override
  String get viewPlanning => 'Planning';

  @override
  String get viewTeam => 'Équipe';

  @override
  String get viewPositions => 'Postes';

  @override
  String get readOnlyCompany => 'Entreprise en lecture seule.';

  @override
  String get team => 'Équipe';

  @override
  String get leaveCompany => 'Quitter cette entreprise';

  @override
  String meSuffix(String name) {
    return '$name (vous)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Transférer l\'entreprise à $name ?';
  }

  @override
  String get transferConfirmBody =>
      'Une fois la proposition acceptée, cette personne deviendra propriétaire (abonnement, factures, responsables) et vous deviendrez responsable.';

  @override
  String transferSent(String name) {
    return 'Proposition envoyée à $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Retirer $name ?';
  }

  @override
  String get removeConfirmBody => 'Son historique est conservé.';

  @override
  String get addPersonTitle => 'Ajouter une personne';

  @override
  String get addPersonHint =>
      'Demandez-lui d\'ouvrir Staff Flow, menu de son compte, « Rejoindre une entreprise », puis saisissez le code affiché.';

  @override
  String get sixDigitCode => 'Code à 6 chiffres';

  @override
  String invitationSent(String name) {
    return 'Invitation envoyée à $name : cette personne doit l\'accepter.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Quitter $company ?';
  }

  @override
  String get leaveConfirmBody => 'Vous ne verrez plus son planning.';

  @override
  String get renameCompany => 'Renommer l\'entreprise';

  @override
  String get actionMakeManager => 'Nommer responsable';

  @override
  String get actionMakeEmployee => 'Repasser salarié';

  @override
  String get actionToEmployee => 'Passer salarié';

  @override
  String get actionToExtra => 'Passer extra';

  @override
  String get actionTransfer => 'Transférer la propriété';

  @override
  String get actionRemove => 'Retirer de l\'entreprise';

  @override
  String get positions => 'Postes';

  @override
  String get sites => 'Sites';

  @override
  String get positionsHint =>
      'Ce que fait la personne : caisse, cuisine, accueil…';

  @override
  String get sitesHint =>
      'Où se passe le service, si l\'entreprise a plusieurs lieux.';

  @override
  String get archived => 'Archivé';

  @override
  String get archive => 'Archiver';

  @override
  String get reactivate => 'Réactiver';

  @override
  String weekOf(String date) {
    return 'Semaine du $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count changements publiés.',
      one: '1 changement publié.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Service';

  @override
  String get display => 'Affichage';

  @override
  String get week => 'Semaine';

  @override
  String get month => 'Mois';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get onlyMine => 'Seulement mes services';

  @override
  String get replacePersonMenu => 'Remplacer une personne…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count changements non publiés',
      one: '1 changement non publié',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Les salariés ne les voient pas encore.';

  @override
  String get publish => 'Publier';

  @override
  String yourHours(String duration) {
    return 'Vos heures sur la période : $duration';
  }

  @override
  String get addShiftThisDay => 'Ajouter un service ce jour';

  @override
  String get noShift => 'Aucun service';

  @override
  String get unassigned => 'Non attribué';

  @override
  String get formerMember => 'Ancien membre';

  @override
  String get statusDraft => 'Brouillon';

  @override
  String get statusModified => 'Modifié';

  @override
  String get statusDeleted => 'Supprimé';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes';
  }

  @override
  String get editShift => 'Modifier le service';

  @override
  String get newShift => 'Nouveau service';

  @override
  String get thisShift => 'Ce service';

  @override
  String get thisAndFollowing => 'Celui-ci et les suivants';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jours',
      one: 'Jour',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Autre jour';

  @override
  String get start => 'Début';

  @override
  String get end => 'Fin';

  @override
  String get endsNextDay => 'Se termine le lendemain.';

  @override
  String get person => 'Personne';

  @override
  String get position => 'Poste';

  @override
  String get site => 'Site';

  @override
  String get noteOptional => 'Note (facultatif)';

  @override
  String get repetition => 'Répétition';

  @override
  String get repeatNone => 'Aucune';

  @override
  String get repeatDaily => 'Chaque jour';

  @override
  String get repeatWeekly => 'Chaque semaine';

  @override
  String get repeatForPrefix => 'Pendant ';

  @override
  String get repeatDaysSuffix => ' jours';

  @override
  String get repeatWeeksSuffix => ' semaines';

  @override
  String get repeatUntilPrefix => 'Jusqu\'au ';

  @override
  String get replacePersonTitle => 'Remplacer une personne';

  @override
  String get replaceFrom => 'Remplacer';

  @override
  String get replaceBy => 'Par';

  @override
  String dateRange(String from, String to) {
    return 'Du $from au $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count services modifiés.',
      one: '1 service modifié.',
      zero: 'Aucun service modifié.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Remplacer';

  @override
  String get joinHint =>
      'Donnez ce code à votre responsable. Il le saisit dans son application, puis vous recevez une invitation à accepter.';

  @override
  String get codeExpired => 'Code expiré.';

  @override
  String codeValidFor(String time) {
    return 'Valable encore $time';
  }

  @override
  String get newCode => 'Nouveau code';

  @override
  String get language => 'Langue';

  @override
  String get languageAuto => 'Automatique (langue de l’appareil)';

  @override
  String get syncUpToDate => 'À jour';

  @override
  String get syncOffline => 'Hors connexion';

  @override
  String syncPending(int count) {
    return 'Modifications en attente : $count';
  }

  @override
  String get syncNow => 'Synchroniser';

  @override
  String syncRejected(String reason) {
    return 'Modification refusée par le serveur : $reason';
  }

  @override
  String get pendingBadge => 'En attente';

  @override
  String get offlineUnavailable => 'Indisponible hors connexion.';

  @override
  String get offlineCached =>
      'Hors connexion : dernières données enregistrées.';

  @override
  String get savedOffline =>
      'Enregistré sur l’appareil, envoyé au retour du réseau.';

  @override
  String get notices => 'Avis';

  @override
  String get noNotices => 'Aucun avis.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name a remplacé votre modification du service du $date.';
  }

  @override
  String get history => 'Historique';

  @override
  String get recentChanges => 'Dernières modifications';

  @override
  String get undoChange => 'Annuler ce changement';

  @override
  String get undoDone => 'Changement annulé.';

  @override
  String get historyCreate => 'Création';

  @override
  String get historyUpdate => 'Modification';

  @override
  String get historyDelete => 'Suppression';

  @override
  String get historyUndo => 'Annulation';

  @override
  String get noHistory => 'Aucune modification.';

  @override
  String get pendingNotEditable =>
      'Ce service n’est pas encore synchronisé : réessayez une fois en ligne.';

  @override
  String get myQrCode => 'Mon QR code';

  @override
  String get myQrCodeHint =>
      'Un responsable scanne ce code pour vous ajouter à son entreprise ; vous confirmez ensuite. Il ne change jamais.';

  @override
  String get changeMyName => 'Changer mon nom';

  @override
  String get nameShownToTeam =>
      'Ce nom est affiché à vos collègues à la place de votre nom Google.';

  @override
  String googleName(String name) {
    return 'Nom Google : $name';
  }

  @override
  String get useGoogleName => 'Reprendre mon nom Google';

  @override
  String renameMemberTitle(String name) {
    return 'Renommer $name';
  }

  @override
  String get renameMemberHint =>
      'Ce nom n\'est utilisé que dans cette entreprise.';

  @override
  String get useOwnName => 'Reprendre son propre nom';

  @override
  String get scanQrCode => 'Scanner un QR code';

  @override
  String get scanQrHint =>
      'Visez le QR code affiché dans son application (menu du compte, « Mon QR code »).';

  @override
  String get orEnterCode => 'Ou saisissez son code à 6 chiffres';

  @override
  String get qrInvalid => 'Ce n\'est pas un QR code Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Caméra indisponible ($error).';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notifChooseHint =>
      'Choisissez ce qui vous est notifié. Tout reste visible dans la cloche.';

  @override
  String get notifPlanning => 'Planning publié ou modifié';

  @override
  String get notifRequests => 'Demandes : échanges, congés, invitations';

  @override
  String get notifMessages => 'Nouveaux messages';

  @override
  String get notifOverlap => 'Chevauchement d\'horaires entre entreprises';

  @override
  String get notifConflicts =>
      'Vos modifications remplacées par un autre responsable';

  @override
  String get notifBilling => 'Rappels d\'abonnement';

  @override
  String get pushEnabled => 'Les notifications sont activées sur cet appareil.';

  @override
  String get pushOff => 'Les notifications sont désactivées sur cet appareil.';

  @override
  String get pushBlocked =>
      'Les notifications sont bloquées : autorisez-les dans les réglages du téléphone ou du navigateur.';

  @override
  String get pushUnavailable =>
      'Les notifications ne sont pas disponibles sur cet appareil.';

  @override
  String get enablePush => 'Activer';

  @override
  String noticeSchedulePublished(String company) {
    return '$company : votre planning a été publié ou modifié.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company veut vous ajouter à son équipe.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name vous propose de devenir propriétaire de $company.';
  }
}
