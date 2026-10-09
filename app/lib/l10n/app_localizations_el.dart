// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class L10nEl extends L10n {
  L10nEl([String locale = 'el']) : super(locale);

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get confirm => 'Επιβεβαίωση';

  @override
  String get validate => 'Επιβεβαίωση';

  @override
  String get add => 'Προσθήκη';

  @override
  String get rename => 'Μετονομασία';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get accept => 'Αποδοχή';

  @override
  String get decline => 'Απόρριψη';

  @override
  String get close => 'Κλείσιμο';

  @override
  String get retry => 'Δοκιμάστε ξανά';

  @override
  String get name => 'Όνομα';

  @override
  String get serverUnreachable => 'Δεν υπάρχει σύνδεση με τον διακομιστή.';

  @override
  String errorStatus(int status) {
    return 'Σφάλμα $status';
  }

  @override
  String get roleOwner => 'Ιδιοκτήτης';

  @override
  String get roleManager => 'Υπεύθυνος';

  @override
  String get roleEmployee => 'Εργαζόμενος';

  @override
  String get roleExtra => 'Έκτακτος';

  @override
  String get taglineStart => 'Τα προγράμματα της ομάδας σας, ';

  @override
  String get taglineEnd => 'παντού.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Σύνδεση με Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Η σύνδεση με Google δεν είναι διαθέσιμη: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Η σύνδεση με Google απέτυχε: $detail';
  }

  @override
  String get newCompany => 'Νέα επιχείρηση';

  @override
  String get timezone => 'Ζώνη ώρας';

  @override
  String get create => 'Δημιουργία';

  @override
  String get noCompanyTitle => 'Δεν ανήκετε ακόμη σε καμία επιχείρηση.';

  @override
  String get noCompanyHint =>
      'Για να μπείτε στην επιχείρηση του εργοδότη σας, δημιουργήστε έναν κωδικό και δώστε τον στον υπεύθυνό σας.';

  @override
  String get joinCompany => 'Συμμετοχή σε επιχείρηση';

  @override
  String get createCompany => 'Δημιουργία επιχείρησης';

  @override
  String transferOffer(String company) {
    return 'Σας προτείνεται να γίνετε ιδιοκτήτης της «$company».';
  }

  @override
  String get someCompany => 'μιας επιχείρησης';

  @override
  String get becameOwner => 'Είστε πλέον ο ιδιοκτήτης.';

  @override
  String get myAccount => 'Ο λογαριασμός μου';

  @override
  String get idCopied => 'Το αναγνωριστικό αντιγράφηκε.';

  @override
  String myId(String id) {
    return 'Το αναγνωριστικό μου: $id';
  }

  @override
  String get signOut => 'Αποσύνδεση';

  @override
  String joinInvite(String company, String role) {
    return 'Η «$company» σας προσκαλεί ως $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Μπήκατε στην $company.';
  }

  @override
  String get viewPlanning => 'Πρόγραμμα';

  @override
  String get viewTeam => 'Ομάδα';

  @override
  String get viewPositions => 'Θέσεις';

  @override
  String get readOnlyCompany => 'Επιχείρηση μόνο για ανάγνωση.';

  @override
  String get team => 'Ομάδα';

  @override
  String get leaveCompany => 'Αποχώρηση από την επιχείρηση';

  @override
  String meSuffix(String name) {
    return '$name (εσείς)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Μεταβίβαση της επιχείρησης σε $name;';
  }

  @override
  String get transferConfirmBody =>
      'Μόλις αποδεχτεί, θα γίνει ιδιοκτήτης (συνδρομή, τιμολόγια, υπεύθυνοι) και εσείς θα γίνετε υπεύθυνος.';

  @override
  String transferSent(String name) {
    return 'Η πρόταση στάλθηκε σε $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Αφαίρεση: $name;';
  }

  @override
  String get removeConfirmBody => 'Το ιστορικό διατηρείται.';

  @override
  String get addPersonTitle => 'Προσθήκη ατόμου';

  @override
  String get addPersonHint =>
      'Ζητήστε να ανοίξει το Staff Flow, το μενού λογαριασμού, «Συμμετοχή σε επιχείρηση», και εισαγάγετε τον κωδικό που εμφανίζεται.';

  @override
  String get sixDigitCode => 'Εξαψήφιος κωδικός';

  @override
  String invitationSent(String name) {
    return 'Η πρόσκληση στάλθηκε σε $name: πρέπει να την αποδεχτεί.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Αποχώρηση από $company;';
  }

  @override
  String get leaveConfirmBody => 'Δεν θα βλέπετε πλέον το πρόγραμμά της.';

  @override
  String get renameCompany => 'Μετονομασία επιχείρησης';

  @override
  String get actionMakeManager => 'Ορισμός ως υπεύθυνου';

  @override
  String get actionMakeEmployee => 'Επαναφορά σε εργαζόμενο';

  @override
  String get actionToEmployee => 'Ορισμός ως εργαζόμενου';

  @override
  String get actionToExtra => 'Ορισμός ως έκτακτου';

  @override
  String get actionTransfer => 'Μεταβίβαση ιδιοκτησίας';

  @override
  String get actionRemove => 'Αφαίρεση από την επιχείρηση';

  @override
  String get positions => 'Θέσεις';

  @override
  String get sites => 'Τοποθεσίες';

  @override
  String get positionsHint => 'Τι κάνει το άτομο: ταμείο, κουζίνα, υποδοχή…';

  @override
  String get sitesHint =>
      'Πού γίνεται η βάρδια, αν η επιχείρηση έχει πολλές τοποθεσίες.';

  @override
  String get archived => 'Αρχειοθετημένο';

  @override
  String get archive => 'Αρχειοθέτηση';

  @override
  String get reactivate => 'Επανενεργοποίηση';

  @override
  String weekOf(String date) {
    return 'Εβδομάδα $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Δημοσιεύτηκαν $count αλλαγές.',
      one: 'Δημοσιεύτηκε 1 αλλαγή.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Βάρδια';

  @override
  String get display => 'Προβολή';

  @override
  String get week => 'Εβδομάδα';

  @override
  String get month => 'Μήνας';

  @override
  String get today => 'Σήμερα';

  @override
  String get onlyMine => 'Μόνο οι βάρδιές μου';

  @override
  String get replacePersonMenu => 'Αντικατάσταση ατόμου…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count μη δημοσιευμένες αλλαγές',
      one: '1 μη δημοσιευμένη αλλαγή',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Οι εργαζόμενοι δεν τις βλέπουν ακόμη.';

  @override
  String get publish => 'Δημοσίευση';

  @override
  String yourHours(String duration) {
    return 'Οι ώρες σας στην περίοδο: $duration';
  }

  @override
  String get addShiftThisDay => 'Προσθήκη βάρδιας αυτήν την ημέρα';

  @override
  String get noShift => 'Καμία βάρδια';

  @override
  String get unassigned => 'Χωρίς ανάθεση';

  @override
  String get formerMember => 'Πρώην μέλος';

  @override
  String get statusDraft => 'Πρόχειρο';

  @override
  String get statusModified => 'Τροποποιήθηκε';

  @override
  String get statusDeleted => 'Διαγράφηκε';

  @override
  String durationHours(int hours) {
    return '$hours ώρ.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ώρ. $minutes λ.';
  }

  @override
  String get editShift => 'Επεξεργασία βάρδιας';

  @override
  String get newShift => 'Νέα βάρδια';

  @override
  String get thisShift => 'Μόνο αυτή η βάρδια';

  @override
  String get thisAndFollowing => 'Αυτή και οι επόμενες';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ημέρες',
      one: 'Ημέρα',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Άλλη ημέρα';

  @override
  String get start => 'Έναρξη';

  @override
  String get end => 'Λήξη';

  @override
  String get endsNextDay => 'Λήγει την επόμενη ημέρα.';

  @override
  String get person => 'Άτομο';

  @override
  String get position => 'Θέση';

  @override
  String get site => 'Τοποθεσία';

  @override
  String get noteOptional => 'Σημείωση (προαιρετική)';

  @override
  String get repetition => 'Επανάληψη';

  @override
  String get repeatNone => 'Καμία';

  @override
  String get repeatDaily => 'Κάθε ημέρα';

  @override
  String get repeatWeekly => 'Κάθε εβδομάδα';

  @override
  String get repeatForPrefix => 'Για ';

  @override
  String get repeatDaysSuffix => ' ημέρες';

  @override
  String get repeatWeeksSuffix => ' εβδομάδες';

  @override
  String get repeatUntilPrefix => 'Έως ';

  @override
  String get replacePersonTitle => 'Αντικατάσταση ατόμου';

  @override
  String get replaceFrom => 'Αντικατάσταση';

  @override
  String get replaceBy => 'Με';

  @override
  String dateRange(String from, String to) {
    return 'Από $from έως $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Άλλαξαν $count βάρδιες.',
      one: 'Άλλαξε 1 βάρδια.',
      zero: 'Καμία βάρδια δεν άλλαξε.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Αντικατάσταση';

  @override
  String get joinHint =>
      'Δώστε αυτόν τον κωδικό στον υπεύθυνό σας. Μόλις τον εισαγάγει στην εφαρμογή, θα λάβετε πρόσκληση.';

  @override
  String get codeExpired => 'Ο κωδικός έληξε.';

  @override
  String codeValidFor(String time) {
    return 'Ισχύει για ακόμη $time';
  }

  @override
  String get newCode => 'Νέος κωδικός';

  @override
  String get language => 'Γλώσσα';

  @override
  String get languageAuto => 'Αυτόματα (γλώσσα συσκευής)';

  @override
  String get syncUpToDate => 'Ενημερωμένο';

  @override
  String get syncOffline => 'Εκτός σύνδεσης';

  @override
  String syncPending(int count) {
    return 'Αλλαγές σε αναμονή: $count';
  }

  @override
  String get syncNow => 'Συγχρονισμός τώρα';

  @override
  String syncRejected(String reason) {
    return 'Ο διακομιστής απέρριψε την αλλαγή: $reason';
  }

  @override
  String get pendingBadge => 'Σε αναμονή';

  @override
  String get offlineUnavailable => 'Μη διαθέσιμο εκτός σύνδεσης.';

  @override
  String get offlineCached =>
      'Εκτός σύνδεσης: τελευταία αποθηκευμένα δεδομένα.';

  @override
  String get savedOffline =>
      'Αποθηκεύτηκε στη συσκευή, θα σταλεί μόλις επανέλθει το δίκτυο.';

  @override
  String get notices => 'Ειδοποιήσεις';

  @override
  String get noNotices => 'Καμία ειδοποίηση.';

  @override
  String noticeOverwritten(String name, String date) {
    return 'Ο/Η $name αντικατέστησε την αλλαγή σας στη βάρδια της $date.';
  }

  @override
  String get history => 'Ιστορικό';

  @override
  String get recentChanges => 'Πρόσφατες αλλαγές';

  @override
  String get undoChange => 'Αναίρεση αυτής της αλλαγής';

  @override
  String get undoDone => 'Η αλλαγή αναιρέθηκε.';

  @override
  String get historyCreate => 'Δημιουργία';

  @override
  String get historyUpdate => 'Αλλαγή';

  @override
  String get historyDelete => 'Διαγραφή';

  @override
  String get historyUndo => 'Αναίρεση';

  @override
  String get noHistory => 'Καμία αλλαγή.';

  @override
  String get pendingNotEditable =>
      'Αυτή η βάρδια δεν έχει συγχρονιστεί ακόμη: δοκιμάστε ξανά όταν είστε συνδεδεμένοι.';

  @override
  String get myQrCode => 'Ο κωδικός QR μου';

  @override
  String get myQrCodeHint =>
      'Ένας υπεύθυνος σαρώνει αυτόν τον κωδικό για να σας προσθέσει στην εταιρεία του· μετά επιβεβαιώνετε. Δεν αλλάζει ποτέ.';

  @override
  String get changeMyName => 'Αλλαγή του ονόματός μου';

  @override
  String get nameShownToTeam =>
      'Αυτό το όνομα εμφανίζεται στους συναδέλφους σας αντί για το όνομα Google.';

  @override
  String googleName(String name) {
    return 'Όνομα Google: $name';
  }

  @override
  String get useGoogleName => 'Χρήση του ονόματος Google';

  @override
  String renameMemberTitle(String name) {
    return 'Μετονομασία: $name';
  }

  @override
  String get renameMemberHint =>
      'Αυτό το όνομα χρησιμοποιείται μόνο σε αυτή την εταιρεία.';

  @override
  String get useOwnName => 'Χρήση του δικού του ονόματος';

  @override
  String get scanQrCode => 'Σάρωση κωδικού QR';

  @override
  String get scanQrHint =>
      'Στρέψτε την κάμερα στον κωδικό QR της εφαρμογής του (μενού λογαριασμού, «Ο κωδικός QR μου»).';

  @override
  String get orEnterCode => 'Ή εισαγάγετε τον 6ψήφιο κωδικό του';

  @override
  String get qrInvalid => 'Αυτός δεν είναι κωδικός QR του Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Η κάμερα δεν είναι διαθέσιμη ($error).';
  }

  @override
  String get notificationsTitle => 'Ειδοποιήσεις';

  @override
  String get notifChooseHint =>
      'Επιλέξτε για τι θα ειδοποιείστε. Όλα παραμένουν ορατά στο καμπανάκι.';

  @override
  String get notifPlanning => 'Πρόγραμμα δημοσιεύτηκε ή άλλαξε';

  @override
  String get notifRequests => 'Αιτήματα: ανταλλαγές, άδειες, προσκλήσεις';

  @override
  String get notifMessages => 'Νέα μηνύματα';

  @override
  String get notifOverlap => 'Επικαλυπτόμενες βάρδιες μεταξύ εταιρειών';

  @override
  String get notifConflicts =>
      'Οι αλλαγές σας αντικαταστάθηκαν από άλλον υπεύθυνο';

  @override
  String get notifBilling => 'Υπενθυμίσεις συνδρομής';

  @override
  String get pushEnabled => 'Οι ειδοποιήσεις είναι ενεργές σε αυτή τη συσκευή.';

  @override
  String get pushOff =>
      'Οι ειδοποιήσεις είναι απενεργοποιημένες σε αυτή τη συσκευή.';

  @override
  String get pushBlocked =>
      'Οι ειδοποιήσεις είναι αποκλεισμένες: επιτρέψτε τις στις ρυθμίσεις του τηλεφώνου ή του προγράμματος περιήγησης.';

  @override
  String get pushUnavailable =>
      'Οι ειδοποιήσεις δεν είναι διαθέσιμες σε αυτή τη συσκευή.';

  @override
  String get enablePush => 'Ενεργοποίηση';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: το πρόγραμμά σας δημοσιεύτηκε ή άλλαξε.';
  }

  @override
  String noticeJoinInvite(String company) {
    return 'Η εταιρεία $company θέλει να σας προσθέσει στην ομάδα της.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return 'Ο/Η $name σας προτείνει να γίνετε ιδιοκτήτης της $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return 'Ο/Η $name μπήκε στην $company.';
  }

  @override
  String get messagesTab => 'Μηνύματα';

  @override
  String get wholeTeam => 'Όλη η ομάδα';

  @override
  String get newConversation => 'Νέα συνομιλία';

  @override
  String get noMessages => 'Δεν υπάρχουν ακόμη μηνύματα.';

  @override
  String get messageHint => 'Γράψτε ένα μήνυμα';

  @override
  String get earlierMessages => 'Παλαιότερα μηνύματα';

  @override
  String get personLeftCompany =>
      'Αυτό το άτομο δεν ανήκει πλέον στην εταιρεία.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Νέα ομάδα';

  @override
  String get editGroup => 'Επεξεργασία ομάδας';

  @override
  String get groupName => 'Όνομα ομάδας';

  @override
  String get groupMembersHint =>
      'Επιλέξτε τα άτομα αυτής της ομάδας. Μόνο αυτά θα βλέπουν τα μηνύματά της.';

  @override
  String get chooseAtLeastOne => 'Επιλέξτε τουλάχιστον ένα άτομο.';

  @override
  String get replyAction => 'Απάντηση';

  @override
  String get translateAction => 'Μετάφραση';

  @override
  String replyingTo(String name) {
    return 'Απάντηση σε $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Τελευταία μηνύματα από $name';
  }

  @override
  String get deleteAllNotices => 'Διαγραφή όλων';

  @override
  String get deleteAllNoticesConfirm => 'Διαγραφή όλων των ειδοποιήσεων;';

  @override
  String get noticeRetention => 'Διαγραφή αναγνωσμένων ειδοποιήσεων μετά από';

  @override
  String get retentionDay => '1 ημέρα';

  @override
  String get retentionWeek => '1 εβδομάδα';

  @override
  String get retentionMonth => '1 μήνα';

  @override
  String get billingOwnersOnly => 'Ενεργό μόνο αν έχετε δική σας εταιρεία.';

  @override
  String get readOnlyPastDays =>
      'Οι ημέρες πριν από περισσότερο από έναν μήνα είναι μόνο για ανάγνωση.';
}
