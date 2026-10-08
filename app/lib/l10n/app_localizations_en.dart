// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get confirm => 'Confirm';

  @override
  String get validate => 'Confirm';

  @override
  String get add => 'Add';

  @override
  String get rename => 'Rename';

  @override
  String get delete => 'Delete';

  @override
  String get accept => 'Accept';

  @override
  String get decline => 'Decline';

  @override
  String get close => 'Close';

  @override
  String get retry => 'Try again';

  @override
  String get name => 'Name';

  @override
  String get serverUnreachable => 'Cannot reach the server.';

  @override
  String errorStatus(int status) {
    return 'Error $status';
  }

  @override
  String get roleOwner => 'Owner';

  @override
  String get roleManager => 'Manager';

  @override
  String get roleEmployee => 'Employee';

  @override
  String get roleExtra => 'Extra';

  @override
  String get taglineStart => 'Your team\'s schedules, ';

  @override
  String get taglineEnd => 'everywhere.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google sign-in unavailable: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google sign-in failed: $detail';
  }

  @override
  String get newCompany => 'New company';

  @override
  String get timezone => 'Time zone';

  @override
  String get create => 'Create';

  @override
  String get noCompanyTitle => 'You are not part of any company yet.';

  @override
  String get noCompanyHint =>
      'To join your employer\'s, generate a code and give it to your manager.';

  @override
  String get joinCompany => 'Join a company';

  @override
  String get createCompany => 'Create a company';

  @override
  String transferOffer(String company) {
    return 'You are invited to become the owner of “$company”.';
  }

  @override
  String get someCompany => 'a company';

  @override
  String get becameOwner => 'You are now the owner.';

  @override
  String get myAccount => 'My account';

  @override
  String get idCopied => 'ID copied.';

  @override
  String myId(String id) {
    return 'My ID: $id';
  }

  @override
  String get signOut => 'Sign out';

  @override
  String joinInvite(String company, String role) {
    return '“$company” invites you as $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'You joined $company.';
  }

  @override
  String get viewPlanning => 'Schedule';

  @override
  String get viewTeam => 'Team';

  @override
  String get viewPositions => 'Positions';

  @override
  String get readOnlyCompany => 'This company is read-only.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Leave this company';

  @override
  String meSuffix(String name) {
    return '$name (you)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Transfer the company to $name?';
  }

  @override
  String get transferConfirmBody =>
      'Once they accept, they will become the owner (subscription, invoices, managers) and you will become a manager.';

  @override
  String transferSent(String name) {
    return 'Offer sent to $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get removeConfirmBody => 'Their history is kept.';

  @override
  String get addPersonTitle => 'Add a person';

  @override
  String get addPersonHint =>
      'Ask them to open Staff Flow, then their account menu, “Join a company”, and enter the code they see.';

  @override
  String get sixDigitCode => '6-digit code';

  @override
  String invitationSent(String name) {
    return 'Invitation sent to $name: they need to accept it.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Leave $company?';
  }

  @override
  String get leaveConfirmBody => 'You will no longer see its schedule.';

  @override
  String get renameCompany => 'Rename the company';

  @override
  String get actionMakeManager => 'Make manager';

  @override
  String get actionMakeEmployee => 'Make employee again';

  @override
  String get actionToEmployee => 'Make employee';

  @override
  String get actionToExtra => 'Make extra';

  @override
  String get actionTransfer => 'Transfer ownership';

  @override
  String get actionRemove => 'Remove from the company';

  @override
  String get positions => 'Positions';

  @override
  String get sites => 'Sites';

  @override
  String get positionsHint =>
      'What the person does: checkout, kitchen, reception…';

  @override
  String get sitesHint =>
      'Where the shift takes place, if the company has several locations.';

  @override
  String get archived => 'Archived';

  @override
  String get archive => 'Archive';

  @override
  String get reactivate => 'Reactivate';

  @override
  String weekOf(String date) {
    return 'Week of $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count changes published.',
      one: '1 change published.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Shift';

  @override
  String get display => 'View';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get today => 'Today';

  @override
  String get onlyMine => 'Only my shifts';

  @override
  String get replacePersonMenu => 'Replace a person…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unpublished changes',
      one: '1 unpublished change',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Employees can\'t see them yet.';

  @override
  String get publish => 'Publish';

  @override
  String yourHours(String duration) {
    return 'Your hours for this period: $duration';
  }

  @override
  String get addShiftThisDay => 'Add a shift on this day';

  @override
  String get noShift => 'No shifts';

  @override
  String get unassigned => 'Unassigned';

  @override
  String get formerMember => 'Former member';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusModified => 'Changed';

  @override
  String get statusDeleted => 'Deleted';

  @override
  String durationHours(int hours) {
    return '${hours}h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '${hours}h$minutes';
  }

  @override
  String get editShift => 'Edit shift';

  @override
  String get newShift => 'New shift';

  @override
  String get thisShift => 'This shift';

  @override
  String get thisAndFollowing => 'This and following';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Days',
      one: 'Day',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Another day';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get endsNextDay => 'Ends the next day.';

  @override
  String get person => 'Person';

  @override
  String get position => 'Position';

  @override
  String get site => 'Site';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get repetition => 'Repeat';

  @override
  String get repeatNone => 'None';

  @override
  String get repeatDaily => 'Every day';

  @override
  String get repeatWeekly => 'Every week';

  @override
  String get repeatForPrefix => 'For ';

  @override
  String get repeatDaysSuffix => ' days';

  @override
  String get repeatWeeksSuffix => ' weeks';

  @override
  String get repeatUntilPrefix => 'Until ';

  @override
  String get replacePersonTitle => 'Replace a person';

  @override
  String get replaceFrom => 'Replace';

  @override
  String get replaceBy => 'With';

  @override
  String dateRange(String from, String to) {
    return 'From $from to $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shifts changed.',
      one: '1 shift changed.',
      zero: 'No shifts changed.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Replace';

  @override
  String get joinHint =>
      'Give this code to your manager. They enter it in their app, then you receive an invitation to accept.';

  @override
  String get codeExpired => 'Code expired.';

  @override
  String codeValidFor(String time) {
    return 'Valid for $time';
  }

  @override
  String get newCode => 'New code';
}
