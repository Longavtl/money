// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Money Wave';

  @override
  String get appTagline => 'Hitung Masa Depan Anda';

  @override
  String get home => 'Beranda';

  @override
  String get saved => 'Tersimpan';

  @override
  String get history => 'Riwayat';

  @override
  String get settings => 'Pengaturan';

  @override
  String get compare => 'Bandingkan';

  @override
  String get simulate => 'Simulasi';

  @override
  String get mainTools => 'Alat Utama';

  @override
  String categories(int count) {
    return '$count KATEGORI';
  }

  @override
  String get loanCalc => 'Pinjaman';

  @override
  String get loanCalcSubtitle => 'Cicilan bulanan';

  @override
  String get interestCalc => 'Bunga';

  @override
  String get interestCalcSubtitle => 'Sederhana & majemuk';

  @override
  String get vault => 'Brankas';

  @override
  String get vaultSubtitle => 'Rencanakan masa depan';

  @override
  String get historySubtitle => 'Perhitungan sebelumnya';

  @override
  String get proAccess => 'AKSES PRO';

  @override
  String get upgradeToPremium => 'Upgrade ke Premium';

  @override
  String get premiumBannerDesc =>
      'Buka grafik canggih dan\npengalaman bebas iklan.';

  @override
  String get marketPulse => 'DENYUT PASAR';

  @override
  String get currentRates => 'Suku bunga saat ini';

  @override
  String get homeLoan => 'Kredit Rumah';

  @override
  String get savingsApy => 'APY Tabungan';

  @override
  String get calculatorSimpleInterest => 'Bunga Sederhana';

  @override
  String get calculatorCompoundInterest => 'Bunga Majemuk';

  @override
  String get calculatorLoan => 'Kalkulator Pinjaman';

  @override
  String get calculatorSavings => 'Kalkulator Tabungan';

  @override
  String get principal => 'Pokok';

  @override
  String get interestRate => 'Suku Bunga';

  @override
  String get annualInterestRate => 'Suku Bunga (Tahunan)';

  @override
  String get term => 'Jangka Waktu';

  @override
  String get termMonths => 'Jangka Waktu (bulan)';

  @override
  String get termYears => 'Jangka Waktu (tahun)';

  @override
  String get monthlyPayment => 'Cicilan Bulanan';

  @override
  String get firstMonthPayment => 'Cicilan Bulan Pertama';

  @override
  String get lastMonthPayment => 'Cicilan Bulan Terakhir';

  @override
  String get totalInterest => 'Total Bunga';

  @override
  String get totalPayment => 'Total Pembayaran';

  @override
  String get interest => 'Bunga';

  @override
  String get totalAmount => 'Jumlah Total';

  @override
  String get interestPrincipalRatio => 'Rasio Bunga/Pokok';

  @override
  String get loanAmount => 'Jumlah Pinjaman';

  @override
  String get paymentMethod => 'Metode Pembayaran';

  @override
  String get loanTypeFixed => 'Cicilan Tetap';

  @override
  String get loanTypeReducing => 'Saldo Menurun';

  @override
  String get savingsTypeReinvest => 'Investasi Ulang';

  @override
  String get savingsTypeWithdraw => 'Tarik';

  @override
  String get results => 'Hasil';

  @override
  String get paymentStructure => 'Struktur Pembayaran';

  @override
  String get amortizationSchedule => 'Jadwal Amortisasi';

  @override
  String get month => 'Bulan';

  @override
  String get year => 'Tahun';

  @override
  String get years => 'tahun';

  @override
  String get payment => 'Pembayaran';

  @override
  String get principalPaid => 'Pokok';

  @override
  String get interestPaid => 'Bunga';

  @override
  String get balance => 'Saldo';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Hapus';

  @override
  String get share => 'Bagikan';

  @override
  String get exportPdf => 'Ekspor PDF';

  @override
  String get calculate => 'Hitung';

  @override
  String get reset => 'Reset';

  @override
  String get close => 'Tutup';

  @override
  String get add => 'Tambah';

  @override
  String get storageLimitTitle => 'Batas Penyimpanan';

  @override
  String storageLimitLoans(int count) {
    return 'Anda telah menyimpan maksimal $count pinjaman. Upgrade ke Premium untuk simpan tanpa batas!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'Anda telah menyimpan maksimal $count tabungan. Upgrade ke Premium untuk simpan tanpa batas!';
  }

  @override
  String get saveLoan => 'Simpan Pinjaman';

  @override
  String get loanNameHint => 'Nama pinjaman (opsional)';

  @override
  String get amount => 'Jumlah';

  @override
  String get rate => 'Bunga';

  @override
  String get loanSaved => 'Pinjaman disimpan';

  @override
  String get saveSavings => 'Simpan Tabungan';

  @override
  String get savingsNameHint => 'Nama tabungan (opsional)';

  @override
  String get savingsSaved => 'Tabungan disimpan';

  @override
  String get savedLoans => 'Pinjaman Tersimpan';

  @override
  String get savedSavings => 'Tabungan Tersimpan';

  @override
  String loansCount(int count) {
    return 'Pinjaman ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'Tabungan ($count)';
  }

  @override
  String get noSavedItems => 'Belum ada item tersimpan';

  @override
  String get noSavedLoans => 'Belum ada pinjaman tersimpan';

  @override
  String get noSavedLoansSubtitle =>
      'Hitung dan simpan pinjaman untuk dilihat nanti';

  @override
  String get noSavedSavings => 'Belum ada tabungan tersimpan';

  @override
  String get noSavedSavingsSubtitle =>
      'Hitung dan simpan tabungan untuk dilihat nanti';

  @override
  String errorLoading(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get compoundingFrequency => 'Frekuensi Bunga Majemuk';

  @override
  String get daily => 'Harian';

  @override
  String get monthly => 'Bulanan';

  @override
  String get quarterly => 'Triwulan';

  @override
  String get yearly => 'Tahunan';

  @override
  String get calculationResults => 'Hasil Perhitungan';

  @override
  String get totalReceived => 'Total Diterima';

  @override
  String get interestEarned => 'Bunga Diperoleh';

  @override
  String get effectiveAnnualRate => 'Suku Bunga Efektif Tahunan';

  @override
  String get compoundingPeriods => 'Periode Bunga Majemuk';

  @override
  String get compareWithSimple => 'Bandingkan dengan Bunga Sederhana';

  @override
  String get simpleInterest => 'Bunga Sederhana';

  @override
  String get compoundInterest => 'Bunga Majemuk';

  @override
  String compoundBenefit(String amount) {
    return 'Bunga majemuk menghasilkan $amount lebih banyak';
  }

  @override
  String get savingsType => 'Jenis Tabungan';

  @override
  String get initialDeposit => 'Setoran Awal';

  @override
  String get monthlyDeposit => 'Setoran Bulanan';

  @override
  String get annualRate => 'Suku Bunga Tahunan';

  @override
  String get finalBalance => 'Saldo Akhir';

  @override
  String get totalDeposited => 'Total Disetor';

  @override
  String get returnRate => 'Tingkat Pengembalian';

  @override
  String get avgMonthlyInterest => 'Bunga Bulanan Rata-rata';

  @override
  String get detailedAnalysis => 'Analisis Detail';

  @override
  String get deposits => 'Setoran';

  @override
  String get reinvestInfo => 'Bunga dimajemukkan setiap bulan';

  @override
  String get withdrawInfo => 'Bunga dibayar bulanan, tidak dimajemukkan';

  @override
  String get averageMonthlyInterest => 'Rata-rata Bunga/Bulan';

  @override
  String get totalStructure => 'Struktur Total';

  @override
  String get premium => 'Upgrade ke Premium';

  @override
  String get premiumActivated => 'Anda Premium!';

  @override
  String get premiumMember => 'Anggota Premium';

  @override
  String get premiumThanks => 'Terima kasih atas dukungannya!';

  @override
  String get premiumDescription => 'Buka semua fitur';

  @override
  String get premiumFeature1 => 'Simpan tanpa batas';

  @override
  String get premiumFeature1Desc => 'Simpan semua pinjaman dan tabungan Anda';

  @override
  String get premiumFeature2 => 'Grafik lengkap';

  @override
  String get premiumFeature2Desc => 'Lihat detail dengan semua jenis grafik';

  @override
  String get premiumFeature3 => 'Perbandingan skenario';

  @override
  String get premiumFeature3Desc => 'Bandingkan beberapa opsi berdampingan';

  @override
  String get premiumFeature4 => 'Ekspor PDF';

  @override
  String get premiumFeature4Desc =>
      'Buat laporan detail untuk cetak atau bagikan';

  @override
  String get premiumFeature5 => 'Dukung pengembangan';

  @override
  String get premiumFeature5Desc => 'Bantu kami memperbaiki aplikasi';

  @override
  String get premiumFeatures => 'Fitur Premium';

  @override
  String get lifetime => 'Seumur hidup';

  @override
  String get oneTimePurchase => 'Bayar sekali, gunakan selamanya';

  @override
  String get upgradeNow => 'Upgrade Sekarang';

  @override
  String get restorePurchase => 'Pulihkan Pembelian';

  @override
  String purchaseDate(String date) {
    return 'Tanggal pembelian: $date';
  }

  @override
  String get premiumRequired => 'Diperlukan Premium';

  @override
  String get premiumMonthlyTitle => 'Premium Monthly Subscription';

  @override
  String get premiumYearlyTitle => 'Premium Yearly Subscription';

  @override
  String get premiumLifetimeTitle => 'Premium Lifetime Access';

  @override
  String get billedMonthly => 'Billed monthly';

  @override
  String get billedAnnually => 'Billed annually';

  @override
  String get payOnceOwnForever => 'Pay once, own forever';

  @override
  String get perMonth => 'per month';

  @override
  String get perYear => 'per year';

  @override
  String get oneTime => 'one-time';

  @override
  String get subscriptionPaymentInfo =>
      'Payment will be charged to your Apple ID account at confirmation of purchase.';

  @override
  String get subscriptionAutoRenewInfo =>
      'Subscriptions automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period. You can manage and cancel subscriptions in your App Store account settings.';

  @override
  String upgradeTo(String feature) {
    return 'Upgrade ke $feature';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => 'Aktif';

  @override
  String get unlockAllFeatures => 'Buka semua fitur';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get language => 'Bahasa';

  @override
  String get about => 'Tentang';

  @override
  String version(String version) {
    return 'Versi $version';
  }

  @override
  String get termsOfService => 'Ketentuan Layanan';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get termsOfUse => 'Syarat Penggunaan (EULA)';

  @override
  String get error => 'Kesalahan';

  @override
  String get errorGeneric => 'Terjadi kesalahan';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get compareScenarios => 'Bandingkan Skenario';

  @override
  String get upgradeToCompare => 'Upgrade untuk membandingkan';

  @override
  String get loanSettings => 'Pengaturan Pinjaman';

  @override
  String get scenarioA => 'Skenario A';

  @override
  String get scenarioB => 'Skenario B';

  @override
  String get comparison => 'Perbandingan';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'Skenario $scenario menghemat $amount';
  }

  @override
  String get simulation => 'Simulasi';

  @override
  String get noScenariosYet => 'Belum ada skenario';

  @override
  String get addScenariosSubtitle =>
      'Tambahkan pinjaman atau tabungan\nuntuk simulasi keuangan Anda';

  @override
  String get addLoan => 'Tambah Pinjaman';

  @override
  String get addSavings => 'Tambah Tabungan';

  @override
  String get loans => 'Pinjaman';

  @override
  String get savings => 'Tabungan';

  @override
  String get timeline => 'Timeline';

  @override
  String monthNumber(int number) {
    return 'Bulan $number';
  }

  @override
  String get netWorth => 'Kekayaan Bersih';

  @override
  String get positive => 'Positif';

  @override
  String get negativeDebt => 'Negatif (hutang)';

  @override
  String get now => 'Sekarang';

  @override
  String yearsCount(int count) {
    return '$count tahun';
  }

  @override
  String get debt => 'Hutang';

  @override
  String get remaining => 'Tersisa';

  @override
  String get clearAll => 'Hapus Semua?';

  @override
  String get allScenariosDeleted => 'Semua skenario akan dihapus.';

  @override
  String get loanNameHintExample => 'Nama pinjaman (cth. KPR)';

  @override
  String get savingsNameHintExample => 'Nama (cth. Dana Pensiun)';

  @override
  String get deposit => 'Setoran';

  @override
  String get loan => 'Pinjaman';

  @override
  String get selectThemeDescription => 'Pilih tema untuk aplikasi Anda';

  @override
  String get selectLanguageDescription => 'Pilih bahasa pilihan Anda';

  @override
  String get apply => 'Terapkan';

  @override
  String get financialTools => 'Alat Keuangan';

  @override
  String get reminders => 'Pengingat';

  @override
  String get paymentRemindersSubtitle => 'Lacak jatuh tempo';

  @override
  String get savingsGoalsSubtitle => 'Capai tujuan Anda';

  @override
  String get calendar => 'Kalender';

  @override
  String get calendarSubtitle => 'Lihat semua acara';

  @override
  String get achievementsSubtitle => 'Kemajuan Anda';

  @override
  String get reportsSubtitle => 'Lihat statistik';

  @override
  String get rateAlertsSubtitle => 'Pantau suku bunga';

  @override
  String get paymentReminders => 'Pengingat Pembayaran';

  @override
  String get noRemindersYet => 'Belum ada pengingat';

  @override
  String get addRemindersSubtitle => 'Tambahkan pengingat pembayaran';

  @override
  String get addReminder => 'Tambah Pengingat';

  @override
  String get editReminder => 'Edit Pengingat';

  @override
  String get reminderNameHint => 'Nama pengingat (cth. Kartu Kredit)';

  @override
  String get dueDate => 'Tanggal Jatuh Tempo';

  @override
  String get remindBefore => 'Ingatkan Sebelum';

  @override
  String get days => 'hari';

  @override
  String get recurring => 'Berulang';

  @override
  String get totalDue => 'Total Jatuh Tempo';

  @override
  String get overdue => 'Terlambat';

  @override
  String get upcoming => 'Akan Datang';

  @override
  String get completed => 'Selesai';

  @override
  String get markAsPaid => 'Tandai Lunas';

  @override
  String get markAsPaidConfirm => 'Yakin tandai sebagai lunas?';

  @override
  String get pending => 'Tertunda';

  @override
  String get paid => 'Lunas';

  @override
  String get skipped => 'Dilewati';

  @override
  String get markPaid => 'Tandai Lunas';

  @override
  String get weekly => 'Mingguan';

  @override
  String get biWeekly => 'Dua Mingguan';

  @override
  String get dueToday => 'Jatuh tempo hari ini';

  @override
  String get dueTomorrow => 'Jatuh tempo besok';

  @override
  String dueInDays(int days) {
    return 'Jatuh tempo dalam $days hari';
  }

  @override
  String get pleaseEnterName => 'Silakan masukkan nama';

  @override
  String get savingsGoals => 'Target Tabungan';

  @override
  String get noGoalsYet => 'Belum ada target';

  @override
  String get addGoalsSubtitle => 'Tetapkan target tabungan dan lacak kemajuan';

  @override
  String get addGoal => 'Tambah Target';

  @override
  String get editGoal => 'Edit Target';

  @override
  String get goalNameHint => 'Nama target (cth. Liburan)';

  @override
  String get targetAmount => 'Jumlah Target';

  @override
  String get initialAmount => 'Jumlah Awal';

  @override
  String get deadline => 'Tenggat Waktu';

  @override
  String get suggestedMonthly => 'Saran Bulanan';

  @override
  String get activeGoals => 'Target Aktif';

  @override
  String get completedGoals => 'Target Tercapai';

  @override
  String get totalSaved => 'Total Tersimpan';

  @override
  String get totalTarget => 'Total Target';

  @override
  String get ofTotalTarget => 'dari total target';

  @override
  String get milestones => 'Pencapaian';

  @override
  String get addMoney => 'Tambah Dana';

  @override
  String get withdraw => 'Tarik';

  @override
  String get addContribution => 'Tambah Kontribusi';

  @override
  String get notesOptional => 'Catatan (opsional)';

  @override
  String get withdrawReason => 'Alasan penarikan';

  @override
  String get noContributionsYet => 'Belum ada kontribusi';

  @override
  String get pauseGoal => 'Jeda Target';

  @override
  String get deleteGoal => 'Hapus Target';

  @override
  String get deleteGoalConfirm => 'Yakin hapus target ini?';

  @override
  String get target => 'Target';

  @override
  String get goals => 'Target';

  @override
  String savePerMonth(String amount) {
    return 'Simpan $amount/bulan untuk mencapai target';
  }

  @override
  String get pleaseEnterGoalName => 'Silakan masukkan nama target';

  @override
  String get withdrawal => 'Penarikan';

  @override
  String get start => 'Mulai';

  @override
  String get goalReached => 'Target Tercapai!';

  @override
  String get progress => 'Kemajuan';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get financialHealthScore => 'Skor Kesehatan Keuangan';

  @override
  String get financialHealth => 'Kesehatan Keuangan';

  @override
  String get points => 'poin';

  @override
  String get healthExcellent => 'Sangat baik! Pertahankan!';

  @override
  String get healthGood => 'Kemajuan bagus! Anda di jalur yang benar.';

  @override
  String get healthFair => 'Cukup. Ada ruang untuk perbaikan.';

  @override
  String get healthNeedsWork => 'Perlu perhatian. Mari perbaiki bersama!';

  @override
  String get paymentStreak => 'Streak Pembayaran';

  @override
  String get dayStreak => 'hari berturut-turut';

  @override
  String get keepItUp => 'Pertahankan!';

  @override
  String get longest => 'Terpanjang';

  @override
  String get unlocked => 'Terbuka';

  @override
  String get locked => 'Terkunci';

  @override
  String get financialCalendar => 'Kalender Keuangan';

  @override
  String get monthView => 'Tampilan Bulan';

  @override
  String get weekView => 'Tampilan Minggu';

  @override
  String get today => 'Hari Ini';

  @override
  String get noEventsForDay => 'Tidak ada acara hari ini';

  @override
  String get goalDeadline => 'Tenggat Target';

  @override
  String get contribution => 'Kontribusi';

  @override
  String get reports => 'Laporan';

  @override
  String get week => 'Minggu';

  @override
  String get quarter => 'Kuartal';

  @override
  String get allTime => 'Semua Waktu';

  @override
  String get totalPaid => 'Total Dibayar';

  @override
  String get totalDebt => 'Total Hutang';

  @override
  String get debtVsPaid => 'Hutang vs Dibayar';

  @override
  String get outstanding => 'Belum Dibayar';

  @override
  String get noDataYet => 'Belum ada data';

  @override
  String get monthlyOverview => 'Ringkasan Bulanan';

  @override
  String get due => 'Jatuh Tempo';

  @override
  String get paymentPerformance => 'Performa Pembayaran';

  @override
  String get onTime => 'Tepat Waktu';

  @override
  String get late => 'Terlambat';

  @override
  String get onTimeRate => 'Tingkat Tepat Waktu';

  @override
  String get rateAlerts => 'Peringatan Suku Bunga';

  @override
  String get currentMarketRates => 'Suku Bunga Pasar Saat Ini';

  @override
  String get edit => 'Edit';

  @override
  String get triggeredAlerts => 'Peringatan Aktif';

  @override
  String get activeAlerts => 'Peringatan Aktif';

  @override
  String get inactiveAlerts => 'Peringatan Nonaktif';

  @override
  String get noAlertsYet => 'Belum ada peringatan';

  @override
  String get addAlertsSubtitle =>
      'Tambah peringatan untuk melacak perubahan suku bunga';

  @override
  String get addAlert => 'Tambah Peringatan';

  @override
  String get alertNameHint => 'Nama peringatan (cth. Suku Bunga KPR)';

  @override
  String get loanType => 'Jenis Pinjaman';

  @override
  String get alertWhen => 'Peringatan Saat';

  @override
  String get rateDrops => 'Suku Bunga Turun';

  @override
  String get rateRises => 'Suku Bunga Naik';

  @override
  String get targetRate => 'Suku Bunga Target';

  @override
  String get when => 'Kapan';

  @override
  String get current => 'Saat Ini';

  @override
  String get triggered => 'Aktif';

  @override
  String get editMarketRates => 'Edit Suku Bunga Pasar';

  @override
  String get personalLoan => 'Pinjaman Pribadi';

  @override
  String get carLoan => 'Kredit Mobil';

  @override
  String get savingsRate => 'Suku Bunga Tabungan';

  @override
  String get homeShort => 'Rumah';

  @override
  String get personalShort => 'Pribadi';

  @override
  String get carShort => 'Mobil';

  @override
  String get savingsShort => 'Tabungan';

  @override
  String get rateDropAlert => 'Peringatan Suku Bunga Turun!';

  @override
  String get rateIncreaseAlert => 'Peringatan Suku Bunga Naik!';

  @override
  String get updated => 'Diperbarui';

  @override
  String get newUpdateAvailable => 'Pembaruan tersedia';

  @override
  String get updateAppMessage =>
      'Versi baru tersedia. Perbarui untuk mendapatkan fitur dan perbaikan terbaru.';

  @override
  String get updateNow => 'Perbarui sekarang';

  @override
  String get later => 'Nanti';

  @override
  String get qrTools => 'Alat QR';

  @override
  String get createQRCode => 'Buat Kode QR';

  @override
  String get createQRSubtitle => 'Buat kode QR';

  @override
  String get scanQRCode => 'Pindai Kode QR';

  @override
  String get scanQRSubtitle => 'Pindai kode QR apapun';

  @override
  String get selectQRType => 'Pilih Jenis QR';

  @override
  String get qrLink => 'Tautan';

  @override
  String get qrText => 'Teks';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => 'Kontak';

  @override
  String get qrCode => 'Kode QR';

  @override
  String get websiteAddress => 'Alamat Website';

  @override
  String get textContent => 'Konten Teks';

  @override
  String get enterContent => 'Masukkan konten Anda di sini';

  @override
  String get networkNameSSID => 'Nama Jaringan (SSID)';

  @override
  String get wifiPasswordLabel => 'Kata Sandi';

  @override
  String get encryptionType => 'Jenis Enkripsi';

  @override
  String get noEncryption => 'Tanpa Enkripsi';

  @override
  String get contactName => 'Nama Kontak';

  @override
  String get contactNameHint => 'Budi Santoso';

  @override
  String get phoneNumber => 'Nomor Telepon';

  @override
  String get generateQRButton => 'Buat Kode QR';

  @override
  String get qrGeneratedOnDevice => 'Kode QR dibuat di perangkat Anda';

  @override
  String get qrLinkInfo =>
      'Masukkan URL untuk membuat kode QR yang membuka tautan saat dipindai.';

  @override
  String get qrWifiInfo =>
      'Buat kode QR agar orang lain dapat terhubung ke WiFi Anda dengan cepat.';

  @override
  String get pleaseEnterWebsite => 'Silakan masukkan alamat website';

  @override
  String get pleaseEnterTextContent => 'Silakan masukkan konten teks';

  @override
  String get pleaseEnterWifiName => 'Silakan masukkan nama jaringan WiFi';

  @override
  String get pleaseEnterContactName => 'Silakan masukkan nama kontak';

  @override
  String get copy => 'Salin';

  @override
  String get copyData => 'Salin Data';

  @override
  String get dataCopied => 'Data disalin ke clipboard';

  @override
  String get saveToGallery => 'Simpan ke Galeri';

  @override
  String get qrPrivacyNote =>
      'Kode QR ini dibuat secara lokal di perangkat Anda dan tidak dikirim ke server manapun.';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return 'Kontak: $name';
  }

  @override
  String get cannotCreateQRImage => 'Tidak dapat membuat gambar QR';

  @override
  String get cannotSaveQR => 'Tidak dapat menyimpan kode QR';

  @override
  String get qrSavedToGallerySuccess => 'Kode QR disimpan ke galeri';

  @override
  String errorWithMessage(String message) {
    return 'Kesalahan: $message';
  }

  @override
  String get scanAgain => 'Pindai Lagi';

  @override
  String get openLink => 'Buka Tautan';

  @override
  String get copyPassword => 'Salin Kata Sandi';

  @override
  String get passwordCopied => 'Kata sandi disalin ke clipboard';

  @override
  String get noQRCodeFound => 'Tidak ada kode QR ditemukan di gambar';

  @override
  String get pointCameraAtQR => 'Arahkan kamera ke kode QR';

  @override
  String get scanFromGallery => 'Pindai dari galeri';

  @override
  String get websiteLink => 'Tautan Website';

  @override
  String get wifiNetworkLabel => 'Jaringan WiFi';

  @override
  String get openInBrowser => 'Buka di browser';

  @override
  String get wifiCredentials => 'Kredensial WiFi';

  @override
  String get contactInformation => 'Informasi Kontak';

  @override
  String get plainTextContent => 'Konten teks biasa';

  @override
  String get reportIssue => 'Laporkan Masalah';

  @override
  String get reportIssueSubtitle => 'Kirim umpan balik';

  @override
  String get earlyWithdrawal => 'Penarikan Dini';

  @override
  String get earlyWithdrawalSubtitle => 'Hitung kerugian penarikan dini';

  @override
  String get depositAmount => 'Jumlah Deposito';

  @override
  String get termDepositRate => 'Suku Bunga Deposito';

  @override
  String get demandDepositRate => 'Suku Bunga Tabungan';

  @override
  String get originalTerm => 'Jangka Waktu Asli';

  @override
  String get actualHoldingPeriod => 'Periode Kepemilikan Aktual';

  @override
  String get withdrawalResult => 'Hasil Penarikan';

  @override
  String get amountReceived => 'Jumlah Diterima';

  @override
  String get actualInterestReceived => 'Bunga Aktual Diterima';

  @override
  String get interestLost => 'Bunga Hilang';

  @override
  String get lossPercentage => 'Persentase Kerugian';

  @override
  String get ifHeldToMaturity => 'Jika Ditahan Sampai Jatuh Tempo';

  @override
  String get youWillLose => 'Anda akan kehilangan';

  @override
  String get earlyWithdrawalWarning => 'Peringatan Penarikan Dini';

  @override
  String get earlyWithdrawalWarningDesc =>
      'Penarikan dini menerapkan suku bunga tabungan bukan suku bunga deposito.';
}
