import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
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
    Locale('de'),
    Locale('en'),
    Locale('en', 'GB'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('uk'),
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
  /// **'Management'**
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
  /// **'New announcements'**
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

  /// No description provided for @translateAction.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translateAction;

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
  /// **'Canceled'**
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

  /// No description provided for @allMyCompanies.
  ///
  /// In en, this message translates to:
  /// **'All my companies'**
  String get allMyCompanies;

  /// No description provided for @openRequest.
  ///
  /// In en, this message translates to:
  /// **'View request'**
  String get openRequest;

  /// No description provided for @thisCompany.
  ///
  /// In en, this message translates to:
  /// **'This company'**
  String get thisCompany;

  /// No description provided for @withExtras.
  ///
  /// In en, this message translates to:
  /// **'Include extras'**
  String get withExtras;

  /// No description provided for @reinforcementHint.
  ///
  /// In en, this message translates to:
  /// **'From {company}: will be added as backup staff and notified.'**
  String reinforcementHint(String company);

  /// No description provided for @addToGoogle.
  ///
  /// In en, this message translates to:
  /// **'Add to Google Calendar'**
  String get addToGoogle;

  /// No description provided for @calendarEnabled.
  ///
  /// In en, this message translates to:
  /// **'Sync my shifts'**
  String get calendarEnabled;

  /// No description provided for @changeSettings.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get changeSettings;

  /// No description provided for @countryBelgium.
  ///
  /// In en, this message translates to:
  /// **'Belgium'**
  String get countryBelgium;

  /// No description provided for @countryCanada.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get countryCanada;

  /// No description provided for @countryFrance.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get countryFrance;

  /// No description provided for @countrySwitzerland.
  ///
  /// In en, this message translates to:
  /// **'Switzerland'**
  String get countrySwitzerland;

  /// No description provided for @employeesSection.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get employeesSection;

  /// No description provided for @emptyNoAlert.
  ///
  /// In en, this message translates to:
  /// **'Empty: no alert'**
  String get emptyNoAlert;

  /// No description provided for @extrasSection.
  ///
  /// In en, this message translates to:
  /// **'Extras'**
  String get extrasSection;

  /// No description provided for @googleCalendar.
  ///
  /// In en, this message translates to:
  /// **'Google Calendar'**
  String get googleCalendar;

  /// No description provided for @hoursTotals.
  ///
  /// In en, this message translates to:
  /// **'Hour totals'**
  String get hoursTotals;

  /// No description provided for @legalAlerts.
  ///
  /// In en, this message translates to:
  /// **'Legal alerts'**
  String get legalAlerts;

  /// No description provided for @legalAlertsHint.
  ///
  /// In en, this message translates to:
  /// **'Warnings, never blocks. Choose the rules that apply to you, or none.'**
  String get legalAlertsHint;

  /// No description provided for @legalPreset.
  ///
  /// In en, this message translates to:
  /// **'Country template'**
  String get legalPreset;

  /// No description provided for @maxConsecutiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum consecutive working days'**
  String get maxConsecutiveLabel;

  /// No description provided for @maxDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum hours per day'**
  String get maxDayLabel;

  /// No description provided for @maxWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum hours per week'**
  String get maxWeekLabel;

  /// No description provided for @minRestLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum rest between shifts (hours)'**
  String get minRestLabel;

  /// No description provided for @noLegalRules.
  ///
  /// In en, this message translates to:
  /// **'No alerts chosen.'**
  String get noLegalRules;

  /// No description provided for @presetNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get presetNone;

  /// No description provided for @presetsCheck.
  ///
  /// In en, this message translates to:
  /// **'Templates are starting points: check them against your country\'s rules and your collective agreement.'**
  String get presetsCheck;

  /// No description provided for @printMine.
  ///
  /// In en, this message translates to:
  /// **'My schedule'**
  String get printMine;

  /// No description provided for @printOwn.
  ///
  /// In en, this message translates to:
  /// **'Their own schedule only'**
  String get printOwn;

  /// No description provided for @printPdf.
  ///
  /// In en, this message translates to:
  /// **'Print / PDF'**
  String get printPdf;

  /// No description provided for @printRights.
  ///
  /// In en, this message translates to:
  /// **'What employees can print'**
  String get printRights;

  /// No description provided for @printTeam.
  ///
  /// In en, this message translates to:
  /// **'The whole team\'s schedule'**
  String get printTeam;

  /// No description provided for @printTeamOption.
  ///
  /// In en, this message translates to:
  /// **'The team\'s schedule'**
  String get printTeamOption;

  /// No description provided for @totalsHint.
  ///
  /// In en, this message translates to:
  /// **'Drafts included. Excel and CSV exports use the published schedule.'**
  String get totalsHint;

  /// No description provided for @alertConsecutive.
  ///
  /// In en, this message translates to:
  /// **'{name}: {value} days in a row (maximum {limit})'**
  String alertConsecutive(String name, String value, String limit);

  /// No description provided for @alertDay.
  ///
  /// In en, this message translates to:
  /// **'{name}: {value} in the day (maximum {limit})'**
  String alertDay(String name, String value, String limit);

  /// No description provided for @alertRest.
  ///
  /// In en, this message translates to:
  /// **'{name}: only {value} of rest (minimum {limit})'**
  String alertRest(String name, String value, String limit);

  /// No description provided for @alertWeek.
  ///
  /// In en, this message translates to:
  /// **'{name}: {value} in the week (maximum {limit})'**
  String alertWeek(String name, String value, String limit);

  /// No description provided for @legalAlertsCount.
  ///
  /// In en, this message translates to:
  /// **'Legal alerts: {count}'**
  String legalAlertsCount(String count);

  /// No description provided for @shiftsCount.
  ///
  /// In en, this message translates to:
  /// **'Shifts: {count}'**
  String shiftsCount(String count);

  /// No description provided for @actionMakeDeputy.
  ///
  /// In en, this message translates to:
  /// **'Appoint as deputy manager'**
  String get actionMakeDeputy;

  /// No description provided for @actionRemoveDeputy.
  ///
  /// In en, this message translates to:
  /// **'Remove deputy manager role'**
  String get actionRemoveDeputy;

  /// No description provided for @busyHere.
  ///
  /// In en, this message translates to:
  /// **'Already working at this company at this time'**
  String get busyHere;

  /// No description provided for @calendarDenied.
  ///
  /// In en, this message translates to:
  /// **'Calendar access denied. Allow it in the phone settings.'**
  String get calendarDenied;

  /// No description provided for @calendarLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Add it from Google Calendar on a computer; Google updates it within a few hours.'**
  String get calendarLinkHint;

  /// No description provided for @calendarNone.
  ///
  /// In en, this message translates to:
  /// **'No editable calendar on this phone.'**
  String get calendarNone;

  /// No description provided for @calendarOnPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'In your Google calendar: visible right away, on the phone and in Google Calendar.'**
  String get calendarOnPhoneHint;

  /// No description provided for @chooseCalendar.
  ///
  /// In en, this message translates to:
  /// **'Choose the calendar'**
  String get chooseCalendar;

  /// No description provided for @otherSiteHint.
  ///
  /// In en, this message translates to:
  /// **'Employee from another site: their managers will be notified.'**
  String get otherSiteHint;

  /// No description provided for @subManager.
  ///
  /// In en, this message translates to:
  /// **'Deputy manager'**
  String get subManager;

  /// No description provided for @calendarSynced.
  ///
  /// In en, this message translates to:
  /// **'Shifts in the calendar: {count}'**
  String calendarSynced(String count);

  /// No description provided for @deputyOf.
  ///
  /// In en, this message translates to:
  /// **'Deputy manager: {name}'**
  String deputyOf(String name);

  /// No description provided for @noticeBorrowed.
  ///
  /// In en, this message translates to:
  /// **'{by} scheduled {name} at {site} on {date}.'**
  String noticeBorrowed(String by, String name, String site, String date);

  /// No description provided for @noticeReinforcement.
  ///
  /// In en, this message translates to:
  /// **'{company} added you as backup staff.'**
  String noticeReinforcement(String company);

  /// No description provided for @companyNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Off: nothing rings on this phone, but everything stays in the bell.'**
  String get companyNotificationsHint;

  /// No description provided for @companyNotificationsOn.
  ///
  /// In en, this message translates to:
  /// **'Get notifications from this company'**
  String get companyNotificationsOn;

  /// No description provided for @companyTimezone.
  ///
  /// In en, this message translates to:
  /// **'Company time zone'**
  String get companyTimezone;

  /// No description provided for @companyTimezoneHint.
  ///
  /// In en, this message translates to:
  /// **'All of this company\'s times are in this time zone (daylight saving included). Calendars convert them automatically.'**
  String get companyTimezoneHint;

  /// No description provided for @iosInstallHint.
  ///
  /// In en, this message translates to:
  /// **'On iPhone: tap Share, then “Add to Home Screen” to install Staff Flow.'**
  String get iosInstallHint;

  /// No description provided for @searchCity.
  ///
  /// In en, this message translates to:
  /// **'Search for a city'**
  String get searchCity;

  /// No description provided for @thisPhone.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get thisPhone;

  /// No description provided for @companyNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications: {name}'**
  String companyNotifications(String name);

  /// No description provided for @timezoneDiffers.
  ///
  /// In en, this message translates to:
  /// **'Times are in {zone} time ({company}). Your device: {here}.'**
  String timezoneDiffers(String zone, String company, String here);

  /// No description provided for @addPreset.
  ///
  /// In en, this message translates to:
  /// **'Add preset'**
  String get addPreset;

  /// No description provided for @addPresets.
  ///
  /// In en, this message translates to:
  /// **'Create presets'**
  String get addPresets;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @chooseLogo.
  ///
  /// In en, this message translates to:
  /// **'Choose a PNG image'**
  String get chooseLogo;

  /// No description provided for @customization.
  ///
  /// In en, this message translates to:
  /// **'Customization'**
  String get customization;

  /// No description provided for @editPresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get editPresets;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Turn back on'**
  String get enable;

  /// No description provided for @logoHint.
  ///
  /// In en, this message translates to:
  /// **'A small PNG image (your logo) shown on the company tab, for all its members.'**
  String get logoHint;

  /// No description provided for @logoPngOnly.
  ///
  /// In en, this message translates to:
  /// **'Choose a PNG image of 1 MB or less.'**
  String get logoPngOnly;

  /// No description provided for @myIdentifier.
  ///
  /// In en, this message translates to:
  /// **'My identifier'**
  String get myIdentifier;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfile;

  /// No description provided for @presetName.
  ///
  /// In en, this message translates to:
  /// **'Name (e.g. Morning)'**
  String get presetName;

  /// No description provided for @removeLogo.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get removeLogo;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @shiftPresets.
  ///
  /// In en, this message translates to:
  /// **'Shift presets'**
  String get shiftPresets;

  /// No description provided for @shiftPresetsHint.
  ///
  /// In en, this message translates to:
  /// **'Ready-made times (morning, evening, night…): one tap in a shift fills in the start and end.'**
  String get shiftPresetsHint;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @awaitingApproval.
  ///
  /// In en, this message translates to:
  /// **'To approve'**
  String get awaitingApproval;

  /// No description provided for @placementNeedsApproval.
  ///
  /// In en, this message translates to:
  /// **'! This person isn\'t on your sites: the shift will wait for approval from your superior or the owner before it can be published. Otherwise, pick someone else.'**
  String get placementNeedsApproval;

  /// No description provided for @placementAwaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for approval from a superior or the owner.'**
  String get placementAwaiting;

  /// No description provided for @noticePlacementToApprove.
  ///
  /// In en, this message translates to:
  /// **'{by} wants to schedule {name}, from another site, on {date}: approval needed.'**
  String noticePlacementToApprove(String by, String name, String date);

  /// No description provided for @noticePlacementApproved.
  ///
  /// In en, this message translates to:
  /// **'{by} approved scheduling {name} on {date}.'**
  String noticePlacementApproved(String by, String name, String date);

  /// No description provided for @noticePlacementRefused.
  ///
  /// In en, this message translates to:
  /// **'{by} refused scheduling {name} on {date}.'**
  String noticePlacementRefused(String by, String name, String date);

  /// No description provided for @addSubSite.
  ///
  /// In en, this message translates to:
  /// **'Add a sub-site'**
  String get addSubSite;

  /// No description provided for @moveSite.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get moveSite;

  /// No description provided for @topLevel.
  ///
  /// In en, this message translates to:
  /// **'Top level'**
  String get topLevel;

  /// No description provided for @moveSiteTitle.
  ///
  /// In en, this message translates to:
  /// **'Move “{name}” under…'**
  String moveSiteTitle(String name);

  /// No description provided for @subSiteOf.
  ///
  /// In en, this message translates to:
  /// **'Sub-site of {name}'**
  String subSiteOf(String name);

  /// No description provided for @siteTreeHint.
  ///
  /// In en, this message translates to:
  /// **'Up to 10 levels, for example Region › City › Shop. The first 3 are included in the subscription; beyond that, you need the “nested sites” option. A site\'s manager also manages everything below it.'**
  String get siteTreeHint;

  /// No description provided for @subSitesOnlyHint.
  ///
  /// In en, this message translates to:
  /// **'Here you add sub-sites under your own sites.'**
  String get subSitesOnlyHint;

  /// No description provided for @messagingSetting.
  ///
  /// In en, this message translates to:
  /// **'News feed'**
  String get messagingSetting;

  /// No description provided for @messagingSettingHint.
  ///
  /// In en, this message translates to:
  /// **'On: the owner and managers post announcements (for everyone, a position, a site or chosen people); everyone reads them and can translate them. Off: the tab disappears for everyone.'**
  String get messagingSettingHint;

  /// No description provided for @billingTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get billingTitle;

  /// No description provided for @billingStatusTrial.
  ///
  /// In en, this message translates to:
  /// **'Free trial until {date}'**
  String billingStatusTrial(String date);

  /// No description provided for @billingStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Paid until {date}'**
  String billingStatusActive(String date);

  /// No description provided for @billingStatusGrace.
  ///
  /// In en, this message translates to:
  /// **'Read-only: without payment, the company will be deleted on {date}.'**
  String billingStatusGrace(String date);

  /// No description provided for @billingStatusComped.
  ///
  /// In en, this message translates to:
  /// **'Complimentary'**
  String get billingStatusComped;

  /// No description provided for @billingStaff.
  ///
  /// In en, this message translates to:
  /// **'{count} employees counted (owner and temps not included)'**
  String billingStaff(String count);

  /// No description provided for @billingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billingMonthly;

  /// No description provided for @billingYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly ({months} months billed)'**
  String billingYearly(String months);

  /// No description provided for @billingCascade.
  ///
  /// In en, this message translates to:
  /// **'“Nested sites” option (levels 4 to 10)'**
  String get billingCascade;

  /// No description provided for @billingCascadeIncluded.
  ///
  /// In en, this message translates to:
  /// **'Included from {count} employees'**
  String billingCascadeIncluded(String count);

  /// No description provided for @billingPay.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount}'**
  String billingPay(String amount);

  /// No description provided for @billingTestNotice.
  ///
  /// In en, this message translates to:
  /// **'Test payment: nothing is charged.'**
  String get billingTestNotice;

  /// No description provided for @billingSoon.
  ///
  /// In en, this message translates to:
  /// **'Online payment is coming soon.'**
  String get billingSoon;

  /// No description provided for @billingPaidOk.
  ///
  /// In en, this message translates to:
  /// **'Payment recorded.'**
  String get billingPaidOk;

  /// No description provided for @billingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get billingInvoices;

  /// No description provided for @billingNoInvoices.
  ///
  /// In en, this message translates to:
  /// **'No invoices yet.'**
  String get billingNoInvoices;

  /// No description provided for @billingManage.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get billingManage;

  /// No description provided for @billingReadOnlyStaff.
  ///
  /// In en, this message translates to:
  /// **'This company is read-only until the owner renews the subscription.'**
  String get billingReadOnlyStaff;

  /// No description provided for @billingPerMonth.
  ///
  /// In en, this message translates to:
  /// **'{amount} / month'**
  String billingPerMonth(String amount);

  /// No description provided for @billingPerYear.
  ///
  /// In en, this message translates to:
  /// **'{amount} / year'**
  String billingPerYear(String amount);

  /// No description provided for @noticeBillingTrialEnding.
  ///
  /// In en, this message translates to:
  /// **'{company}: the free trial ends in less than 24 hours.'**
  String noticeBillingTrialEnding(String company);

  /// No description provided for @noticeBillingGrace.
  ///
  /// In en, this message translates to:
  /// **'{company} is read-only for non-payment; deletion on {date}.'**
  String noticeBillingGrace(String company, String date);

  /// No description provided for @noticeBillingGraceReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder: without payment, {company} will be deleted on {date}.'**
  String noticeBillingGraceReminder(String company, String date);

  /// No description provided for @noticeBillingDeleted.
  ///
  /// In en, this message translates to:
  /// **'{company} was deleted for non-payment.'**
  String noticeBillingDeleted(String company);

  /// No description provided for @billingCompanyId.
  ///
  /// In en, this message translates to:
  /// **'Company ID: {id}'**
  String billingCompanyId(String id);

  /// No description provided for @billingDueToday.
  ///
  /// In en, this message translates to:
  /// **'Today: {amount}'**
  String billingDueToday(String amount);

  /// No description provided for @billingProrataNote.
  ///
  /// In en, this message translates to:
  /// **'Includes the rest of this month ({days} days, prorated), then whole months from the 1st.'**
  String billingProrataNote(String days);

  /// No description provided for @telegramTitle.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegramTitle;

  /// No description provided for @telegramNotLinked.
  ///
  /// In en, this message translates to:
  /// **'Not linked yet. It is used to verify your identity, for example to change Google account.'**
  String get telegramNotLinked;

  /// No description provided for @telegramLinked.
  ///
  /// In en, this message translates to:
  /// **'Linked: {name}'**
  String telegramLinked(String name);

  /// No description provided for @telegramNoUsername.
  ///
  /// In en, this message translates to:
  /// **'no username'**
  String get telegramNoUsername;

  /// No description provided for @telegramLink.
  ///
  /// In en, this message translates to:
  /// **'Link my Telegram'**
  String get telegramLink;

  /// No description provided for @telegramLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Telegram opens: tap “Start”, then come back here.'**
  String get telegramLinkHint;

  /// No description provided for @telegramUnlink.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get telegramUnlink;

  /// No description provided for @telegramUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Telegram is not available yet.'**
  String get telegramUnavailable;

  /// No description provided for @telegramShowIn.
  ///
  /// In en, this message translates to:
  /// **'Show my Telegram in:'**
  String get telegramShowIn;

  /// No description provided for @newQrCode.
  ///
  /// In en, this message translates to:
  /// **'Change QR code'**
  String get newQrCode;

  /// No description provided for @newQrCodeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Your old QR code and old ID will stop working. Your place in your companies does not change.'**
  String get newQrCodeConfirm;

  /// No description provided for @newQrCodeDone.
  ///
  /// In en, this message translates to:
  /// **'New QR code created.'**
  String get newQrCodeDone;

  /// No description provided for @changeGoogle.
  ///
  /// In en, this message translates to:
  /// **'Change Google account'**
  String get changeGoogle;

  /// No description provided for @changeGoogleSub.
  ///
  /// In en, this message translates to:
  /// **'Same account, same number, same companies'**
  String get changeGoogleSub;

  /// No description provided for @changeGoogleSteps.
  ///
  /// In en, this message translates to:
  /// **'1. Link your Telegram in this profile (required).\n2. Sign out, then sign in with the new Google account.\n3. Choose “I already have a Staff Flow account” and enter your ID {id}.\n4. Enter the code received on Telegram.\nYour account, number and companies stay the same.'**
  String changeGoogleSteps(String id);

  /// No description provided for @recoverAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have a Staff Flow account'**
  String get recoverAccount;

  /// No description provided for @recoverHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the ID of your old account (SF-…). A code will be sent to the Telegram linked to that account.'**
  String get recoverHint;

  /// No description provided for @recoverIdLabel.
  ///
  /// In en, this message translates to:
  /// **'ID (SF-…)'**
  String get recoverIdLabel;

  /// No description provided for @recoverSend.
  ///
  /// In en, this message translates to:
  /// **'Send the code'**
  String get recoverSend;

  /// No description provided for @recoverCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Code sent on Telegram.'**
  String get recoverCodeSent;

  /// No description provided for @recoverCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Code received (6 digits)'**
  String get recoverCodeLabel;

  /// No description provided for @recoverConfirm.
  ///
  /// In en, this message translates to:
  /// **'Recover my account'**
  String get recoverConfirm;

  /// No description provided for @recoverDone.
  ///
  /// In en, this message translates to:
  /// **'Done: you are back in your account.'**
  String get recoverDone;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export my data'**
  String get exportData;

  /// No description provided for @exportDataSub.
  ///
  /// In en, this message translates to:
  /// **'A file with all your personal data'**
  String get exportDataSub;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteAccount;

  /// No description provided for @deleteGhost.
  ///
  /// In en, this message translates to:
  /// **'Delete but keep a ghost'**
  String get deleteGhost;

  /// No description provided for @deleteGhostHint.
  ///
  /// In en, this message translates to:
  /// **'You leave all your companies. Sign in later with the same Google account to get your account and number back.'**
  String get deleteGhostHint;

  /// No description provided for @deleteErase.
  ///
  /// In en, this message translates to:
  /// **'Erase everything permanently'**
  String get deleteErase;

  /// No description provided for @deleteEraseHint.
  ///
  /// In en, this message translates to:
  /// **'Name, email, photo, Telegram, messages and notifications are erased. This cannot be undone.'**
  String get deleteEraseHint;

  /// No description provided for @deleteGhostNote.
  ///
  /// In en, this message translates to:
  /// **'Either way, company history keeps an anonymous “Ghost” in your place (leave requests, past shifts…) so the owner and managers can trace what happened.'**
  String get deleteGhostNote;

  /// No description provided for @deleteOwnerNote.
  ///
  /// In en, this message translates to:
  /// **'Own a company? Transfer it first, or let its subscription end.'**
  String get deleteOwnerNote;

  /// No description provided for @deleteConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteConfirmButton;

  /// No description provided for @accountRestored.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Your account has been reactivated.'**
  String get accountRestored;

  /// No description provided for @closedInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices of closed companies'**
  String get closedInvoices;

  /// No description provided for @downloadAllInvoices.
  ///
  /// In en, this message translates to:
  /// **'Download all invoices (ZIP)'**
  String get downloadAllInvoices;

  /// No description provided for @legalTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use and sale'**
  String get legalTerms;

  /// No description provided for @legalPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get legalPrivacy;

  /// No description provided for @billingDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment details'**
  String get billingDetailTitle;

  /// No description provided for @billingLineProrata.
  ///
  /// In en, this message translates to:
  /// **'Rest of this month ({days} days out of {total}): subscription'**
  String billingLineProrata(String days, String total);

  /// No description provided for @billingLineCascadeProrata.
  ///
  /// In en, this message translates to:
  /// **'Rest of this month ({days} days out of {total}): “nested sites” option'**
  String billingLineCascadeProrata(String days, String total);

  /// No description provided for @billingLineMonth.
  ///
  /// In en, this message translates to:
  /// **'Subscription, {staff} employees: 1 month'**
  String billingLineMonth(String staff);

  /// No description provided for @billingLineYear.
  ///
  /// In en, this message translates to:
  /// **'Subscription, {staff} employees: 12 months for the price of {paid}'**
  String billingLineYear(String staff, String paid);

  /// No description provided for @billingLineCascade.
  ///
  /// In en, this message translates to:
  /// **'“Nested sites” option: {months} months, no discount'**
  String billingLineCascade(String months);

  /// No description provided for @billingTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get billingTotal;

  /// No description provided for @billingCovers.
  ///
  /// In en, this message translates to:
  /// **'Period covered: {from} to {to}'**
  String billingCovers(String from, String to);

  /// No description provided for @billingGraceInvoices.
  ///
  /// In en, this message translates to:
  /// **'This company is not being renewed: download all its invoices now.'**
  String get billingGraceInvoices;

  /// No description provided for @billingYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get billingYearLabel;

  /// No description provided for @sitesNoneChosen.
  ///
  /// In en, this message translates to:
  /// **'No site chosen'**
  String get sitesNoneChosen;

  /// No description provided for @avatarTitle.
  ///
  /// In en, this message translates to:
  /// **'My avatar'**
  String get avatarTitle;

  /// No description provided for @avatarSub.
  ///
  /// In en, this message translates to:
  /// **'A picture instead of your photo'**
  String get avatarSub;

  /// No description provided for @avatarUseGoogle.
  ///
  /// In en, this message translates to:
  /// **'Use my Google photo'**
  String get avatarUseGoogle;

  /// No description provided for @avatarColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get avatarColor;

  /// No description provided for @hidePhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Hide Google photos'**
  String get hidePhotosTitle;

  /// No description provided for @hidePhotosSub.
  ///
  /// In en, this message translates to:
  /// **'In this company, everyone appears with their avatar or initial.'**
  String get hidePhotosSub;

  /// No description provided for @billingApi.
  ///
  /// In en, this message translates to:
  /// **'“API access” option'**
  String get billingApi;

  /// No description provided for @billingLineApi.
  ///
  /// In en, this message translates to:
  /// **'“API access” option: {months} months, no discount'**
  String billingLineApi(String months);

  /// No description provided for @billingLineApiProrata.
  ///
  /// In en, this message translates to:
  /// **'Rest of this month ({days} days out of {total}): “API access” option'**
  String billingLineApiProrata(String days, String total);

  /// No description provided for @apiTitle.
  ///
  /// In en, this message translates to:
  /// **'API access (accounting, CRM)'**
  String get apiTitle;

  /// No description provided for @apiSub.
  ///
  /// In en, this message translates to:
  /// **'Your accounting, payroll or CRM software reads the published schedule, hours and absences.'**
  String get apiSub;

  /// No description provided for @apiNeedsOption.
  ///
  /// In en, this message translates to:
  /// **'Paid option: add “API access” in “Manage subscription”.'**
  String get apiNeedsOption;

  /// No description provided for @apiNewKey.
  ///
  /// In en, this message translates to:
  /// **'New key'**
  String get apiNewKey;

  /// No description provided for @apiKeyName.
  ///
  /// In en, this message translates to:
  /// **'Key name (e.g. payroll software)'**
  String get apiKeyName;

  /// No description provided for @apiKeyCreated.
  ///
  /// In en, this message translates to:
  /// **'Copy this key now and keep it safe: it will not be shown again.'**
  String get apiKeyCreated;

  /// No description provided for @apiKeyCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get apiKeyCopy;

  /// No description provided for @apiKeyCopied.
  ///
  /// In en, this message translates to:
  /// **'Key copied.'**
  String get apiKeyCopied;

  /// No description provided for @apiKeyLastUsed.
  ///
  /// In en, this message translates to:
  /// **'Last used: {date}'**
  String apiKeyLastUsed(String date);

  /// No description provided for @apiKeyNeverUsed.
  ///
  /// In en, this message translates to:
  /// **'Never used'**
  String get apiKeyNeverUsed;

  /// No description provided for @apiRevoke.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get apiRevoke;

  /// No description provided for @apiRevokeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Software using this key will lose access.'**
  String get apiRevokeConfirm;

  /// No description provided for @apiDocs.
  ///
  /// In en, this message translates to:
  /// **'API documentation'**
  String get apiDocs;

  /// No description provided for @memberGoogleLink.
  ///
  /// In en, this message translates to:
  /// **'Employee Google reconnection'**
  String get memberGoogleLink;

  /// No description provided for @googleLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Send this link to {name}. It opens in a browser (not in the Android app), once, for 24 hours: {name} signs in with their new Google account and gets their account back. All their other devices are then signed out.'**
  String googleLinkHint(String name);

  /// No description provided for @googleLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied.'**
  String get googleLinkCopied;

  /// No description provided for @switchBanner.
  ///
  /// In en, this message translates to:
  /// **'Google account change link: sign in with your new Google account to get your Staff Flow account back.'**
  String get switchBanner;

  /// No description provided for @switchSignOutFirst.
  ///
  /// In en, this message translates to:
  /// **'This link attaches a Staff Flow account to a new Google account. Sign out first, then sign in with the new Google account.'**
  String get switchSignOutFirst;

  /// No description provided for @switchDone.
  ///
  /// In en, this message translates to:
  /// **'Done: your Staff Flow account is linked to this Google account. Your other devices have been signed out.'**
  String get switchDone;

  /// No description provided for @changeGoogleBot.
  ///
  /// In en, this message translates to:
  /// **'The easiest way: in Telegram, send /changegoogle to the bot {bot} and follow its instructions, then sign in with the new Google account within 10 minutes.'**
  String changeGoogleBot(String bot);

  /// No description provided for @changeGoogleNoTelegram.
  ///
  /// In en, this message translates to:
  /// **'Without Telegram: ask your owner or a manager for a Google account change link.'**
  String get changeGoogleNoTelegram;

  /// No description provided for @noticeGoogleSwitchLink.
  ///
  /// In en, this message translates to:
  /// **'{name} created a link to attach your account to a new Google account. If you did not ask for this, tell your manager.'**
  String noticeGoogleSwitchLink(String name);

  /// No description provided for @sessionRevoked.
  ///
  /// In en, this message translates to:
  /// **'You have been signed out: your account is now linked to another Google account.'**
  String get sessionRevoked;

  /// No description provided for @telegramLoginHint.
  ///
  /// In en, this message translates to:
  /// **'Tip: send /connexion to the bot {bot} to get a link and open Staff Flow in a browser, without the app or a Google account.'**
  String telegramLoginHint(String bot);

  /// No description provided for @timeFormat.
  ///
  /// In en, this message translates to:
  /// **'Time format'**
  String get timeFormat;

  /// No description provided for @timeFormatAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get timeFormatAuto;

  /// No description provided for @people.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people;

  /// No description provided for @sortNatural.
  ///
  /// In en, this message translates to:
  /// **'Default order'**
  String get sortNatural;

  /// No description provided for @sortName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get sortName;

  /// No description provided for @employeeNumber.
  ///
  /// In en, this message translates to:
  /// **'Employee number'**
  String get employeeNumber;

  /// No description provided for @sfIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Staff Flow ID'**
  String get sfIdLabel;

  /// No description provided for @pickSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get pickSearch;

  /// No description provided for @pickSearchPeople.
  ///
  /// In en, this message translates to:
  /// **'Search: name, employee number, SF ID'**
  String get pickSearchPeople;

  /// No description provided for @pickSortTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort and show by'**
  String get pickSortTitle;

  /// No description provided for @pickSelected.
  ///
  /// In en, this message translates to:
  /// **'Checked: {count}'**
  String pickSelected(String count);

  /// No description provided for @pickCheckAll.
  ///
  /// In en, this message translates to:
  /// **'Check all'**
  String get pickCheckAll;

  /// No description provided for @pickClear.
  ///
  /// In en, this message translates to:
  /// **'Uncheck all'**
  String get pickClear;

  /// No description provided for @pickNoResult.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get pickNoResult;

  /// No description provided for @pickMultiHint.
  ///
  /// In en, this message translates to:
  /// **'Check several people: a shift will be created for each of them, all at once.'**
  String get pickMultiHint;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterValue.
  ///
  /// In en, this message translates to:
  /// **'{label}: {value}'**
  String filterValue(String label, String value);

  /// No description provided for @noPositionGroup.
  ///
  /// In en, this message translates to:
  /// **'No position'**
  String get noPositionGroup;

  /// No description provided for @noSiteGroup.
  ///
  /// In en, this message translates to:
  /// **'No site'**
  String get noSiteGroup;

  /// No description provided for @groupByTitle.
  ///
  /// In en, this message translates to:
  /// **'Group by'**
  String get groupByTitle;

  /// No description provided for @groupRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get groupRole;

  /// No description provided for @groupNone.
  ///
  /// In en, this message translates to:
  /// **'No grouping'**
  String get groupNone;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show {count} more ({left} left)'**
  String showMore(String count, String left);

  /// No description provided for @findByQr.
  ///
  /// In en, this message translates to:
  /// **'Find a member with their QR code'**
  String get findByQr;

  /// No description provided for @qrNotMember.
  ///
  /// In en, this message translates to:
  /// **'This QR code doesn\'t match anyone in this company.'**
  String get qrNotMember;

  /// No description provided for @memberProfile.
  ///
  /// In en, this message translates to:
  /// **'Employee number and position'**
  String get memberProfile;

  /// No description provided for @employeeNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Your company\'s own number (optional). The Staff Flow ID stays assigned.'**
  String get employeeNumberHint;

  /// No description provided for @usualPosition.
  ///
  /// In en, this message translates to:
  /// **'Usual position'**
  String get usualPosition;

  /// No description provided for @inviteCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Invitation code'**
  String get inviteCodeTitle;

  /// No description provided for @inviteCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the code you received from your employer, or scan the QR code of your invitation.'**
  String get inviteCodeHint;

  /// No description provided for @inviteJoined.
  ///
  /// In en, this message translates to:
  /// **'You joined {company}.'**
  String inviteJoined(String company);

  /// No description provided for @importTitle.
  ///
  /// In en, this message translates to:
  /// **'Import employees'**
  String get importTitle;

  /// No description provided for @importIntro.
  ///
  /// In en, this message translates to:
  /// **'Import your list of employees from an Excel or CSV file. Each one gets an invitation: with their Google e-mail, they see it as soon as they sign in; otherwise, give them their code or QR code. Nobody is added without their consent.'**
  String get importIntro;

  /// No description provided for @importTemplate.
  ///
  /// In en, this message translates to:
  /// **'Download the Excel template'**
  String get importTemplate;

  /// No description provided for @importTemplateHint.
  ///
  /// In en, this message translates to:
  /// **'Columns: name, Google e-mail, employee number, position, site. Only the name is required.'**
  String get importTemplateHint;

  /// No description provided for @importChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose a file (.xlsx or .csv)'**
  String get importChooseFile;

  /// No description provided for @importNew.
  ///
  /// In en, this message translates to:
  /// **'New: {count}'**
  String importNew(String count);

  /// No description provided for @importUpdate.
  ///
  /// In en, this message translates to:
  /// **'Updated: {count}'**
  String importUpdate(String count);

  /// No description provided for @importSkip.
  ///
  /// In en, this message translates to:
  /// **'Already invited: {count}'**
  String importSkip(String count);

  /// No description provided for @importErrors.
  ///
  /// In en, this message translates to:
  /// **'Errors: {count}'**
  String importErrors(String count);

  /// No description provided for @importConfirm.
  ///
  /// In en, this message translates to:
  /// **'Import ({count})'**
  String importConfirm(String count);

  /// No description provided for @importErrorsIgnored.
  ///
  /// In en, this message translates to:
  /// **'Rows with errors will be skipped: fix them in the file and import it again.'**
  String get importErrorsIgnored;

  /// No description provided for @importCreated.
  ///
  /// In en, this message translates to:
  /// **'new'**
  String get importCreated;

  /// No description provided for @importDone.
  ///
  /// In en, this message translates to:
  /// **'Invitations created: {count}'**
  String importDone(String count);

  /// No description provided for @invitesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending invitations'**
  String get invitesTitle;

  /// No description provided for @invitesPrint.
  ///
  /// In en, this message translates to:
  /// **'Print the codes'**
  String get invitesPrint;

  /// No description provided for @inviteShowHint.
  ///
  /// In en, this message translates to:
  /// **'The person scans this QR code or enters this code in Staff Flow (account menu, “I have an invitation code”). Valid for 90 days, once.'**
  String get inviteShowHint;

  /// No description provided for @invitesHint.
  ///
  /// In en, this message translates to:
  /// **'Pending invitations: {count}. Tap a person to show their code and QR code, or print them all.'**
  String invitesHint(String count);

  /// No description provided for @inviteSeenByEmail.
  ///
  /// In en, this message translates to:
  /// **'invitation seen (e-mail)'**
  String get inviteSeenByEmail;

  /// No description provided for @invitesNone.
  ///
  /// In en, this message translates to:
  /// **'No pending invitations.'**
  String get invitesNone;

  /// No description provided for @haveInviteCode.
  ///
  /// In en, this message translates to:
  /// **'I have an invitation code'**
  String get haveInviteCode;

  /// No description provided for @newsTab.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get newsTab;

  /// No description provided for @newsNew.
  ///
  /// In en, this message translates to:
  /// **'New announcement'**
  String get newsNew;

  /// No description provided for @newsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No announcements yet.'**
  String get newsEmpty;

  /// No description provided for @newsEmptyManager.
  ///
  /// In en, this message translates to:
  /// **'No announcements yet. Post the first one: for the whole company, a position, a site or chosen people.'**
  String get newsEmptyManager;

  /// No description provided for @newsOlder.
  ///
  /// In en, this message translates to:
  /// **'Older announcements'**
  String get newsOlder;

  /// No description provided for @newsEdited.
  ///
  /// In en, this message translates to:
  /// **'edited'**
  String get newsEdited;

  /// No description provided for @newsEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit the announcement'**
  String get newsEdit;

  /// No description provided for @newsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove this announcement?'**
  String get newsDeleteTitle;

  /// No description provided for @newsForEveryone.
  ///
  /// In en, this message translates to:
  /// **'For everyone'**
  String get newsForEveryone;

  /// No description provided for @newsEveryoneMySites.
  ///
  /// In en, this message translates to:
  /// **'Everyone in my sites'**
  String get newsEveryoneMySites;

  /// No description provided for @newsFor.
  ///
  /// In en, this message translates to:
  /// **'For: {names}'**
  String newsFor(String names);

  /// No description provided for @newsReadCount.
  ///
  /// In en, this message translates to:
  /// **'Read by {count}'**
  String newsReadCount(String count);

  /// No description provided for @newsReadOf.
  ///
  /// In en, this message translates to:
  /// **'Read by {count} of {total}'**
  String newsReadOf(String count, String total);

  /// No description provided for @newsTranslated.
  ///
  /// In en, this message translates to:
  /// **'Automatically translated'**
  String get newsTranslated;

  /// No description provided for @newsTitleField.
  ///
  /// In en, this message translates to:
  /// **'Title (optional)'**
  String get newsTitleField;

  /// No description provided for @newsBodyField.
  ///
  /// In en, this message translates to:
  /// **'Announcement text'**
  String get newsBodyField;

  /// No description provided for @newsRecipients.
  ///
  /// In en, this message translates to:
  /// **'Recipients'**
  String get newsRecipients;

  /// No description provided for @newsTargetHint.
  ///
  /// In en, this message translates to:
  /// **'Check one or more groups: the announcement goes to everyone who matches any of them.'**
  String get newsTargetHint;

  /// No description provided for @newsPublish.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get newsPublish;

  /// No description provided for @newsSent.
  ///
  /// In en, this message translates to:
  /// **'Announcement sent to {count} person(s).'**
  String newsSent(String count);

  /// No description provided for @billingLineApiAddon.
  ///
  /// In en, this message translates to:
  /// **'“API access” option, added during the subscription, from {from} to {to}: {months} months, no discount'**
  String billingLineApiAddon(String from, String to, String months);

  /// No description provided for @billingLineCascadeAddon.
  ///
  /// In en, this message translates to:
  /// **'“Nested sites” option, added during the subscription, from {from} to {to}: {months} months, no discount'**
  String billingLineCascadeAddon(String from, String to, String months);

  /// No description provided for @billingRenewalOptions.
  ///
  /// In en, this message translates to:
  /// **'Checked options will be included in your next renewals. An unchecked option stays active until the end of the period already paid.'**
  String get billingRenewalOptions;

  /// No description provided for @billingAddonTitle.
  ///
  /// In en, this message translates to:
  /// **'Add now: {option}'**
  String billingAddonTitle(String option);

  /// No description provided for @billingAddonHint.
  ///
  /// In en, this message translates to:
  /// **'The whole current month, then each month until {date} (end of the paid period), no discount. The option is active as soon as you pay and is included in the next renewals.'**
  String billingAddonHint(String date);

  /// No description provided for @billingAddonInvoice.
  ///
  /// In en, this message translates to:
  /// **'option'**
  String get billingAddonInvoice;

  /// No description provided for @billingAccessRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} no longer manages the subscription.'**
  String billingAccessRemoved(String name);

  /// No description provided for @billingAccessGiven.
  ///
  /// In en, this message translates to:
  /// **'{name} can now manage the subscription and invoices.'**
  String billingAccessGiven(String name);

  /// No description provided for @actionBillingRemove.
  ///
  /// In en, this message translates to:
  /// **'Stop managing the subscription'**
  String get actionBillingRemove;

  /// No description provided for @actionBillingGive.
  ///
  /// In en, this message translates to:
  /// **'Allow to manage the subscription'**
  String get actionBillingGive;

  /// No description provided for @billingAccessTag.
  ///
  /// In en, this message translates to:
  /// **'Manages the subscription'**
  String get billingAccessTag;

  /// No description provided for @billingOptionRenewed.
  ///
  /// In en, this message translates to:
  /// **'Option renewal resumed.'**
  String get billingOptionRenewed;

  /// No description provided for @billingOptionStopped.
  ///
  /// In en, this message translates to:
  /// **'Option not renewed: it stays active until the end of the paid period.'**
  String get billingOptionStopped;

  /// No description provided for @billingOptionEnds.
  ///
  /// In en, this message translates to:
  /// **'Active until {date}, won\'t be renewed (check to keep it)'**
  String billingOptionEnds(String date);

  /// No description provided for @billingOptionActive.
  ///
  /// In en, this message translates to:
  /// **'Active and renewed (uncheck to stop renewing it)'**
  String get billingOptionActive;

  /// No description provided for @statusCancelRequested.
  ///
  /// In en, this message translates to:
  /// **'Cancellation requested'**
  String get statusCancelRequested;

  /// No description provided for @requestEndedEarly.
  ///
  /// In en, this message translates to:
  /// **'Ended early by the person.'**
  String get requestEndedEarly;

  /// No description provided for @confirmCancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel this request? Managers will no longer see it.'**
  String get confirmCancelRequest;

  /// No description provided for @endUnavailability.
  ///
  /// In en, this message translates to:
  /// **'End my unavailability'**
  String get endUnavailability;

  /// No description provided for @confirmEndUnavailability.
  ///
  /// In en, this message translates to:
  /// **'End your unavailability? You will be available again from today, and managers will be notified.'**
  String get confirmEndUnavailability;

  /// No description provided for @askLeaveCancel.
  ///
  /// In en, this message translates to:
  /// **'Ask to cancel this leave'**
  String get askLeaveCancel;

  /// No description provided for @confirmAskLeaveCancel.
  ///
  /// In en, this message translates to:
  /// **'Ask to cancel this leave? A manager will have to approve it; until then, the leave stays planned.'**
  String get confirmAskLeaveCancel;

  /// No description provided for @refuseLeaveCancel.
  ///
  /// In en, this message translates to:
  /// **'Refuse the cancellation'**
  String get refuseLeaveCancel;

  /// No description provided for @acceptLeaveCancel.
  ///
  /// In en, this message translates to:
  /// **'Accept the cancellation'**
  String get acceptLeaveCancel;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pl',
    'pt',
    'ro',
    'ru',
    'uk',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'GB':
            return L10nEnGb();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return L10nDe();
    case 'en':
      return L10nEn();
    case 'es':
      return L10nEs();
    case 'fr':
      return L10nFr();
    case 'it':
      return L10nIt();
    case 'pl':
      return L10nPl();
    case 'pt':
      return L10nPt();
    case 'ro':
      return L10nRo();
    case 'ru':
      return L10nRu();
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
