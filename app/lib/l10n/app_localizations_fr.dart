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
  String get viewTeam => 'Management';

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
  String get notifMessages => 'Nouvelles annonces';

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
  String get translateAction => 'Traduire';

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
  String get openRequest => 'Voir la demande';

  @override
  String get thisCompany => 'Cette entreprise';

  @override
  String get withExtras => 'Avec les extras';

  @override
  String reinforcementHint(String company) {
    return 'Vient de $company : sera ajouté(e) comme renfort et prévenu(e).';
  }

  @override
  String get addToGoogle => 'Ajouter à Google Agenda';

  @override
  String get calendarEnabled => 'Synchroniser mes services';

  @override
  String get changeSettings => 'Modifier';

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
  String get calendarDenied =>
      'Accès à l\'agenda refusé. Autorisez-le dans les réglages du téléphone.';

  @override
  String get calendarLinkHint =>
      'À ajouter depuis Google Agenda sur un ordinateur ; Google le met à jour en quelques heures.';

  @override
  String get calendarNone => 'Aucun agenda modifiable sur ce téléphone.';

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
  String get customization => 'Personnalisation';

  @override
  String get editPresets => 'Préréglages';

  @override
  String get enable => 'Réactiver';

  @override
  String get logoHint =>
      'Une petite image PNG (votre logo) affichée sur l\'onglet de l\'entreprise, pour tous ses membres.';

  @override
  String get logoPngOnly => 'Choisissez une image PNG de 1 Mo au plus.';

  @override
  String get myIdentifier => 'Mon identifiant';

  @override
  String get myProfile => 'Mon profil';

  @override
  String get presetName => 'Nom (ex. Matin)';

  @override
  String get removeLogo => 'Retirer l\'image';

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
      'Jusqu\'à 10 niveaux, par exemple Région › Ville › Magasin. Les 3 premiers sont compris dans l\'abonnement ; au-delà, il faut l\'option « sites en cascade ». Le responsable d\'un site gère aussi tout ce qui est en dessous.';

  @override
  String get subSitesOnlyHint =>
      'Ici, vous ajoutez des sous-sites sous vos propres sites.';

  @override
  String get messagingSetting => 'Fil d\'actualités';

  @override
  String get messagingSettingHint =>
      'Activé : le patron et les responsables publient des annonces (pour tous, un poste, un site ou des personnes) ; chacun les lit et peut les traduire. Désactivé : l\'onglet disparaît pour tous.';

  @override
  String get billingTitle => 'Abonnement';

  @override
  String billingStatusTrial(String date) {
    return 'Essai gratuit jusqu\'au $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Payé jusqu\'au $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Lecture seule : sans paiement, l\'entreprise sera supprimée le $date.';
  }

  @override
  String get billingStatusComped => 'Offert';

  @override
  String billingStaff(String count) {
    return '$count salariés et responsables (sans le propriétaire ni les extras)';
  }

  @override
  String get billingMonthly => 'Mensuel';

  @override
  String billingYearly(String months) {
    return 'Annuel ($months mois facturés)';
  }

  @override
  String get billingCascade => 'Option « sites en cascade » (niveaux 4 à 10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'Incluse à partir de $count salariés';
  }

  @override
  String billingPay(String amount) {
    return 'Payer $amount';
  }

  @override
  String get billingTestNotice => 'Paiement de test : rien n\'est prélevé.';

  @override
  String get billingSoon => 'Le paiement en ligne arrive bientôt.';

  @override
  String get billingPaidOk => 'Paiement enregistré.';

  @override
  String get billingInvoices => 'Factures';

  @override
  String get billingNoInvoices => 'Aucune facture pour l\'instant.';

  @override
  String get billingManage => 'Gérer l\'abonnement';

  @override
  String get billingReadOnlyStaff =>
      'Cette entreprise est en lecture seule jusqu\'au renouvellement de l\'abonnement par le propriétaire.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / mois';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / an';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company : l\'essai gratuit se termine dans moins de 24 heures.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company est en lecture seule faute de paiement ; suppression le $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Rappel : sans paiement, $company sera supprimée le $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company a été supprimée faute de paiement.';
  }

  @override
  String billingCompanyId(String id) {
    return 'Identifiant de l\'entreprise : $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Aujourd\'hui : $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Comprend la fin du mois en cours ($days jours, au prorata), puis des mois pleins à partir du 1er.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Pas encore relié. Il sert à vérifier votre identité, par exemple pour changer de compte Google.';

  @override
  String telegramLinked(String name) {
    return 'Relié : $name';
  }

  @override
  String get telegramNoUsername => 'sans nom d\'utilisateur';

  @override
  String get telegramLink => 'Relier mon Telegram';

  @override
  String get telegramLinkHint =>
      'Telegram s\'ouvre : touchez « Démarrer », puis revenez ici.';

  @override
  String get telegramUnlink => 'Délier';

  @override
  String get telegramUnavailable => 'Telegram n\'est pas encore disponible.';

  @override
  String get telegramShowIn => 'Afficher mon Telegram dans :';

  @override
  String get newQrCode => 'Changer de QR code';

  @override
  String get newQrCodeConfirm =>
      'Votre ancien QR code et votre ancien identifiant ne fonctionneront plus. Votre place dans vos entreprises ne change pas.';

  @override
  String get newQrCodeDone => 'Nouveau QR code créé.';

  @override
  String get changeGoogle => 'Changer de compte Google';

  @override
  String get changeGoogleSub => 'Même compte, même numéro, mêmes entreprises';

  @override
  String changeGoogleSteps(String id) {
    return '1. Reliez votre Telegram dans ce profil (obligatoire).\n2. Déconnectez-vous, puis connectez-vous avec le nouveau compte Google.\n3. Choisissez « J\'ai déjà un compte Staff Flow » et saisissez votre identifiant $id.\n4. Saisissez le code reçu sur Telegram.\nVotre compte, votre numéro et vos entreprises restent les mêmes.';
  }

  @override
  String get recoverAccount => 'J\'ai déjà un compte Staff Flow';

  @override
  String get recoverHint =>
      'Saisissez l\'identifiant de votre ancien compte (SF-…). Un code sera envoyé sur le Telegram relié à ce compte.';

  @override
  String get recoverIdLabel => 'Identifiant (SF-…)';

  @override
  String get recoverSend => 'Envoyer le code';

  @override
  String get recoverCodeSent => 'Code envoyé sur Telegram.';

  @override
  String get recoverCodeLabel => 'Code reçu (6 chiffres)';

  @override
  String get recoverConfirm => 'Récupérer mon compte';

  @override
  String get recoverDone => 'C\'est fait : vous retrouvez votre compte.';

  @override
  String get exportData => 'Exporter mes données';

  @override
  String get exportDataSub => 'Un fichier avec toutes vos données personnelles';

  @override
  String get deleteAccount => 'Supprimer mon compte';

  @override
  String get deleteGhost => 'Supprimer en gardant un fantôme';

  @override
  String get deleteGhostHint =>
      'Vous quittez toutes vos entreprises. Reconnectez-vous plus tard avec le même compte Google pour retrouver votre compte et votre numéro.';

  @override
  String get deleteErase => 'Tout effacer définitivement';

  @override
  String get deleteEraseHint =>
      'Nom, e-mail, photo, Telegram, messages et notifications sont effacés. Impossible de revenir en arrière.';

  @override
  String get deleteGhostNote =>
      'Dans les deux cas, l\'historique des entreprises garde un « Ghost » anonyme à votre place (demandes de congé, services passés…) pour que le patron et les responsables puissent retracer les évènements.';

  @override
  String get deleteOwnerNote =>
      'Propriétaire d\'une entreprise ? Transférez-la d\'abord, ou laissez son abonnement s\'arrêter.';

  @override
  String get deleteConfirmButton => 'Supprimer';

  @override
  String get accountRestored => 'Bon retour ! Votre compte a été réactivé.';

  @override
  String get closedInvoices => 'Factures des entreprises fermées';

  @override
  String get downloadAllInvoices => 'Télécharger toutes les factures (ZIP)';

  @override
  String get legalTerms => 'Conditions d\'utilisation et de vente';

  @override
  String get legalPrivacy => 'Politique de confidentialité';

  @override
  String get billingDetailTitle => 'Détail du paiement';

  @override
  String billingLineProrata(String days, String total) {
    return 'Fin du mois en cours ($days jours sur $total) : abonnement';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Fin du mois en cours ($days jours sur $total) : option « sites en cascade »';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Abonnement, $staff places : 1 mois';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Abonnement, $staff places : 12 mois au prix de $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Option « sites en cascade » : $months mois, sans remise';
  }

  @override
  String get billingTotal => 'Total';

  @override
  String billingCovers(String from, String to) {
    return 'Période couverte : du $from au $to';
  }

  @override
  String get billingGraceInvoices =>
      'Cette entreprise n\'est pas renouvelée : téléchargez dès maintenant toutes ses factures.';

  @override
  String get billingYearLabel => 'Année';

  @override
  String get sitesNoneChosen => 'Aucun site choisi';

  @override
  String get avatarTitle => 'Mon avatar';

  @override
  String get avatarSub => 'Une image à la place de votre photo';

  @override
  String get avatarUseGoogle => 'Utiliser ma photo Google';

  @override
  String get avatarColor => 'Couleur';

  @override
  String get hidePhotosTitle => 'Masquer les photos Google';

  @override
  String get hidePhotosSub =>
      'Dans cette entreprise, chacun apparaît avec son avatar ou son initiale.';

  @override
  String get billingApi => 'Option « accès API »';

  @override
  String billingLineApi(String months) {
    return 'Option « accès API » : $months mois, sans remise';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Fin du mois en cours ($days jours sur $total) : option « accès API »';
  }

  @override
  String get apiTitle => 'Accès API (comptabilité, CRM)';

  @override
  String get apiSub =>
      'Vos logiciels de comptabilité, de paie ou votre CRM lisent le planning publié, les heures et les absences.';

  @override
  String get apiNeedsOption =>
      'Option payante : ajoutez « accès API » dans « Gérer l\'abonnement ».';

  @override
  String get apiNewKey => 'Nouvelle clé';

  @override
  String get apiKeyName => 'Nom de la clé (ex. : logiciel de paie)';

  @override
  String get apiKeyCreated =>
      'Copiez cette clé maintenant et gardez-la en lieu sûr : elle ne sera plus affichée.';

  @override
  String get apiKeyCopy => 'Copier';

  @override
  String get apiKeyCopied => 'Clé copiée.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Dernière utilisation : $date';
  }

  @override
  String get apiKeyNeverUsed => 'Jamais utilisée';

  @override
  String get apiRevoke => 'Révoquer';

  @override
  String get apiRevokeConfirm =>
      'Les logiciels qui utilisent cette clé n\'auront plus accès.';

  @override
  String get apiDocs => 'Documentation de l\'API';

  @override
  String get memberGoogleLink => 'Reconnexion Google du salarié';

  @override
  String googleLinkHint(String name) {
    return 'Envoyez ce lien à $name. Il s\'ouvre dans un navigateur (pas dans l\'application Android), une seule fois, pendant 24 heures : $name s\'y connecte avec son nouveau compte Google et retrouve son compte. Tous ses autres appareils sont alors déconnectés.';
  }

  @override
  String get googleLinkCopied => 'Lien copié.';

  @override
  String get switchBanner =>
      'Lien de changement de compte Google : connectez-vous avec votre nouveau compte Google pour retrouver votre compte Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Ce lien sert à relier un compte Staff Flow à un nouveau compte Google. Déconnectez-vous d\'abord, puis connectez-vous avec le nouveau compte Google.';

  @override
  String get switchDone =>
      'C\'est fait : votre compte Staff Flow est relié à ce compte Google. Vos autres appareils ont été déconnectés.';

  @override
  String changeGoogleBot(String bot) {
    return 'Le plus simple : dans Telegram, envoyez /changegoogle au bot $bot et suivez ses instructions, puis connectez-vous avec le nouveau compte Google dans les 10 minutes.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Sans Telegram : demandez à votre patron ou à un responsable un lien de changement de compte Google.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name a créé un lien pour relier votre compte à un nouveau compte Google. Si vous n\'avez rien demandé, prévenez votre responsable.';
  }

  @override
  String get sessionRevoked =>
      'Vous avez été déconnecté : votre compte est maintenant relié à un autre compte Google.';

  @override
  String telegramLoginHint(String bot) {
    return 'Astuce : envoyez /connexion au bot $bot pour recevoir un lien et ouvrir Staff Flow dans un navigateur, sans application ni compte Google.';
  }

  @override
  String get timeFormat => 'Format de l\'heure';

  @override
  String get timeFormatAuto => 'Auto';

  @override
  String get people => 'Personnes';

  @override
  String get sortNatural => 'Ordre habituel';

  @override
  String get sortName => 'Nom';

  @override
  String get employeeNumber => 'Matricule';

  @override
  String get sfIdLabel => 'ID Staff Flow';

  @override
  String get pickSearch => 'Rechercher';

  @override
  String get pickSearchPeople => 'Rechercher : nom, matricule, ID SF';

  @override
  String get pickSortTitle => 'Trier et afficher par';

  @override
  String pickSelected(String count) {
    return 'Cochés : $count';
  }

  @override
  String get pickCheckAll => 'Tout cocher';

  @override
  String get pickClear => 'Tout décocher';

  @override
  String get pickNoResult => 'Aucun résultat';

  @override
  String get pickMultiHint =>
      'Cochez plusieurs personnes : un service sera créé pour chacune, en une seule fois.';

  @override
  String get filterAll => 'Tous';

  @override
  String filterValue(String label, String value) {
    return '$label : $value';
  }

  @override
  String get noPositionGroup => 'Sans poste';

  @override
  String get noSiteGroup => 'Sans site';

  @override
  String get groupByTitle => 'Regrouper par';

  @override
  String get groupRole => 'Rôle';

  @override
  String get groupNone => 'Sans regroupement';

  @override
  String showMore(String count, String left) {
    return 'Afficher $count de plus (reste $left)';
  }

  @override
  String get findByQr => 'Trouver un membre avec son QR code';

  @override
  String get qrNotMember =>
      'Ce QR code ne correspond à personne dans cette entreprise.';

  @override
  String get memberProfile => 'Matricule et poste';

  @override
  String get employeeNumberHint =>
      'Numéro propre à votre entreprise (facultatif). L\'identifiant Staff Flow reste attribué.';

  @override
  String get usualPosition => 'Poste habituel';

  @override
  String get inviteCodeTitle => 'Code d\'invitation';

  @override
  String get inviteCodeHint =>
      'Saisissez le code reçu de votre employeur, ou scannez le QR code de votre invitation.';

  @override
  String inviteJoined(String company) {
    return 'Vous avez rejoint $company.';
  }

  @override
  String get importTitle => 'Importer des salariés';

  @override
  String get importIntro =>
      'Importez votre liste de salariés depuis un fichier Excel ou CSV. Chacun reçoit un code et un QR code personnels : il active son compte avec une application 2FA (ou avec Google). Personne n\'est ajouté sans son accord.';

  @override
  String get importTemplate => 'Télécharger le modèle Excel';

  @override
  String get importTemplateHint =>
      'Colonnes : nom, matricule, poste, site. Seul le nom est obligatoire.';

  @override
  String get importChooseFile => 'Choisir un fichier (.xlsx ou .csv)';

  @override
  String importNew(String count) {
    return 'Nouveaux : $count';
  }

  @override
  String importUpdate(String count) {
    return 'Mis à jour : $count';
  }

  @override
  String importSkip(String count) {
    return 'Déjà invités : $count';
  }

  @override
  String importErrors(String count) {
    return 'Erreurs : $count';
  }

  @override
  String importConfirm(String count) {
    return 'Importer ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Les lignes en erreur seront ignorées : corrigez-les dans le fichier et importez-le de nouveau.';

  @override
  String get importCreated => 'nouveau';

  @override
  String importDone(String count) {
    return 'Invitations créées : $count';
  }

  @override
  String get invitesTitle => 'Invitations en attente';

  @override
  String get invitesPrint => 'Imprimer les codes';

  @override
  String get inviteShowHint =>
      'La personne choisit « Activer mon compte » sur l\'écran de connexion (ou « J\'ai un code d\'invitation » si elle a déjà un compte), puis scanne ce QR code ou tape ce code. Valable 90 jours, une seule fois.';

  @override
  String invitesHint(String count) {
    return 'Invitations en attente : $count. Touchez une personne pour afficher son code et son QR code, ou imprimez-les tous.';
  }

  @override
  String get inviteSeenByEmail => 'invitation vue (e-mail)';

  @override
  String get invitesNone => 'Aucune invitation en attente.';

  @override
  String get haveInviteCode => 'J\'ai un code d\'invitation';

  @override
  String get newsTab => 'Actualités';

  @override
  String get newsNew => 'Nouvelle annonce';

  @override
  String get newsEmpty => 'Aucune annonce pour l\'instant.';

  @override
  String get newsEmptyManager =>
      'Aucune annonce pour l\'instant. Publiez la première : pour toute l\'entreprise, un poste, un site ou des personnes choisies.';

  @override
  String get newsOlder => 'Annonces plus anciennes';

  @override
  String get newsEdited => 'modifiée';

  @override
  String get newsEdit => 'Modifier l\'annonce';

  @override
  String get newsDeleteTitle => 'Retirer cette annonce ?';

  @override
  String get newsForEveryone => 'Pour tout le monde';

  @override
  String get newsEveryoneMySites => 'Tout le monde dans mes sites';

  @override
  String newsFor(String names) {
    return 'Pour : $names';
  }

  @override
  String newsReadCount(String count) {
    return 'Lue par $count';
  }

  @override
  String newsReadOf(String count, String total) {
    return 'Lue par $count sur $total';
  }

  @override
  String get newsTranslated => 'Traduit automatiquement';

  @override
  String get newsTitleField => 'Titre (facultatif)';

  @override
  String get newsBodyField => 'Texte de l\'annonce';

  @override
  String get newsRecipients => 'Destinataires';

  @override
  String get newsTargetHint =>
      'Cochez un ou plusieurs groupes : l\'annonce va à chaque personne qui correspond à l\'un d\'eux.';

  @override
  String get newsPublish => 'Publier';

  @override
  String newsSent(String count) {
    return 'Annonce envoyée à $count personne(s).';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Option « accès API », ajoutée en cours d\'abonnement, du $from au $to : $months mois, sans remise';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Option « sites en cascade », ajoutée en cours d\'abonnement, du $from au $to : $months mois, sans remise';
  }

  @override
  String get billingRenewalOptions =>
      'Les options cochées seront comprises dans vos prochains renouvellements. Une option décochée reste active jusqu\'à la fin de la période déjà payée.';

  @override
  String billingAddonTitle(String option) {
    return 'Ajouter maintenant : $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'Le mois en cours en entier, puis chaque mois jusqu\'au $date (fin de la période payée), sans remise. L\'option est active dès le paiement et reprise dans les renouvellements suivants.';
  }

  @override
  String get billingAddonInvoice => 'option';

  @override
  String billingAccessRemoved(String name) {
    return '$name ne gère plus l\'abonnement.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name peut maintenant gérer l\'abonnement et les factures.';
  }

  @override
  String get actionBillingRemove => 'Retirer la gestion de l\'abonnement';

  @override
  String get actionBillingGive => 'Autoriser à gérer l\'abonnement';

  @override
  String get billingAccessTag => 'Gère l\'abonnement';

  @override
  String get billingOptionRenewed => 'Renouvellement de l\'option repris.';

  @override
  String get billingOptionStopped =>
      'Option non renouvelée : elle reste active jusqu\'à la fin de la période payée.';

  @override
  String billingOptionEnds(String date) {
    return 'Active jusqu\'au $date, ne sera pas renouvelée (cochez pour la garder)';
  }

  @override
  String get billingOptionActive =>
      'Active et renouvelée (décochez pour ne pas la renouveler)';

  @override
  String get statusCancelRequested => 'Annulation demandée';

  @override
  String get requestEndedEarly => 'Terminée plus tôt par la personne.';

  @override
  String get confirmCancelRequest =>
      'Annuler cette demande ? Elle ne sera plus proposée aux responsables.';

  @override
  String get endUnavailability => 'Mettre fin à mon indisponibilité';

  @override
  String get confirmEndUnavailability =>
      'Mettre fin à votre indisponibilité ? Vous serez de nouveau disponible dès aujourd\'hui, et les responsables seront prévenus.';

  @override
  String get askLeaveCancel => 'Demander l\'annulation de ce congé';

  @override
  String get confirmAskLeaveCancel =>
      'Demander l\'annulation de ce congé ? Un responsable devra la valider ; d\'ici là, le congé reste prévu.';

  @override
  String get refuseLeaveCancel => 'Refuser l\'annulation';

  @override
  String get acceptLeaveCancel => 'Accepter l\'annulation';

  @override
  String get requestsSearchHint => 'Rechercher : nom, matricule, ID SF, note';

  @override
  String get filterType => 'Type';

  @override
  String get filterState => 'État';

  @override
  String get statePending => 'En attente';

  @override
  String get stateClosed => 'Refusées ou annulées';

  @override
  String billingLineSlotsAddon(
    String from,
    String to,
    String start,
    String end,
    String months,
  ) {
    return 'Places ajoutées, de $from à $to, du $start au $end : $months mois, sans remise';
  }

  @override
  String billingSeats(String used, String limit) {
    return '$used places payées · jusqu\'à $limit personnes avec la marge de 5 %';
  }

  @override
  String get billingSeatsTitle => 'Nombre de places';

  @override
  String get billingSeatsHint =>
      'Salariés et responsables (sans le patron ni les extras), par tranches de 10. 10 places à la création ; au-delà, 5 % de marge puis plus d\'ajout possible.';

  @override
  String get billingSeatsUnit => 'places';

  @override
  String billingSeatsAddon(String from, String to) {
    return 'Places : $from → $to';
  }

  @override
  String billingSeatsRange(String min) {
    return 'De $min à 5000, par tranches de 10.';
  }

  @override
  String get printWeek => 'Semaine';

  @override
  String get printMonth => 'Mois';

  @override
  String teamCount(String team, String count) {
    return '$team · $count';
  }

  @override
  String teamCountSeats(String team, String count, String slots) {
    return '$team · $count/$slots';
  }

  @override
  String get rememberMe => 'Rester connecté sur cet appareil';

  @override
  String get rememberMeHint =>
      'Activé : comme avec Google, plus besoin de code à chaque ouverture. À éviter sur un appareil partagé.';

  @override
  String get totpLoginTitle => 'Connexion 2FA';

  @override
  String get totpLoginHint =>
      'Saisissez votre identifiant Staff Flow (SF-…) ou votre matricule, puis le code à 6 chiffres de votre application d\'authentification.';

  @override
  String get totpLoginField => 'Identifiant SF ou matricule';

  @override
  String get totpCompanyCode => 'Code de l\'entreprise';

  @override
  String get totpCompanyCodeHint =>
      '6 caractères, donnés par votre employeur (avec un matricule seulement).';

  @override
  String get totpBackupCode => 'Code de secours';

  @override
  String get totpCode => 'Code de l\'application';

  @override
  String get totpUseApp => 'Utiliser l\'application 2FA';

  @override
  String get totpUseBackup => 'Utiliser un code de secours';

  @override
  String get totpSignIn => 'Se connecter';

  @override
  String get totpLostPhone =>
      'Téléphone perdu ou application effacée ? Demandez un nouveau code d\'activation à votre responsable.';

  @override
  String get activateTitle => 'Activer mon compte';

  @override
  String get activateStep1 => 'Étape 1 : votre code d\'invitation';

  @override
  String get activateStep1Hint =>
      'Scannez le QR code donné par votre employeur, ou tapez le code écrit dessous.';

  @override
  String get activateScan => 'Scanner le QR code';

  @override
  String get activateCodeField => 'Code d\'invitation';

  @override
  String get activateContinue => 'Continuer';

  @override
  String activateHello(String name, String company) {
    return 'Bonjour $name · $company';
  }

  @override
  String get activateStep2 =>
      'Étape 2 : reliez une application d\'authentification (Google Authenticator, Microsoft Authenticator…). Elle vous donnera un code à 6 chiffres à chaque connexion.';

  @override
  String get activateOpenApp => 'Ajouter à mon application d\'authentification';

  @override
  String get activateOrScan =>
      'Ou, depuis un autre appareil, scannez ce QR code avec l\'application :';

  @override
  String get activateManualKey => 'Clé à saisir à la main :';

  @override
  String get activateFirstCode => 'Premier code affiché par l\'application';

  @override
  String get activateDone => 'Activer';

  @override
  String get totpReadyTitle => 'Votre compte est prêt';

  @override
  String get totpYourId => 'Votre identifiant Staff Flow :';

  @override
  String get totpBackupHint =>
      'Codes de secours (un seul usage chacun) : notez-les ou gardez-les en lieu sûr. Ils servent si vous n\'avez plus votre application.';

  @override
  String get totpBackupSaved => 'C\'est noté';

  @override
  String get linkGoogleTitle => 'Relier un compte Google';

  @override
  String get linkGoogleHint =>
      'Pour créer une entreprise et gérer son abonnement, reliez un compte Google à votre compte Staff Flow. Vos entreprises, plannings et votre application 2FA sont gardés.';

  @override
  String get linkGoogleButton => 'Relier mon compte Google';

  @override
  String get linkGoogleBanner =>
      'Connectez-vous avec le compte Google à relier à votre compte Staff Flow.';

  @override
  String get totpLoginButton => 'Se connecter avec une application 2FA';

  @override
  String get activateButton => 'Activer mon compte (code de l\'employeur)';

  @override
  String get activationCodeAction => 'Nouveau code d\'activation';

  @override
  String activationCodeTitle(String name) {
    return 'Nouveau code pour $name ?';
  }

  @override
  String get activationCodeConfirm =>
      'L\'ancien téléphone et l\'ancienne application 2FA ne serviront plus. La personne active de nouveau son compte avec ce code (valable 7 jours).';

  @override
  String get activationCodeHint =>
      'La personne choisit « Activer mon compte » sur l\'écran de connexion, puis scanne ce QR code ou tape ce code.';
}
