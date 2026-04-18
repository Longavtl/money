// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Money Nest';

  @override
  String get appTagline => 'Tính toán tương lai của bạn';

  @override
  String get home => 'Trang chủ';

  @override
  String get saved => 'Đã tiết kiệm';

  @override
  String get history => 'Lịch sử';

  @override
  String get settings => 'Cài đặt';

  @override
  String get compare => 'So sánh';

  @override
  String get simulate => 'Mô phỏng';

  @override
  String get mainTools => 'Công cụ chính';

  @override
  String categories(int count) {
    return '$count DANH MỤC';
  }

  @override
  String get loanCalc => 'Vay ngân hàng';

  @override
  String get loanCalcSubtitle => 'Thanh toán hàng tháng';

  @override
  String get interestCalc => 'Lãi suất';

  @override
  String get interestCalcSubtitle => 'Đơn & kép';

  @override
  String get vault => 'Tiết kiệm';

  @override
  String get vaultSubtitle => 'Lên kế hoạch tương lai';

  @override
  String get historySubtitle => 'Các tính toán trước';

  @override
  String get proAccess => 'TRUY CẬP PRO';

  @override
  String get upgradeToPremium => 'Nâng cấp Premium';

  @override
  String get premiumBannerDesc =>
      'Mở khóa biểu đồ nâng cao\nvà không quảng cáo.';

  @override
  String get marketPulse => 'THÔNG TIN THỊ TRƯỜNG';

  @override
  String get currentRates => 'Lãi suất hiện tại';

  @override
  String get homeLoan => 'Vay mua nhà';

  @override
  String get savingsApy => 'Lãi tiết kiệm';

  @override
  String get calculatorSimpleInterest => 'Lãi đơn';

  @override
  String get calculatorCompoundInterest => 'Lãi kép';

  @override
  String get calculatorLoan => 'Vay ngân hàng';

  @override
  String get calculatorSavings => 'Gửi tiết kiệm';

  @override
  String get principal => 'Số tiền gốc';

  @override
  String get interestRate => 'Lãi suất';

  @override
  String get annualInterestRate => 'Lãi suất (năm)';

  @override
  String get term => 'Kỳ hạn';

  @override
  String get termMonths => 'Kỳ hạn (tháng)';

  @override
  String get termYears => 'Kỳ hạn (năm)';

  @override
  String get monthlyPayment => 'Thanh toán hàng tháng';

  @override
  String get firstMonthPayment => 'Thanh toán tháng đầu';

  @override
  String get lastMonthPayment => 'Thanh toán tháng cuối';

  @override
  String get totalInterest => 'Tổng lãi';

  @override
  String get totalPayment => 'Tổng thanh toán';

  @override
  String get interest => 'Tiền lãi';

  @override
  String get totalAmount => 'Tổng cộng';

  @override
  String get interestPrincipalRatio => 'Tỷ lệ lãi/gốc';

  @override
  String get loanAmount => 'Số tiền vay';

  @override
  String get paymentMethod => 'Phương thức trả';

  @override
  String get loanTypeFixed => 'Trả góp đều';

  @override
  String get loanTypeReducing => 'Dư nợ giảm dần';

  @override
  String get savingsTypeReinvest => 'Tái tục lãi';

  @override
  String get savingsTypeWithdraw => 'Lĩnh lãi';

  @override
  String get results => 'Kết quả';

  @override
  String get paymentStructure => 'Cơ cấu thanh toán';

  @override
  String get amortizationSchedule => 'Bảng trả nợ';

  @override
  String get month => 'Tháng';

  @override
  String get year => 'Năm';

  @override
  String get years => 'năm';

  @override
  String get payment => 'Thanh toán';

  @override
  String get principalPaid => 'Gốc';

  @override
  String get interestPaid => 'Lãi';

  @override
  String get balance => 'Dư nợ';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String get share => 'Chia sẻ';

  @override
  String get exportPdf => 'Xuất PDF';

  @override
  String get calculate => 'Tính';

  @override
  String get reset => 'Đặt lại';

  @override
  String get close => 'Đóng';

  @override
  String get add => 'Thêm';

  @override
  String get storageLimitTitle => 'Giới hạn lưu trữ';

  @override
  String storageLimitLoans(int count) {
    return 'Bạn đã lưu tối đa $count khoản vay. Nâng cấp Premium để lưu không giới hạn!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'Bạn đã lưu tối đa $count khoản tiết kiệm. Nâng cấp Premium để lưu không giới hạn!';
  }

  @override
  String get saveLoan => 'Lưu khoản vay';

  @override
  String get loanNameHint => 'Tên khoản vay (tùy chọn)';

  @override
  String get amount => 'Số tiền';

  @override
  String get rate => 'Lãi suất';

  @override
  String get loanSaved => 'Đã lưu khoản vay';

  @override
  String get saveSavings => 'Lưu khoản tiết kiệm';

  @override
  String get savingsNameHint => 'Tên khoản tiết kiệm (tùy chọn)';

  @override
  String get savingsSaved => 'Đã lưu khoản tiết kiệm';

  @override
  String get savedLoans => 'Khoản vay đã lưu';

  @override
  String get savedSavings => 'Tiết kiệm đã lưu';

  @override
  String loansCount(int count) {
    return 'Khoản vay ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'Tiết kiệm ($count)';
  }

  @override
  String get noSavedItems => 'Chưa có mục nào được lưu';

  @override
  String get noSavedLoans => 'Chưa có khoản vay nào';

  @override
  String get noSavedLoansSubtitle => 'Tính toán và lưu khoản vay để xem sau';

  @override
  String get noSavedSavings => 'Chưa có khoản tiết kiệm nào';

  @override
  String get noSavedSavingsSubtitle => 'Tính toán và lưu tiết kiệm để xem sau';

  @override
  String errorLoading(String error) {
    return 'Lỗi: $error';
  }

  @override
  String get compoundingFrequency => 'Chu kỳ ghép lãi';

  @override
  String get daily => 'Ngày';

  @override
  String get monthly => 'Hàng tháng';

  @override
  String get quarterly => 'Quý';

  @override
  String get yearly => 'Năm';

  @override
  String get calculationResults => 'Kết quả tính toán';

  @override
  String get totalReceived => 'Tổng tiền nhận';

  @override
  String get interestEarned => 'Tiền lãi';

  @override
  String get effectiveAnnualRate => 'Lãi suất thực/năm';

  @override
  String get compoundingPeriods => 'Số lần ghép lãi';

  @override
  String get compareWithSimple => 'So sánh với Lãi đơn';

  @override
  String get simpleInterest => 'Lãi đơn';

  @override
  String get compoundInterest => 'Lãi kép';

  @override
  String compoundBenefit(String amount) {
    return 'Lãi kép giúp bạn nhận thêm $amount';
  }

  @override
  String get savingsType => 'Hình thức tiết kiệm';

  @override
  String get initialDeposit => 'Tiền gửi ban đầu';

  @override
  String get monthlyDeposit => 'Gửi thêm hàng tháng';

  @override
  String get annualRate => 'Lãi suất năm';

  @override
  String get finalBalance => 'Số dư cuối kỳ';

  @override
  String get totalDeposited => 'Tổng đã gửi';

  @override
  String get returnRate => 'Tỷ suất sinh lời';

  @override
  String get avgMonthlyInterest => 'Lãi bình quân/tháng';

  @override
  String get detailedAnalysis => 'Phân tích chi tiết';

  @override
  String get deposits => 'Tiền gửi vào';

  @override
  String get reinvestInfo => 'Lãi được cộng dồn vào gốc mỗi tháng';

  @override
  String get withdrawInfo => 'Lãi được trả ra mỗi tháng, không cộng vào gốc';

  @override
  String get averageMonthlyInterest => 'Lãi trung bình/tháng';

  @override
  String get totalStructure => 'Cơ cấu tổng tiền';

  @override
  String get premium => 'Nâng cấp Premium';

  @override
  String get premiumActivated => 'Bạn đã là Premium!';

  @override
  String get premiumThanks => 'Cảm ơn bạn đã ủng hộ!';

  @override
  String get premiumDescription => 'Mở khóa tất cả tính năng';

  @override
  String get premiumFeature1 => 'Lưu không giới hạn';

  @override
  String get premiumFeature1Desc => 'Lưu trữ tất cả các khoản vay và tiết kiệm';

  @override
  String get premiumFeature2 => 'Biểu đồ đầy đủ';

  @override
  String get premiumFeature2Desc => 'Xem chi tiết với tất cả loại biểu đồ';

  @override
  String get premiumFeature3 => 'So sánh kịch bản';

  @override
  String get premiumFeature3Desc => 'So sánh nhiều phương án song song';

  @override
  String get premiumFeature4 => 'Xuất PDF';

  @override
  String get premiumFeature4Desc => 'Tạo báo cáo chi tiết để in hoặc chia sẻ';

  @override
  String get premiumFeature5 => 'Hỗ trợ phát triển';

  @override
  String get premiumFeature5Desc => 'Giúp chúng tôi cải thiện ứng dụng';

  @override
  String get premiumFeatures => 'Tính năng Premium';

  @override
  String get lifetime => 'Trọn đời';

  @override
  String get oneTimePurchase => 'Thanh toán một lần, sử dụng mãi mãi';

  @override
  String get upgradeNow => 'Nâng cấp ngay';

  @override
  String get restorePurchase => 'Khôi phục giao dịch';

  @override
  String purchaseDate(String date) {
    return 'Ngày mua: $date';
  }

  @override
  String get premiumRequired => 'Yêu cầu Premium';

  @override
  String upgradeTo(String feature) {
    return 'Nâng cấp để mở khóa $feature';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => 'Đã kích hoạt';

  @override
  String get unlockAllFeatures => 'Mở khóa tất cả tính năng';

  @override
  String get theme => 'Giao diện';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get themeSystem => 'Hệ thống';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get about => 'Về ứng dụng';

  @override
  String version(String version) {
    return 'Phiên bản $version';
  }

  @override
  String get termsOfService => 'Điều khoản dịch vụ';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get error => 'Lỗi';

  @override
  String get errorGeneric => 'Đã xảy ra lỗi';

  @override
  String get tryAgain => 'Thử lại';

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'Nâng cấp';

  @override
  String get compareScenarios => 'So sánh phương án';

  @override
  String get upgradeToCompare => 'Nâng cấp để so sánh phương án';

  @override
  String get loanSettings => 'Cài đặt khoản vay';

  @override
  String get scenarioA => 'Phương án A';

  @override
  String get scenarioB => 'Phương án B';

  @override
  String get comparison => 'So sánh';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'Phương án $scenario tiết kiệm $amount';
  }

  @override
  String get simulation => 'Mô phỏng';

  @override
  String get noScenariosYet => 'Chưa có kịch bản nào';

  @override
  String get addScenariosSubtitle =>
      'Thêm khoản vay hoặc tiết kiệm để\nmô phỏng tài chính theo thời gian';

  @override
  String get addLoan => 'Thêm khoản vay';

  @override
  String get addSavings => 'Thêm tiết kiệm';

  @override
  String get loans => 'Khoản vay';

  @override
  String get savings => 'Tiết kiệm';

  @override
  String get timeline => 'Dòng thời gian';

  @override
  String monthNumber(int number) {
    return 'Tháng $number';
  }

  @override
  String get netWorth => 'Giá trị ròng';

  @override
  String get positive => 'Dương';

  @override
  String get negativeDebt => 'Âm (nợ)';

  @override
  String get now => 'Hiện tại';

  @override
  String yearsCount(int count) {
    return '$count năm';
  }

  @override
  String get debt => 'Nợ';

  @override
  String get remaining => 'Còn lại';

  @override
  String get clearAll => 'Xóa tất cả?';

  @override
  String get allScenariosDeleted => 'Tất cả kịch bản sẽ bị xóa.';

  @override
  String get loanNameHintExample => 'Tên khoản vay (VD: Vay mua nhà)';

  @override
  String get savingsNameHintExample => 'Tên (VD: Hưu trí)';

  @override
  String get deposit => 'Tiền gửi';

  @override
  String get loan => 'Khoản vay';

  @override
  String get selectThemeDescription => 'Chọn giao diện cho ứng dụng';

  @override
  String get selectLanguageDescription => 'Chọn ngôn ngữ ưa thích của bạn';

  @override
  String get apply => 'Áp dụng';

  @override
  String get financialTools => 'Công cụ tài chính';

  @override
  String get reminders => 'Nhắc nhở';

  @override
  String get paymentRemindersSubtitle => 'Theo dõi ngày đến hạn';

  @override
  String get savingsGoalsSubtitle => 'Đạt mục tiêu của bạn';

  @override
  String get calendar => 'Lịch';

  @override
  String get calendarSubtitle => 'Xem tất cả sự kiện';

  @override
  String get achievementsSubtitle => 'Tiến độ của bạn';

  @override
  String get reportsSubtitle => 'Xem thống kê';

  @override
  String get rateAlertsSubtitle => 'Theo dõi lãi suất';

  @override
  String get paymentReminders => 'Nhắc nhở thanh toán';

  @override
  String get noRemindersYet => 'Chưa có nhắc nhở nào';

  @override
  String get addRemindersSubtitle => 'Thêm nhắc nhở để không bỏ lỡ thanh toán';

  @override
  String get addReminder => 'Thêm nhắc nhở';

  @override
  String get editReminder => 'Sửa nhắc nhở';

  @override
  String get reminderNameHint => 'Tên nhắc nhở (VD: Thẻ tín dụng)';

  @override
  String get dueDate => 'Ngày đến hạn';

  @override
  String get remindBefore => 'Nhắc trước';

  @override
  String get days => 'ngày';

  @override
  String get recurring => 'Lặp lại';

  @override
  String get totalDue => 'Tổng đến hạn';

  @override
  String get overdue => 'Quá hạn';

  @override
  String get upcoming => 'Sắp tới';

  @override
  String get completed => 'Đã hoàn thành';

  @override
  String get markAsPaid => 'Đánh dấu đã trả';

  @override
  String get markAsPaidConfirm => 'Bạn có chắc muốn đánh dấu là đã thanh toán?';

  @override
  String get pending => 'Chờ xử lý';

  @override
  String get paid => 'Đã trả';

  @override
  String get skipped => 'Đã bỏ qua';

  @override
  String get markPaid => 'Đánh dấu đã trả';

  @override
  String get weekly => 'Hàng tuần';

  @override
  String get biWeekly => 'Hai tuần một lần';

  @override
  String get dueToday => 'Đến hạn hôm nay';

  @override
  String get dueTomorrow => 'Đến hạn ngày mai';

  @override
  String dueInDays(int days) {
    return 'Còn $days ngày';
  }

  @override
  String get pleaseEnterName => 'Vui lòng nhập tên';

  @override
  String get savingsGoals => 'Mục tiêu tiết kiệm';

  @override
  String get noGoalsYet => 'Chưa có mục tiêu nào';

  @override
  String get addGoalsSubtitle => 'Đặt mục tiêu tiết kiệm và theo dõi tiến độ';

  @override
  String get addGoal => 'Thêm mục tiêu';

  @override
  String get editGoal => 'Sửa mục tiêu';

  @override
  String get goalNameHint => 'Tên mục tiêu (VD: Du lịch)';

  @override
  String get targetAmount => 'Số tiền mục tiêu';

  @override
  String get initialAmount => 'Số tiền ban đầu';

  @override
  String get deadline => 'Hạn chót';

  @override
  String get suggestedMonthly => 'Đề xuất hàng tháng';

  @override
  String get activeGoals => 'Mục tiêu đang thực hiện';

  @override
  String get completedGoals => 'Mục tiêu đã hoàn thành';

  @override
  String get totalSaved => 'Tổng đã tiết kiệm';

  @override
  String get totalTarget => 'Tổng mục tiêu';

  @override
  String get ofTotalTarget => 'của tổng mục tiêu';

  @override
  String get milestones => 'Cột mốc';

  @override
  String get addMoney => 'Thêm tiền';

  @override
  String get withdraw => 'Rút tiền';

  @override
  String get addContribution => 'Thêm đóng góp';

  @override
  String get notesOptional => 'Ghi chú (tùy chọn)';

  @override
  String get withdrawReason => 'Lý do rút tiền';

  @override
  String get noContributionsYet => 'Chưa có đóng góp nào';

  @override
  String get pauseGoal => 'Tạm dừng mục tiêu';

  @override
  String get deleteGoal => 'Xóa mục tiêu';

  @override
  String get deleteGoalConfirm => 'Bạn có chắc muốn xóa mục tiêu này?';

  @override
  String get target => 'Mục tiêu';

  @override
  String get goals => 'Mục tiêu';

  @override
  String savePerMonth(String amount) {
    return 'Tiết kiệm $amount/tháng để đạt mục tiêu';
  }

  @override
  String get pleaseEnterGoalName => 'Vui lòng nhập tên mục tiêu';

  @override
  String get withdrawal => 'Rút tiền';

  @override
  String get start => 'Bắt đầu';

  @override
  String get goalReached => 'Đạt mục tiêu!';

  @override
  String get progress => 'Tiến độ';

  @override
  String get achievements => 'Thành tựu';

  @override
  String get financialHealthScore => 'Điểm sức khỏe tài chính';

  @override
  String get financialHealth => 'Sức khỏe tài chính';

  @override
  String get points => 'điểm';

  @override
  String get healthExcellent => 'Xuất sắc! Hãy tiếp tục phát huy!';

  @override
  String get healthGood => 'Tốt! Bạn đang đi đúng hướng.';

  @override
  String get healthFair => 'Khá. Vẫn có thể cải thiện thêm.';

  @override
  String get healthNeedsWork => 'Cần chú ý. Hãy cùng cải thiện nhé!';

  @override
  String get paymentStreak => 'Chuỗi thanh toán';

  @override
  String get dayStreak => 'ngày liên tiếp';

  @override
  String get keepItUp => 'Tiếp tục phát huy!';

  @override
  String get longest => 'Dài nhất';

  @override
  String get unlocked => 'Đã mở';

  @override
  String get locked => 'Chưa mở';

  @override
  String get financialCalendar => 'Lịch tài chính';

  @override
  String get monthView => 'Xem tháng';

  @override
  String get weekView => 'Xem tuần';

  @override
  String get today => 'Hôm nay';

  @override
  String get noEventsForDay => 'Không có sự kiện trong ngày này';

  @override
  String get goalDeadline => 'Hạn mục tiêu';

  @override
  String get contribution => 'Đóng góp';

  @override
  String get reports => 'Báo cáo';

  @override
  String get week => 'Tuần';

  @override
  String get quarter => 'Quý';

  @override
  String get allTime => 'Tất cả';

  @override
  String get totalPaid => 'Tổng đã trả';

  @override
  String get totalDebt => 'Tổng nợ';

  @override
  String get debtVsPaid => 'Nợ vs Đã trả';

  @override
  String get outstanding => 'Chưa trả';

  @override
  String get noDataYet => 'Chưa có dữ liệu';

  @override
  String get monthlyOverview => 'Tổng quan theo tháng';

  @override
  String get due => 'Đến hạn';

  @override
  String get paymentPerformance => 'Hiệu suất thanh toán';

  @override
  String get onTime => 'Đúng hạn';

  @override
  String get late => 'Trễ';

  @override
  String get onTimeRate => 'Tỷ lệ đúng hạn';

  @override
  String get rateAlerts => 'Cảnh báo lãi suất';

  @override
  String get currentMarketRates => 'Lãi suất thị trường hiện tại';

  @override
  String get edit => 'Sửa';

  @override
  String get triggeredAlerts => 'Cảnh báo đã kích hoạt';

  @override
  String get activeAlerts => 'Cảnh báo đang hoạt động';

  @override
  String get inactiveAlerts => 'Cảnh báo tạm dừng';

  @override
  String get noAlertsYet => 'Chưa có cảnh báo nào';

  @override
  String get addAlertsSubtitle =>
      'Thêm cảnh báo để theo dõi biến động lãi suất';

  @override
  String get addAlert => 'Thêm cảnh báo';

  @override
  String get alertNameHint => 'Tên cảnh báo (VD: Lãi vay nhà)';

  @override
  String get loanType => 'Loại khoản vay';

  @override
  String get alertWhen => 'Cảnh báo khi';

  @override
  String get rateDrops => 'Lãi suất giảm';

  @override
  String get rateRises => 'Lãi suất tăng';

  @override
  String get targetRate => 'Lãi suất mục tiêu';

  @override
  String get when => 'Khi';

  @override
  String get current => 'Hiện tại';

  @override
  String get triggered => 'Đã kích hoạt';

  @override
  String get editMarketRates => 'Sửa lãi suất thị trường';

  @override
  String get personalLoan => 'Vay cá nhân';

  @override
  String get carLoan => 'Vay mua xe';

  @override
  String get savingsRate => 'Lãi tiết kiệm';

  @override
  String get homeShort => 'Nhà';

  @override
  String get personalShort => 'Cá nhân';

  @override
  String get carShort => 'Xe';

  @override
  String get savingsShort => 'Tiết kiệm';

  @override
  String get rateDropAlert => 'Lãi suất giảm!';

  @override
  String get rateIncreaseAlert => 'Lãi suất tăng!';

  @override
  String get updated => 'Cập nhật';

  @override
  String get newUpdateAvailable => 'Có bản cập nhật mới';

  @override
  String get updateAppMessage =>
      'Phiên bản mới của ứng dụng đã có sẵn. Vui lòng cập nhật để nhận các tính năng và cải tiến mới nhất.';

  @override
  String get updateNow => 'Cập nhật ngay';

  @override
  String get later => 'Để sau';
}
