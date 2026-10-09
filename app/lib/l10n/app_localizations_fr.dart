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

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name a rejoint $company.';
  }

  @override
  String get messagesTab => 'Messages';

  @override
  String get wholeTeam => 'Toute l\'équipe';

  @override
  String get newConversation => 'Nouvelle conversation';

  @override
  String get noMessages => 'Pas encore de message.';

  @override
  String get messageHint => 'Écrire un message';

  @override
  String get earlierMessages => 'Messages précédents';

  @override
  String get personLeftCompany =>
      'Cette personne ne fait plus partie de l\'entreprise.';

  @override
  String messagePreview(String name, String text) {
    return '$name : $text';
  }

  @override
  String get newGroup => 'Nouveau groupe';

  @override
  String get editGroup => 'Modifier le groupe';

  @override
  String get groupName => 'Nom du groupe';

  @override
  String get groupMembersHint =>
      'Choisissez les personnes de ce groupe. Elles seules verront ses messages.';

  @override
  String get chooseAtLeastOne => 'Choisissez au moins une personne.';

  @override
  String get replyAction => 'Répondre';

  @override
  String get translateAction => 'Traduire';

  @override
  String replyingTo(String name) {
    return 'Réponse à $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Derniers messages de $name';
  }

  @override
  String get deleteAllNotices => 'Tout supprimer';

  @override
  String get deleteAllNoticesConfirm => 'Supprimer tous les avis ?';

  @override
  String get noticeRetention => 'Supprimer les avis lus après';

  @override
  String get retentionDay => '1 jour';

  @override
  String get retentionWeek => '1 semaine';

  @override
  String get retentionMonth => '1 mois';

  @override
  String get billingOwnersOnly =>
      'Actif uniquement si vous possédez une entreprise.';

  @override
  String get readOnlyPastDays =>
      'Les jours de plus d\'un mois sont en lecture seule.';

  @override
  String get wholeCompany => 'Toute l\'entreprise';

  @override
  String get sitesLabel => 'Sites';

  @override
  String get actionSites => 'Sites…';

  @override
  String managerOf(String name) {
    return '$name est responsable de';
  }

  @override
  String teamSitesOf(String name) {
    return 'Équipe de $name';
  }

  @override
  String get notYourSite => 'Ce site n\'est pas sous votre responsabilité.';

  @override
  String get chooseYourSite => 'Choisissez au moins un site.';

  @override
  String get viewRequests => 'Demandes';

  @override
  String get newRequest => 'Nouvelle demande';

  @override
  String get requestLeave => 'Congé';

  @override
  String get requestUnavailability => 'Indisponibilité';

  @override
  String get requestSwap => 'Échange de service';

  @override
  String get swapHint =>
      'Pour proposer un échange, touchez un de vos services à venir dans le planning.';

  @override
  String get noRequests => 'Aucune demande pour le moment.';

  @override
  String get requestsToHandle => 'À traiter';

  @override
  String get myRequests => 'Mes demandes';

  @override
  String get otherRequests => 'Demandes de l\'équipe';

  @override
  String get statusPendingPeer => 'En attente du collègue';

  @override
  String get statusPendingManager => 'En attente du responsable';

  @override
  String get statusApproved => 'Acceptée';

  @override
  String get statusRefused => 'Refusée';

  @override
  String get statusCancelled => 'Annulée';

  @override
  String get cancelRequest => 'Annuler la demande';

  @override
  String get acceptSwap => 'Reprendre ce service';

  @override
  String get approve => 'Valider';

  @override
  String periodLabel(String from, String to) {
    return 'Du $from au $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Proposé à $name';
  }

  @override
  String get swapToTeam => 'Toute l\'équipe';

  @override
  String everyWeekdays(String days) {
    return 'Chaque semaine : $days';
  }

  @override
  String get unavailableEveryWeek =>
      'Jours où vous n\'êtes jamais disponible :';

  @override
  String get choosePeriod => 'Choisir les dates';

  @override
  String get choosePeriodOptional => 'Limiter à une période (facultatif)';

  @override
  String get clearPeriod => 'Sans période';

  @override
  String get sendRequest => 'Envoyer la demande';

  @override
  String get proposeSwap => 'Proposer un échange';

  @override
  String get swapWith => 'Proposer à';

  @override
  String get swapSteps =>
      'Le collègue accepte, puis un responsable valide. Le planning ne change qu\'après.';

  @override
  String get absentThatDay => 'Absence validée ce jour-là';

  @override
  String get requestSent => 'Demande envoyée.';

  @override
  String noticeSwapOffer(String name) {
    return '$name vous propose de reprendre un de ses services.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name a refusé votre proposition d\'échange.';
  }

  @override
  String get noticeSwapToApprove =>
      'Un échange de service attend votre validation.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name demande un congé.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name déclare une indisponibilité.';
  }

  @override
  String get noticeRequestApproved => 'Votre demande a été acceptée.';

  @override
  String get noticeRequestRefused => 'Votre demande a été refusée.';

  @override
  String get choosePeer => 'Qui reprend ce service ?';

  @override
  String get discardAll => 'Tout annuler';

  @override
  String get notifySitesHint =>
      'Choisissez les sites dont vous recevez les notifications de demandes. Toutes les demandes restent visibles dans la liste.';

  @override
  String get notifySitesTitle => 'Notifications par site';

  @override
  String get pendingRequestTooltip =>
      'Demande en attente : touchez pour l\'ouvrir';

  @override
  String get requestsHistory => 'Toutes les demandes';

  @override
  String get revertChange => 'Annuler cette modification';

  @override
  String get statusExpired => 'Sans objet';

  @override
  String get swapWithHint => 'Touchez pour choisir un collègue précis';

  @override
  String changesDiscarded(String count) {
    return 'Modifications annulées : $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Annuler les $count modifications non publiées ?';
  }

  @override
  String get allSchedules => 'Tous mes plannings';

  @override
  String get busyElsewhere =>
      'Déjà en service dans une autre entreprise sur ce créneau';

  @override
  String get overlapTooltip => 'Chevauche un service d\'une autre entreprise';

  @override
  String get overlapWarning =>
      'Certains de vos services se chevauchent entre deux entreprises.';

  @override
  String noticeOverlap(String date) {
    return 'Deux de vos services dans des entreprises différentes se chevauchent le $date.';
  }

  @override
  String get allMyCompanies => 'Toutes mes entreprises';

  @override
  String get deleteGroup => 'Supprimer le groupe';

  @override
  String get openRequest => 'Voir la demande';

  @override
  String get thisCompany => 'Cette entreprise';

  @override
  String get withExtras => 'Avec les extras';

  @override
  String deleteGroupConfirm(String name) {
    return 'Supprimer « $name » et tous ses messages, pour tout le monde ?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Vient de $company : sera ajouté(e) comme renfort et prévenu(e).';
  }

  @override
  String get addToGoogle => 'Ajouter à Google Agenda';

  @override
  String get calendarEnabled => 'Synchroniser mes services';

  @override
  String get calendarHint =>
      'Ajoutez vos services de toutes vos entreprises dans Google Agenda. Ils se mettent à jour tout seuls, et vous pouvez désactiver quand vous voulez.';

  @override
  String get changeSettings => 'Modifier';

  @override
  String get copyCalendarLink => 'Copier le lien de l\'agenda';

  @override
  String get countryBelgium => 'Belgique';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'France';

  @override
  String get countrySwitzerland => 'Suisse';

  @override
  String get employeesSection => 'Salariés';

  @override
  String get emptyNoAlert => 'Vide : pas d\'alerte';

  @override
  String get extrasSection => 'Extras';

  @override
  String get googleCalendar => 'Google Agenda';

  @override
  String get hoursTotals => 'Totaux d\'heures';

  @override
  String get legalAlerts => 'Alertes légales';

  @override
  String get legalAlertsHint =>
      'Des avertissements, jamais des blocages. Choisissez les règles qui s\'appliquent chez vous, ou aucune.';

  @override
  String get legalPreset => 'Modèle par pays';

  @override
  String get linkCopied => 'Lien copié.';

  @override
  String get maxConsecutiveLabel => 'Jours travaillés d\'affilée au maximum';

  @override
  String get maxDayLabel => 'Durée maximale par jour (heures)';

  @override
  String get maxWeekLabel => 'Durée maximale par semaine (heures)';

  @override
  String get minRestLabel => 'Repos minimal entre deux services (heures)';

  @override
  String get noLegalRules => 'Aucune alerte choisie.';

  @override
  String get presetNone => 'Aucune';

  @override
  String get presetsCheck =>
      'Les modèles sont des points de départ : vérifiez-les selon votre pays et votre convention collective.';

  @override
  String get printMine => 'Mon planning';

  @override
  String get printOwn => 'Leur propre planning seulement';

  @override
  String get printPdf => 'Imprimer / PDF';

  @override
  String get printRights => 'Ce que les salariés peuvent imprimer';

  @override
  String get printTeam => 'Le planning de toute l\'équipe';

  @override
  String get printTeamOption => 'Le planning de l\'équipe';

  @override
  String get totalsHint =>
      'Brouillons compris. Les exports Excel et CSV reprennent le planning publié.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name : $value jours d\'affilée (maximum $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name : $value dans la journée (maximum $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name : $value de repos seulement (minimum $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name : $value dans la semaine (maximum $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Alertes légales : $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Services : $count';
  }

  @override
  String get actionMakeDeputy => 'Nommer sous-responsable';

  @override
  String get actionRemoveDeputy => 'Retirer le rôle de sous-responsable';

  @override
  String get busyHere => 'Déjà en service dans l\'entreprise sur ce créneau';

  @override
  String get calendarByLink => 'Par lien (Google Agenda sur ordinateur)';

  @override
  String get calendarDenied =>
      'Accès à l\'agenda refusé. Autorisez-le dans les réglages du téléphone.';

  @override
  String get calendarLinkHint =>
      'À ajouter depuis Google Agenda sur un ordinateur ; Google le met à jour en quelques heures.';

  @override
  String get calendarNone => 'Aucun agenda modifiable sur ce téléphone.';

  @override
  String get calendarOnPhone => 'Ajouter mes services à l\'agenda du téléphone';

  @override
  String get calendarOnPhoneHint =>
      'Dans votre agenda Google : visible tout de suite, sur le téléphone et sur Google Agenda.';

  @override
  String get chooseCalendar => 'Choisir l\'agenda';

  @override
  String get otherSiteHint =>
      'Salarié d\'un autre site : ses responsables seront prévenus.';

  @override
  String get subManager => 'Sous-responsable';

  @override
  String calendarSynced(String count) {
    return 'Services dans l\'agenda : $count';
  }

  @override
  String deputyOf(String name) {
    return 'Sous-responsable : $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by a placé $name sur le site $site le $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company vous a ajouté comme renfort.';
  }

  @override
  String get companyNotificationsHint =>
      'Coupées : rien ne sonne sur ce téléphone, mais tout reste dans la cloche.';

  @override
  String get companyNotificationsOn =>
      'Recevoir les notifications de cette entreprise';

  @override
  String get companyTimezone => 'Fuseau horaire de l\'entreprise';

  @override
  String get companyTimezoneHint =>
      'Tous les horaires de cette entreprise sont à cette heure-là (heure d\'été comprise). Les agendas les convertissent automatiquement.';

  @override
  String get iosInstallHint =>
      'Sur iPhone : touchez Partager, puis « Sur l\'écran d\'accueil » pour installer Staff Flow.';

  @override
  String get searchCity => 'Rechercher une ville';

  @override
  String get thisPhone => 'Cet appareil';

  @override
  String companyNotifications(String name) {
    return 'Notifications : $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Horaires à l\'heure de $zone ($company). Votre appareil : $here.';
  }

  @override
  String get addPreset => 'Ajouter le préréglage';

  @override
  String get addPresets => 'Créer des préréglages';

  @override
  String get appearance => 'Apparence';

  @override
  String get chooseLogo => 'Choisir une image PNG';

  @override
  String get conversationMuted =>
      'Notifications coupées pour cette conversation.';

  @override
  String get conversationUnmuted =>
      'Notifications rétablies pour cette conversation.';

  @override
  String get customization => 'Personnalisation';

  @override
  String get disableGroup => 'Désactiver le groupe';

  @override
  String get disableGroupConfirm =>
      'Le groupe de toute l\'entreprise sera caché pour tout le monde. Vous pourrez le réactiver dans Messages.';

  @override
  String get editPresets => 'Préréglages';

  @override
  String get enable => 'Réactiver';

  @override
  String get groupDisabled => 'Groupe désactivé (vous seul le voyez)';

  @override
  String get logoHint =>
      'Une petite image PNG (votre logo) affichée sur l\'onglet de l\'entreprise, pour tous ses membres.';

  @override
  String get logoPngOnly => 'Choisissez une image PNG de 1 Mo au plus.';

  @override
  String get muteConversation =>
      'Couper les notifications de cette conversation';

  @override
  String get myIdentifier => 'Mon identifiant';

  @override
  String get myProfile => 'Mon profil';

  @override
  String get presetName => 'Nom (ex. Matin)';

  @override
  String get removeLogo => 'Retirer l\'image';

  @override
  String get resetGroup => 'Réinitialiser le groupe';

  @override
  String get resetGroupConfirm =>
      'Tous les messages du groupe de l\'entreprise seront effacés pour tout le monde.';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get shiftPresets => 'Préréglages d\'horaires';

  @override
  String get shiftPresetsHint =>
      'Des horaires tout prêts (matin, soir, nuit…) : un appui dans un service remplit le début et la fin.';

  @override
  String get themeDark => 'Foncé';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeSystem => 'Système';

  @override
  String get unmuteConversation =>
      'Rétablir les notifications de cette conversation';

  @override
  String get awaitingApproval => 'À valider';

  @override
  String get placementNeedsApproval =>
      '! Cette personne n\'est pas de vos sites : le service attendra la validation de votre supérieur ou du patron avant de pouvoir être publié. Sinon, choisissez quelqu\'un d\'autre.';

  @override
  String get placementAwaiting =>
      'En attente de validation par un supérieur ou le patron.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by veut placer $name, d\'un autre site, le $date : à valider.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by a validé le placement de $name le $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by a refusé le placement de $name le $date.';
  }

  @override
  String get addSubSite => 'Ajouter un sous-site';

  @override
  String get moveSite => 'Déplacer';

  @override
  String get topLevel => 'Premier niveau';

  @override
  String moveSiteTitle(String name) {
    return 'Déplacer « $name » sous…';
  }

  @override
  String subSiteOf(String name) {
    return 'Sous-site de $name';
  }

  @override
  String get siteTreeHint =>
      'Jusqu\'à 3 niveaux, par exemple Région › Ville › Magasin. Le responsable d\'un site gère aussi tout ce qui est en dessous.';

  @override
  String get subSitesOnlyHint =>
      'Ici, vous ajoutez des sous-sites sous vos propres sites.';
}
