// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Money Nest';

  @override
  String get appTagline => '计算您的未来';

  @override
  String get home => '首页';

  @override
  String get saved => '已保存';

  @override
  String get history => '历史';

  @override
  String get settings => '设置';

  @override
  String get compare => '比较';

  @override
  String get simulate => '模拟';

  @override
  String get mainTools => '主要工具';

  @override
  String categories(int count) {
    return '$count 个分类';
  }

  @override
  String get loanCalc => '贷款';

  @override
  String get loanCalcSubtitle => '月供计算';

  @override
  String get interestCalc => '利息';

  @override
  String get interestCalcSubtitle => '单利和复利';

  @override
  String get vault => '金库';

  @override
  String get vaultSubtitle => '规划您的未来';

  @override
  String get historySubtitle => '历史计算记录';

  @override
  String get proAccess => '专业版';

  @override
  String get upgradeToPremium => '升级到高级版';

  @override
  String get premiumBannerDesc => '解锁高级图表\n和无广告体验。';

  @override
  String get marketPulse => '市场动态';

  @override
  String get currentRates => '当前利率';

  @override
  String get homeLoan => '房贷';

  @override
  String get savingsApy => '储蓄年化收益';

  @override
  String get calculatorSimpleInterest => '单利计算';

  @override
  String get calculatorCompoundInterest => '复利计算';

  @override
  String get calculatorLoan => '贷款计算器';

  @override
  String get calculatorSavings => '储蓄计算器';

  @override
  String get principal => '本金';

  @override
  String get interestRate => '利率';

  @override
  String get annualInterestRate => '年利率';

  @override
  String get term => '期限';

  @override
  String get termMonths => '期限（月）';

  @override
  String get termYears => '期限（年）';

  @override
  String get monthlyPayment => '月供';

  @override
  String get firstMonthPayment => '首月还款';

  @override
  String get lastMonthPayment => '末月还款';

  @override
  String get totalInterest => '总利息';

  @override
  String get totalPayment => '总还款';

  @override
  String get interest => '利息';

  @override
  String get totalAmount => '总金额';

  @override
  String get interestPrincipalRatio => '利息/本金比';

  @override
  String get loanAmount => '贷款金额';

  @override
  String get paymentMethod => '还款方式';

  @override
  String get loanTypeFixed => '等额本息';

  @override
  String get loanTypeReducing => '等额本金';

  @override
  String get savingsTypeReinvest => '再投资';

  @override
  String get savingsTypeWithdraw => '提取';

  @override
  String get results => '结果';

  @override
  String get paymentStructure => '还款结构';

  @override
  String get amortizationSchedule => '还款计划表';

  @override
  String get month => '月';

  @override
  String get year => '年';

  @override
  String get years => '年';

  @override
  String get payment => '还款';

  @override
  String get principalPaid => '本金';

  @override
  String get interestPaid => '利息';

  @override
  String get balance => '余额';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get share => '分享';

  @override
  String get exportPdf => '导出PDF';

  @override
  String get calculate => '计算';

  @override
  String get reset => '重置';

  @override
  String get close => '关闭';

  @override
  String get add => '添加';

  @override
  String get storageLimitTitle => '存储限制';

  @override
  String storageLimitLoans(int count) {
    return '您已保存最多$count笔贷款。升级到高级版可无限保存！';
  }

  @override
  String storageLimitSavings(int count) {
    return '您已保存最多$count笔储蓄。升级到高级版可无限保存！';
  }

  @override
  String get saveLoan => '保存贷款';

  @override
  String get loanNameHint => '贷款名称（可选）';

  @override
  String get amount => '金额';

  @override
  String get rate => '利率';

  @override
  String get loanSaved => '贷款已保存';

  @override
  String get saveSavings => '保存储蓄';

  @override
  String get savingsNameHint => '储蓄名称（可选）';

  @override
  String get savingsSaved => '储蓄已保存';

  @override
  String get savedLoans => '已保存贷款';

  @override
  String get savedSavings => '已保存储蓄';

  @override
  String loansCount(int count) {
    return '贷款 ($count)';
  }

  @override
  String savingsCount(int count) {
    return '储蓄 ($count)';
  }

  @override
  String get noSavedItems => '暂无保存项目';

  @override
  String get noSavedLoans => '暂无保存的贷款';

  @override
  String get noSavedLoansSubtitle => '计算并保存贷款以便稍后查看';

  @override
  String get noSavedSavings => '暂无保存的储蓄';

  @override
  String get noSavedSavingsSubtitle => '计算并保存储蓄以便稍后查看';

  @override
  String errorLoading(String error) {
    return '错误: $error';
  }

  @override
  String get compoundingFrequency => '复利频率';

  @override
  String get daily => '每日';

  @override
  String get monthly => '每月';

  @override
  String get quarterly => '每季度';

  @override
  String get yearly => '每年';

  @override
  String get calculationResults => '计算结果';

  @override
  String get totalReceived => '总收入';

  @override
  String get interestEarned => '利息收入';

  @override
  String get effectiveAnnualRate => '实际年利率';

  @override
  String get compoundingPeriods => '复利周期';

  @override
  String get compareWithSimple => '与单利比较';

  @override
  String get simpleInterest => '单利';

  @override
  String get compoundInterest => '复利';

  @override
  String compoundBenefit(String amount) {
    return '复利为您多赚 $amount';
  }

  @override
  String get savingsType => '储蓄类型';

  @override
  String get initialDeposit => '初始存款';

  @override
  String get monthlyDeposit => '月存款';

  @override
  String get annualRate => '年利率';

  @override
  String get finalBalance => '最终余额';

  @override
  String get totalDeposited => '总存款';

  @override
  String get returnRate => '收益率';

  @override
  String get avgMonthlyInterest => '平均月息';

  @override
  String get detailedAnalysis => '详细分析';

  @override
  String get deposits => '存款';

  @override
  String get reinvestInfo => '利息按月复利';

  @override
  String get withdrawInfo => '利息按月支付，不复利';

  @override
  String get averageMonthlyInterest => '平均月息';

  @override
  String get totalStructure => '总体结构';

  @override
  String get premium => '升级高级版';

  @override
  String get premiumActivated => '您已是高级会员！';

  @override
  String get premiumMember => '高级会员';

  @override
  String get premiumThanks => '感谢您的支持！';

  @override
  String get premiumDescription => '解锁所有功能';

  @override
  String get premiumFeature1 => '无限保存';

  @override
  String get premiumFeature1Desc => '保存所有贷款和储蓄记录';

  @override
  String get premiumFeature2 => '完整图表';

  @override
  String get premiumFeature2Desc => '查看所有类型图表的详情';

  @override
  String get premiumFeature3 => '方案比较';

  @override
  String get premiumFeature3Desc => '并排比较多个选项';

  @override
  String get premiumFeature4 => 'PDF导出';

  @override
  String get premiumFeature4Desc => '创建详细报告用于打印或分享';

  @override
  String get premiumFeature5 => '支持开发';

  @override
  String get premiumFeature5Desc => '帮助我们改进应用';

  @override
  String get premiumFeatures => '高级功能';

  @override
  String get lifetime => '终身';

  @override
  String get oneTimePurchase => '一次付费，永久使用';

  @override
  String get upgradeNow => '立即升级';

  @override
  String get restorePurchase => '恢复购买';

  @override
  String purchaseDate(String date) {
    return '购买日期: $date';
  }

  @override
  String get premiumRequired => '需要高级版';

  @override
  String upgradeTo(String feature) {
    return '升级到 $feature';
  }

  @override
  String get pro => '专业版';

  @override
  String get activated => '已激活';

  @override
  String get unlockAllFeatures => '解锁所有功能';

  @override
  String get theme => '主题';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get language => '语言';

  @override
  String get about => '关于';

  @override
  String version(String version) {
    return '版本 $version';
  }

  @override
  String get termsOfService => '服务条款';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get error => '错误';

  @override
  String get errorGeneric => '出错了';

  @override
  String get tryAgain => '重试';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get ok => '确定';

  @override
  String get upgrade => '升级';

  @override
  String get compareScenarios => '比较方案';

  @override
  String get upgradeToCompare => '升级以比较方案';

  @override
  String get loanSettings => '贷款设置';

  @override
  String get scenarioA => '方案 A';

  @override
  String get scenarioB => '方案 B';

  @override
  String get comparison => '比较';

  @override
  String scenarioSaves(String scenario, String amount) {
    return '方案 $scenario 节省 $amount';
  }

  @override
  String get simulation => '模拟';

  @override
  String get noScenariosYet => '暂无方案';

  @override
  String get addScenariosSubtitle => '添加贷款或储蓄\n模拟您的财务状况';

  @override
  String get addLoan => '添加贷款';

  @override
  String get addSavings => '添加储蓄';

  @override
  String get loans => '贷款';

  @override
  String get savings => '储蓄';

  @override
  String get timeline => '时间线';

  @override
  String monthNumber(int number) {
    return '第 $number 月';
  }

  @override
  String get netWorth => '净资产';

  @override
  String get positive => '正数';

  @override
  String get negativeDebt => '负数（负债）';

  @override
  String get now => '现在';

  @override
  String yearsCount(int count) {
    return '$count 年';
  }

  @override
  String get debt => '负债';

  @override
  String get remaining => '剩余';

  @override
  String get clearAll => '清除所有？';

  @override
  String get allScenariosDeleted => '所有方案将被删除。';

  @override
  String get loanNameHintExample => '贷款名称（如：房贷）';

  @override
  String get savingsNameHintExample => '名称（如：退休金）';

  @override
  String get deposit => '存款';

  @override
  String get loan => '贷款';

  @override
  String get selectThemeDescription => '为您的应用选择主题';

  @override
  String get selectLanguageDescription => '选择您的首选语言';

  @override
  String get apply => '应用';

  @override
  String get financialTools => '财务工具';

  @override
  String get reminders => '提醒';

  @override
  String get paymentRemindersSubtitle => '跟踪还款日期';

  @override
  String get savingsGoalsSubtitle => '实现您的目标';

  @override
  String get calendar => '日历';

  @override
  String get calendarSubtitle => '查看所有事件';

  @override
  String get achievementsSubtitle => '您的进度';

  @override
  String get reportsSubtitle => '查看统计';

  @override
  String get rateAlertsSubtitle => '监控利率';

  @override
  String get paymentReminders => '还款提醒';

  @override
  String get noRemindersYet => '暂无提醒';

  @override
  String get addRemindersSubtitle => '添加还款提醒以保持跟踪';

  @override
  String get addReminder => '添加提醒';

  @override
  String get editReminder => '编辑提醒';

  @override
  String get reminderNameHint => '提醒名称（如：信用卡）';

  @override
  String get dueDate => '到期日';

  @override
  String get remindBefore => '提前提醒';

  @override
  String get days => '天';

  @override
  String get recurring => '重复';

  @override
  String get totalDue => '应付总额';

  @override
  String get overdue => '逾期';

  @override
  String get upcoming => '即将到期';

  @override
  String get completed => '已完成';

  @override
  String get markAsPaid => '标记为已付';

  @override
  String get markAsPaidConfirm => '确定要标记为已付吗？';

  @override
  String get pending => '待处理';

  @override
  String get paid => '已付';

  @override
  String get skipped => '已跳过';

  @override
  String get markPaid => '标记已付';

  @override
  String get weekly => '每周';

  @override
  String get biWeekly => '两周一次';

  @override
  String get dueToday => '今天到期';

  @override
  String get dueTomorrow => '明天到期';

  @override
  String dueInDays(int days) {
    return '$days 天后到期';
  }

  @override
  String get pleaseEnterName => '请输入名称';

  @override
  String get savingsGoals => '储蓄目标';

  @override
  String get noGoalsYet => '暂无目标';

  @override
  String get addGoalsSubtitle => '设定储蓄目标并跟踪进度';

  @override
  String get addGoal => '添加目标';

  @override
  String get editGoal => '编辑目标';

  @override
  String get goalNameHint => '目标名称（如：度假）';

  @override
  String get targetAmount => '目标金额';

  @override
  String get initialAmount => '初始金额';

  @override
  String get deadline => '截止日期';

  @override
  String get suggestedMonthly => '建议月存';

  @override
  String get activeGoals => '进行中的目标';

  @override
  String get completedGoals => '已完成的目标';

  @override
  String get totalSaved => '总储蓄';

  @override
  String get totalTarget => '总目标';

  @override
  String get ofTotalTarget => '占总目标';

  @override
  String get milestones => '里程碑';

  @override
  String get addMoney => '存入';

  @override
  String get withdraw => '取出';

  @override
  String get addContribution => '添加存款';

  @override
  String get notesOptional => '备注（可选）';

  @override
  String get withdrawReason => '取款原因';

  @override
  String get noContributionsYet => '暂无存款记录';

  @override
  String get pauseGoal => '暂停目标';

  @override
  String get deleteGoal => '删除目标';

  @override
  String get deleteGoalConfirm => '确定要删除此目标吗？';

  @override
  String get target => '目标';

  @override
  String get goals => '目标';

  @override
  String savePerMonth(String amount) {
    return '每月存 $amount 以达成目标';
  }

  @override
  String get pleaseEnterGoalName => '请输入目标名称';

  @override
  String get withdrawal => '取款';

  @override
  String get start => '开始';

  @override
  String get goalReached => '目标达成！';

  @override
  String get progress => '进度';

  @override
  String get achievements => '成就';

  @override
  String get financialHealthScore => '财务健康评分';

  @override
  String get financialHealth => '财务健康';

  @override
  String get points => '分';

  @override
  String get healthExcellent => '优秀！继续保持！';

  @override
  String get healthGood => '进展良好！您正在正确的轨道上。';

  @override
  String get healthFair => '一般。还有改进空间。';

  @override
  String get healthNeedsWork => '需要关注。让我们一起改进！';

  @override
  String get paymentStreak => '连续还款';

  @override
  String get dayStreak => '天连续';

  @override
  String get keepItUp => '继续加油！';

  @override
  String get longest => '最长';

  @override
  String get unlocked => '已解锁';

  @override
  String get locked => '已锁定';

  @override
  String get financialCalendar => '财务日历';

  @override
  String get monthView => '月视图';

  @override
  String get weekView => '周视图';

  @override
  String get today => '今天';

  @override
  String get noEventsForDay => '当天无事件';

  @override
  String get goalDeadline => '目标截止';

  @override
  String get contribution => '存款';

  @override
  String get reports => '报告';

  @override
  String get week => '周';

  @override
  String get quarter => '季度';

  @override
  String get allTime => '全部';

  @override
  String get totalPaid => '已付总额';

  @override
  String get totalDebt => '总负债';

  @override
  String get debtVsPaid => '负债 vs 已付';

  @override
  String get outstanding => '未付';

  @override
  String get noDataYet => '暂无数据';

  @override
  String get monthlyOverview => '月度概览';

  @override
  String get due => '到期';

  @override
  String get paymentPerformance => '还款表现';

  @override
  String get onTime => '准时';

  @override
  String get late => '逾期';

  @override
  String get onTimeRate => '准时率';

  @override
  String get rateAlerts => '利率提醒';

  @override
  String get currentMarketRates => '当前市场利率';

  @override
  String get edit => '编辑';

  @override
  String get triggeredAlerts => '已触发提醒';

  @override
  String get activeAlerts => '活跃提醒';

  @override
  String get inactiveAlerts => '非活跃提醒';

  @override
  String get noAlertsYet => '暂无提醒';

  @override
  String get addAlertsSubtitle => '添加提醒以跟踪利率变化';

  @override
  String get addAlert => '添加提醒';

  @override
  String get alertNameHint => '提醒名称（如：房贷利率）';

  @override
  String get loanType => '贷款类型';

  @override
  String get alertWhen => '提醒条件';

  @override
  String get rateDrops => '利率下降';

  @override
  String get rateRises => '利率上升';

  @override
  String get targetRate => '目标利率';

  @override
  String get when => '时间';

  @override
  String get current => '当前';

  @override
  String get triggered => '已触发';

  @override
  String get editMarketRates => '编辑市场利率';

  @override
  String get personalLoan => '个人贷款';

  @override
  String get carLoan => '车贷';

  @override
  String get savingsRate => '储蓄利率';

  @override
  String get homeShort => '房贷';

  @override
  String get personalShort => '个人';

  @override
  String get carShort => '车贷';

  @override
  String get savingsShort => '储蓄';

  @override
  String get rateDropAlert => '利率下降提醒！';

  @override
  String get rateIncreaseAlert => '利率上升提醒！';

  @override
  String get updated => '已更新';

  @override
  String get newUpdateAvailable => '有新版本';

  @override
  String get updateAppMessage => '有新版本可用。请更新以获取最新功能和改进。';

  @override
  String get updateNow => '立即更新';

  @override
  String get later => '稍后';

  @override
  String get qrTools => '二维码工具';

  @override
  String get createQRCode => '创建二维码';

  @override
  String get createQRSubtitle => '生成二维码';

  @override
  String get scanQRCode => '扫描二维码';

  @override
  String get scanQRSubtitle => '扫描任意二维码';

  @override
  String get selectQRType => '选择二维码类型';

  @override
  String get qrLink => '链接';

  @override
  String get qrText => '文本';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => '联系人';

  @override
  String get qrCode => '二维码';

  @override
  String get websiteAddress => '网站地址';

  @override
  String get textContent => '文本内容';

  @override
  String get enterContent => '在此输入内容';

  @override
  String get networkNameSSID => '网络名称 (SSID)';

  @override
  String get wifiPasswordLabel => '密码';

  @override
  String get encryptionType => '加密类型';

  @override
  String get noEncryption => '无加密';

  @override
  String get contactName => '联系人姓名';

  @override
  String get contactNameHint => '张三';

  @override
  String get phoneNumber => '电话号码';

  @override
  String get generateQRButton => '生成二维码';

  @override
  String get qrGeneratedOnDevice => '二维码在您的设备上生成';

  @override
  String get qrLinkInfo => '输入网址以创建一个扫描后打开链接的二维码。';

  @override
  String get qrWifiInfo => '创建一个让他人快速连接到您的WiFi网络的二维码。';

  @override
  String get pleaseEnterWebsite => '请输入网站地址';

  @override
  String get pleaseEnterTextContent => '请输入文本内容';

  @override
  String get pleaseEnterWifiName => '请输入WiFi网络名称';

  @override
  String get pleaseEnterContactName => '请输入联系人姓名';

  @override
  String get copy => '复制';

  @override
  String get copyData => '复制数据';

  @override
  String get dataCopied => '数据已复制到剪贴板';

  @override
  String get saveToGallery => '保存到相册';

  @override
  String get qrPrivacyNote => '此二维码在您的设备上本地生成，不会发送到任何服务器。';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return '联系人: $name';
  }

  @override
  String get cannotCreateQRImage => '无法创建二维码图片';

  @override
  String get cannotSaveQR => '无法保存二维码';

  @override
  String get qrSavedToGallerySuccess => '二维码已保存到相册';

  @override
  String errorWithMessage(String message) {
    return '错误: $message';
  }

  @override
  String get scanAgain => '重新扫描';

  @override
  String get openLink => '打开链接';

  @override
  String get copyPassword => '复制密码';

  @override
  String get passwordCopied => '密码已复制到剪贴板';

  @override
  String get noQRCodeFound => '图片中未找到二维码';

  @override
  String get pointCameraAtQR => '将相机对准二维码';

  @override
  String get scanFromGallery => '从相册扫描';

  @override
  String get websiteLink => '网站链接';

  @override
  String get wifiNetworkLabel => 'WiFi网络';

  @override
  String get openInBrowser => '在浏览器中打开';

  @override
  String get wifiCredentials => 'WiFi凭证';

  @override
  String get contactInformation => '联系信息';

  @override
  String get plainTextContent => '纯文本内容';

  @override
  String get reportIssue => '报告问题';

  @override
  String get reportIssueSubtitle => '发送反馈';
}
