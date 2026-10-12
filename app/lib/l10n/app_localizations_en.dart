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
  String get viewTeam => 'Management';

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

  @override
  String get language => 'Language';

  @override
  String get languageAuto => 'Automatic (device language)';

  @override
  String get syncUpToDate => 'Up to date';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Pending changes: $count';
  }

  @override
  String get syncNow => 'Sync now';

  @override
  String syncRejected(String reason) {
    return 'Change refused by the server: $reason';
  }

  @override
  String get pendingBadge => 'Pending';

  @override
  String get offlineUnavailable => 'Unavailable offline.';

  @override
  String get offlineCached => 'Offline: showing the last saved data.';

  @override
  String get savedOffline =>
      'Saved on this device, will be sent when the network is back.';

  @override
  String get notices => 'Notices';

  @override
  String get noNotices => 'No notices.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name replaced your change to the shift on $date.';
  }

  @override
  String get history => 'History';

  @override
  String get recentChanges => 'Recent changes';

  @override
  String get undoChange => 'Undo this change';

  @override
  String get undoDone => 'Change undone.';

  @override
  String get historyCreate => 'Created';

  @override
  String get historyUpdate => 'Changed';

  @override
  String get historyDelete => 'Deleted';

  @override
  String get historyUndo => 'Undone';

  @override
  String get noHistory => 'No changes.';

  @override
  String get pendingNotEditable =>
      'This shift is not synced yet: try again once online.';

  @override
  String get myQrCode => 'My QR code';

  @override
  String get myQrCodeHint =>
      'A manager scans this code to add you to their company; you then confirm. It never changes.';

  @override
  String get changeMyName => 'Change my name';

  @override
  String get nameShownToTeam =>
      'This name is shown to your colleagues instead of your Google name.';

  @override
  String googleName(String name) {
    return 'Google name: $name';
  }

  @override
  String get useGoogleName => 'Use my Google name';

  @override
  String renameMemberTitle(String name) {
    return 'Rename $name';
  }

  @override
  String get renameMemberHint => 'This name is only used in this company.';

  @override
  String get useOwnName => 'Use their own name';

  @override
  String get scanQrCode => 'Scan a QR code';

  @override
  String get scanQrHint =>
      'Point the camera at the QR code shown in their app (account menu, “My QR code”).';

  @override
  String get orEnterCode => 'Or enter their 6-digit code';

  @override
  String get qrInvalid => 'This is not a Staff Flow QR code.';

  @override
  String cameraUnavailable(String error) {
    return 'Camera unavailable ($error).';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notifChooseHint =>
      'Choose what you are notified about. Everything stays visible in the bell.';

  @override
  String get notifPlanning => 'Schedule published or changed';

  @override
  String get notifRequests => 'Requests: swaps, leave, invitations';

  @override
  String get notifMessages => 'New messages';

  @override
  String get notifOverlap => 'Overlapping shifts between companies';

  @override
  String get notifConflicts => 'Your changes replaced by another manager';

  @override
  String get notifBilling => 'Subscription reminders';

  @override
  String get pushEnabled => 'Notifications are on for this device.';

  @override
  String get pushOff => 'Notifications are off on this device.';

  @override
  String get pushBlocked =>
      'Notifications are blocked: allow them in your phone or browser settings.';

  @override
  String get pushUnavailable =>
      'Notifications are not available on this device.';

  @override
  String get enablePush => 'Turn on';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: your schedule has been published or changed.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company wants to add you to its team.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name offers to make you the owner of $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name joined $company.';
  }

  @override
  String get messagesTab => 'Messages';

  @override
  String get wholeTeam => 'Whole team';

  @override
  String get newConversation => 'New conversation';

  @override
  String get noMessages => 'No messages yet.';

  @override
  String get messageHint => 'Write a message';

  @override
  String get earlierMessages => 'Earlier messages';

  @override
  String get personLeftCompany =>
      'This person is no longer part of the company.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'New group';

  @override
  String get editGroup => 'Edit group';

  @override
  String get groupName => 'Group name';

  @override
  String get groupMembersHint =>
      'Choose the people in this group. Only they will see its messages.';

  @override
  String get chooseAtLeastOne => 'Choose at least one person.';

  @override
  String get replyAction => 'Reply';

  @override
  String get translateAction => 'Translate';

  @override
  String replyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Last messages from $name';
  }

  @override
  String get deleteAllNotices => 'Delete all';

  @override
  String get deleteAllNoticesConfirm => 'Delete all notices?';

  @override
  String get noticeRetention => 'Delete read notices after';

  @override
  String get retentionDay => '1 day';

  @override
  String get retentionWeek => '1 week';

  @override
  String get retentionMonth => '1 month';

  @override
  String get billingOwnersOnly => 'Only active when you own a company.';

  @override
  String get readOnlyPastDays => 'Days more than a month old are read-only.';

  @override
  String get wholeCompany => 'Whole company';

  @override
  String get sitesLabel => 'Sites';

  @override
  String get actionSites => 'Sites…';

  @override
  String managerOf(String name) {
    return '$name manages';
  }

  @override
  String teamSitesOf(String name) {
    return '$name\'s team';
  }

  @override
  String get notYourSite => 'This site is not under your responsibility.';

  @override
  String get chooseYourSite => 'Choose at least one site.';

  @override
  String get viewRequests => 'Requests';

  @override
  String get newRequest => 'New request';

  @override
  String get requestLeave => 'Leave';

  @override
  String get requestUnavailability => 'Unavailability';

  @override
  String get requestSwap => 'Shift swap';

  @override
  String get swapHint =>
      'To offer a swap, tap one of your upcoming shifts in the schedule.';

  @override
  String get noRequests => 'No requests yet.';

  @override
  String get requestsToHandle => 'To handle';

  @override
  String get myRequests => 'My requests';

  @override
  String get otherRequests => 'Team requests';

  @override
  String get statusPendingPeer => 'Waiting for the colleague';

  @override
  String get statusPendingManager => 'Waiting for a manager';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusRefused => 'Refused';

  @override
  String get statusCancelled => 'Canceled';

  @override
  String get cancelRequest => 'Cancel request';

  @override
  String get acceptSwap => 'Take this shift';

  @override
  String get approve => 'Approve';

  @override
  String periodLabel(String from, String to) {
    return 'From $from to $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Offered to $name';
  }

  @override
  String get swapToTeam => 'Whole team';

  @override
  String everyWeekdays(String days) {
    return 'Every week: $days';
  }

  @override
  String get unavailableEveryWeek => 'Days you are never available:';

  @override
  String get choosePeriod => 'Choose dates';

  @override
  String get choosePeriodOptional => 'Limit to a period (optional)';

  @override
  String get clearPeriod => 'No period';

  @override
  String get sendRequest => 'Send request';

  @override
  String get proposeSwap => 'Offer a swap';

  @override
  String get swapWith => 'Offer to';

  @override
  String get swapSteps =>
      'The colleague accepts, then a manager approves. The schedule only changes after that.';

  @override
  String get absentThatDay => 'Approved absence that day';

  @override
  String get requestSent => 'Request sent.';

  @override
  String noticeSwapOffer(String name) {
    return '$name offers you one of their shifts.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name declined your swap offer.';
  }

  @override
  String get noticeSwapToApprove =>
      'A shift swap is waiting for your approval.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name is asking for leave.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name reports being unavailable.';
  }

  @override
  String get noticeRequestApproved => 'Your request has been approved.';

  @override
  String get noticeRequestRefused => 'Your request has been refused.';

  @override
  String get choosePeer => 'Who takes over this shift?';

  @override
  String get discardAll => 'Discard all';

  @override
  String get notifySitesHint =>
      'Choose the sites you get request notifications for. All requests stay visible in the list.';

  @override
  String get notifySitesTitle => 'Notifications by site';

  @override
  String get pendingRequestTooltip => 'Pending request: tap to open it';

  @override
  String get requestsHistory => 'All requests';

  @override
  String get revertChange => 'Undo this change';

  @override
  String get statusExpired => 'No longer applies';

  @override
  String get swapWithHint => 'Tap to choose a specific colleague';

  @override
  String changesDiscarded(String count) {
    return 'Changes discarded: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Discard the $count unpublished changes?';
  }

  @override
  String get allSchedules => 'All my schedules';

  @override
  String get busyElsewhere => 'Already working at another company at this time';

  @override
  String get overlapTooltip => 'Overlaps a shift at another company';

  @override
  String get overlapWarning => 'Some of your shifts at two companies overlap.';

  @override
  String noticeOverlap(String date) {
    return 'Two of your shifts at different companies overlap on $date.';
  }

  @override
  String get allMyCompanies => 'All my companies';

  @override
  String get deleteGroup => 'Delete group';

  @override
  String get openRequest => 'View request';

  @override
  String get thisCompany => 'This company';

  @override
  String get withExtras => 'Include extras';

  @override
  String deleteGroupConfirm(String name) {
    return 'Delete “$name” and all its messages for everyone?';
  }

  @override
  String reinforcementHint(String company) {
    return 'From $company: will be added as backup staff and notified.';
  }

  @override
  String get addToGoogle => 'Add to Google Calendar';

  @override
  String get calendarEnabled => 'Sync my shifts';

  @override
  String get calendarHint =>
      'Add your shifts from all your companies to Google Calendar. They update on their own, and you can turn this off at any time.';

  @override
  String get changeSettings => 'Edit';

  @override
  String get copyCalendarLink => 'Copy calendar link';

  @override
  String get countryBelgium => 'Belgium';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'France';

  @override
  String get countrySwitzerland => 'Switzerland';

  @override
  String get employeesSection => 'Employees';

  @override
  String get emptyNoAlert => 'Empty: no alert';

  @override
  String get extrasSection => 'Extras';

  @override
  String get googleCalendar => 'Google Calendar';

  @override
  String get hoursTotals => 'Hour totals';

  @override
  String get legalAlerts => 'Legal alerts';

  @override
  String get legalAlertsHint =>
      'Warnings, never blocks. Choose the rules that apply to you, or none.';

  @override
  String get legalPreset => 'Country template';

  @override
  String get linkCopied => 'Link copied.';

  @override
  String get maxConsecutiveLabel => 'Maximum consecutive working days';

  @override
  String get maxDayLabel => 'Maximum hours per day';

  @override
  String get maxWeekLabel => 'Maximum hours per week';

  @override
  String get minRestLabel => 'Minimum rest between shifts (hours)';

  @override
  String get noLegalRules => 'No alerts chosen.';

  @override
  String get presetNone => 'None';

  @override
  String get presetsCheck =>
      'Templates are starting points: check them against your country\'s rules and your collective agreement.';

  @override
  String get printMine => 'My schedule';

  @override
  String get printOwn => 'Their own schedule only';

  @override
  String get printPdf => 'Print / PDF';

  @override
  String get printRights => 'What employees can print';

  @override
  String get printTeam => 'The whole team\'s schedule';

  @override
  String get printTeamOption => 'The team\'s schedule';

  @override
  String get totalsHint =>
      'Drafts included. Excel and CSV exports use the published schedule.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value days in a row (maximum $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value in the day (maximum $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: only $value of rest (minimum $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value in the week (maximum $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Legal alerts: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Shifts: $count';
  }

  @override
  String get actionMakeDeputy => 'Appoint as deputy manager';

  @override
  String get actionRemoveDeputy => 'Remove deputy manager role';

  @override
  String get busyHere => 'Already working at this company at this time';

  @override
  String get calendarByLink => 'By link (Google Calendar on a computer)';

  @override
  String get calendarDenied =>
      'Calendar access denied. Allow it in the phone settings.';

  @override
  String get calendarLinkHint =>
      'Add it from Google Calendar on a computer; Google updates it within a few hours.';

  @override
  String get calendarNone => 'No editable calendar on this phone.';

  @override
  String get calendarOnPhone => 'Add my shifts to the phone calendar';

  @override
  String get calendarOnPhoneHint =>
      'In your Google calendar: visible right away, on the phone and in Google Calendar.';

  @override
  String get chooseCalendar => 'Choose the calendar';

  @override
  String get otherSiteHint =>
      'Employee from another site: their managers will be notified.';

  @override
  String get subManager => 'Deputy manager';

  @override
  String calendarSynced(String count) {
    return 'Shifts in the calendar: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Deputy manager: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by scheduled $name at $site on $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company added you as backup staff.';
  }

  @override
  String get companyNotificationsHint =>
      'Off: nothing rings on this phone, but everything stays in the bell.';

  @override
  String get companyNotificationsOn => 'Get notifications from this company';

  @override
  String get companyTimezone => 'Company time zone';

  @override
  String get companyTimezoneHint =>
      'All of this company\'s times are in this time zone (daylight saving included). Calendars convert them automatically.';

  @override
  String get iosInstallHint =>
      'On iPhone: tap Share, then “Add to Home Screen” to install Staff Flow.';

  @override
  String get searchCity => 'Search for a city';

  @override
  String get thisPhone => 'This device';

  @override
  String companyNotifications(String name) {
    return 'Notifications: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Times are in $zone time ($company). Your device: $here.';
  }

  @override
  String get addPreset => 'Add preset';

  @override
  String get addPresets => 'Create presets';

  @override
  String get appearance => 'Appearance';

  @override
  String get chooseLogo => 'Choose a PNG image';

  @override
  String get conversationMuted => 'Notifications muted for this conversation.';

  @override
  String get conversationUnmuted =>
      'Notifications back on for this conversation.';

  @override
  String get customization => 'Customization';

  @override
  String get disableGroup => 'Turn off the group';

  @override
  String get disableGroupConfirm =>
      'The whole-company group will be hidden for everyone. You can turn it back on in Messages.';

  @override
  String get editPresets => 'Presets';

  @override
  String get enable => 'Turn back on';

  @override
  String get groupDisabled => 'Group turned off (only you can see it)';

  @override
  String get logoHint =>
      'A small PNG image (your logo) shown on the company tab, for all its members.';

  @override
  String get logoPngOnly => 'Choose a PNG image of 1 MB or less.';

  @override
  String get muteConversation => 'Mute this conversation';

  @override
  String get myIdentifier => 'My identifier';

  @override
  String get myProfile => 'My profile';

  @override
  String get presetName => 'Name (e.g. Morning)';

  @override
  String get removeLogo => 'Remove image';

  @override
  String get resetGroup => 'Reset the group';

  @override
  String get resetGroupConfirm =>
      'All messages in the company group will be deleted for everyone.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get shiftPresets => 'Shift presets';

  @override
  String get shiftPresetsHint =>
      'Ready-made times (morning, evening, night…): one tap in a shift fills in the start and end.';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get unmuteConversation => 'Unmute this conversation';

  @override
  String get awaitingApproval => 'To approve';

  @override
  String get placementNeedsApproval =>
      '! This person isn\'t on your sites: the shift will wait for approval from your superior or the owner before it can be published. Otherwise, pick someone else.';

  @override
  String get placementAwaiting =>
      'Waiting for approval from a superior or the owner.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by wants to schedule $name, from another site, on $date: approval needed.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by approved scheduling $name on $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by refused scheduling $name on $date.';
  }

  @override
  String get addSubSite => 'Add a sub-site';

  @override
  String get moveSite => 'Move';

  @override
  String get topLevel => 'Top level';

  @override
  String moveSiteTitle(String name) {
    return 'Move “$name” under…';
  }

  @override
  String subSiteOf(String name) {
    return 'Sub-site of $name';
  }

  @override
  String get siteTreeHint =>
      'Up to 3 levels, e.g. Region › City › Store. A manager of a site also manages everything below it.';

  @override
  String get subSitesOnlyHint => 'Here you add sub-sites under your own sites.';

  @override
  String get messagingSetting => 'Company messaging';

  @override
  String get messagingSettingHint =>
      'On: the team has a Messages tab. Off: nobody sees it or can write (old messages are kept).';

  @override
  String get billingTitle => 'Subscription';

  @override
  String billingStatusTrial(String date) {
    return 'Free trial until $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Paid until $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Read-only: without payment, the company will be deleted on $date.';
  }

  @override
  String get billingStatusComped => 'Complimentary';

  @override
  String billingStaff(String count) {
    return '$count employees counted (owner and temps not included)';
  }

  @override
  String get billingMonthly => 'Monthly';

  @override
  String billingYearly(String months) {
    return 'Yearly ($months months billed)';
  }

  @override
  String get billingCascade => '“Nested sites” option';

  @override
  String billingCascadeIncluded(String count) {
    return 'Included from $count employees';
  }

  @override
  String billingPay(String amount) {
    return 'Pay $amount';
  }

  @override
  String get billingTestNotice => 'Test payment: nothing is charged.';

  @override
  String get billingSoon => 'Online payment is coming soon.';

  @override
  String get billingPaidOk => 'Payment recorded.';

  @override
  String get billingInvoices => 'Invoices';

  @override
  String get billingNoInvoices => 'No invoices yet.';

  @override
  String get billingManage => 'Manage subscription';

  @override
  String get billingReadOnlyStaff =>
      'This company is read-only until the owner renews the subscription.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / month';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / year';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: the free trial ends in less than 24 hours.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company is read-only for non-payment; deletion on $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Reminder: without payment, $company will be deleted on $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company was deleted for non-payment.';
  }

  @override
  String billingCompanyId(String id) {
    return 'Company ID: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Today: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Includes the rest of this month ($days days, prorated), then whole months from the 1st.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Not linked yet. It is used to verify your identity, for example to change Google account.';

  @override
  String telegramLinked(String name) {
    return 'Linked: $name';
  }

  @override
  String get telegramNoUsername => 'no username';

  @override
  String get telegramLink => 'Link my Telegram';

  @override
  String get telegramLinkHint =>
      'Telegram opens: tap “Start”, then come back here.';

  @override
  String get telegramUnlink => 'Unlink';

  @override
  String get telegramUnavailable => 'Telegram is not available yet.';

  @override
  String get telegramShowIn => 'Show my Telegram in:';

  @override
  String get newQrCode => 'Change QR code';

  @override
  String get newQrCodeConfirm =>
      'Your old QR code and old ID will stop working. Your place in your companies does not change.';

  @override
  String get newQrCodeDone => 'New QR code created.';

  @override
  String get changeGoogle => 'Change Google account';

  @override
  String get changeGoogleSub => 'Same account, same number, same companies';

  @override
  String changeGoogleSteps(String id) {
    return '1. Link your Telegram in this profile (required).\n2. Sign out, then sign in with the new Google account.\n3. Choose “I already have a Staff Flow account” and enter your ID $id.\n4. Enter the code received on Telegram.\nYour account, number and companies stay the same.';
  }

  @override
  String get recoverAccount => 'I already have a Staff Flow account';

  @override
  String get recoverHint =>
      'Enter the ID of your old account (SF-…). A code will be sent to the Telegram linked to that account.';

  @override
  String get recoverIdLabel => 'ID (SF-…)';

  @override
  String get recoverSend => 'Send the code';

  @override
  String get recoverCodeSent => 'Code sent on Telegram.';

  @override
  String get recoverCodeLabel => 'Code received (6 digits)';

  @override
  String get recoverConfirm => 'Recover my account';

  @override
  String get recoverDone => 'Done: you are back in your account.';

  @override
  String get exportData => 'Export my data';

  @override
  String get exportDataSub => 'A file with all your personal data';

  @override
  String get deleteAccount => 'Delete my account';

  @override
  String get deleteGhost => 'Delete but keep a ghost';

  @override
  String get deleteGhostHint =>
      'You leave all your companies. Sign in later with the same Google account to get your account and number back.';

  @override
  String get deleteErase => 'Erase everything permanently';

  @override
  String get deleteEraseHint =>
      'Name, email, photo, Telegram, messages and notifications are erased. This cannot be undone.';

  @override
  String get deleteGhostNote =>
      'Either way, company history keeps an anonymous “Ghost” in your place (leave requests, past shifts…) so the owner and managers can trace what happened.';

  @override
  String get deleteOwnerNote =>
      'Own a company? Transfer it first, or let its subscription end.';

  @override
  String get deleteConfirmButton => 'Delete';

  @override
  String get accountRestored =>
      'Welcome back! Your account has been reactivated.';

  @override
  String get closedInvoices => 'Invoices of closed companies';

  @override
  String get downloadAllInvoices => 'Download all invoices (ZIP)';

  @override
  String get legalTerms => 'Terms of use and sale';

  @override
  String get legalPrivacy => 'Privacy policy';

  @override
  String get billingDetailTitle => 'Payment details';

  @override
  String billingLineProrata(String days, String total) {
    return 'Rest of this month ($days days out of $total): subscription';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Rest of this month ($days days out of $total): “nested sites” option';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Subscription, $staff employees: 1 month';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Subscription, $staff employees: 12 months for the price of $paid';
  }

  @override
  String billingLineCascade(String months) {
    return '“Nested sites” option: $months months, no discount';
  }

  @override
  String get billingTotal => 'Total';

  @override
  String billingCovers(String from, String to) {
    return 'Period covered: $from to $to';
  }

  @override
  String get billingGraceInvoices =>
      'This company is not being renewed: download all its invoices now.';

  @override
  String get billingYearLabel => 'Year';

  @override
  String get sitesNoneChosen => 'No site chosen';

  @override
  String get avatarTitle => 'My avatar';

  @override
  String get avatarSub => 'A picture instead of your photo';

  @override
  String get avatarUseGoogle => 'Use my Google photo';

  @override
  String get avatarColor => 'Color';

  @override
  String get hidePhotosTitle => 'Hide Google photos';

  @override
  String get hidePhotosSub =>
      'In this company, everyone appears with their avatar or initial.';

  @override
  String get billingApi => '“API access” option';

  @override
  String billingLineApi(String months) {
    return '“API access” option: $months months, no discount';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Rest of this month ($days days out of $total): “API access” option';
  }

  @override
  String get apiTitle => 'API access (accounting, CRM)';

  @override
  String get apiSub =>
      'Your accounting, payroll or CRM software reads the published schedule, hours and absences.';

  @override
  String get apiNeedsOption =>
      'Paid option: add “API access” in “Manage subscription”.';

  @override
  String get apiNewKey => 'New key';

  @override
  String get apiKeyName => 'Key name (e.g. payroll software)';

  @override
  String get apiKeyCreated =>
      'Copy this key now and keep it safe: it will not be shown again.';

  @override
  String get apiKeyCopy => 'Copy';

  @override
  String get apiKeyCopied => 'Key copied.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Last used: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Never used';

  @override
  String get apiRevoke => 'Revoke';

  @override
  String get apiRevokeConfirm => 'Software using this key will lose access.';

  @override
  String get apiDocs => 'API documentation';

  @override
  String get memberGoogleLink => 'Employee Google reconnection';

  @override
  String googleLinkHint(String name) {
    return 'Send this link to $name. It opens in a browser (not in the Android app), once, for 24 hours: $name signs in with their new Google account and gets their account back. All their other devices are then signed out.';
  }

  @override
  String get googleLinkCopied => 'Link copied.';

  @override
  String get switchBanner =>
      'Google account change link: sign in with your new Google account to get your Staff Flow account back.';

  @override
  String get switchSignOutFirst =>
      'This link attaches a Staff Flow account to a new Google account. Sign out first, then sign in with the new Google account.';

  @override
  String get switchDone =>
      'Done: your Staff Flow account is linked to this Google account. Your other devices have been signed out.';

  @override
  String changeGoogleBot(String bot) {
    return 'The easiest way: in Telegram, send /changegoogle to the bot $bot and follow its instructions, then sign in with the new Google account within 10 minutes.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Without Telegram: ask your owner or a manager for a Google account change link.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name created a link to attach your account to a new Google account. If you did not ask for this, tell your manager.';
  }

  @override
  String get sessionRevoked =>
      'You have been signed out: your account is now linked to another Google account.';

  @override
  String telegramLoginHint(String bot) {
    return 'Tip: send /connexion to the bot $bot to get a link and open Staff Flow in a browser, without the app or a Google account.';
  }

  @override
  String get timeFormat => 'Time format';

  @override
  String get timeFormatAuto => 'Auto';

  @override
  String get people => 'People';

  @override
  String get sortNatural => 'Default order';

  @override
  String get sortName => 'Name';

  @override
  String get employeeNumber => 'Employee number';

  @override
  String get sfIdLabel => 'Staff Flow ID';

  @override
  String get pickSearch => 'Search';

  @override
  String get pickSearchPeople => 'Search: name, employee number, SF ID';

  @override
  String get pickSortTitle => 'Sort and show by';

  @override
  String pickSelected(String count) {
    return 'Checked: $count';
  }

  @override
  String get pickCheckAll => 'Check all';

  @override
  String get pickClear => 'Uncheck all';

  @override
  String get pickNoResult => 'No results';

  @override
  String get pickMultiHint =>
      'Check several people: a shift will be created for each of them, all at once.';

  @override
  String get filterAll => 'All';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'No position';

  @override
  String get noSiteGroup => 'No site';

  @override
  String get groupByTitle => 'Group by';

  @override
  String get groupRole => 'Role';

  @override
  String get groupNone => 'No grouping';

  @override
  String showMore(String count, String left) {
    return 'Show $count more ($left left)';
  }

  @override
  String get findByQr => 'Find a member with their QR code';

  @override
  String get qrNotMember =>
      'This QR code doesn\'t match anyone in this company.';

  @override
  String get memberProfile => 'Employee number and position';

  @override
  String get employeeNumberHint =>
      'Your company\'s own number (optional). The Staff Flow ID stays assigned.';

  @override
  String get usualPosition => 'Usual position';

  @override
  String get inviteCodeTitle => 'Invitation code';

  @override
  String get inviteCodeHint =>
      'Enter the code you received from your employer, or scan the QR code of your invitation.';

  @override
  String inviteJoined(String company) {
    return 'You joined $company.';
  }

  @override
  String get importTitle => 'Import employees';

  @override
  String get importIntro =>
      'Import your list of employees from an Excel or CSV file. Each one gets an invitation: with their Google e-mail, they see it as soon as they sign in; otherwise, give them their code or QR code. Nobody is added without their consent.';

  @override
  String get importTemplate => 'Download the Excel template';

  @override
  String get importTemplateHint =>
      'Columns: name, Google e-mail, employee number, position, site. Only the name is required.';

  @override
  String get importChooseFile => 'Choose a file (.xlsx or .csv)';

  @override
  String importNew(String count) {
    return 'New: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Updated: $count';
  }

  @override
  String importSkip(String count) {
    return 'Already invited: $count';
  }

  @override
  String importErrors(String count) {
    return 'Errors: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Import ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Rows with errors will be skipped: fix them in the file and import it again.';

  @override
  String get importCreated => 'created';

  @override
  String importDone(String count) {
    return 'Invitations created: $count';
  }

  @override
  String get invitesTitle => 'Pending invitations';

  @override
  String get invitesPrint => 'Print the codes';

  @override
  String get inviteShowHint =>
      'The person scans this QR code or enters this code in Staff Flow (account menu, “I have an invitation code”). Valid for 90 days, once.';

  @override
  String invitesHint(String count) {
    return 'Pending invitations: $count. Tap a person to show their code and QR code, or print them all.';
  }

  @override
  String get inviteSeenByEmail => 'invitation seen (e-mail)';

  @override
  String get invitesNone => 'No pending invitations.';

  @override
  String get haveInviteCode => 'I have an invitation code';
}

/// The translations for English, as used in the United Kingdom (`en_GB`).
class L10nEnGb extends L10nEn {
  L10nEnGb() : super('en_GB');

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get customization => 'Customisation';

  @override
  String get avatarColor => 'Colour';
}
