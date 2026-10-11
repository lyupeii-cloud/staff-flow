// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class L10nId extends L10n {
  L10nId([String locale = 'id']) : super(locale);

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get validate => 'Konfirmasi';

  @override
  String get add => 'Tambah';

  @override
  String get rename => 'Ganti nama';

  @override
  String get delete => 'Hapus';

  @override
  String get accept => 'Terima';

  @override
  String get decline => 'Tolak';

  @override
  String get close => 'Tutup';

  @override
  String get retry => 'Coba lagi';

  @override
  String get name => 'Nama';

  @override
  String get serverUnreachable => 'Server tidak dapat dihubungi.';

  @override
  String errorStatus(int status) {
    return 'Kesalahan $status';
  }

  @override
  String get roleOwner => 'Pemilik';

  @override
  String get roleManager => 'Penanggung jawab';

  @override
  String get roleEmployee => 'Karyawan';

  @override
  String get roleExtra => 'Pekerja lepas';

  @override
  String get taglineStart => 'Jadwal tim Anda, ';

  @override
  String get taglineEnd => 'di mana saja.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Masuk dengan Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Masuk dengan Google tidak tersedia: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Gagal masuk dengan Google: $detail';
  }

  @override
  String get newCompany => 'Perusahaan baru';

  @override
  String get timezone => 'Zona waktu';

  @override
  String get create => 'Buat';

  @override
  String get noCompanyTitle =>
      'Anda belum bergabung dengan perusahaan mana pun.';

  @override
  String get noCompanyHint =>
      'Untuk bergabung dengan perusahaan pemberi kerja, buat kode dan berikan kepada penanggung jawab Anda.';

  @override
  String get joinCompany => 'Gabung ke perusahaan';

  @override
  String get createCompany => 'Buat perusahaan';

  @override
  String transferOffer(String company) {
    return 'Anda ditawari menjadi pemilik “$company”.';
  }

  @override
  String get someCompany => 'sebuah perusahaan';

  @override
  String get becameOwner => 'Sekarang Anda adalah pemilik.';

  @override
  String get myAccount => 'Akun saya';

  @override
  String get idCopied => 'ID disalin.';

  @override
  String myId(String id) {
    return 'ID saya: $id';
  }

  @override
  String get signOut => 'Keluar';

  @override
  String joinInvite(String company, String role) {
    return '“$company” mengundang Anda sebagai $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Anda bergabung dengan $company.';
  }

  @override
  String get viewPlanning => 'Jadwal';

  @override
  String get viewTeam => 'Manajemen';

  @override
  String get viewPositions => 'Posisi';

  @override
  String get readOnlyCompany => 'Perusahaan ini hanya bisa dilihat.';

  @override
  String get team => 'Tim';

  @override
  String get leaveCompany => 'Keluar dari perusahaan ini';

  @override
  String meSuffix(String name) {
    return '$name (Anda)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Alihkan perusahaan ke $name?';
  }

  @override
  String get transferConfirmBody =>
      'Setelah diterima, orang tersebut menjadi pemilik (langganan, tagihan, penanggung jawab) dan Anda menjadi penanggung jawab.';

  @override
  String transferSent(String name) {
    return 'Tawaran dikirim ke $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Keluarkan $name?';
  }

  @override
  String get removeConfirmBody => 'Riwayatnya tetap disimpan.';

  @override
  String get addPersonTitle => 'Tambah orang';

  @override
  String get addPersonHint =>
      'Minta dia membuka Staff Flow, menu akun, “Gabung ke perusahaan”, lalu masukkan kode yang muncul.';

  @override
  String get sixDigitCode => 'Kode 6 digit';

  @override
  String invitationSent(String name) {
    return 'Undangan dikirim ke $name: dia harus menerimanya.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Keluar dari $company?';
  }

  @override
  String get leaveConfirmBody => 'Anda tidak akan melihat jadwalnya lagi.';

  @override
  String get renameCompany => 'Ganti nama perusahaan';

  @override
  String get actionMakeManager => 'Jadikan penanggung jawab';

  @override
  String get actionMakeEmployee => 'Kembalikan jadi karyawan';

  @override
  String get actionToEmployee => 'Jadikan karyawan';

  @override
  String get actionToExtra => 'Jadikan pekerja lepas';

  @override
  String get actionTransfer => 'Alihkan kepemilikan';

  @override
  String get actionRemove => 'Keluarkan dari perusahaan';

  @override
  String get positions => 'Posisi';

  @override
  String get sites => 'Lokasi';

  @override
  String get positionsHint => 'Apa yang dikerjakan: kasir, dapur, resepsionis…';

  @override
  String get sitesHint =>
      'Tempat shift berlangsung, jika perusahaan punya beberapa lokasi.';

  @override
  String get archived => 'Diarsipkan';

  @override
  String get archive => 'Arsipkan';

  @override
  String get reactivate => 'Aktifkan lagi';

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
  String get shiftButton => 'Shift';

  @override
  String get display => 'Tampilan';

  @override
  String get week => 'Minggu';

  @override
  String get month => 'Bulan';

  @override
  String get today => 'Hari ini';

  @override
  String get onlyMine => 'Hanya shift saya';

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
  String get pendingHint => 'Karyawan belum dapat melihatnya.';

  @override
  String get publish => 'Terbitkan';

  @override
  String yourHours(String duration) {
    return 'Jam Anda pada periode ini: $duration';
  }

  @override
  String get addShiftThisDay => 'Tambah shift pada hari ini';

  @override
  String get noShift => 'Tidak ada shift';

  @override
  String get unassigned => 'Belum ditugaskan';

  @override
  String get formerMember => 'Mantan anggota';

  @override
  String get statusDraft => 'Draf';

  @override
  String get statusModified => 'Diubah';

  @override
  String get statusDeleted => 'Dihapus';

  @override
  String durationHours(int hours) {
    return '$hours jam';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours jam $minutes mnt';
  }

  @override
  String get editShift => 'Ubah shift';

  @override
  String get newShift => 'Shift baru';

  @override
  String get thisShift => 'Shift ini saja';

  @override
  String get thisAndFollowing => 'Ini dan berikutnya';

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
  String get start => 'Mulai';

  @override
  String get end => 'Selesai';

  @override
  String get endsNextDay => 'Berakhir keesokan harinya.';

  @override
  String get person => 'Orang';

  @override
  String get position => 'Posisi';

  @override
  String get site => 'Lokasi';

  @override
  String get noteOptional => 'Catatan (opsional)';

  @override
  String get repetition => 'Pengulangan';

  @override
  String get repeatNone => 'Tidak ada';

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
  String get repeatUntilPrefix => 'Sampai ';

  @override
  String get replacePersonTitle => 'Ganti orang';

  @override
  String get replaceFrom => 'Ganti';

  @override
  String get replaceBy => 'Dengan';

  @override
  String dateRange(String from, String to) {
    return 'Dari $from sampai $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shift diubah.',
      zero: 'Tidak ada shift yang diubah.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Ganti';

  @override
  String get joinHint =>
      'Berikan kode ini kepada penanggung jawab Anda. Setelah dia memasukkannya di aplikasi, Anda akan menerima undangan.';

  @override
  String get codeExpired => 'Kode kedaluwarsa.';

  @override
  String codeValidFor(String time) {
    return 'Berlaku $time lagi';
  }

  @override
  String get newCode => 'Kode baru';

  @override
  String get language => 'Bahasa';

  @override
  String get languageAuto => 'Otomatis (bahasa perangkat)';

  @override
  String get syncUpToDate => 'Terbaru';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Perubahan tertunda: $count';
  }

  @override
  String get syncNow => 'Sinkronkan';

  @override
  String syncRejected(String reason) {
    return 'Perubahan ditolak server: $reason';
  }

  @override
  String get pendingBadge => 'Tertunda';

  @override
  String get offlineUnavailable => 'Tidak tersedia saat offline.';

  @override
  String get offlineCached => 'Offline: data terakhir yang disimpan.';

  @override
  String get savedOffline =>
      'Disimpan di perangkat, dikirim saat jaringan kembali.';

  @override
  String get notices => 'Pemberitahuan';

  @override
  String get noNotices => 'Tidak ada pemberitahuan.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name menggantikan perubahan Anda pada shift $date.';
  }

  @override
  String get history => 'Riwayat';

  @override
  String get recentChanges => 'Perubahan terbaru';

  @override
  String get undoChange => 'Batalkan perubahan ini';

  @override
  String get undoDone => 'Perubahan dibatalkan.';

  @override
  String get historyCreate => 'Dibuat';

  @override
  String get historyUpdate => 'Diubah';

  @override
  String get historyDelete => 'Dihapus';

  @override
  String get historyUndo => 'Dibatalkan';

  @override
  String get noHistory => 'Tidak ada perubahan.';

  @override
  String get pendingNotEditable =>
      'Shift ini belum disinkronkan: coba lagi saat online.';

  @override
  String get myQrCode => 'Kode QR saya';

  @override
  String get myQrCodeHint =>
      'Manajer memindai kode ini untuk menambahkan Anda ke perusahaannya; lalu Anda mengonfirmasi. Kode ini tidak pernah berubah.';

  @override
  String get changeMyName => 'Ubah nama saya';

  @override
  String get nameShownToTeam =>
      'Nama ini ditampilkan ke rekan kerja Anda sebagai pengganti nama Google.';

  @override
  String googleName(String name) {
    return 'Nama Google: $name';
  }

  @override
  String get useGoogleName => 'Gunakan nama Google saya';

  @override
  String renameMemberTitle(String name) {
    return 'Ganti nama $name';
  }

  @override
  String get renameMemberHint => 'Nama ini hanya digunakan di perusahaan ini.';

  @override
  String get useOwnName => 'Gunakan namanya sendiri';

  @override
  String get scanQrCode => 'Pindai kode QR';

  @override
  String get scanQrHint =>
      'Arahkan kamera ke kode QR di aplikasinya (menu akun, “Kode QR saya”).';

  @override
  String get orEnterCode => 'Atau masukkan kode 6 digitnya';

  @override
  String get qrInvalid => 'Ini bukan kode QR Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Kamera tidak tersedia ($error).';
  }

  @override
  String get notificationsTitle => 'Notifikasi';

  @override
  String get notifChooseHint =>
      'Pilih hal yang ingin Anda terima notifikasinya. Semuanya tetap terlihat di lonceng.';

  @override
  String get notifPlanning => 'Jadwal diterbitkan atau diubah';

  @override
  String get notifRequests => 'Permintaan: tukar, cuti, undangan';

  @override
  String get notifMessages => 'Pesan baru';

  @override
  String get notifOverlap => 'Shift yang tumpang tindih antarperusahaan';

  @override
  String get notifConflicts => 'Perubahan Anda digantikan manajer lain';

  @override
  String get notifBilling => 'Pengingat langganan';

  @override
  String get pushEnabled => 'Notifikasi aktif di perangkat ini.';

  @override
  String get pushOff => 'Notifikasi nonaktif di perangkat ini.';

  @override
  String get pushBlocked =>
      'Notifikasi diblokir: izinkan di pengaturan ponsel atau browser.';

  @override
  String get pushUnavailable => 'Notifikasi tidak tersedia di perangkat ini.';

  @override
  String get enablePush => 'Aktifkan';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: jadwal Anda telah diterbitkan atau diubah.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company ingin menambahkan Anda ke timnya.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name menawarkan Anda menjadi pemilik $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name telah bergabung dengan $company.';
  }

  @override
  String get messagesTab => 'Pesan';

  @override
  String get wholeTeam => 'Seluruh tim';

  @override
  String get newConversation => 'Percakapan baru';

  @override
  String get noMessages => 'Belum ada pesan.';

  @override
  String get messageHint => 'Tulis pesan';

  @override
  String get earlierMessages => 'Pesan sebelumnya';

  @override
  String get personLeftCompany =>
      'Orang ini sudah tidak lagi menjadi bagian dari perusahaan.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Grup baru';

  @override
  String get editGroup => 'Edit grup';

  @override
  String get groupName => 'Nama grup';

  @override
  String get groupMembersHint =>
      'Pilih orang-orang di grup ini. Hanya mereka yang melihat pesannya.';

  @override
  String get chooseAtLeastOne => 'Pilih setidaknya satu orang.';

  @override
  String get replyAction => 'Balas';

  @override
  String get translateAction => 'Terjemahkan';

  @override
  String replyingTo(String name) {
    return 'Membalas $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Pesan terakhir dari $name';
  }

  @override
  String get deleteAllNotices => 'Hapus semua';

  @override
  String get deleteAllNoticesConfirm => 'Hapus semua notifikasi?';

  @override
  String get noticeRetention => 'Hapus notifikasi yang sudah dibaca setelah';

  @override
  String get retentionDay => '1 hari';

  @override
  String get retentionWeek => '1 minggu';

  @override
  String get retentionMonth => '1 bulan';

  @override
  String get billingOwnersOnly => 'Hanya aktif jika Anda memiliki perusahaan.';

  @override
  String get readOnlyPastDays =>
      'Hari yang lewat lebih dari sebulan hanya bisa dibaca.';

  @override
  String get wholeCompany => 'Seluruh perusahaan';

  @override
  String get sitesLabel => 'Lokasi';

  @override
  String get actionSites => 'Lokasi…';

  @override
  String managerOf(String name) {
    return '$name bertanggung jawab atas';
  }

  @override
  String teamSitesOf(String name) {
    return 'Tim $name';
  }

  @override
  String get notYourSite => 'Lokasi ini bukan tanggung jawab Anda.';

  @override
  String get chooseYourSite => 'Pilih setidaknya satu lokasi.';

  @override
  String get viewRequests => 'Permintaan';

  @override
  String get newRequest => 'Permintaan baru';

  @override
  String get requestLeave => 'Cuti';

  @override
  String get requestUnavailability => 'Tidak tersedia';

  @override
  String get requestSwap => 'Tukar shift';

  @override
  String get swapHint =>
      'Untuk menawarkan tukar shift, ketuk salah satu shift mendatang Anda di jadwal.';

  @override
  String get noRequests => 'Belum ada permintaan.';

  @override
  String get requestsToHandle => 'Perlu ditangani';

  @override
  String get myRequests => 'Permintaan saya';

  @override
  String get otherRequests => 'Permintaan tim';

  @override
  String get statusPendingPeer => 'Menunggu rekan';

  @override
  String get statusPendingManager => 'Menunggu manajer';

  @override
  String get statusApproved => 'Disetujui';

  @override
  String get statusRefused => 'Ditolak';

  @override
  String get statusCancelled => 'Dibatalkan';

  @override
  String get cancelRequest => 'Batalkan permintaan';

  @override
  String get acceptSwap => 'Ambil shift ini';

  @override
  String get approve => 'Setujui';

  @override
  String periodLabel(String from, String to) {
    return 'Dari $from sampai $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Ditawarkan ke $name';
  }

  @override
  String get swapToTeam => 'Seluruh tim';

  @override
  String everyWeekdays(String days) {
    return 'Setiap minggu: $days';
  }

  @override
  String get unavailableEveryWeek => 'Hari Anda tidak pernah tersedia:';

  @override
  String get choosePeriod => 'Pilih tanggal';

  @override
  String get choosePeriodOptional => 'Batasi ke suatu periode (opsional)';

  @override
  String get clearPeriod => 'Tanpa periode';

  @override
  String get sendRequest => 'Kirim permintaan';

  @override
  String get proposeSwap => 'Tawarkan tukar shift';

  @override
  String get swapWith => 'Tawarkan ke';

  @override
  String get swapSteps =>
      'Rekan menerima, lalu manajer menyetujui. Jadwal baru berubah setelah itu.';

  @override
  String get absentThatDay => 'Ketidakhadiran disetujui pada hari itu';

  @override
  String get requestSent => 'Permintaan terkirim.';

  @override
  String noticeSwapOffer(String name) {
    return '$name menawarkan salah satu shift-nya kepada Anda.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name menolak tawaran tukar Anda.';
  }

  @override
  String get noticeSwapToApprove =>
      'Pertukaran shift menunggu persetujuan Anda.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name mengajukan cuti.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name menyatakan tidak tersedia.';
  }

  @override
  String get noticeRequestApproved => 'Permintaan Anda disetujui.';

  @override
  String get noticeRequestRefused => 'Permintaan Anda ditolak.';

  @override
  String get choosePeer => 'Siapa yang mengambil alih shift ini?';

  @override
  String get discardAll => 'Batalkan semua';

  @override
  String get notifySitesHint =>
      'Pilih lokasi yang notifikasi permintaannya Anda terima. Semua permintaan tetap terlihat di daftar.';

  @override
  String get notifySitesTitle => 'Notifikasi per lokasi';

  @override
  String get pendingRequestTooltip =>
      'Permintaan menunggu: ketuk untuk membuka';

  @override
  String get requestsHistory => 'Semua permintaan';

  @override
  String get revertChange => 'Batalkan perubahan ini';

  @override
  String get statusExpired => 'Tidak berlaku lagi';

  @override
  String get swapWithHint => 'Ketuk untuk memilih rekan tertentu';

  @override
  String changesDiscarded(String count) {
    return 'Perubahan dibatalkan: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Batalkan $count perubahan yang belum diterbitkan?';
  }

  @override
  String get allSchedules => 'Semua jadwal saya';

  @override
  String get busyElsewhere => 'Sudah bekerja di perusahaan lain pada jam ini';

  @override
  String get overlapTooltip => 'Bertabrakan dengan shift di perusahaan lain';

  @override
  String get overlapWarning =>
      'Beberapa shift Anda di dua perusahaan bertabrakan.';

  @override
  String noticeOverlap(String date) {
    return 'Dua shift Anda di perusahaan berbeda bertabrakan pada $date.';
  }

  @override
  String get allMyCompanies => 'Semua perusahaan saya';

  @override
  String get deleteGroup => 'Hapus grup';

  @override
  String get openRequest => 'Lihat permintaan';

  @override
  String get thisCompany => 'Perusahaan ini';

  @override
  String get withExtras => 'Termasuk pekerja lepas';

  @override
  String deleteGroupConfirm(String name) {
    return 'Hapus “$name” dan semua pesannya untuk semua orang?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Dari $company: akan ditambahkan sebagai tenaga bantuan dan diberi tahu.';
  }

  @override
  String get addToGoogle => 'Tambahkan ke Google Kalender';

  @override
  String get calendarEnabled => 'Sinkronkan shift saya';

  @override
  String get calendarHint =>
      'Tambahkan shift Anda dari semua perusahaan ke Google Kalender. Shift diperbarui otomatis, dan Anda bisa menonaktifkannya kapan saja.';

  @override
  String get changeSettings => 'Ubah';

  @override
  String get copyCalendarLink => 'Salin tautan kalender';

  @override
  String get countryBelgium => 'Belgia';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Prancis';

  @override
  String get countrySwitzerland => 'Swiss';

  @override
  String get employeesSection => 'Karyawan';

  @override
  String get emptyNoAlert => 'Kosong: tanpa peringatan';

  @override
  String get extrasSection => 'Pekerja lepas';

  @override
  String get googleCalendar => 'Google Kalender';

  @override
  String get hoursTotals => 'Total jam';

  @override
  String get legalAlerts => 'Peringatan hukum';

  @override
  String get legalAlertsHint =>
      'Hanya peringatan, tidak pernah memblokir. Pilih aturan yang berlaku bagi Anda, atau tidak sama sekali.';

  @override
  String get legalPreset => 'Templat negara';

  @override
  String get linkCopied => 'Tautan disalin.';

  @override
  String get maxConsecutiveLabel => 'Maksimum hari kerja berturut-turut';

  @override
  String get maxDayLabel => 'Durasi maksimum per hari (jam)';

  @override
  String get maxWeekLabel => 'Durasi maksimum per minggu (jam)';

  @override
  String get minRestLabel => 'Istirahat minimum antar-shift (jam)';

  @override
  String get noLegalRules => 'Tidak ada peringatan yang dipilih.';

  @override
  String get presetNone => 'Tidak ada';

  @override
  String get presetsCheck =>
      'Templat hanyalah titik awal: periksa sesuai aturan negara dan perjanjian kerja bersama Anda.';

  @override
  String get printMine => 'Jadwal saya';

  @override
  String get printOwn => 'Hanya jadwal sendiri';

  @override
  String get printPdf => 'Cetak / PDF';

  @override
  String get printRights => 'Yang boleh dicetak karyawan';

  @override
  String get printTeam => 'Jadwal seluruh tim';

  @override
  String get printTeamOption => 'Jadwal tim';

  @override
  String get totalsHint =>
      'Termasuk draf. Ekspor Excel dan CSV memakai jadwal yang diterbitkan.';

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
    return '$name: hanya $value istirahat (minimum $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value dalam seminggu (maksimum $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Peringatan hukum: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Shift: $count';
  }

  @override
  String get actionMakeDeputy => 'Angkat sebagai wakil manajer';

  @override
  String get actionRemoveDeputy => 'Cabut peran wakil manajer';

  @override
  String get busyHere => 'Sudah bekerja di perusahaan ini pada jam ini';

  @override
  String get calendarByLink => 'Lewat tautan (Google Kalender di komputer)';

  @override
  String get calendarDenied =>
      'Akses kalender ditolak. Izinkan di pengaturan ponsel.';

  @override
  String get calendarLinkHint =>
      'Tambahkan dari Google Kalender di komputer; Google memperbaruinya dalam beberapa jam.';

  @override
  String get calendarNone =>
      'Tidak ada kalender yang bisa diubah di ponsel ini.';

  @override
  String get calendarOnPhone => 'Tambahkan shift saya ke kalender ponsel';

  @override
  String get calendarOnPhoneHint =>
      'Di kalender Google Anda: langsung terlihat, di ponsel dan di Google Kalender.';

  @override
  String get chooseCalendar => 'Pilih kalender';

  @override
  String get otherSiteHint =>
      'Karyawan dari lokasi lain: manajernya akan diberi tahu.';

  @override
  String get subManager => 'Wakil manajer';

  @override
  String calendarSynced(String count) {
    return 'Shift di kalender: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Wakil manajer: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by menempatkan $name di lokasi $site pada $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company menambahkan Anda sebagai tenaga bantuan.';
  }

  @override
  String get companyNotificationsHint =>
      'Mati: tidak ada yang berbunyi di ponsel ini, tetapi semuanya tetap ada di lonceng.';

  @override
  String get companyNotificationsOn => 'Terima notifikasi dari perusahaan ini';

  @override
  String get companyTimezone => 'Zona waktu perusahaan';

  @override
  String get companyTimezoneHint =>
      'Semua jam perusahaan ini memakai zona waktu ini (termasuk waktu musim panas). Kalender mengonversinya otomatis.';

  @override
  String get iosInstallHint =>
      'Di iPhone: ketuk Bagikan, lalu “Tambah ke Layar Utama” untuk memasang Staff Flow.';

  @override
  String get searchCity => 'Cari kota';

  @override
  String get thisPhone => 'Perangkat ini';

  @override
  String companyNotifications(String name) {
    return 'Notifikasi: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Jam menurut waktu $zone ($company). Perangkat Anda: $here.';
  }

  @override
  String get addPreset => 'Tambah prasetel';

  @override
  String get addPresets => 'Buat prasetel';

  @override
  String get appearance => 'Tampilan';

  @override
  String get chooseLogo => 'Pilih gambar PNG';

  @override
  String get conversationMuted => 'Notifikasi percakapan ini dibisukan.';

  @override
  String get conversationUnmuted => 'Notifikasi percakapan ini aktif lagi.';

  @override
  String get customization => 'Personalisasi';

  @override
  String get disableGroup => 'Nonaktifkan grup';

  @override
  String get disableGroupConfirm =>
      'Grup seluruh perusahaan akan disembunyikan untuk semua orang. Anda bisa mengaktifkannya lagi di Pesan.';

  @override
  String get editPresets => 'Prasetel';

  @override
  String get enable => 'Aktifkan lagi';

  @override
  String get groupDisabled => 'Grup dinonaktifkan (hanya Anda yang melihatnya)';

  @override
  String get logoHint =>
      'Gambar PNG kecil (logo Anda) yang tampil di tab perusahaan untuk semua anggotanya.';

  @override
  String get logoPngOnly => 'Pilih gambar PNG maksimal 1 MB.';

  @override
  String get muteConversation => 'Bisukan percakapan ini';

  @override
  String get myIdentifier => 'ID saya';

  @override
  String get myProfile => 'Profil saya';

  @override
  String get presetName => 'Nama (mis. Pagi)';

  @override
  String get removeLogo => 'Hapus gambar';

  @override
  String get resetGroup => 'Atur ulang grup';

  @override
  String get resetGroupConfirm =>
      'Semua pesan di grup perusahaan akan dihapus untuk semua orang.';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get shiftPresets => 'Prasetel jam kerja';

  @override
  String get shiftPresetsHint =>
      'Jam siap pakai (pagi, sore, malam…): satu ketukan di shift mengisi jam mulai dan selesai.';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get unmuteConversation => 'Aktifkan notifikasi percakapan ini';

  @override
  String get awaitingApproval => 'Perlu disetujui';

  @override
  String get placementNeedsApproval =>
      '! Orang ini bukan dari lokasi Anda: shift akan menunggu persetujuan atasan Anda atau pemilik sebelum bisa diterbitkan. Jika tidak, pilih orang lain.';

  @override
  String get placementAwaiting => 'Menunggu persetujuan atasan atau pemilik.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by ingin menjadwalkan $name dari lokasi lain pada $date: perlu persetujuan.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by menyetujui penjadwalan $name pada $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by menolak penjadwalan $name pada $date.';
  }

  @override
  String get addSubSite => 'Tambah sub-lokasi';

  @override
  String get moveSite => 'Pindahkan';

  @override
  String get topLevel => 'Tingkat teratas';

  @override
  String moveSiteTitle(String name) {
    return 'Pindahkan “$name” ke bawah…';
  }

  @override
  String subSiteOf(String name) {
    return 'Sub-lokasi dari $name';
  }

  @override
  String get siteTreeHint =>
      'Hingga 3 tingkat, mis. Wilayah › Kota › Toko. Manajer suatu lokasi juga mengelola semua yang ada di bawahnya.';

  @override
  String get subSitesOnlyHint =>
      'Di sini Anda menambah sub-lokasi di bawah lokasi Anda sendiri.';

  @override
  String get messagingSetting => 'Pesan perusahaan';

  @override
  String get messagingSettingHint =>
      'Aktif: tim punya tab Pesan. Nonaktif: tidak ada yang melihatnya atau bisa menulis (pesan lama tetap disimpan).';

  @override
  String get billingTitle => 'Langganan';

  @override
  String billingStatusTrial(String date) {
    return 'Uji coba gratis hingga $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Dibayar hingga $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Hanya-baca: tanpa pembayaran, perusahaan akan dihapus pada $date.';
  }

  @override
  String get billingStatusComped => 'Gratis';

  @override
  String billingStaff(String count) {
    return '$count karyawan dihitung (tanpa pemilik dan pekerja sementara)';
  }

  @override
  String get billingMonthly => 'Bulanan';

  @override
  String billingYearly(String months) {
    return 'Tahunan ($months bulan ditagih)';
  }

  @override
  String get billingCascade => 'Opsi “lokasi bertingkat”';

  @override
  String billingCascadeIncluded(String count) {
    return 'Termasuk mulai $count karyawan';
  }

  @override
  String billingPay(String amount) {
    return 'Bayar $amount';
  }

  @override
  String get billingTestNotice => 'Pembayaran uji: tidak ada yang ditagih.';

  @override
  String get billingSoon => 'Pembayaran online segera hadir.';

  @override
  String get billingPaidOk => 'Pembayaran tercatat.';

  @override
  String get billingInvoices => 'Faktur';

  @override
  String get billingNoInvoices => 'Belum ada faktur.';

  @override
  String get billingManage => 'Kelola langganan';

  @override
  String get billingReadOnlyStaff =>
      'Perusahaan ini hanya-baca sampai pemilik memperpanjang langganan.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / bulan';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / tahun';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: uji coba gratis berakhir dalam kurang dari 24 jam.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company hanya-baca karena belum dibayar; dihapus pada $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Pengingat: tanpa pembayaran, $company akan dihapus pada $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company dihapus karena tidak dibayar.';
  }

  @override
  String billingCompanyId(String id) {
    return 'ID perusahaan: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Hari ini: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Termasuk sisa bulan ini ($days hari, prorata), lalu bulan penuh mulai tanggal 1.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Belum terhubung. Digunakan untuk memverifikasi identitas Anda, misalnya saat mengganti akun Google.';

  @override
  String telegramLinked(String name) {
    return 'Terhubung: $name';
  }

  @override
  String get telegramNoUsername => 'tanpa nama pengguna';

  @override
  String get telegramLink => 'Hubungkan Telegram saya';

  @override
  String get telegramLinkHint =>
      'Telegram akan terbuka: ketuk “Mulai”, lalu kembali ke sini.';

  @override
  String get telegramUnlink => 'Putuskan';

  @override
  String get telegramUnavailable => 'Telegram belum tersedia.';

  @override
  String get telegramShowIn => 'Tampilkan Telegram saya di:';

  @override
  String get newQrCode => 'Ganti kode QR';

  @override
  String get newQrCodeConfirm =>
      'Kode QR lama dan ID lama Anda tidak akan berfungsi lagi. Posisi Anda di perusahaan tidak berubah.';

  @override
  String get newQrCodeDone => 'Kode QR baru dibuat.';

  @override
  String get changeGoogle => 'Ganti akun Google';

  @override
  String get changeGoogleSub => 'Akun sama, nomor sama, perusahaan sama';

  @override
  String changeGoogleSteps(String id) {
    return '1. Hubungkan Telegram Anda di profil ini (wajib).\n2. Keluar, lalu masuk dengan akun Google yang baru.\n3. Pilih “Saya sudah punya akun Staff Flow” dan masukkan ID Anda $id.\n4. Masukkan kode yang diterima di Telegram.\nAkun, nomor, dan perusahaan Anda tetap sama.';
  }

  @override
  String get recoverAccount => 'Saya sudah punya akun Staff Flow';

  @override
  String get recoverHint =>
      'Masukkan ID akun lama Anda (SF-…). Kode akan dikirim ke Telegram yang terhubung dengan akun itu.';

  @override
  String get recoverIdLabel => 'ID (SF-…)';

  @override
  String get recoverSend => 'Kirim kode';

  @override
  String get recoverCodeSent => 'Kode dikirim lewat Telegram.';

  @override
  String get recoverCodeLabel => 'Kode yang diterima (6 digit)';

  @override
  String get recoverConfirm => 'Pulihkan akun saya';

  @override
  String get recoverDone => 'Selesai: Anda kembali ke akun Anda.';

  @override
  String get exportData => 'Ekspor data saya';

  @override
  String get exportDataSub => 'File berisi semua data pribadi Anda';

  @override
  String get deleteAccount => 'Hapus akun saya';

  @override
  String get deleteGhost => 'Hapus dengan menyisakan hantu';

  @override
  String get deleteGhostHint =>
      'Anda keluar dari semua perusahaan. Masuk lagi nanti dengan akun Google yang sama untuk mendapatkan kembali akun dan nomor Anda.';

  @override
  String get deleteErase => 'Hapus semuanya secara permanen';

  @override
  String get deleteEraseHint =>
      'Nama, email, foto, Telegram, pesan, dan notifikasi akan dihapus. Tidak bisa dibatalkan.';

  @override
  String get deleteGhostNote =>
      'Dalam kedua kasus, riwayat perusahaan menyimpan “Ghost” anonim sebagai pengganti Anda (permintaan cuti, shift lampau…) agar pemilik dan manajer dapat menelusuri kejadian.';

  @override
  String get deleteOwnerNote =>
      'Pemilik perusahaan? Alihkan dulu, atau biarkan langganannya berakhir.';

  @override
  String get deleteConfirmButton => 'Hapus';

  @override
  String get accountRestored => 'Selamat datang kembali! Akun Anda aktif lagi.';

  @override
  String get closedInvoices => 'Faktur perusahaan yang ditutup';

  @override
  String get downloadAllInvoices => 'Unduh semua faktur (ZIP)';

  @override
  String get legalTerms => 'Ketentuan penggunaan dan penjualan';

  @override
  String get legalPrivacy => 'Kebijakan privasi';

  @override
  String get billingDetailTitle => 'Rincian pembayaran';

  @override
  String billingLineProrata(String days, String total) {
    return 'Sisa bulan ini ($days dari $total hari): langganan';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Sisa bulan ini ($days dari $total hari): opsi “lokasi bertingkat”';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Langganan, $staff karyawan: 1 bulan';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Langganan, $staff karyawan: 12 bulan dengan harga $paid bulan';
  }

  @override
  String billingLineCascade(String months) {
    return 'Opsi “lokasi bertingkat”: $months bulan, tanpa diskon';
  }

  @override
  String get billingTotal => 'Total';

  @override
  String billingCovers(String from, String to) {
    return 'Periode: $from sampai $to';
  }

  @override
  String get billingGraceInvoices =>
      'Perusahaan ini tidak diperpanjang: unduh semua fakturnya sekarang.';

  @override
  String get billingYearLabel => 'Tahun';

  @override
  String get sitesNoneChosen => 'Belum ada lokasi dipilih';

  @override
  String get avatarTitle => 'Avatar saya';

  @override
  String get avatarSub => 'Gambar sebagai pengganti foto Anda';

  @override
  String get avatarUseGoogle => 'Pakai foto Google saya';

  @override
  String get avatarColor => 'Warna';

  @override
  String get hidePhotosTitle => 'Sembunyikan foto Google';

  @override
  String get hidePhotosSub =>
      'Di perusahaan ini, semua orang tampil dengan avatar atau inisialnya.';

  @override
  String get billingApi => 'Opsi “akses API”';

  @override
  String billingLineApi(String months) {
    return 'Opsi “akses API”: $months bulan, tanpa diskon';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Sisa bulan ini ($days dari $total hari): opsi “akses API”';
  }

  @override
  String get apiTitle => 'Akses API (akuntansi, CRM)';

  @override
  String get apiSub =>
      'Perangkat lunak akuntansi, penggajian, atau CRM Anda membaca jadwal yang diterbitkan, jam kerja, dan ketidakhadiran.';

  @override
  String get apiNeedsOption =>
      'Opsi berbayar: tambahkan “akses API” di “Kelola langganan”.';

  @override
  String get apiNewKey => 'Kunci baru';

  @override
  String get apiKeyName => 'Nama kunci (mis.: aplikasi penggajian)';

  @override
  String get apiKeyCreated =>
      'Salin kunci ini sekarang dan simpan dengan aman: kunci tidak akan ditampilkan lagi.';

  @override
  String get apiKeyCopy => 'Salin';

  @override
  String get apiKeyCopied => 'Kunci disalin.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Terakhir dipakai: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Belum pernah dipakai';

  @override
  String get apiRevoke => 'Cabut';

  @override
  String get apiRevokeConfirm =>
      'Perangkat lunak yang memakai kunci ini akan kehilangan akses.';

  @override
  String get apiDocs => 'Dokumentasi API';

  @override
  String get memberGoogleLink => 'Tautan untuk mengganti akun Google';

  @override
  String googleLinkHint(String name) {
    return 'Kirim tautan ini ke $name. Tautan dibuka di peramban (bukan di aplikasi Android), sekali saja, selama 24 jam: $name masuk dengan akun Google barunya dan mendapatkan kembali akunnya. Semua perangkatnya yang lain lalu dikeluarkan.';
  }

  @override
  String get googleLinkCopied => 'Tautan disalin.';

  @override
  String get switchBanner =>
      'Tautan penggantian akun Google: masuk dengan akun Google baru Anda untuk mendapatkan kembali akun Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Tautan ini menghubungkan akun Staff Flow ke akun Google baru. Keluar dulu, lalu masuk dengan akun Google yang baru.';

  @override
  String get switchDone =>
      'Selesai: akun Staff Flow Anda terhubung ke akun Google ini. Perangkat Anda yang lain telah dikeluarkan.';

  @override
  String changeGoogleBot(String bot) {
    return 'Cara termudah: di Telegram, kirim /changegoogle ke bot $bot dan ikuti petunjuknya, lalu masuk dengan akun Google baru dalam 10 menit.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Tanpa Telegram: minta tautan penggantian akun Google kepada pemilik atau manajer.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name membuat tautan untuk menghubungkan akun Anda ke akun Google baru. Jika Anda tidak memintanya, beri tahu manajer Anda.';
  }

  @override
  String get sessionRevoked =>
      'Anda telah dikeluarkan: akun Anda kini terhubung ke akun Google lain.';

  @override
  String telegramLoginHint(String bot) {
    return 'Tips: kirim /connexion ke bot $bot untuk mendapatkan tautan dan membuka Staff Flow di peramban, tanpa aplikasi atau akun Google.';
  }
}
