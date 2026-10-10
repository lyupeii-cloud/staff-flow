// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class L10nMs extends L10n {
  L10nMs([String locale = 'ms']) : super(locale);

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get confirm => 'Sahkan';

  @override
  String get validate => 'Sahkan';

  @override
  String get add => 'Tambah';

  @override
  String get rename => 'Namakan semula';

  @override
  String get delete => 'Padam';

  @override
  String get accept => 'Terima';

  @override
  String get decline => 'Tolak';

  @override
  String get close => 'Tutup';

  @override
  String get retry => 'Cuba lagi';

  @override
  String get name => 'Nama';

  @override
  String get serverUnreachable => 'Pelayan tidak dapat dihubungi.';

  @override
  String errorStatus(int status) {
    return 'Ralat $status';
  }

  @override
  String get roleOwner => 'Pemilik';

  @override
  String get roleManager => 'Pengurus';

  @override
  String get roleEmployee => 'Pekerja';

  @override
  String get roleExtra => 'Pekerja sementara';

  @override
  String get taglineStart => 'Jadual pasukan anda, ';

  @override
  String get taglineEnd => 'di mana-mana.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Log masuk dengan Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Log masuk Google tidak tersedia: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Gagal log masuk dengan Google: $detail';
  }

  @override
  String get newCompany => 'Syarikat baharu';

  @override
  String get timezone => 'Zon waktu';

  @override
  String get create => 'Cipta';

  @override
  String get noCompanyTitle => 'Anda belum menyertai mana-mana syarikat.';

  @override
  String get noCompanyHint =>
      'Untuk menyertai syarikat majikan anda, jana kod dan berikan kepada pengurus anda.';

  @override
  String get joinCompany => 'Sertai syarikat';

  @override
  String get createCompany => 'Cipta syarikat';

  @override
  String transferOffer(String company) {
    return 'Anda ditawarkan untuk menjadi pemilik “$company”.';
  }

  @override
  String get someCompany => 'sebuah syarikat';

  @override
  String get becameOwner => 'Anda kini pemilik.';

  @override
  String get myAccount => 'Akaun saya';

  @override
  String get idCopied => 'ID disalin.';

  @override
  String myId(String id) {
    return 'ID saya: $id';
  }

  @override
  String get signOut => 'Log keluar';

  @override
  String joinInvite(String company, String role) {
    return '“$company” menjemput anda sebagai $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Anda telah menyertai $company.';
  }

  @override
  String get viewPlanning => 'Jadual';

  @override
  String get viewTeam => 'Pasukan';

  @override
  String get viewPositions => 'Jawatan';

  @override
  String get readOnlyCompany => 'Syarikat ini baca sahaja.';

  @override
  String get team => 'Pasukan';

  @override
  String get leaveCompany => 'Keluar dari syarikat ini';

  @override
  String meSuffix(String name) {
    return '$name (anda)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Pindahkan syarikat kepada $name?';
  }

  @override
  String get transferConfirmBody =>
      'Selepas diterima, orang itu menjadi pemilik (langganan, invois, pengurus) dan anda menjadi pengurus.';

  @override
  String transferSent(String name) {
    return 'Tawaran dihantar kepada $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Keluarkan $name?';
  }

  @override
  String get removeConfirmBody => 'Sejarahnya disimpan.';

  @override
  String get addPersonTitle => 'Tambah orang';

  @override
  String get addPersonHint =>
      'Minta dia membuka Staff Flow, menu akaun, “Sertai syarikat”, kemudian masukkan kod yang dipaparkan.';

  @override
  String get sixDigitCode => 'Kod 6 digit';

  @override
  String invitationSent(String name) {
    return 'Jemputan dihantar kepada $name: dia perlu menerimanya.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Keluar dari $company?';
  }

  @override
  String get leaveConfirmBody => 'Anda tidak akan melihat jadualnya lagi.';

  @override
  String get renameCompany => 'Namakan semula syarikat';

  @override
  String get actionMakeManager => 'Jadikan pengurus';

  @override
  String get actionMakeEmployee => 'Kembalikan sebagai pekerja';

  @override
  String get actionToEmployee => 'Jadikan pekerja';

  @override
  String get actionToExtra => 'Jadikan pekerja sementara';

  @override
  String get actionTransfer => 'Pindahkan pemilikan';

  @override
  String get actionRemove => 'Keluarkan dari syarikat';

  @override
  String get positions => 'Jawatan';

  @override
  String get sites => 'Lokasi';

  @override
  String get positionsHint => 'Kerja yang dilakukan: juruwang, dapur, kaunter…';

  @override
  String get sitesHint =>
      'Tempat syif dijalankan, jika syarikat mempunyai beberapa lokasi.';

  @override
  String get archived => 'Diarkibkan';

  @override
  String get archive => 'Arkibkan';

  @override
  String get reactivate => 'Aktifkan semula';

  @override
  String weekOf(String date) {
    return 'Minggu $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perubahan diterbitkan.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Syif';

  @override
  String get display => 'Paparan';

  @override
  String get week => 'Minggu';

  @override
  String get month => 'Bulan';

  @override
  String get today => 'Hari ini';

  @override
  String get onlyMine => 'Syif saya sahaja';

  @override
  String get replacePersonMenu => 'Ganti orang…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perubahan belum diterbitkan',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Pekerja belum dapat melihatnya.';

  @override
  String get publish => 'Terbitkan';

  @override
  String yourHours(String duration) {
    return 'Jam anda dalam tempoh ini: $duration';
  }

  @override
  String get addShiftThisDay => 'Tambah syif pada hari ini';

  @override
  String get noShift => 'Tiada syif';

  @override
  String get unassigned => 'Belum ditetapkan';

  @override
  String get formerMember => 'Bekas ahli';

  @override
  String get statusDraft => 'Draf';

  @override
  String get statusModified => 'Diubah';

  @override
  String get statusDeleted => 'Dipadam';

  @override
  String durationHours(int hours) {
    return '$hours jam';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours jam $minutes min';
  }

  @override
  String get editShift => 'Edit syif';

  @override
  String get newShift => 'Syif baharu';

  @override
  String get thisShift => 'Syif ini sahaja';

  @override
  String get thisAndFollowing => 'Ini dan seterusnya';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hari',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Hari lain';

  @override
  String get start => 'Mula';

  @override
  String get end => 'Tamat';

  @override
  String get endsNextDay => 'Tamat pada hari berikutnya.';

  @override
  String get person => 'Orang';

  @override
  String get position => 'Jawatan';

  @override
  String get site => 'Lokasi';

  @override
  String get noteOptional => 'Nota (pilihan)';

  @override
  String get repetition => 'Ulangan';

  @override
  String get repeatNone => 'Tiada';

  @override
  String get repeatDaily => 'Setiap hari';

  @override
  String get repeatWeekly => 'Setiap minggu';

  @override
  String get repeatForPrefix => 'Selama ';

  @override
  String get repeatDaysSuffix => ' hari';

  @override
  String get repeatWeeksSuffix => ' minggu';

  @override
  String get repeatUntilPrefix => 'Hingga ';

  @override
  String get replacePersonTitle => 'Ganti orang';

  @override
  String get replaceFrom => 'Ganti';

  @override
  String get replaceBy => 'Dengan';

  @override
  String dateRange(String from, String to) {
    return 'Dari $from hingga $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count syif diubah.',
      zero: 'Tiada syif diubah.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Ganti';

  @override
  String get joinHint =>
      'Berikan kod ini kepada pengurus anda. Selepas dia memasukkannya dalam aplikasi, anda akan menerima jemputan.';

  @override
  String get codeExpired => 'Kod telah tamat tempoh.';

  @override
  String codeValidFor(String time) {
    return 'Sah selama $time lagi';
  }

  @override
  String get newCode => 'Kod baharu';

  @override
  String get language => 'Bahasa';

  @override
  String get languageAuto => 'Automatik (bahasa peranti)';

  @override
  String get syncUpToDate => 'Terkini';

  @override
  String get syncOffline => 'Luar talian';

  @override
  String syncPending(int count) {
    return 'Perubahan tertunda: $count';
  }

  @override
  String get syncNow => 'Segerak sekarang';

  @override
  String syncRejected(String reason) {
    return 'Perubahan ditolak pelayan: $reason';
  }

  @override
  String get pendingBadge => 'Tertunda';

  @override
  String get offlineUnavailable => 'Tidak tersedia di luar talian.';

  @override
  String get offlineCached => 'Luar talian: data terakhir yang disimpan.';

  @override
  String get savedOffline =>
      'Disimpan pada peranti, akan dihantar apabila rangkaian kembali.';

  @override
  String get notices => 'Notis';

  @override
  String get noNotices => 'Tiada notis.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name menggantikan perubahan anda pada syif $date.';
  }

  @override
  String get history => 'Sejarah';

  @override
  String get recentChanges => 'Perubahan terkini';

  @override
  String get undoChange => 'Buat asal perubahan ini';

  @override
  String get undoDone => 'Perubahan dibuat asal.';

  @override
  String get historyCreate => 'Dicipta';

  @override
  String get historyUpdate => 'Diubah';

  @override
  String get historyDelete => 'Dipadam';

  @override
  String get historyUndo => 'Dibuat asal';

  @override
  String get noHistory => 'Tiada perubahan.';

  @override
  String get pendingNotEditable =>
      'Syif ini belum disegerakkan: cuba lagi apabila dalam talian.';

  @override
  String get myQrCode => 'Kod QR saya';

  @override
  String get myQrCodeHint =>
      'Pengurus mengimbas kod ini untuk menambah anda ke syarikatnya; kemudian anda mengesahkan. Kod ini tidak pernah berubah.';

  @override
  String get changeMyName => 'Tukar nama saya';

  @override
  String get nameShownToTeam =>
      'Nama ini dipaparkan kepada rakan sekerja anda dan bukannya nama Google anda.';

  @override
  String googleName(String name) {
    return 'Nama Google: $name';
  }

  @override
  String get useGoogleName => 'Guna nama Google saya';

  @override
  String renameMemberTitle(String name) {
    return 'Namakan semula $name';
  }

  @override
  String get renameMemberHint => 'Nama ini hanya digunakan dalam syarikat ini.';

  @override
  String get useOwnName => 'Guna namanya sendiri';

  @override
  String get scanQrCode => 'Imbas kod QR';

  @override
  String get scanQrHint =>
      'Halakan kamera ke kod QR dalam aplikasinya (menu akaun, “Kod QR saya”).';

  @override
  String get orEnterCode => 'Atau masukkan kod 6 digitnya';

  @override
  String get qrInvalid => 'Ini bukan kod QR Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Kamera tidak tersedia ($error).';
  }

  @override
  String get notificationsTitle => 'Pemberitahuan';

  @override
  String get notifChooseHint =>
      'Pilih perkara yang anda mahu diberitahu. Semuanya tetap kelihatan di loceng.';

  @override
  String get notifPlanning => 'Jadual diterbitkan atau diubah';

  @override
  String get notifRequests => 'Permintaan: tukar syif, cuti, jemputan';

  @override
  String get notifMessages => 'Mesej baharu';

  @override
  String get notifOverlap => 'Syif bertindih antara syarikat';

  @override
  String get notifConflicts => 'Perubahan anda digantikan oleh pengurus lain';

  @override
  String get notifBilling => 'Peringatan langganan';

  @override
  String get pushEnabled => 'Pemberitahuan dihidupkan pada peranti ini.';

  @override
  String get pushOff => 'Pemberitahuan dimatikan pada peranti ini.';

  @override
  String get pushBlocked =>
      'Pemberitahuan disekat: benarkan dalam tetapan telefon atau pelayar.';

  @override
  String get pushUnavailable =>
      'Pemberitahuan tidak tersedia pada peranti ini.';

  @override
  String get enablePush => 'Hidupkan';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: jadual anda telah diterbitkan atau diubah.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company mahu menambah anda ke dalam pasukannya.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name menawarkan anda menjadi pemilik $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name telah menyertai $company.';
  }

  @override
  String get messagesTab => 'Mesej';

  @override
  String get wholeTeam => 'Seluruh pasukan';

  @override
  String get newConversation => 'Perbualan baharu';

  @override
  String get noMessages => 'Belum ada mesej.';

  @override
  String get messageHint => 'Tulis mesej';

  @override
  String get earlierMessages => 'Mesej terdahulu';

  @override
  String get personLeftCompany =>
      'Orang ini bukan lagi sebahagian daripada syarikat.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Kumpulan baharu';

  @override
  String get editGroup => 'Edit kumpulan';

  @override
  String get groupName => 'Nama kumpulan';

  @override
  String get groupMembersHint =>
      'Pilih orang dalam kumpulan ini. Hanya mereka yang melihat mesejnya.';

  @override
  String get chooseAtLeastOne => 'Pilih sekurang-kurangnya seorang.';

  @override
  String get replyAction => 'Balas';

  @override
  String get translateAction => 'Terjemah';

  @override
  String replyingTo(String name) {
    return 'Membalas $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Mesej terakhir daripada $name';
  }

  @override
  String get deleteAllNotices => 'Padam semua';

  @override
  String get deleteAllNoticesConfirm => 'Padam semua pemberitahuan?';

  @override
  String get noticeRetention => 'Padam pemberitahuan yang dibaca selepas';

  @override
  String get retentionDay => '1 hari';

  @override
  String get retentionWeek => '1 minggu';

  @override
  String get retentionMonth => '1 bulan';

  @override
  String get billingOwnersOnly => 'Hanya aktif jika anda memiliki syarikat.';

  @override
  String get readOnlyPastDays =>
      'Hari yang lebih sebulan lalu hanya boleh dibaca.';

  @override
  String get wholeCompany => 'Seluruh syarikat';

  @override
  String get sitesLabel => 'Lokasi';

  @override
  String get actionSites => 'Lokasi…';

  @override
  String managerOf(String name) {
    return '$name bertanggungjawab atas';
  }

  @override
  String teamSitesOf(String name) {
    return 'Pasukan $name';
  }

  @override
  String get notYourSite => 'Lokasi ini bukan di bawah tanggungjawab anda.';

  @override
  String get chooseYourSite => 'Pilih sekurang-kurangnya satu lokasi.';

  @override
  String get viewRequests => 'Permintaan';

  @override
  String get newRequest => 'Permintaan baharu';

  @override
  String get requestLeave => 'Cuti';

  @override
  String get requestUnavailability => 'Tidak tersedia';

  @override
  String get requestSwap => 'Tukar syif';

  @override
  String get swapHint =>
      'Untuk menawarkan pertukaran, ketik salah satu syif akan datang anda dalam jadual.';

  @override
  String get noRequests => 'Belum ada permintaan.';

  @override
  String get requestsToHandle => 'Perlu diuruskan';

  @override
  String get myRequests => 'Permintaan saya';

  @override
  String get otherRequests => 'Permintaan pasukan';

  @override
  String get statusPendingPeer => 'Menunggu rakan sekerja';

  @override
  String get statusPendingManager => 'Menunggu pengurus';

  @override
  String get statusApproved => 'Diluluskan';

  @override
  String get statusRefused => 'Ditolak';

  @override
  String get statusCancelled => 'Dibatalkan';

  @override
  String get cancelRequest => 'Batalkan permintaan';

  @override
  String get acceptSwap => 'Ambil syif ini';

  @override
  String get approve => 'Luluskan';

  @override
  String periodLabel(String from, String to) {
    return 'Dari $from hingga $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Ditawarkan kepada $name';
  }

  @override
  String get swapToTeam => 'Seluruh pasukan';

  @override
  String everyWeekdays(String days) {
    return 'Setiap minggu: $days';
  }

  @override
  String get unavailableEveryWeek => 'Hari anda tidak pernah tersedia:';

  @override
  String get choosePeriod => 'Pilih tarikh';

  @override
  String get choosePeriodOptional => 'Hadkan kepada satu tempoh (pilihan)';

  @override
  String get clearPeriod => 'Tiada tempoh';

  @override
  String get sendRequest => 'Hantar permintaan';

  @override
  String get proposeSwap => 'Tawarkan pertukaran';

  @override
  String get swapWith => 'Tawarkan kepada';

  @override
  String get swapSteps =>
      'Rakan sekerja menerima, kemudian pengurus meluluskan. Jadual hanya berubah selepas itu.';

  @override
  String get absentThatDay => 'Ketidakhadiran diluluskan pada hari itu';

  @override
  String get requestSent => 'Permintaan dihantar.';

  @override
  String noticeSwapOffer(String name) {
    return '$name menawarkan salah satu syifnya kepada anda.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name menolak tawaran tukar anda.';
  }

  @override
  String get noticeSwapToApprove => 'Pertukaran syif menunggu pengesahan anda.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name memohon cuti.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name memaklumkan tidak tersedia.';
  }

  @override
  String get noticeRequestApproved => 'Permintaan anda telah diluluskan.';

  @override
  String get noticeRequestRefused => 'Permintaan anda telah ditolak.';

  @override
  String get choosePeer => 'Siapa yang mengambil alih syif ini?';

  @override
  String get discardAll => 'Batalkan semua';

  @override
  String get notifySitesHint =>
      'Pilih lokasi yang anda terima pemberitahuan permintaan. Semua permintaan masih kelihatan dalam senarai.';

  @override
  String get notifySitesTitle => 'Pemberitahuan mengikut lokasi';

  @override
  String get pendingRequestTooltip =>
      'Permintaan menunggu: ketik untuk membuka';

  @override
  String get requestsHistory => 'Semua permintaan';

  @override
  String get revertChange => 'Batalkan perubahan ini';

  @override
  String get statusExpired => 'Tidak lagi berkenaan';

  @override
  String get swapWithHint => 'Ketik untuk memilih rakan sekerja tertentu';

  @override
  String changesDiscarded(String count) {
    return 'Perubahan dibatalkan: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Batalkan $count perubahan yang belum diterbitkan?';
  }

  @override
  String get allSchedules => 'Semua jadual saya';

  @override
  String get busyElsewhere => 'Sudah bekerja di syarikat lain pada waktu ini';

  @override
  String get overlapTooltip => 'Bertindih dengan syif di syarikat lain';

  @override
  String get overlapWarning =>
      'Sebahagian syif anda di dua syarikat bertindih.';

  @override
  String noticeOverlap(String date) {
    return 'Dua syif anda di syarikat berbeza bertindih pada $date.';
  }

  @override
  String get allMyCompanies => 'Semua syarikat saya';

  @override
  String get deleteGroup => 'Padam kumpulan';

  @override
  String get openRequest => 'Lihat permintaan';

  @override
  String get thisCompany => 'Syarikat ini';

  @override
  String get withExtras => 'Termasuk pekerja sambilan';

  @override
  String deleteGroupConfirm(String name) {
    return 'Padam “$name” dan semua mesejnya untuk semua orang?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Dari $company: akan ditambah sebagai tenaga bantuan dan dimaklumkan.';
  }

  @override
  String get addToGoogle => 'Tambah ke Kalendar Google';

  @override
  String get calendarEnabled => 'Segerakkan syif saya';

  @override
  String get calendarHint =>
      'Tambah syif anda dari semua syarikat ke Kalendar Google. Ia dikemas kini sendiri dan anda boleh mematikannya bila-bila masa.';

  @override
  String get changeSettings => 'Ubah';

  @override
  String get copyCalendarLink => 'Salin pautan kalendar';

  @override
  String get countryBelgium => 'Belgium';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Perancis';

  @override
  String get countrySwitzerland => 'Switzerland';

  @override
  String get employeesSection => 'Pekerja';

  @override
  String get emptyNoAlert => 'Kosong: tiada amaran';

  @override
  String get extrasSection => 'Pekerja sambilan';

  @override
  String get googleCalendar => 'Kalendar Google';

  @override
  String get hoursTotals => 'Jumlah jam';

  @override
  String get legalAlerts => 'Amaran undang-undang';

  @override
  String get legalAlertsHint =>
      'Amaran sahaja, tidak pernah menyekat. Pilih peraturan yang terpakai kepada anda, atau tiada.';

  @override
  String get legalPreset => 'Templat negara';

  @override
  String get linkCopied => 'Pautan disalin.';

  @override
  String get maxConsecutiveLabel => 'Maksimum hari bekerja berturut-turut';

  @override
  String get maxDayLabel => 'Tempoh maksimum sehari (jam)';

  @override
  String get maxWeekLabel => 'Tempoh maksimum seminggu (jam)';

  @override
  String get minRestLabel => 'Rehat minimum antara syif (jam)';

  @override
  String get noLegalRules => 'Tiada amaran dipilih.';

  @override
  String get presetNone => 'Tiada';

  @override
  String get presetsCheck =>
      'Templat hanyalah titik permulaan: semak mengikut peraturan negara dan perjanjian kolektif anda.';

  @override
  String get printMine => 'Jadual saya';

  @override
  String get printOwn => 'Jadual sendiri sahaja';

  @override
  String get printPdf => 'Cetak / PDF';

  @override
  String get printRights => 'Perkara yang boleh dicetak pekerja';

  @override
  String get printTeam => 'Jadual seluruh pasukan';

  @override
  String get printTeamOption => 'Jadual pasukan';

  @override
  String get totalsHint =>
      'Termasuk draf. Eksport Excel dan CSV menggunakan jadual yang diterbitkan.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value hari berturut-turut (maksimum $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value dalam sehari (maksimum $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: hanya $value rehat (minimum $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value dalam seminggu (maksimum $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Amaran undang-undang: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Syif: $count';
  }

  @override
  String get actionMakeDeputy => 'Lantik sebagai timbalan pengurus';

  @override
  String get actionRemoveDeputy => 'Tarik balik peranan timbalan';

  @override
  String get busyHere => 'Sudah bekerja di syarikat ini pada waktu ini';

  @override
  String get calendarByLink => 'Melalui pautan (Kalendar Google di komputer)';

  @override
  String get calendarDenied =>
      'Akses kalendar ditolak. Benarkan dalam tetapan telefon.';

  @override
  String get calendarLinkHint =>
      'Tambah dari Kalendar Google di komputer; Google mengemas kininya dalam beberapa jam.';

  @override
  String get calendarNone => 'Tiada kalendar boleh disunting pada telefon ini.';

  @override
  String get calendarOnPhone => 'Tambah syif saya ke kalendar telefon';

  @override
  String get calendarOnPhoneHint =>
      'Dalam kalendar Google anda: kelihatan serta-merta, di telefon dan di Kalendar Google.';

  @override
  String get chooseCalendar => 'Pilih kalendar';

  @override
  String get otherSiteHint =>
      'Pekerja dari lokasi lain: pengurusnya akan dimaklumkan.';

  @override
  String get subManager => 'Timbalan pengurus';

  @override
  String calendarSynced(String count) {
    return 'Syif dalam kalendar: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Timbalan pengurus: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by menempatkan $name di lokasi $site pada $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company menambah anda sebagai tenaga bantuan.';
  }

  @override
  String get companyNotificationsHint =>
      'Dimatikan: tiada apa-apa berbunyi pada telefon ini, tetapi semuanya kekal dalam loceng.';

  @override
  String get companyNotificationsOn =>
      'Terima pemberitahuan daripada syarikat ini';

  @override
  String get companyTimezone => 'Zon waktu syarikat';

  @override
  String get companyTimezoneHint =>
      'Semua waktu syarikat ini dalam zon waktu ini (termasuk waktu musim panas). Kalendar menukarnya secara automatik.';

  @override
  String get iosInstallHint =>
      'Pada iPhone: ketik Kongsi, kemudian “Tambah ke Skrin Utama” untuk memasang Staff Flow.';

  @override
  String get searchCity => 'Cari bandar';

  @override
  String get thisPhone => 'Peranti ini';

  @override
  String companyNotifications(String name) {
    return 'Pemberitahuan: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Waktu mengikut waktu $zone ($company). Peranti anda: $here.';
  }

  @override
  String get addPreset => 'Tambah pratetap';

  @override
  String get addPresets => 'Cipta pratetap';

  @override
  String get appearance => 'Rupa';

  @override
  String get chooseLogo => 'Pilih imej PNG';

  @override
  String get conversationMuted => 'Pemberitahuan perbualan ini dibisukan.';

  @override
  String get conversationUnmuted =>
      'Pemberitahuan perbualan ini dihidupkan semula.';

  @override
  String get customization => 'Pemperibadian';

  @override
  String get disableGroup => 'Matikan kumpulan';

  @override
  String get disableGroupConfirm =>
      'Kumpulan seluruh syarikat akan disembunyikan untuk semua. Anda boleh menghidupkannya semula dalam Mesej.';

  @override
  String get editPresets => 'Pratetap';

  @override
  String get enable => 'Hidupkan semula';

  @override
  String get groupDisabled => 'Kumpulan dimatikan (hanya anda yang nampak)';

  @override
  String get logoHint =>
      'Imej PNG kecil (logo anda) dipaparkan pada tab syarikat untuk semua ahli.';

  @override
  String get logoPngOnly => 'Pilih imej PNG maksimum 1 MB.';

  @override
  String get muteConversation => 'Bisukan perbualan ini';

  @override
  String get myIdentifier => 'ID saya';

  @override
  String get myProfile => 'Profil saya';

  @override
  String get presetName => 'Nama (cth. Pagi)';

  @override
  String get removeLogo => 'Buang imej';

  @override
  String get resetGroup => 'Set semula kumpulan';

  @override
  String get resetGroupConfirm =>
      'Semua mesej dalam kumpulan syarikat akan dipadam untuk semua.';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get shiftPresets => 'Pratetap waktu syif';

  @override
  String get shiftPresetsHint =>
      'Waktu sedia ada (pagi, petang, malam…): satu ketikan dalam syif mengisi mula dan tamat.';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeLight => 'Cerah';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get unmuteConversation => 'Hidupkan pemberitahuan perbualan ini';

  @override
  String get awaitingApproval => 'Perlu kelulusan';

  @override
  String get placementNeedsApproval =>
      '! Orang ini bukan dari tapak anda: syif akan menunggu kelulusan penyelia anda atau pemilik sebelum boleh diterbitkan. Jika tidak, pilih orang lain.';

  @override
  String get placementAwaiting => 'Menunggu kelulusan penyelia atau pemilik.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by mahu menjadualkan $name dari tapak lain pada $date: perlu kelulusan.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by meluluskan penjadualan $name pada $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by menolak penjadualan $name pada $date.';
  }

  @override
  String get addSubSite => 'Tambah sub-tapak';

  @override
  String get moveSite => 'Alih';

  @override
  String get topLevel => 'Peringkat teratas';

  @override
  String moveSiteTitle(String name) {
    return 'Alih “$name” ke bawah…';
  }

  @override
  String subSiteOf(String name) {
    return 'Sub-tapak $name';
  }

  @override
  String get siteTreeHint =>
      'Sehingga 3 peringkat, cth. Wilayah › Bandar › Kedai. Pengurus sesuatu tapak juga mengurus semua di bawahnya.';

  @override
  String get subSitesOnlyHint =>
      'Di sini anda menambah sub-tapak di bawah tapak anda sendiri.';

  @override
  String get messagingSetting => 'Pemesejan syarikat';

  @override
  String get messagingSettingHint =>
      'Hidup: pasukan ada tab Mesej. Mati: tiada siapa nampak atau boleh menulis (mesej lama disimpan).';
}
