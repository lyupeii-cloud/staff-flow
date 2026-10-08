import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('uk'),
  ];

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @confirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirm;

  /// No description provided for @validate.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get validate;

  /// No description provided for @add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add;

  /// No description provided for @rename.
  ///
  /// In fr, this message translates to:
  /// **'Renommer'**
  String get rename;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @accept.
  ///
  /// In fr, this message translates to:
  /// **'Accepter'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In fr, this message translates to:
  /// **'Refuser'**
  String get decline;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @name.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get name;

  /// No description provided for @serverUnreachable.
  ///
  /// In fr, this message translates to:
  /// **'Serveur injoignable.'**
  String get serverUnreachable;

  /// No description provided for @errorStatus.
  ///
  /// In fr, this message translates to:
  /// **'Erreur {status}'**
  String errorStatus(int status);

  /// No description provided for @roleOwner.
  ///
  /// In fr, this message translates to:
  /// **'Propriétaire'**
  String get roleOwner;

  /// No description provided for @roleManager.
  ///
  /// In fr, this message translates to:
  /// **'Responsable'**
  String get roleManager;

  /// No description provided for @roleEmployee.
  ///
  /// In fr, this message translates to:
  /// **'Salarié'**
  String get roleEmployee;

  /// No description provided for @roleExtra.
  ///
  /// In fr, this message translates to:
  /// **'Extra'**
  String get roleExtra;

  /// No description provided for @taglineStart.
  ///
  /// In fr, this message translates to:
  /// **'Les plannings de votre équipe, '**
  String get taglineStart;

  /// No description provided for @taglineEnd.
  ///
  /// In fr, this message translates to:
  /// **'partout.'**
  String get taglineEnd;

  /// No description provided for @googleNotConfigured.
  ///
  /// In fr, this message translates to:
  /// **'Connexion Google non configurée (GOOGLE_WEB_CLIENT_ID).'**
  String get googleNotConfigured;

  /// No description provided for @signInWithGoogle.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter avec Google'**
  String get signInWithGoogle;

  /// No description provided for @devSection.
  ///
  /// In fr, this message translates to:
  /// **'Développement'**
  String get devSection;

  /// No description provided for @emailLabel.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail'**
  String get emailLabel;

  /// No description provided for @devSignIn.
  ///
  /// In fr, this message translates to:
  /// **'Connexion de test'**
  String get devSignIn;

  /// No description provided for @googleUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Connexion Google indisponible : {detail}'**
  String googleUnavailable(String detail);

  /// No description provided for @googleFailed.
  ///
  /// In fr, this message translates to:
  /// **'Connexion Google impossible : {detail}'**
  String googleFailed(String detail);

  /// No description provided for @newCompany.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle entreprise'**
  String get newCompany;

  /// No description provided for @timezone.
  ///
  /// In fr, this message translates to:
  /// **'Fuseau horaire'**
  String get timezone;

  /// No description provided for @create.
  ///
  /// In fr, this message translates to:
  /// **'Créer'**
  String get create;

  /// No description provided for @noCompanyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Vous ne faites partie d\'aucune entreprise.'**
  String get noCompanyTitle;

  /// No description provided for @noCompanyHint.
  ///
  /// In fr, this message translates to:
  /// **'Pour rejoindre celle de votre employeur, générez un code et donnez-le à votre responsable.'**
  String get noCompanyHint;

  /// No description provided for @joinCompany.
  ///
  /// In fr, this message translates to:
  /// **'Rejoindre une entreprise'**
  String get joinCompany;

  /// No description provided for @createCompany.
  ///
  /// In fr, this message translates to:
  /// **'Créer une entreprise'**
  String get createCompany;

  /// No description provided for @transferOffer.
  ///
  /// In fr, this message translates to:
  /// **'On vous propose de devenir propriétaire de « {company} ».'**
  String transferOffer(String company);

  /// No description provided for @someCompany.
  ///
  /// In fr, this message translates to:
  /// **'une entreprise'**
  String get someCompany;

  /// No description provided for @becameOwner.
  ///
  /// In fr, this message translates to:
  /// **'Vous êtes maintenant propriétaire.'**
  String get becameOwner;

  /// No description provided for @myAccount.
  ///
  /// In fr, this message translates to:
  /// **'Mon compte'**
  String get myAccount;

  /// No description provided for @idCopied.
  ///
  /// In fr, this message translates to:
  /// **'Identifiant copié.'**
  String get idCopied;

  /// No description provided for @myId.
  ///
  /// In fr, this message translates to:
  /// **'Mon identifiant : {id}'**
  String myId(String id);

  /// No description provided for @signOut.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get signOut;

  /// No description provided for @joinInvite.
  ///
  /// In fr, this message translates to:
  /// **'« {company} » vous invite comme {role}.'**
  String joinInvite(String company, String role);

  /// No description provided for @joinedCompany.
  ///
  /// In fr, this message translates to:
  /// **'Vous avez rejoint {company}.'**
  String joinedCompany(String company);

  /// No description provided for @viewPlanning.
  ///
  /// In fr, this message translates to:
  /// **'Planning'**
  String get viewPlanning;

  /// No description provided for @viewTeam.
  ///
  /// In fr, this message translates to:
  /// **'Équipe'**
  String get viewTeam;

  /// No description provided for @viewPositions.
  ///
  /// In fr, this message translates to:
  /// **'Postes'**
  String get viewPositions;

  /// No description provided for @readOnlyCompany.
  ///
  /// In fr, this message translates to:
  /// **'Entreprise en lecture seule.'**
  String get readOnlyCompany;

  /// No description provided for @team.
  ///
  /// In fr, this message translates to:
  /// **'Équipe'**
  String get team;

  /// No description provided for @leaveCompany.
  ///
  /// In fr, this message translates to:
  /// **'Quitter cette entreprise'**
  String get leaveCompany;

  /// No description provided for @meSuffix.
  ///
  /// In fr, this message translates to:
  /// **'{name} (vous)'**
  String meSuffix(String name);

  /// No description provided for @transferConfirmTitle.
  ///
  /// In fr, this message translates to:
  /// **'Transférer l\'entreprise à {name} ?'**
  String transferConfirmTitle(String name);

  /// No description provided for @transferConfirmBody.
  ///
  /// In fr, this message translates to:
  /// **'Une fois la proposition acceptée, cette personne deviendra propriétaire (abonnement, factures, responsables) et vous deviendrez responsable.'**
  String get transferConfirmBody;

  /// No description provided for @transferSent.
  ///
  /// In fr, this message translates to:
  /// **'Proposition envoyée à {name}.'**
  String transferSent(String name);

  /// No description provided for @removeConfirmTitle.
  ///
  /// In fr, this message translates to:
  /// **'Retirer {name} ?'**
  String removeConfirmTitle(String name);

  /// No description provided for @removeConfirmBody.
  ///
  /// In fr, this message translates to:
  /// **'Son historique est conservé.'**
  String get removeConfirmBody;

  /// No description provided for @addPersonTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une personne'**
  String get addPersonTitle;

  /// No description provided for @addPersonHint.
  ///
  /// In fr, this message translates to:
  /// **'Demandez-lui d\'ouvrir Staff Flow, menu de son compte, « Rejoindre une entreprise », puis saisissez le code affiché.'**
  String get addPersonHint;

  /// No description provided for @sixDigitCode.
  ///
  /// In fr, this message translates to:
  /// **'Code à 6 chiffres'**
  String get sixDigitCode;

  /// No description provided for @invitationSent.
  ///
  /// In fr, this message translates to:
  /// **'Invitation envoyée à {name} : cette personne doit l\'accepter.'**
  String invitationSent(String name);

  /// No description provided for @leaveConfirmTitle.
  ///
  /// In fr, this message translates to:
  /// **'Quitter {company} ?'**
  String leaveConfirmTitle(String company);

  /// No description provided for @leaveConfirmBody.
  ///
  /// In fr, this message translates to:
  /// **'Vous ne verrez plus son planning.'**
  String get leaveConfirmBody;

  /// No description provided for @renameCompany.
  ///
  /// In fr, this message translates to:
  /// **'Renommer l\'entreprise'**
  String get renameCompany;

  /// No description provided for @actionMakeManager.
  ///
  /// In fr, this message translates to:
  /// **'Nommer responsable'**
  String get actionMakeManager;

  /// No description provided for @actionMakeEmployee.
  ///
  /// In fr, this message translates to:
  /// **'Repasser salarié'**
  String get actionMakeEmployee;

  /// No description provided for @actionToEmployee.
  ///
  /// In fr, this message translates to:
  /// **'Passer salarié'**
  String get actionToEmployee;

  /// No description provided for @actionToExtra.
  ///
  /// In fr, this message translates to:
  /// **'Passer extra'**
  String get actionToExtra;

  /// No description provided for @actionTransfer.
  ///
  /// In fr, this message translates to:
  /// **'Transférer la propriété'**
  String get actionTransfer;

  /// No description provided for @actionRemove.
  ///
  /// In fr, this message translates to:
  /// **'Retirer de l\'entreprise'**
  String get actionRemove;

  /// No description provided for @positions.
  ///
  /// In fr, this message translates to:
  /// **'Postes'**
  String get positions;

  /// No description provided for @sites.
  ///
  /// In fr, this message translates to:
  /// **'Sites'**
  String get sites;

  /// No description provided for @positionsHint.
  ///
  /// In fr, this message translates to:
  /// **'Ce que fait la personne : caisse, cuisine, accueil…'**
  String get positionsHint;

  /// No description provided for @sitesHint.
  ///
  /// In fr, this message translates to:
  /// **'Où se passe le service, si l\'entreprise a plusieurs lieux.'**
  String get sitesHint;

  /// No description provided for @archived.
  ///
  /// In fr, this message translates to:
  /// **'Archivé'**
  String get archived;

  /// No description provided for @archive.
  ///
  /// In fr, this message translates to:
  /// **'Archiver'**
  String get archive;

  /// No description provided for @reactivate.
  ///
  /// In fr, this message translates to:
  /// **'Réactiver'**
  String get reactivate;

  /// No description provided for @weekOf.
  ///
  /// In fr, this message translates to:
  /// **'Semaine du {date}'**
  String weekOf(String date);

  /// No description provided for @changesPublished.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 changement publié.} other{{count} changements publiés.}}'**
  String changesPublished(int count);

  /// No description provided for @shiftButton.
  ///
  /// In fr, this message translates to:
  /// **'Service'**
  String get shiftButton;

  /// No description provided for @display.
  ///
  /// In fr, this message translates to:
  /// **'Affichage'**
  String get display;

  /// No description provided for @week.
  ///
  /// In fr, this message translates to:
  /// **'Semaine'**
  String get week;

  /// No description provided for @month.
  ///
  /// In fr, this message translates to:
  /// **'Mois'**
  String get month;

  /// No description provided for @today.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get today;

  /// No description provided for @onlyMine.
  ///
  /// In fr, this message translates to:
  /// **'Seulement mes services'**
  String get onlyMine;

  /// No description provided for @replacePersonMenu.
  ///
  /// In fr, this message translates to:
  /// **'Remplacer une personne…'**
  String get replacePersonMenu;

  /// No description provided for @pendingChanges.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 changement non publié} other{{count} changements non publiés}}'**
  String pendingChanges(int count);

  /// No description provided for @pendingHint.
  ///
  /// In fr, this message translates to:
  /// **'Les salariés ne les voient pas encore.'**
  String get pendingHint;

  /// No description provided for @publish.
  ///
  /// In fr, this message translates to:
  /// **'Publier'**
  String get publish;

  /// No description provided for @yourHours.
  ///
  /// In fr, this message translates to:
  /// **'Vos heures sur la période : {duration}'**
  String yourHours(String duration);

  /// No description provided for @addShiftThisDay.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un service ce jour'**
  String get addShiftThisDay;

  /// No description provided for @noShift.
  ///
  /// In fr, this message translates to:
  /// **'Aucun service'**
  String get noShift;

  /// No description provided for @unassigned.
  ///
  /// In fr, this message translates to:
  /// **'Non attribué'**
  String get unassigned;

  /// No description provided for @formerMember.
  ///
  /// In fr, this message translates to:
  /// **'Ancien membre'**
  String get formerMember;

  /// No description provided for @statusDraft.
  ///
  /// In fr, this message translates to:
  /// **'Brouillon'**
  String get statusDraft;

  /// No description provided for @statusModified.
  ///
  /// In fr, this message translates to:
  /// **'Modifié'**
  String get statusModified;

  /// No description provided for @statusDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Supprimé'**
  String get statusDeleted;

  /// No description provided for @durationHours.
  ///
  /// In fr, this message translates to:
  /// **'{hours} h'**
  String durationHours(int hours);

  /// No description provided for @durationHoursMinutes.
  ///
  /// In fr, this message translates to:
  /// **'{hours} h {minutes}'**
  String durationHoursMinutes(int hours, String minutes);

  /// No description provided for @editShift.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le service'**
  String get editShift;

  /// No description provided for @newShift.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau service'**
  String get newShift;

  /// No description provided for @thisShift.
  ///
  /// In fr, this message translates to:
  /// **'Ce service'**
  String get thisShift;

  /// No description provided for @thisAndFollowing.
  ///
  /// In fr, this message translates to:
  /// **'Celui-ci et les suivants'**
  String get thisAndFollowing;

  /// No description provided for @daysLabel.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{Jour} other{Jours}}'**
  String daysLabel(int count);

  /// No description provided for @otherDay.
  ///
  /// In fr, this message translates to:
  /// **'Autre jour'**
  String get otherDay;

  /// No description provided for @start.
  ///
  /// In fr, this message translates to:
  /// **'Début'**
  String get start;

  /// No description provided for @end.
  ///
  /// In fr, this message translates to:
  /// **'Fin'**
  String get end;

  /// No description provided for @endsNextDay.
  ///
  /// In fr, this message translates to:
  /// **'Se termine le lendemain.'**
  String get endsNextDay;

  /// No description provided for @person.
  ///
  /// In fr, this message translates to:
  /// **'Personne'**
  String get person;

  /// No description provided for @position.
  ///
  /// In fr, this message translates to:
  /// **'Poste'**
  String get position;

  /// No description provided for @site.
  ///
  /// In fr, this message translates to:
  /// **'Site'**
  String get site;

  /// No description provided for @noteOptional.
  ///
  /// In fr, this message translates to:
  /// **'Note (facultatif)'**
  String get noteOptional;

  /// No description provided for @repetition.
  ///
  /// In fr, this message translates to:
  /// **'Répétition'**
  String get repetition;

  /// No description provided for @repeatNone.
  ///
  /// In fr, this message translates to:
  /// **'Aucune'**
  String get repeatNone;

  /// No description provided for @repeatDaily.
  ///
  /// In fr, this message translates to:
  /// **'Chaque jour'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In fr, this message translates to:
  /// **'Chaque semaine'**
  String get repeatWeekly;

  /// No description provided for @repeatForPrefix.
  ///
  /// In fr, this message translates to:
  /// **'Pendant '**
  String get repeatForPrefix;

  /// No description provided for @repeatDaysSuffix.
  ///
  /// In fr, this message translates to:
  /// **' jours'**
  String get repeatDaysSuffix;

  /// No description provided for @repeatWeeksSuffix.
  ///
  /// In fr, this message translates to:
  /// **' semaines'**
  String get repeatWeeksSuffix;

  /// No description provided for @repeatUntilPrefix.
  ///
  /// In fr, this message translates to:
  /// **'Jusqu\'au '**
  String get repeatUntilPrefix;

  /// No description provided for @replacePersonTitle.
  ///
  /// In fr, this message translates to:
  /// **'Remplacer une personne'**
  String get replacePersonTitle;

  /// No description provided for @replaceFrom.
  ///
  /// In fr, this message translates to:
  /// **'Remplacer'**
  String get replaceFrom;

  /// No description provided for @replaceBy.
  ///
  /// In fr, this message translates to:
  /// **'Par'**
  String get replaceBy;

  /// No description provided for @dateRange.
  ///
  /// In fr, this message translates to:
  /// **'Du {from} au {to}'**
  String dateRange(String from, String to);

  /// No description provided for @shiftsChanged.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucun service modifié.} =1{1 service modifié.} other{{count} services modifiés.}}'**
  String shiftsChanged(int count);

  /// No description provided for @replaceButton.
  ///
  /// In fr, this message translates to:
  /// **'Remplacer'**
  String get replaceButton;

  /// No description provided for @joinHint.
  ///
  /// In fr, this message translates to:
  /// **'Donnez ce code à votre responsable. Il le saisit dans son application, puis vous recevez une invitation à accepter.'**
  String get joinHint;

  /// No description provided for @codeExpired.
  ///
  /// In fr, this message translates to:
  /// **'Code expiré.'**
  String get codeExpired;

  /// No description provided for @codeValidFor.
  ///
  /// In fr, this message translates to:
  /// **'Valable encore {time}'**
  String codeValidFor(String time);

  /// No description provided for @newCode.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau code'**
  String get newCode;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'fr':
      return L10nFr();
    case 'uk':
      return L10nUk();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
