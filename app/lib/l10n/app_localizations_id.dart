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
  String get viewTeam => 'Tim';

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
}
