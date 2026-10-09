import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bg.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_th.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

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
    Locale('bg'),
    Locale('bn'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fil'),
    Locale('fr'),
    Locale('gu'),
    Locale('hi'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kk'),
    Locale('ko'),
    Locale('mr'),
    Locale('ms'),
    Locale('nb'),
    Locale('nl'),
    Locale('pa'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sv'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @validate.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get validate;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @serverUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Cannot reach the server.'**
  String get serverUnreachable;

  /// No description provided for @errorStatus.
  ///
  /// In en, this message translates to:
  /// **'Error {status}'**
  String errorStatus(int status);

  /// No description provided for @roleOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get roleOwner;

  /// No description provided for @roleManager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get roleManager;

  /// No description provided for @roleEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get roleEmployee;

  /// No description provided for @roleExtra.
  ///
  /// In en, this message translates to:
  /// **'Extra'**
  String get roleExtra;

  /// No description provided for @taglineStart.
  ///
  /// In en, this message translates to:
  /// **'Your team\'s schedules, '**
  String get taglineStart;

  /// No description provided for @taglineEnd.
  ///
  /// In en, this message translates to:
  /// **'everywhere.'**
  String get taglineEnd;

  /// No description provided for @googleNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).'**
  String get googleNotConfigured;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @devSection.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get devSection;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailLabel;

  /// No description provided for @devSignIn.
  ///
  /// In en, this message translates to:
  /// **'Test sign-in'**
  String get devSignIn;

  /// No description provided for @googleUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in unavailable: {detail}'**
  String googleUnavailable(String detail);

  /// No description provided for @googleFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed: {detail}'**
  String googleFailed(String detail);

  /// No description provided for @newCompany.
  ///
  /// In en, this message translates to:
  /// **'New company'**
  String get newCompany;

  /// No description provided for @timezone.
  ///
  /// In en, this message translates to:
  /// **'Time zone'**
  String get timezone;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @noCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'You are not part of any company yet.'**
  String get noCompanyTitle;

  /// No description provided for @noCompanyHint.
  ///
  /// In en, this message translates to:
  /// **'To join your employer\'s, generate a code and give it to your manager.'**
  String get noCompanyHint;

  /// No description provided for @joinCompany.
  ///
  /// In en, this message translates to:
  /// **'Join a company'**
  String get joinCompany;

  /// No description provided for @createCompany.
  ///
  /// In en, this message translates to:
  /// **'Create a company'**
  String get createCompany;

  /// No description provided for @transferOffer.
  ///
  /// In en, this message translates to:
  /// **'You are invited to become the owner of “{company}”.'**
  String transferOffer(String company);

  /// No description provided for @someCompany.
  ///
  /// In en, this message translates to:
  /// **'a company'**
  String get someCompany;

  /// No description provided for @becameOwner.
  ///
  /// In en, this message translates to:
  /// **'You are now the owner.'**
  String get becameOwner;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get myAccount;

  /// No description provided for @idCopied.
  ///
  /// In en, this message translates to:
  /// **'ID copied.'**
  String get idCopied;

  /// No description provided for @myId.
  ///
  /// In en, this message translates to:
  /// **'My ID: {id}'**
  String myId(String id);

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @joinInvite.
  ///
  /// In en, this message translates to:
  /// **'“{company}” invites you as {role}.'**
  String joinInvite(String company, String role);

  /// No description provided for @joinedCompany.
  ///
  /// In en, this message translates to:
  /// **'You joined {company}.'**
  String joinedCompany(String company);

  /// No description provided for @viewPlanning.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get viewPlanning;

  /// No description provided for @viewTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get viewTeam;

  /// No description provided for @viewPositions.
  ///
  /// In en, this message translates to:
  /// **'Positions'**
  String get viewPositions;

  /// No description provided for @readOnlyCompany.
  ///
  /// In en, this message translates to:
  /// **'This company is read-only.'**
  String get readOnlyCompany;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @leaveCompany.
  ///
  /// In en, this message translates to:
  /// **'Leave this company'**
  String get leaveCompany;

  /// No description provided for @meSuffix.
  ///
  /// In en, this message translates to:
  /// **'{name} (you)'**
  String meSuffix(String name);

  /// No description provided for @transferConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Transfer the company to {name}?'**
  String transferConfirmTitle(String name);

  /// No description provided for @transferConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Once they accept, they will become the owner (subscription, invoices, managers) and you will become a manager.'**
  String get transferConfirmBody;

  /// No description provided for @transferSent.
  ///
  /// In en, this message translates to:
  /// **'Offer sent to {name}.'**
  String transferSent(String name);

  /// No description provided for @removeConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String removeConfirmTitle(String name);

  /// No description provided for @removeConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Their history is kept.'**
  String get removeConfirmBody;

  /// No description provided for @addPersonTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a person'**
  String get addPersonTitle;

  /// No description provided for @addPersonHint.
  ///
  /// In en, this message translates to:
  /// **'Ask them to open Staff Flow, then their account menu, “Join a company”, and enter the code they see.'**
  String get addPersonHint;

  /// No description provided for @sixDigitCode.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get sixDigitCode;

  /// No description provided for @invitationSent.
  ///
  /// In en, this message translates to:
  /// **'Invitation sent to {name}: they need to accept it.'**
  String invitationSent(String name);

  /// No description provided for @leaveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave {company}?'**
  String leaveConfirmTitle(String company);

  /// No description provided for @leaveConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You will no longer see its schedule.'**
  String get leaveConfirmBody;

  /// No description provided for @renameCompany.
  ///
  /// In en, this message translates to:
  /// **'Rename the company'**
  String get renameCompany;

  /// No description provided for @actionMakeManager.
  ///
  /// In en, this message translates to:
  /// **'Make manager'**
  String get actionMakeManager;

  /// No description provided for @actionMakeEmployee.
  ///
  /// In en, this message translates to:
  /// **'Make employee again'**
  String get actionMakeEmployee;

  /// No description provided for @actionToEmployee.
  ///
  /// In en, this message translates to:
  /// **'Make employee'**
  String get actionToEmployee;

  /// No description provided for @actionToExtra.
  ///
  /// In en, this message translates to:
  /// **'Make extra'**
  String get actionToExtra;

  /// No description provided for @actionTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer ownership'**
  String get actionTransfer;

  /// No description provided for @actionRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from the company'**
  String get actionRemove;

  /// No description provided for @positions.
  ///
  /// In en, this message translates to:
  /// **'Positions'**
  String get positions;

  /// No description provided for @sites.
  ///
  /// In en, this message translates to:
  /// **'Sites'**
  String get sites;

  /// No description provided for @positionsHint.
  ///
  /// In en, this message translates to:
  /// **'What the person does: checkout, kitchen, reception…'**
  String get positionsHint;

  /// No description provided for @sitesHint.
  ///
  /// In en, this message translates to:
  /// **'Where the shift takes place, if the company has several locations.'**
  String get sitesHint;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @reactivate.
  ///
  /// In en, this message translates to:
  /// **'Reactivate'**
  String get reactivate;

  /// No description provided for @weekOf.
  ///
  /// In en, this message translates to:
  /// **'Week of {date}'**
  String weekOf(String date);

  /// No description provided for @changesPublished.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 change published.} other{{count} changes published.}}'**
  String changesPublished(int count);

  /// No description provided for @shiftButton.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get shiftButton;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get display;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @onlyMine.
  ///
  /// In en, this message translates to:
  /// **'Only my shifts'**
  String get onlyMine;

  /// No description provided for @replacePersonMenu.
  ///
  /// In en, this message translates to:
  /// **'Replace a person…'**
  String get replacePersonMenu;

  /// No description provided for @pendingChanges.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 unpublished change} other{{count} unpublished changes}}'**
  String pendingChanges(int count);

  /// No description provided for @pendingHint.
  ///
  /// In en, this message translates to:
  /// **'Employees can\'t see them yet.'**
  String get pendingHint;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @yourHours.
  ///
  /// In en, this message translates to:
  /// **'Your hours for this period: {duration}'**
  String yourHours(String duration);

  /// No description provided for @addShiftThisDay.
  ///
  /// In en, this message translates to:
  /// **'Add a shift on this day'**
  String get addShiftThisDay;

  /// No description provided for @noShift.
  ///
  /// In en, this message translates to:
  /// **'No shifts'**
  String get noShift;

  /// No description provided for @unassigned.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get unassigned;

  /// No description provided for @formerMember.
  ///
  /// In en, this message translates to:
  /// **'Former member'**
  String get formerMember;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusModified.
  ///
  /// In en, this message translates to:
  /// **'Changed'**
  String get statusModified;

  /// No description provided for @statusDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get statusDeleted;

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String durationHours(int hours);

  /// No description provided for @durationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h{minutes}'**
  String durationHoursMinutes(int hours, String minutes);

  /// No description provided for @editShift.
  ///
  /// In en, this message translates to:
  /// **'Edit shift'**
  String get editShift;

  /// No description provided for @newShift.
  ///
  /// In en, this message translates to:
  /// **'New shift'**
  String get newShift;

  /// No description provided for @thisShift.
  ///
  /// In en, this message translates to:
  /// **'This shift'**
  String get thisShift;

  /// No description provided for @thisAndFollowing.
  ///
  /// In en, this message translates to:
  /// **'This and following'**
  String get thisAndFollowing;

  /// No description provided for @daysLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Day} other{Days}}'**
  String daysLabel(int count);

  /// No description provided for @otherDay.
  ///
  /// In en, this message translates to:
  /// **'Another day'**
  String get otherDay;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @endsNextDay.
  ///
  /// In en, this message translates to:
  /// **'Ends the next day.'**
  String get endsNextDay;

  /// No description provided for @person.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get person;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @site.
  ///
  /// In en, this message translates to:
  /// **'Site'**
  String get site;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @repetition.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repetition;

  /// No description provided for @repeatNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get repeatNone;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get repeatWeekly;

  /// No description provided for @repeatForPrefix.
  ///
  /// In en, this message translates to:
  /// **'For '**
  String get repeatForPrefix;

  /// No description provided for @repeatDaysSuffix.
  ///
  /// In en, this message translates to:
  /// **' days'**
  String get repeatDaysSuffix;

  /// No description provided for @repeatWeeksSuffix.
  ///
  /// In en, this message translates to:
  /// **' weeks'**
  String get repeatWeeksSuffix;

  /// No description provided for @repeatUntilPrefix.
  ///
  /// In en, this message translates to:
  /// **'Until '**
  String get repeatUntilPrefix;

  /// No description provided for @replacePersonTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace a person'**
  String get replacePersonTitle;

  /// No description provided for @replaceFrom.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replaceFrom;

  /// No description provided for @replaceBy.
  ///
  /// In en, this message translates to:
  /// **'With'**
  String get replaceBy;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'From {from} to {to}'**
  String dateRange(String from, String to);

  /// No description provided for @shiftsChanged.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No shifts changed.} =1{1 shift changed.} other{{count} shifts changed.}}'**
  String shiftsChanged(int count);

  /// No description provided for @replaceButton.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replaceButton;

  /// No description provided for @joinHint.
  ///
  /// In en, this message translates to:
  /// **'Give this code to your manager. They enter it in their app, then you receive an invitation to accept.'**
  String get joinHint;

  /// No description provided for @codeExpired.
  ///
  /// In en, this message translates to:
  /// **'Code expired.'**
  String get codeExpired;

  /// No description provided for @codeValidFor.
  ///
  /// In en, this message translates to:
  /// **'Valid for {time}'**
  String codeValidFor(String time);

  /// No description provided for @newCode.
  ///
  /// In en, this message translates to:
  /// **'New code'**
  String get newCode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic (device language)'**
  String get languageAuto;

  /// No description provided for @syncUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Up to date'**
  String get syncUpToDate;

  /// No description provided for @syncOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get syncOffline;

  /// No description provided for @syncPending.
  ///
  /// In en, this message translates to:
  /// **'Pending changes: {count}'**
  String syncPending(int count);

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get syncNow;

  /// No description provided for @syncRejected.
  ///
  /// In en, this message translates to:
  /// **'Change refused by the server: {reason}'**
  String syncRejected(String reason);

  /// No description provided for @pendingBadge.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingBadge;

  /// No description provided for @offlineUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable offline.'**
  String get offlineUnavailable;

  /// No description provided for @offlineCached.
  ///
  /// In en, this message translates to:
  /// **'Offline: showing the last saved data.'**
  String get offlineCached;

  /// No description provided for @savedOffline.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device, will be sent when the network is back.'**
  String get savedOffline;

  /// No description provided for @notices.
  ///
  /// In en, this message translates to:
  /// **'Notices'**
  String get notices;

  /// No description provided for @noNotices.
  ///
  /// In en, this message translates to:
  /// **'No notices.'**
  String get noNotices;

  /// No description provided for @noticeOverwritten.
  ///
  /// In en, this message translates to:
  /// **'{name} replaced your change to the shift on {date}.'**
  String noticeOverwritten(String name, String date);

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @recentChanges.
  ///
  /// In en, this message translates to:
  /// **'Recent changes'**
  String get recentChanges;

  /// No description provided for @undoChange.
  ///
  /// In en, this message translates to:
  /// **'Undo this change'**
  String get undoChange;

  /// No description provided for @undoDone.
  ///
  /// In en, this message translates to:
  /// **'Change undone.'**
  String get undoDone;

  /// No description provided for @historyCreate.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get historyCreate;

  /// No description provided for @historyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Changed'**
  String get historyUpdate;

  /// No description provided for @historyDelete.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get historyDelete;

  /// No description provided for @historyUndo.
  ///
  /// In en, this message translates to:
  /// **'Undone'**
  String get historyUndo;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No changes.'**
  String get noHistory;

  /// No description provided for @pendingNotEditable.
  ///
  /// In en, this message translates to:
  /// **'This shift is not synced yet: try again once online.'**
  String get pendingNotEditable;

  /// No description provided for @myQrCode.
  ///
  /// In en, this message translates to:
  /// **'My QR code'**
  String get myQrCode;

  /// No description provided for @myQrCodeHint.
  ///
  /// In en, this message translates to:
  /// **'A manager scans this code to add you to their company; you then confirm. It never changes.'**
  String get myQrCodeHint;

  /// No description provided for @changeMyName.
  ///
  /// In en, this message translates to:
  /// **'Change my name'**
  String get changeMyName;

  /// No description provided for @nameShownToTeam.
  ///
  /// In en, this message translates to:
  /// **'This name is shown to your colleagues instead of your Google name.'**
  String get nameShownToTeam;

  /// No description provided for @googleName.
  ///
  /// In en, this message translates to:
  /// **'Google name: {name}'**
  String googleName(String name);

  /// No description provided for @useGoogleName.
  ///
  /// In en, this message translates to:
  /// **'Use my Google name'**
  String get useGoogleName;

  /// No description provided for @renameMemberTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename {name}'**
  String renameMemberTitle(String name);

  /// No description provided for @renameMemberHint.
  ///
  /// In en, this message translates to:
  /// **'This name is only used in this company.'**
  String get renameMemberHint;

  /// No description provided for @useOwnName.
  ///
  /// In en, this message translates to:
  /// **'Use their own name'**
  String get useOwnName;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan a QR code'**
  String get scanQrCode;

  /// No description provided for @scanQrHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at the QR code shown in their app (account menu, “My QR code”).'**
  String get scanQrHint;

  /// No description provided for @orEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Or enter their 6-digit code'**
  String get orEnterCode;

  /// No description provided for @qrInvalid.
  ///
  /// In en, this message translates to:
  /// **'This is not a Staff Flow QR code.'**
  String get qrInvalid;

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera unavailable ({error}).'**
  String cameraUnavailable(String error);

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notifChooseHint.
  ///
  /// In en, this message translates to:
  /// **'Choose what you are notified about. Everything stays visible in the bell.'**
  String get notifChooseHint;

  /// No description provided for @notifPlanning.
  ///
  /// In en, this message translates to:
  /// **'Schedule published or changed'**
  String get notifPlanning;

  /// No description provided for @notifRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests: swaps, leave, invitations'**
  String get notifRequests;

  /// No description provided for @notifMessages.
  ///
  /// In en, this message translates to:
  /// **'New messages'**
  String get notifMessages;

  /// No description provided for @notifOverlap.
  ///
  /// In en, this message translates to:
  /// **'Overlapping shifts between companies'**
  String get notifOverlap;

  /// No description provided for @notifConflicts.
  ///
  /// In en, this message translates to:
  /// **'Your changes replaced by another manager'**
  String get notifConflicts;

  /// No description provided for @notifBilling.
  ///
  /// In en, this message translates to:
  /// **'Subscription reminders'**
  String get notifBilling;

  /// No description provided for @pushEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications are on for this device.'**
  String get pushEnabled;

  /// No description provided for @pushOff.
  ///
  /// In en, this message translates to:
  /// **'Notifications are off on this device.'**
  String get pushOff;

  /// No description provided for @pushBlocked.
  ///
  /// In en, this message translates to:
  /// **'Notifications are blocked: allow them in your phone or browser settings.'**
  String get pushBlocked;

  /// No description provided for @pushUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Notifications are not available on this device.'**
  String get pushUnavailable;

  /// No description provided for @enablePush.
  ///
  /// In en, this message translates to:
  /// **'Turn on'**
  String get enablePush;

  /// No description provided for @noticeSchedulePublished.
  ///
  /// In en, this message translates to:
  /// **'{company}: your schedule has been published or changed.'**
  String noticeSchedulePublished(String company);

  /// No description provided for @noticeJoinInvite.
  ///
  /// In en, this message translates to:
  /// **'{company} wants to add you to its team.'**
  String noticeJoinInvite(String company);

  /// No description provided for @noticeTransferOffer.
  ///
  /// In en, this message translates to:
  /// **'{name} offers to make you the owner of {company}.'**
  String noticeTransferOffer(String name, String company);

  /// No description provided for @noticeMemberJoined.
  ///
  /// In en, this message translates to:
  /// **'{name} joined {company}.'**
  String noticeMemberJoined(String name, String company);

  /// No description provided for @messagesTab.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesTab;

  /// No description provided for @wholeTeam.
  ///
  /// In en, this message translates to:
  /// **'Whole team'**
  String get wholeTeam;

  /// No description provided for @newConversation.
  ///
  /// In en, this message translates to:
  /// **'New conversation'**
  String get newConversation;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet.'**
  String get noMessages;

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Write a message'**
  String get messageHint;

  /// No description provided for @earlierMessages.
  ///
  /// In en, this message translates to:
  /// **'Earlier messages'**
  String get earlierMessages;

  /// No description provided for @personLeftCompany.
  ///
  /// In en, this message translates to:
  /// **'This person is no longer part of the company.'**
  String get personLeftCompany;

  /// No description provided for @messagePreview.
  ///
  /// In en, this message translates to:
  /// **'{name}: {text}'**
  String messagePreview(String name, String text);

  /// No description provided for @newGroup.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get newGroup;

  /// No description provided for @editGroup.
  ///
  /// In en, this message translates to:
  /// **'Edit group'**
  String get editGroup;

  /// No description provided for @groupName.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get groupName;

  /// No description provided for @groupMembersHint.
  ///
  /// In en, this message translates to:
  /// **'Choose the people in this group. Only they will see its messages.'**
  String get groupMembersHint;

  /// No description provided for @chooseAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Choose at least one person.'**
  String get chooseAtLeastOne;

  /// No description provided for @replyAction.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get replyAction;

  /// No description provided for @translateAction.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translateAction;

  /// No description provided for @replyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String replyingTo(String name);

  /// No description provided for @lastMessagesOf.
  ///
  /// In en, this message translates to:
  /// **'Last messages from {name}'**
  String lastMessagesOf(String name);

  /// No description provided for @deleteAllNotices.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get deleteAllNotices;

  /// No description provided for @deleteAllNoticesConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete all notices?'**
  String get deleteAllNoticesConfirm;

  /// No description provided for @noticeRetention.
  ///
  /// In en, this message translates to:
  /// **'Delete read notices after'**
  String get noticeRetention;

  /// No description provided for @retentionDay.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get retentionDay;

  /// No description provided for @retentionWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get retentionWeek;

  /// No description provided for @retentionMonth.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get retentionMonth;

  /// No description provided for @billingOwnersOnly.
  ///
  /// In en, this message translates to:
  /// **'Only active when you own a company.'**
  String get billingOwnersOnly;

  /// No description provided for @readOnlyPastDays.
  ///
  /// In en, this message translates to:
  /// **'Days more than a month old are read-only.'**
  String get readOnlyPastDays;

  /// No description provided for @wholeCompany.
  ///
  /// In en, this message translates to:
  /// **'Whole company'**
  String get wholeCompany;

  /// No description provided for @sitesLabel.
  ///
  /// In en, this message translates to:
  /// **'Sites'**
  String get sitesLabel;

  /// No description provided for @actionSites.
  ///
  /// In en, this message translates to:
  /// **'Sites…'**
  String get actionSites;

  /// No description provided for @managerOf.
  ///
  /// In en, this message translates to:
  /// **'{name} manages'**
  String managerOf(String name);

  /// No description provided for @teamSitesOf.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s team'**
  String teamSitesOf(String name);

  /// No description provided for @notYourSite.
  ///
  /// In en, this message translates to:
  /// **'This site is not under your responsibility.'**
  String get notYourSite;

  /// No description provided for @chooseYourSite.
  ///
  /// In en, this message translates to:
  /// **'Choose at least one site.'**
  String get chooseYourSite;

  /// No description provided for @viewRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get viewRequests;

  /// No description provided for @newRequest.
  ///
  /// In en, this message translates to:
  /// **'New request'**
  String get newRequest;

  /// No description provided for @requestLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get requestLeave;

  /// No description provided for @requestUnavailability.
  ///
  /// In en, this message translates to:
  /// **'Unavailability'**
  String get requestUnavailability;

  /// No description provided for @requestSwap.
  ///
  /// In en, this message translates to:
  /// **'Shift swap'**
  String get requestSwap;

  /// No description provided for @swapHint.
  ///
  /// In en, this message translates to:
  /// **'To offer a swap, tap one of your upcoming shifts in the schedule.'**
  String get swapHint;

  /// No description provided for @noRequests.
  ///
  /// In en, this message translates to:
  /// **'No requests yet.'**
  String get noRequests;

  /// No description provided for @requestsToHandle.
  ///
  /// In en, this message translates to:
  /// **'To handle'**
  String get requestsToHandle;

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'My requests'**
  String get myRequests;

  /// No description provided for @otherRequests.
  ///
  /// In en, this message translates to:
  /// **'Team requests'**
  String get otherRequests;

  /// No description provided for @statusPendingPeer.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the colleague'**
  String get statusPendingPeer;

  /// No description provided for @statusPendingManager.
  ///
  /// In en, this message translates to:
  /// **'Waiting for a manager'**
  String get statusPendingManager;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusRefused.
  ///
  /// In en, this message translates to:
  /// **'Refused'**
  String get statusRefused;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get cancelRequest;

  /// No description provided for @acceptSwap.
  ///
  /// In en, this message translates to:
  /// **'Take this shift'**
  String get acceptSwap;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @periodLabel.
  ///
  /// In en, this message translates to:
  /// **'From {from} to {to}'**
  String periodLabel(String from, String to);

  /// No description provided for @swapToPeer.
  ///
  /// In en, this message translates to:
  /// **'Offered to {name}'**
  String swapToPeer(String name);

  /// No description provided for @swapToTeam.
  ///
  /// In en, this message translates to:
  /// **'Whole team'**
  String get swapToTeam;

  /// No description provided for @everyWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Every week: {days}'**
  String everyWeekdays(String days);

  /// No description provided for @unavailableEveryWeek.
  ///
  /// In en, this message translates to:
  /// **'Days you are never available:'**
  String get unavailableEveryWeek;

  /// No description provided for @choosePeriod.
  ///
  /// In en, this message translates to:
  /// **'Choose dates'**
  String get choosePeriod;

  /// No description provided for @choosePeriodOptional.
  ///
  /// In en, this message translates to:
  /// **'Limit to a period (optional)'**
  String get choosePeriodOptional;

  /// No description provided for @clearPeriod.
  ///
  /// In en, this message translates to:
  /// **'No period'**
  String get clearPeriod;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send request'**
  String get sendRequest;

  /// No description provided for @proposeSwap.
  ///
  /// In en, this message translates to:
  /// **'Offer a swap'**
  String get proposeSwap;

  /// No description provided for @swapWith.
  ///
  /// In en, this message translates to:
  /// **'Offer to'**
  String get swapWith;

  /// No description provided for @swapSteps.
  ///
  /// In en, this message translates to:
  /// **'The colleague accepts, then a manager approves. The schedule only changes after that.'**
  String get swapSteps;

  /// No description provided for @absentThatDay.
  ///
  /// In en, this message translates to:
  /// **'Approved absence that day'**
  String get absentThatDay;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent.'**
  String get requestSent;

  /// No description provided for @noticeSwapOffer.
  ///
  /// In en, this message translates to:
  /// **'{name} offers you one of their shifts.'**
  String noticeSwapOffer(String name);

  /// No description provided for @noticeSwapDeclined.
  ///
  /// In en, this message translates to:
  /// **'{name} declined your swap offer.'**
  String noticeSwapDeclined(String name);

  /// No description provided for @noticeSwapToApprove.
  ///
  /// In en, this message translates to:
  /// **'A shift swap is waiting for your approval.'**
  String get noticeSwapToApprove;

  /// No description provided for @noticeLeaveToApprove.
  ///
  /// In en, this message translates to:
  /// **'{name} is asking for leave.'**
  String noticeLeaveToApprove(String name);

  /// No description provided for @noticeUnavailabilityToApprove.
  ///
  /// In en, this message translates to:
  /// **'{name} reports being unavailable.'**
  String noticeUnavailabilityToApprove(String name);

  /// No description provided for @noticeRequestApproved.
  ///
  /// In en, this message translates to:
  /// **'Your request has been approved.'**
  String get noticeRequestApproved;

  /// No description provided for @noticeRequestRefused.
  ///
  /// In en, this message translates to:
  /// **'Your request has been refused.'**
  String get noticeRequestRefused;

  /// No description provided for @choosePeer.
  ///
  /// In en, this message translates to:
  /// **'Who takes over this shift?'**
  String get choosePeer;

  /// No description provided for @discardAll.
  ///
  /// In en, this message translates to:
  /// **'Discard all'**
  String get discardAll;

  /// No description provided for @notifySitesHint.
  ///
  /// In en, this message translates to:
  /// **'Choose the sites you get request notifications for. All requests stay visible in the list.'**
  String get notifySitesHint;

  /// No description provided for @notifySitesTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications by site'**
  String get notifySitesTitle;

  /// No description provided for @pendingRequestTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pending request: tap to open it'**
  String get pendingRequestTooltip;

  /// No description provided for @requestsHistory.
  ///
  /// In en, this message translates to:
  /// **'All requests'**
  String get requestsHistory;

  /// No description provided for @revertChange.
  ///
  /// In en, this message translates to:
  /// **'Undo this change'**
  String get revertChange;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'No longer applies'**
  String get statusExpired;

  /// No description provided for @swapWithHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose a specific colleague'**
  String get swapWithHint;

  /// No description provided for @changesDiscarded.
  ///
  /// In en, this message translates to:
  /// **'Changes discarded: {count}'**
  String changesDiscarded(String count);

  /// No description provided for @discardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard the {count} unpublished changes?'**
  String discardConfirm(String count);

  /// No description provided for @allSchedules.
  ///
  /// In en, this message translates to:
  /// **'All my schedules'**
  String get allSchedules;

  /// No description provided for @busyElsewhere.
  ///
  /// In en, this message translates to:
  /// **'Already working at another company at this time'**
  String get busyElsewhere;

  /// No description provided for @overlapTooltip.
  ///
  /// In en, this message translates to:
  /// **'Overlaps a shift at another company'**
  String get overlapTooltip;

  /// No description provided for @overlapWarning.
  ///
  /// In en, this message translates to:
  /// **'Some of your shifts at two companies overlap.'**
  String get overlapWarning;

  /// No description provided for @noticeOverlap.
  ///
  /// In en, this message translates to:
  /// **'Two of your shifts at different companies overlap on {date}.'**
  String noticeOverlap(String date);
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bg',
    'bn',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'fi',
    'fil',
    'fr',
    'gu',
    'hi',
    'hu',
    'id',
    'it',
    'ja',
    'kk',
    'ko',
    'mr',
    'ms',
    'nb',
    'nl',
    'pa',
    'pl',
    'pt',
    'ro',
    'ru',
    'sk',
    'sv',
    'sw',
    'ta',
    'te',
    'th',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bg':
      return L10nBg();
    case 'bn':
      return L10nBn();
    case 'cs':
      return L10nCs();
    case 'da':
      return L10nDa();
    case 'de':
      return L10nDe();
    case 'el':
      return L10nEl();
    case 'en':
      return L10nEn();
    case 'es':
      return L10nEs();
    case 'fi':
      return L10nFi();
    case 'fil':
      return L10nFil();
    case 'fr':
      return L10nFr();
    case 'gu':
      return L10nGu();
    case 'hi':
      return L10nHi();
    case 'hu':
      return L10nHu();
    case 'id':
      return L10nId();
    case 'it':
      return L10nIt();
    case 'ja':
      return L10nJa();
    case 'kk':
      return L10nKk();
    case 'ko':
      return L10nKo();
    case 'mr':
      return L10nMr();
    case 'ms':
      return L10nMs();
    case 'nb':
      return L10nNb();
    case 'nl':
      return L10nNl();
    case 'pa':
      return L10nPa();
    case 'pl':
      return L10nPl();
    case 'pt':
      return L10nPt();
    case 'ro':
      return L10nRo();
    case 'ru':
      return L10nRu();
    case 'sk':
      return L10nSk();
    case 'sv':
      return L10nSv();
    case 'sw':
      return L10nSw();
    case 'ta':
      return L10nTa();
    case 'te':
      return L10nTe();
    case 'th':
      return L10nTh();
    case 'uk':
      return L10nUk();
    case 'vi':
      return L10nVi();
    case 'zh':
      return L10nZh();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
