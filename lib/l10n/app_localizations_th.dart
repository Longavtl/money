// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appName => 'Money Nest';

  @override
  String get appTagline => 'คำนวณอนาคตของคุณ';

  @override
  String get home => 'หน้าแรก';

  @override
  String get saved => 'ออมแล้ว';

  @override
  String get history => 'ประวัติ';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get compare => 'เปรียบเทียบ';

  @override
  String get simulate => 'จำลอง';

  @override
  String get mainTools => 'เครื่องมือหลัก';

  @override
  String categories(int count) {
    return '$count หมวดหมู่';
  }

  @override
  String get loanCalc => 'คำนวณสินเชื่อ';

  @override
  String get loanCalcSubtitle => 'ผ่อนรายเดือน';

  @override
  String get interestCalc => 'ดอกเบี้ย';

  @override
  String get interestCalcSubtitle => 'ธรรมดาและทบต้น';

  @override
  String get vault => 'กระปุก';

  @override
  String get vaultSubtitle => 'วางแผนอนาคต';

  @override
  String get historySubtitle => 'การคำนวณที่ผ่านมา';

  @override
  String get proAccess => 'การเข้าถึงแบบโปร';

  @override
  String get upgradeToPremium => 'อัพเกรดเป็นพรีเมียม';

  @override
  String get premiumBannerDesc => 'ปลดล็อคกราฟขั้นสูง\nและประสบการณ์ไร้โฆษณา';

  @override
  String get marketPulse => 'ชีพจรตลาด';

  @override
  String get currentRates => 'อัตราปัจจุบัน';

  @override
  String get homeLoan => 'สินเชื่อบ้าน';

  @override
  String get savingsApy => 'ดอกเบี้ยเงินฝาก';

  @override
  String get calculatorSimpleInterest => 'ดอกเบี้ยธรรมดา';

  @override
  String get calculatorCompoundInterest => 'ดอกเบี้ยทบต้น';

  @override
  String get calculatorLoan => 'เครื่องคำนวณสินเชื่อ';

  @override
  String get calculatorSavings => 'เครื่องคำนวณเงินออม';

  @override
  String get principal => 'เงินต้น';

  @override
  String get interestRate => 'อัตราดอกเบี้ย';

  @override
  String get annualInterestRate => 'อัตราดอกเบี้ย (ต่อปี)';

  @override
  String get term => 'ระยะเวลา';

  @override
  String get termMonths => 'ระยะเวลา (เดือน)';

  @override
  String get termYears => 'ระยะเวลา (ปี)';

  @override
  String get monthlyPayment => 'ผ่อนรายเดือน';

  @override
  String get firstMonthPayment => 'ผ่อนเดือนแรก';

  @override
  String get lastMonthPayment => 'ผ่อนเดือนสุดท้าย';

  @override
  String get totalInterest => 'ดอกเบี้ยรวม';

  @override
  String get totalPayment => 'ยอดชำระรวม';

  @override
  String get interest => 'ดอกเบี้ย';

  @override
  String get totalAmount => 'จำนวนรวม';

  @override
  String get interestPrincipalRatio => 'อัตราส่วนดอกเบี้ย/เงินต้น';

  @override
  String get loanAmount => 'จำนวนสินเชื่อ';

  @override
  String get paymentMethod => 'วิธีการชำระ';

  @override
  String get loanTypeFixed => 'ผ่อนคงที่';

  @override
  String get loanTypeReducing => 'ลดต้นลดดอก';

  @override
  String get savingsTypeReinvest => 'นำดอกเบี้ยทบต้น';

  @override
  String get savingsTypeWithdraw => 'ถอนดอกเบี้ย';

  @override
  String get results => 'ผลลัพธ์';

  @override
  String get paymentStructure => 'โครงสร้างการชำระ';

  @override
  String get amortizationSchedule => 'ตารางผ่อนชำระ';

  @override
  String get month => 'เดือน';

  @override
  String get year => 'ปี';

  @override
  String get years => 'ปี';

  @override
  String get payment => 'ชำระ';

  @override
  String get principalPaid => 'เงินต้น';

  @override
  String get interestPaid => 'ดอกเบี้ย';

  @override
  String get balance => 'ยอดคงเหลือ';

  @override
  String get save => 'บันทึก';

  @override
  String get delete => 'ลบ';

  @override
  String get share => 'แชร์';

  @override
  String get exportPdf => 'ส่งออก PDF';

  @override
  String get calculate => 'คำนวณ';

  @override
  String get reset => 'รีเซ็ต';

  @override
  String get close => 'ปิด';

  @override
  String get add => 'เพิ่ม';

  @override
  String get storageLimitTitle => 'ขีดจำกัดพื้นที่เก็บข้อมูล';

  @override
  String storageLimitLoans(int count) {
    return 'คุณบันทึกสินเชื่อครบ $count รายการแล้ว อัพเกรดเป็นพรีเมียมเพื่อบันทึกไม่จำกัด!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'คุณบันทึกเงินออมครบ $count รายการแล้ว อัพเกรดเป็นพรีเมียมเพื่อบันทึกไม่จำกัด!';
  }

  @override
  String get saveLoan => 'บันทึกสินเชื่อ';

  @override
  String get loanNameHint => 'ชื่อสินเชื่อ (ไม่บังคับ)';

  @override
  String get amount => 'จำนวน';

  @override
  String get rate => 'อัตรา';

  @override
  String get loanSaved => 'บันทึกสินเชื่อแล้ว';

  @override
  String get saveSavings => 'บันทึกเงินออม';

  @override
  String get savingsNameHint => 'ชื่อเงินออม (ไม่บังคับ)';

  @override
  String get savingsSaved => 'บันทึกเงินออมแล้ว';

  @override
  String get savedLoans => 'สินเชื่อที่บันทึก';

  @override
  String get savedSavings => 'เงินออมที่บันทึก';

  @override
  String loansCount(int count) {
    return 'สินเชื่อ ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'เงินออม ($count)';
  }

  @override
  String get noSavedItems => 'ยังไม่มีรายการบันทึก';

  @override
  String get noSavedLoans => 'ไม่มีสินเชื่อที่บันทึก';

  @override
  String get noSavedLoansSubtitle => 'คำนวณและบันทึกสินเชื่อเพื่อดูในภายหลัง';

  @override
  String get noSavedSavings => 'ไม่มีเงินออมที่บันทึก';

  @override
  String get noSavedSavingsSubtitle => 'คำนวณและบันทึกเงินออมเพื่อดูในภายหลัง';

  @override
  String errorLoading(String error) {
    return 'ข้อผิดพลาด: $error';
  }

  @override
  String get compoundingFrequency => 'ความถี่การทบต้น';

  @override
  String get daily => 'รายวัน';

  @override
  String get monthly => 'รายเดือน';

  @override
  String get quarterly => 'รายไตรมาส';

  @override
  String get yearly => 'รายปี';

  @override
  String get calculationResults => 'ผลการคำนวณ';

  @override
  String get totalReceived => 'รับรวมทั้งหมด';

  @override
  String get interestEarned => 'ดอกเบี้ยที่ได้รับ';

  @override
  String get effectiveAnnualRate => 'อัตราต่อปีที่แท้จริง';

  @override
  String get compoundingPeriods => 'จำนวนครั้งที่ทบต้น';

  @override
  String get compareWithSimple => 'เปรียบเทียบกับดอกเบี้ยธรรมดา';

  @override
  String get simpleInterest => 'ดอกเบี้ยธรรมดา';

  @override
  String get compoundInterest => 'ดอกเบี้ยทบต้น';

  @override
  String compoundBenefit(String amount) {
    return 'ดอกเบี้ยทบต้นทำให้คุณได้รับมากขึ้น $amount';
  }

  @override
  String get savingsType => 'ประเภทเงินออม';

  @override
  String get initialDeposit => 'เงินฝากเริ่มต้น';

  @override
  String get monthlyDeposit => 'ฝากรายเดือน';

  @override
  String get annualRate => 'อัตราต่อปี';

  @override
  String get finalBalance => 'ยอดคงเหลือสุดท้าย';

  @override
  String get totalDeposited => 'ฝากรวมทั้งหมด';

  @override
  String get returnRate => 'อัตราผลตอบแทน';

  @override
  String get avgMonthlyInterest => 'ดอกเบี้ยเฉลี่ยต่อเดือน';

  @override
  String get detailedAnalysis => 'การวิเคราะห์โดยละเอียด';

  @override
  String get deposits => 'เงินฝาก';

  @override
  String get reinvestInfo => 'ดอกเบี้ยทบต้นรายเดือน';

  @override
  String get withdrawInfo => 'ดอกเบี้ยจ่ายรายเดือน ไม่ทบต้น';

  @override
  String get averageMonthlyInterest => 'ดอกเบี้ยเฉลี่ย/เดือน';

  @override
  String get totalStructure => 'โครงสร้างรวม';

  @override
  String get premium => 'อัพเกรดเป็นพรีเมียม';

  @override
  String get premiumActivated => 'คุณเป็นพรีเมียมแล้ว!';

  @override
  String get premiumMember => 'สมาชิกพรีเมียม';

  @override
  String get premiumThanks => 'ขอบคุณสำหรับการสนับสนุน!';

  @override
  String get premiumDescription => 'ปลดล็อคทุกฟีเจอร์';

  @override
  String get premiumFeature1 => 'บันทึกไม่จำกัด';

  @override
  String get premiumFeature1Desc => 'เก็บสินเชื่อและเงินออมทั้งหมดของคุณ';

  @override
  String get premiumFeature2 => 'กราฟครบชุด';

  @override
  String get premiumFeature2Desc => 'ดูรายละเอียดด้วยกราฟทุกประเภท';

  @override
  String get premiumFeature3 => 'เปรียบเทียบสถานการณ์';

  @override
  String get premiumFeature3Desc => 'เปรียบเทียบหลายตัวเลือกแบบเคียงข้าง';

  @override
  String get premiumFeature4 => 'ส่งออก PDF';

  @override
  String get premiumFeature4Desc => 'สร้างรายงานโดยละเอียดเพื่อพิมพ์หรือแชร์';

  @override
  String get premiumFeature5 => 'สนับสนุนการพัฒนา';

  @override
  String get premiumFeature5Desc => 'ช่วยเราปรับปรุงแอป';

  @override
  String get premiumFeatures => 'ฟีเจอร์พรีเมียม';

  @override
  String get lifetime => 'ตลอดชีพ';

  @override
  String get oneTimePurchase => 'จ่ายครั้งเดียว ใช้ตลอดไป';

  @override
  String get upgradeNow => 'อัพเกรดเลย';

  @override
  String get restorePurchase => 'กู้คืนการซื้อ';

  @override
  String purchaseDate(String date) {
    return 'วันที่ซื้อ: $date';
  }

  @override
  String get premiumRequired => 'ต้องมีพรีเมียม';

  @override
  String upgradeTo(String feature) {
    return 'อัพเกรดเป็น $feature';
  }

  @override
  String get pro => 'โปร';

  @override
  String get activated => 'เปิดใช้งานแล้ว';

  @override
  String get unlockAllFeatures => 'ปลดล็อคทุกฟีเจอร์';

  @override
  String get theme => 'ธีม';

  @override
  String get themeLight => 'สว่าง';

  @override
  String get themeDark => 'มืด';

  @override
  String get themeSystem => 'ตามระบบ';

  @override
  String get language => 'ภาษา';

  @override
  String get about => 'เกี่ยวกับ';

  @override
  String version(String version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get termsOfService => 'ข้อกำหนดการใช้งาน';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get errorGeneric => 'เกิดข้อผิดพลาดบางอย่าง';

  @override
  String get tryAgain => 'ลองอีกครั้ง';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get ok => 'ตกลง';

  @override
  String get upgrade => 'อัพเกรด';

  @override
  String get compareScenarios => 'เปรียบเทียบสถานการณ์';

  @override
  String get upgradeToCompare => 'อัพเกรดเพื่อเปรียบเทียบสถานการณ์';

  @override
  String get loanSettings => 'การตั้งค่าสินเชื่อ';

  @override
  String get scenarioA => 'สถานการณ์ A';

  @override
  String get scenarioB => 'สถานการณ์ B';

  @override
  String get comparison => 'การเปรียบเทียบ';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'สถานการณ์ $scenario ประหยัด $amount';
  }

  @override
  String get simulation => 'การจำลอง';

  @override
  String get noScenariosYet => 'ยังไม่มีสถานการณ์';

  @override
  String get addScenariosSubtitle =>
      'เพิ่มสินเชื่อหรือเงินออมเพื่อจำลอง\nการเงินของคุณตามช่วงเวลา';

  @override
  String get addLoan => 'เพิ่มสินเชื่อ';

  @override
  String get addSavings => 'เพิ่มเงินออม';

  @override
  String get loans => 'สินเชื่อ';

  @override
  String get savings => 'เงินออม';

  @override
  String get timeline => 'ไทม์ไลน์';

  @override
  String monthNumber(int number) {
    return 'เดือน $number';
  }

  @override
  String get netWorth => 'มูลค่าสุทธิ';

  @override
  String get positive => 'บวก';

  @override
  String get negativeDebt => 'ลบ (หนี้)';

  @override
  String get now => 'ตอนนี้';

  @override
  String yearsCount(int count) {
    return '$count ปี';
  }

  @override
  String get debt => 'หนี้';

  @override
  String get remaining => 'คงเหลือ';

  @override
  String get clearAll => 'ล้างทั้งหมด?';

  @override
  String get allScenariosDeleted => 'สถานการณ์ทั้งหมดจะถูกลบ';

  @override
  String get loanNameHintExample => 'ชื่อสินเชื่อ (เช่น สินเชื่อบ้าน)';

  @override
  String get savingsNameHintExample => 'ชื่อ (เช่น เกษียณ)';

  @override
  String get deposit => 'ฝาก';

  @override
  String get loan => 'สินเชื่อ';

  @override
  String get selectThemeDescription => 'เลือกธีมสำหรับแอปของคุณ';

  @override
  String get selectLanguageDescription => 'เลือกภาษาที่ต้องการ';

  @override
  String get apply => 'ใช้งาน';

  @override
  String get financialTools => 'เครื่องมือทางการเงิน';

  @override
  String get reminders => 'การแจ้งเตือน';

  @override
  String get paymentRemindersSubtitle => 'ติดตามวันครบกำหนด';

  @override
  String get savingsGoalsSubtitle => 'บรรลุเป้าหมาย';

  @override
  String get calendar => 'ปฏิทิน';

  @override
  String get calendarSubtitle => 'ดูกิจกรรมทั้งหมด';

  @override
  String get achievementsSubtitle => 'ความคืบหน้าของคุณ';

  @override
  String get reportsSubtitle => 'ดูสถิติ';

  @override
  String get rateAlertsSubtitle => 'ติดตามอัตราดอกเบี้ย';

  @override
  String get paymentReminders => 'การแจ้งเตือนชำระเงิน';

  @override
  String get noRemindersYet => 'ยังไม่มีการแจ้งเตือน';

  @override
  String get addRemindersSubtitle =>
      'เพิ่มการแจ้งเตือนชำระเงินเพื่อไม่พลาดกำหนด';

  @override
  String get addReminder => 'เพิ่มการแจ้งเตือน';

  @override
  String get editReminder => 'แก้ไขการแจ้งเตือน';

  @override
  String get reminderNameHint => 'ชื่อการแจ้งเตือน (เช่น บัตรเครดิต)';

  @override
  String get dueDate => 'วันครบกำหนด';

  @override
  String get remindBefore => 'แจ้งเตือนก่อน';

  @override
  String get days => 'วัน';

  @override
  String get recurring => 'ซ้ำ';

  @override
  String get totalDue => 'รวมที่ต้องชำระ';

  @override
  String get overdue => 'เกินกำหนด';

  @override
  String get upcoming => 'ใกล้ถึง';

  @override
  String get completed => 'เสร็จสมบูรณ์';

  @override
  String get markAsPaid => 'ทำเครื่องหมายว่าชำระแล้ว';

  @override
  String get markAsPaidConfirm =>
      'คุณแน่ใจหรือไม่ว่าต้องการทำเครื่องหมายว่าชำระแล้ว?';

  @override
  String get pending => 'รอดำเนินการ';

  @override
  String get paid => 'ชำระแล้ว';

  @override
  String get skipped => 'ข้าม';

  @override
  String get markPaid => 'ทำเครื่องหมายชำระ';

  @override
  String get weekly => 'รายสัปดาห์';

  @override
  String get biWeekly => 'สองสัปดาห์ครั้ง';

  @override
  String get dueToday => 'ครบกำหนดวันนี้';

  @override
  String get dueTomorrow => 'ครบกำหนดพรุ่งนี้';

  @override
  String dueInDays(int days) {
    return 'ครบกำหนดใน $days วัน';
  }

  @override
  String get pleaseEnterName => 'กรุณากรอกชื่อ';

  @override
  String get savingsGoals => 'เป้าหมายเงินออม';

  @override
  String get noGoalsYet => 'ยังไม่มีเป้าหมาย';

  @override
  String get addGoalsSubtitle => 'ตั้งเป้าหมายเงินออมและติดตามความคืบหน้า';

  @override
  String get addGoal => 'เพิ่มเป้าหมาย';

  @override
  String get editGoal => 'แก้ไขเป้าหมาย';

  @override
  String get goalNameHint => 'ชื่อเป้าหมาย (เช่น ท่องเที่ยว)';

  @override
  String get targetAmount => 'จำนวนเป้าหมาย';

  @override
  String get initialAmount => 'จำนวนเริ่มต้น';

  @override
  String get deadline => 'วันครบกำหนด';

  @override
  String get suggestedMonthly => 'แนะนำรายเดือน';

  @override
  String get activeGoals => 'เป้าหมายที่ใช้งาน';

  @override
  String get completedGoals => 'เป้าหมายที่สำเร็จ';

  @override
  String get totalSaved => 'ออมรวม';

  @override
  String get totalTarget => 'เป้าหมายรวม';

  @override
  String get ofTotalTarget => 'ของเป้าหมายรวม';

  @override
  String get milestones => 'ก้าวสำคัญ';

  @override
  String get addMoney => 'เพิ่มเงิน';

  @override
  String get withdraw => 'ถอน';

  @override
  String get addContribution => 'เพิ่มการมีส่วนร่วม';

  @override
  String get notesOptional => 'หมายเหตุ (ไม่บังคับ)';

  @override
  String get withdrawReason => 'เหตุผลในการถอน';

  @override
  String get noContributionsYet => 'ยังไม่มีการมีส่วนร่วม';

  @override
  String get pauseGoal => 'หยุดเป้าหมายชั่วคราว';

  @override
  String get deleteGoal => 'ลบเป้าหมาย';

  @override
  String get deleteGoalConfirm => 'คุณแน่ใจหรือไม่ว่าต้องการลบเป้าหมายนี้?';

  @override
  String get target => 'เป้าหมาย';

  @override
  String get goals => 'เป้าหมาย';

  @override
  String savePerMonth(String amount) {
    return 'ออม $amount/เดือน เพื่อบรรลุเป้าหมาย';
  }

  @override
  String get pleaseEnterGoalName => 'กรุณากรอกชื่อเป้าหมาย';

  @override
  String get withdrawal => 'การถอน';

  @override
  String get start => 'เริ่ม';

  @override
  String get goalReached => 'บรรลุเป้าหมาย!';

  @override
  String get progress => 'ความคืบหน้า';

  @override
  String get achievements => 'ความสำเร็จ';

  @override
  String get financialHealthScore => 'คะแนนสุขภาพทางการเงิน';

  @override
  String get financialHealth => 'สุขภาพทางการเงิน';

  @override
  String get points => 'คะแนน';

  @override
  String get healthExcellent => 'ยอดเยี่ยม! ทำต่อไปแบบนี้!';

  @override
  String get healthGood => 'ดีมาก! คุณอยู่บนเส้นทางที่ถูกต้อง';

  @override
  String get healthFair => 'พอใช้ ยังมีที่ปรับปรุง';

  @override
  String get healthNeedsWork => 'ต้องใส่ใจ มาปรับปรุงด้วยกัน!';

  @override
  String get paymentStreak => 'ชุดการชำระต่อเนื่อง';

  @override
  String get dayStreak => 'วันต่อเนื่อง';

  @override
  String get keepItUp => 'ทำต่อไป!';

  @override
  String get longest => 'ยาวที่สุด';

  @override
  String get unlocked => 'ปลดล็อคแล้ว';

  @override
  String get locked => 'ล็อคอยู่';

  @override
  String get financialCalendar => 'ปฏิทินทางการเงิน';

  @override
  String get monthView => 'มุมมองรายเดือน';

  @override
  String get weekView => 'มุมมองรายสัปดาห์';

  @override
  String get today => 'วันนี้';

  @override
  String get noEventsForDay => 'ไม่มีกิจกรรมในวันนี้';

  @override
  String get goalDeadline => 'วันครบกำหนดเป้าหมาย';

  @override
  String get contribution => 'การมีส่วนร่วม';

  @override
  String get reports => 'รายงาน';

  @override
  String get week => 'สัปดาห์';

  @override
  String get quarter => 'ไตรมาส';

  @override
  String get allTime => 'ตลอดเวลา';

  @override
  String get totalPaid => 'ชำระรวม';

  @override
  String get totalDebt => 'หนี้รวม';

  @override
  String get debtVsPaid => 'หนี้เทียบกับชำระ';

  @override
  String get outstanding => 'ค้างชำระ';

  @override
  String get noDataYet => 'ยังไม่มีข้อมูล';

  @override
  String get monthlyOverview => 'ภาพรวมรายเดือน';

  @override
  String get due => 'ครบกำหนด';

  @override
  String get paymentPerformance => 'ประสิทธิภาพการชำระ';

  @override
  String get onTime => 'ตรงเวลา';

  @override
  String get late => 'สาย';

  @override
  String get onTimeRate => 'อัตราตรงเวลา';

  @override
  String get rateAlerts => 'การแจ้งเตือนอัตราดอกเบี้ย';

  @override
  String get currentMarketRates => 'อัตราตลาดปัจจุบัน';

  @override
  String get edit => 'แก้ไข';

  @override
  String get triggeredAlerts => 'การแจ้งเตือนที่เริ่มทำงาน';

  @override
  String get activeAlerts => 'การแจ้งเตือนที่ใช้งาน';

  @override
  String get inactiveAlerts => 'การแจ้งเตือนที่ไม่ใช้งาน';

  @override
  String get noAlertsYet => 'ยังไม่มีการแจ้งเตือน';

  @override
  String get addAlertsSubtitle =>
      'เพิ่มการแจ้งเตือนเพื่อติดตามการเปลี่ยนแปลงอัตราดอกเบี้ย';

  @override
  String get addAlert => 'เพิ่มการแจ้งเตือน';

  @override
  String get alertNameHint => 'ชื่อการแจ้งเตือน (เช่น อัตราสินเชื่อบ้าน)';

  @override
  String get loanType => 'ประเภทสินเชื่อ';

  @override
  String get alertWhen => 'แจ้งเตือนเมื่อ';

  @override
  String get rateDrops => 'อัตราลดลง';

  @override
  String get rateRises => 'อัตราเพิ่มขึ้น';

  @override
  String get targetRate => 'อัตราเป้าหมาย';

  @override
  String get when => 'เมื่อ';

  @override
  String get current => 'ปัจจุบัน';

  @override
  String get triggered => 'เริ่มทำงาน';

  @override
  String get editMarketRates => 'แก้ไขอัตราตลาด';

  @override
  String get personalLoan => 'สินเชื่อส่วนบุคคล';

  @override
  String get carLoan => 'สินเชื่อรถยนต์';

  @override
  String get savingsRate => 'อัตราเงินออม';

  @override
  String get homeShort => 'บ้าน';

  @override
  String get personalShort => 'ส่วนบุคคล';

  @override
  String get carShort => 'รถยนต์';

  @override
  String get savingsShort => 'เงินออม';

  @override
  String get rateDropAlert => 'แจ้งเตือนอัตราลดลง!';

  @override
  String get rateIncreaseAlert => 'แจ้งเตือนอัตราเพิ่มขึ้น!';

  @override
  String get updated => 'อัพเดทแล้ว';

  @override
  String get newUpdateAvailable => 'มีอัพเดทใหม่';

  @override
  String get updateAppMessage =>
      'มีเวอร์ชันใหม่ของแอปพร้อมแล้ว กรุณาอัพเดทเพื่อรับฟีเจอร์และการปรับปรุงล่าสุด';

  @override
  String get updateNow => 'อัพเดทเลย';

  @override
  String get later => 'ไว้ทีหลัง';

  @override
  String get qrTools => 'เครื่องมือ QR';

  @override
  String get createQRCode => 'สร้าง QR Code';

  @override
  String get createQRSubtitle => 'สร้างรหัส QR';

  @override
  String get scanQRCode => 'สแกน QR Code';

  @override
  String get scanQRSubtitle => 'สแกนรหัส QR ใดๆ';

  @override
  String get selectQRType => 'เลือกประเภท QR';

  @override
  String get qrLink => 'ลิงก์';

  @override
  String get qrText => 'ข้อความ';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => 'ผู้ติดต่อ';

  @override
  String get qrCode => 'QR Code';

  @override
  String get websiteAddress => 'ที่อยู่เว็บไซต์';

  @override
  String get textContent => 'เนื้อหาข้อความ';

  @override
  String get enterContent => 'กรอกเนื้อหาของคุณที่นี่';

  @override
  String get networkNameSSID => 'ชื่อเครือข่าย (SSID)';

  @override
  String get wifiPasswordLabel => 'รหัสผ่าน';

  @override
  String get encryptionType => 'ประเภทการเข้ารหัส';

  @override
  String get noEncryption => 'ไม่เข้ารหัส';

  @override
  String get contactName => 'ชื่อผู้ติดต่อ';

  @override
  String get contactNameHint => 'สมชาย ใจดี';

  @override
  String get phoneNumber => 'เบอร์โทรศัพท์';

  @override
  String get generateQRButton => 'สร้าง QR Code';

  @override
  String get qrGeneratedOnDevice => 'QR code สร้างบนอุปกรณ์ของคุณ';

  @override
  String get qrLinkInfo =>
      'กรอก URL เว็บไซต์เพื่อสร้าง QR code ที่เปิดลิงก์เมื่อสแกน';

  @override
  String get qrWifiInfo =>
      'สร้าง QR code ที่ให้ผู้อื่นเชื่อมต่อเครือข่าย WiFi ของคุณได้อย่างรวดเร็ว';

  @override
  String get pleaseEnterWebsite => 'กรุณากรอกที่อยู่เว็บไซต์';

  @override
  String get pleaseEnterTextContent => 'กรุณากรอกเนื้อหาข้อความ';

  @override
  String get pleaseEnterWifiName => 'กรุณากรอกชื่อเครือข่าย WiFi';

  @override
  String get pleaseEnterContactName => 'กรุณากรอกชื่อผู้ติดต่อ';

  @override
  String get copy => 'คัดลอก';

  @override
  String get copyData => 'คัดลอกข้อมูล';

  @override
  String get dataCopied => 'คัดลอกข้อมูลไปยังคลิปบอร์ดแล้ว';

  @override
  String get saveToGallery => 'บันทึกไปยังแกลเลอรี';

  @override
  String get qrPrivacyNote =>
      'QR code นี้สร้างในเครื่องของคุณและไม่ได้ส่งไปยังเซิร์ฟเวอร์ใดๆ';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return 'ผู้ติดต่อ: $name';
  }

  @override
  String get cannotCreateQRImage => 'ไม่สามารถสร้างภาพ QR ได้';

  @override
  String get cannotSaveQR => 'ไม่สามารถบันทึก QR code ได้';

  @override
  String get qrSavedToGallerySuccess => 'บันทึก QR code ไปยังแกลเลอรีแล้ว';

  @override
  String errorWithMessage(String message) {
    return 'ข้อผิดพลาด: $message';
  }

  @override
  String get scanAgain => 'สแกนอีกครั้ง';

  @override
  String get openLink => 'เปิดลิงก์';

  @override
  String get copyPassword => 'คัดลอกรหัสผ่าน';

  @override
  String get passwordCopied => 'คัดลอกรหัสผ่านไปยังคลิปบอร์ดแล้ว';

  @override
  String get noQRCodeFound => 'ไม่พบ QR code ในภาพ';

  @override
  String get pointCameraAtQR => 'เล็งกล้องไปที่ QR code';

  @override
  String get scanFromGallery => 'สแกนจากแกลเลอรี';

  @override
  String get websiteLink => 'ลิงก์เว็บไซต์';

  @override
  String get wifiNetworkLabel => 'เครือข่าย WiFi';

  @override
  String get openInBrowser => 'เปิดในเบราว์เซอร์';

  @override
  String get wifiCredentials => 'ข้อมูลประจำตัว WiFi';

  @override
  String get contactInformation => 'ข้อมูลผู้ติดต่อ';

  @override
  String get plainTextContent => 'เนื้อหาข้อความธรรมดา';

  @override
  String get reportIssue => 'รายงานปัญหา';

  @override
  String get reportIssueSubtitle => 'ส่งความคิดเห็นถึงเรา';
}
