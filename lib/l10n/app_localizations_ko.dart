// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'Money Wave';

  @override
  String get appTagline => '미래를 계산하세요';

  @override
  String get home => '홈';

  @override
  String get saved => '저장됨';

  @override
  String get history => '기록';

  @override
  String get settings => '설정';

  @override
  String get compare => '비교';

  @override
  String get simulate => '시뮬레이션';

  @override
  String get mainTools => '주요 도구';

  @override
  String categories(int count) {
    return '$count개 카테고리';
  }

  @override
  String get loanCalc => '대출';

  @override
  String get loanCalcSubtitle => '월 납입금';

  @override
  String get interestCalc => '이자';

  @override
  String get interestCalcSubtitle => '단리 및 복리';

  @override
  String get vault => '금고';

  @override
  String get vaultSubtitle => '미래를 계획하세요';

  @override
  String get historySubtitle => '이전 계산';

  @override
  String get proAccess => 'PRO 액세스';

  @override
  String get upgradeToPremium => '프리미엄으로 업그레이드';

  @override
  String get premiumBannerDesc => '고급 차트와\n광고 없는 경험을 잠금 해제하세요.';

  @override
  String get marketPulse => '시장 동향';

  @override
  String get currentRates => '현재 금리';

  @override
  String get homeLoan => '주택담보대출';

  @override
  String get savingsApy => '저축 APY';

  @override
  String get calculatorSimpleInterest => '단리 계산';

  @override
  String get calculatorCompoundInterest => '복리 계산';

  @override
  String get calculatorLoan => '대출 계산기';

  @override
  String get calculatorSavings => '저축 계산기';

  @override
  String get principal => '원금';

  @override
  String get interestRate => '이자율';

  @override
  String get annualInterestRate => '연이율';

  @override
  String get term => '기간';

  @override
  String get termMonths => '기간 (개월)';

  @override
  String get termYears => '기간 (년)';

  @override
  String get monthlyPayment => '월 납입금';

  @override
  String get firstMonthPayment => '첫 달 납입금';

  @override
  String get lastMonthPayment => '마지막 달 납입금';

  @override
  String get totalInterest => '총 이자';

  @override
  String get totalPayment => '총 상환액';

  @override
  String get interest => '이자';

  @override
  String get totalAmount => '총액';

  @override
  String get interestPrincipalRatio => '이자/원금 비율';

  @override
  String get loanAmount => '대출 금액';

  @override
  String get paymentMethod => '상환 방식';

  @override
  String get loanTypeFixed => '원리금균등';

  @override
  String get loanTypeReducing => '원금균등';

  @override
  String get savingsTypeReinvest => '재투자';

  @override
  String get savingsTypeWithdraw => '인출';

  @override
  String get results => '결과';

  @override
  String get paymentStructure => '상환 구조';

  @override
  String get amortizationSchedule => '상환 일정';

  @override
  String get month => '월';

  @override
  String get year => '년';

  @override
  String get years => '년';

  @override
  String get payment => '납입';

  @override
  String get principalPaid => '원금';

  @override
  String get interestPaid => '이자';

  @override
  String get balance => '잔액';

  @override
  String get save => '저장';

  @override
  String get delete => '삭제';

  @override
  String get share => '공유';

  @override
  String get exportPdf => 'PDF 내보내기';

  @override
  String get calculate => '계산';

  @override
  String get reset => '초기화';

  @override
  String get close => '닫기';

  @override
  String get add => '추가';

  @override
  String get storageLimitTitle => '저장 한도';

  @override
  String storageLimitLoans(int count) {
    return '최대 $count개의 대출을 저장했습니다. 무제한 저장을 위해 프리미엄으로 업그레이드하세요!';
  }

  @override
  String storageLimitSavings(int count) {
    return '최대 $count개의 저축을 저장했습니다. 무제한 저장을 위해 프리미엄으로 업그레이드하세요!';
  }

  @override
  String get saveLoan => '대출 저장';

  @override
  String get loanNameHint => '대출명 (선택)';

  @override
  String get amount => '금액';

  @override
  String get rate => '금리';

  @override
  String get loanSaved => '대출이 저장되었습니다';

  @override
  String get saveSavings => '저축 저장';

  @override
  String get savingsNameHint => '저축명 (선택)';

  @override
  String get savingsSaved => '저축이 저장되었습니다';

  @override
  String get savedLoans => '저장된 대출';

  @override
  String get savedSavings => '저장된 저축';

  @override
  String loansCount(int count) {
    return '대출 ($count)';
  }

  @override
  String savingsCount(int count) {
    return '저축 ($count)';
  }

  @override
  String get noSavedItems => '저장된 항목이 없습니다';

  @override
  String get noSavedLoans => '저장된 대출이 없습니다';

  @override
  String get noSavedLoansSubtitle => '대출을 계산하고 저장하여 나중에 확인하세요';

  @override
  String get noSavedSavings => '저장된 저축이 없습니다';

  @override
  String get noSavedSavingsSubtitle => '저축을 계산하고 저장하여 나중에 확인하세요';

  @override
  String errorLoading(String error) {
    return '오류: $error';
  }

  @override
  String get compoundingFrequency => '복리 빈도';

  @override
  String get daily => '매일';

  @override
  String get monthly => '매월';

  @override
  String get quarterly => '분기별';

  @override
  String get yearly => '매년';

  @override
  String get calculationResults => '계산 결과';

  @override
  String get totalReceived => '총 수령액';

  @override
  String get interestEarned => '이자 수익';

  @override
  String get effectiveAnnualRate => '실효 연이율';

  @override
  String get compoundingPeriods => '복리 기간';

  @override
  String get compareWithSimple => '단리와 비교';

  @override
  String get simpleInterest => '단리';

  @override
  String get compoundInterest => '복리';

  @override
  String compoundBenefit(String amount) {
    return '복리로 $amount 더 벌 수 있습니다';
  }

  @override
  String get savingsType => '저축 유형';

  @override
  String get initialDeposit => '초기 예금';

  @override
  String get monthlyDeposit => '월 예금';

  @override
  String get annualRate => '연이율';

  @override
  String get finalBalance => '최종 잔액';

  @override
  String get totalDeposited => '총 예금';

  @override
  String get returnRate => '수익률';

  @override
  String get avgMonthlyInterest => '평균 월 이자';

  @override
  String get detailedAnalysis => '상세 분석';

  @override
  String get deposits => '예금';

  @override
  String get reinvestInfo => '이자가 매월 복리로 계산됩니다';

  @override
  String get withdrawInfo => '이자가 매월 지급되며 복리 없음';

  @override
  String get averageMonthlyInterest => '평균 월 이자';

  @override
  String get totalStructure => '전체 구조';

  @override
  String get premium => '프리미엄 업그레이드';

  @override
  String get premiumActivated => '프리미엄 회원입니다!';

  @override
  String get premiumMember => '프리미엄 회원';

  @override
  String get premiumThanks => '지원해 주셔서 감사합니다!';

  @override
  String get premiumDescription => '모든 기능 잠금 해제';

  @override
  String get premiumFeature1 => '무제한 저장';

  @override
  String get premiumFeature1Desc => '모든 대출과 저축 저장';

  @override
  String get premiumFeature2 => '전체 차트';

  @override
  String get premiumFeature2Desc => '모든 차트 유형으로 세부 정보 확인';

  @override
  String get premiumFeature3 => '시나리오 비교';

  @override
  String get premiumFeature3Desc => '여러 옵션을 나란히 비교';

  @override
  String get premiumFeature4 => 'PDF 내보내기';

  @override
  String get premiumFeature4Desc => '인쇄 또는 공유용 상세 보고서 생성';

  @override
  String get premiumFeature5 => '개발 지원';

  @override
  String get premiumFeature5Desc => '앱 개선에 도움을 주세요';

  @override
  String get premiumFeatures => '프리미엄 기능';

  @override
  String get lifetime => '평생';

  @override
  String get oneTimePurchase => '한 번 결제, 영구 사용';

  @override
  String get upgradeNow => '지금 업그레이드';

  @override
  String get restorePurchase => '구매 복원';

  @override
  String purchaseDate(String date) {
    return '구매일: $date';
  }

  @override
  String get premiumRequired => '프리미엄 필요';

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
    return '$feature로 업그레이드';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => '활성화됨';

  @override
  String get unlockAllFeatures => '모든 기능 잠금 해제';

  @override
  String get theme => '테마';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get themeSystem => '시스템';

  @override
  String get language => '언어';

  @override
  String get about => '정보';

  @override
  String version(String version) {
    return '버전 $version';
  }

  @override
  String get termsOfService => '이용약관';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get termsOfUse => '사용권 계약 (EULA)';

  @override
  String get error => '오류';

  @override
  String get errorGeneric => '문제가 발생했습니다';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get ok => '확인';

  @override
  String get upgrade => '업그레이드';

  @override
  String get compareScenarios => '시나리오 비교';

  @override
  String get upgradeToCompare => '비교하려면 업그레이드';

  @override
  String get loanSettings => '대출 설정';

  @override
  String get scenarioA => '시나리오 A';

  @override
  String get scenarioB => '시나리오 B';

  @override
  String get comparison => '비교';

  @override
  String scenarioSaves(String scenario, String amount) {
    return '시나리오 $scenario가 $amount 절약';
  }

  @override
  String get simulation => '시뮬레이션';

  @override
  String get noScenariosYet => '아직 시나리오가 없습니다';

  @override
  String get addScenariosSubtitle => '대출이나 저축을 추가하여\n재정을 시뮬레이션하세요';

  @override
  String get addLoan => '대출 추가';

  @override
  String get addSavings => '저축 추가';

  @override
  String get loans => '대출';

  @override
  String get savings => '저축';

  @override
  String get timeline => '타임라인';

  @override
  String monthNumber(int number) {
    return '$number개월차';
  }

  @override
  String get netWorth => '순자산';

  @override
  String get positive => '플러스';

  @override
  String get negativeDebt => '마이너스 (부채)';

  @override
  String get now => '현재';

  @override
  String yearsCount(int count) {
    return '$count년';
  }

  @override
  String get debt => '부채';

  @override
  String get remaining => '남은';

  @override
  String get clearAll => '모두 삭제?';

  @override
  String get allScenariosDeleted => '모든 시나리오가 삭제됩니다.';

  @override
  String get loanNameHintExample => '대출명 (예: 주택담보대출)';

  @override
  String get savingsNameHintExample => '이름 (예: 은퇴자금)';

  @override
  String get deposit => '예금';

  @override
  String get loan => '대출';

  @override
  String get selectThemeDescription => '앱 테마를 선택하세요';

  @override
  String get selectLanguageDescription => '원하는 언어를 선택하세요';

  @override
  String get apply => '적용';

  @override
  String get financialTools => '금융 도구';

  @override
  String get reminders => '알림';

  @override
  String get paymentRemindersSubtitle => '납부일 추적';

  @override
  String get savingsGoalsSubtitle => '목표 달성';

  @override
  String get calendar => '캘린더';

  @override
  String get calendarSubtitle => '모든 일정 보기';

  @override
  String get achievementsSubtitle => '진행 상황';

  @override
  String get reportsSubtitle => '통계 보기';

  @override
  String get rateAlertsSubtitle => '금리 모니터링';

  @override
  String get paymentReminders => '납부 알림';

  @override
  String get noRemindersYet => '아직 알림이 없습니다';

  @override
  String get addRemindersSubtitle => '납부 알림을 추가하세요';

  @override
  String get addReminder => '알림 추가';

  @override
  String get editReminder => '알림 편집';

  @override
  String get reminderNameHint => '알림명 (예: 신용카드)';

  @override
  String get dueDate => '납부일';

  @override
  String get remindBefore => '사전 알림';

  @override
  String get days => '일';

  @override
  String get recurring => '반복';

  @override
  String get totalDue => '총 납부액';

  @override
  String get overdue => '연체';

  @override
  String get upcoming => '예정';

  @override
  String get completed => '완료';

  @override
  String get markAsPaid => '납부 완료로 표시';

  @override
  String get markAsPaidConfirm => '납부 완료로 표시하시겠습니까?';

  @override
  String get pending => '대기 중';

  @override
  String get paid => '납부됨';

  @override
  String get skipped => '건너뜀';

  @override
  String get markPaid => '납부 완료';

  @override
  String get weekly => '매주';

  @override
  String get biWeekly => '격주';

  @override
  String get dueToday => '오늘 납부';

  @override
  String get dueTomorrow => '내일 납부';

  @override
  String dueInDays(int days) {
    return '$days일 후 납부';
  }

  @override
  String get pleaseEnterName => '이름을 입력하세요';

  @override
  String get savingsGoals => '저축 목표';

  @override
  String get noGoalsYet => '아직 목표가 없습니다';

  @override
  String get addGoalsSubtitle => '저축 목표를 설정하고 진행 상황을 추적하세요';

  @override
  String get addGoal => '목표 추가';

  @override
  String get editGoal => '목표 편집';

  @override
  String get goalNameHint => '목표명 (예: 여행)';

  @override
  String get targetAmount => '목표 금액';

  @override
  String get initialAmount => '초기 금액';

  @override
  String get deadline => '마감일';

  @override
  String get suggestedMonthly => '권장 월 저축액';

  @override
  String get activeGoals => '진행 중인 목표';

  @override
  String get completedGoals => '완료된 목표';

  @override
  String get totalSaved => '총 저축액';

  @override
  String get totalTarget => '총 목표액';

  @override
  String get ofTotalTarget => '총 목표의';

  @override
  String get milestones => '마일스톤';

  @override
  String get addMoney => '입금';

  @override
  String get withdraw => '인출';

  @override
  String get addContribution => '기여 추가';

  @override
  String get notesOptional => '메모 (선택)';

  @override
  String get withdrawReason => '인출 사유';

  @override
  String get noContributionsYet => '아직 기여가 없습니다';

  @override
  String get pauseGoal => '목표 일시 중지';

  @override
  String get deleteGoal => '목표 삭제';

  @override
  String get deleteGoalConfirm => '이 목표를 삭제하시겠습니까?';

  @override
  String get target => '목표';

  @override
  String get goals => '목표';

  @override
  String savePerMonth(String amount) {
    return '목표 달성을 위해 월 $amount 저축';
  }

  @override
  String get pleaseEnterGoalName => '목표명을 입력하세요';

  @override
  String get withdrawal => '인출';

  @override
  String get start => '시작';

  @override
  String get goalReached => '목표 달성!';

  @override
  String get progress => '진행';

  @override
  String get achievements => '업적';

  @override
  String get financialHealthScore => '재정 건전성 점수';

  @override
  String get financialHealth => '재정 건전성';

  @override
  String get points => '점';

  @override
  String get healthExcellent => '훌륭합니다! 계속 유지하세요!';

  @override
  String get healthGood => '좋은 진전입니다! 올바른 방향으로 가고 있습니다.';

  @override
  String get healthFair => '보통입니다. 개선의 여지가 있습니다.';

  @override
  String get healthNeedsWork => '주의가 필요합니다. 함께 개선해 나갑시다!';

  @override
  String get paymentStreak => '연속 납부';

  @override
  String get dayStreak => '일 연속';

  @override
  String get keepItUp => '계속 유지하세요!';

  @override
  String get longest => '최장';

  @override
  String get unlocked => '잠금 해제됨';

  @override
  String get locked => '잠김';

  @override
  String get financialCalendar => '재정 캘린더';

  @override
  String get monthView => '월별 보기';

  @override
  String get weekView => '주별 보기';

  @override
  String get today => '오늘';

  @override
  String get noEventsForDay => '이 날의 일정이 없습니다';

  @override
  String get goalDeadline => '목표 마감일';

  @override
  String get contribution => '기여';

  @override
  String get reports => '보고서';

  @override
  String get week => '주';

  @override
  String get quarter => '분기';

  @override
  String get allTime => '전체';

  @override
  String get totalPaid => '총 납부액';

  @override
  String get totalDebt => '총 부채';

  @override
  String get debtVsPaid => '부채 vs 납부';

  @override
  String get outstanding => '미납';

  @override
  String get noDataYet => '아직 데이터가 없습니다';

  @override
  String get monthlyOverview => '월별 개요';

  @override
  String get due => '납부';

  @override
  String get paymentPerformance => '납부 성과';

  @override
  String get onTime => '정시';

  @override
  String get late => '지연';

  @override
  String get onTimeRate => '정시 납부율';

  @override
  String get rateAlerts => '금리 알림';

  @override
  String get currentMarketRates => '현재 시장 금리';

  @override
  String get edit => '편집';

  @override
  String get triggeredAlerts => '발동된 알림';

  @override
  String get activeAlerts => '활성 알림';

  @override
  String get inactiveAlerts => '비활성 알림';

  @override
  String get noAlertsYet => '아직 알림이 없습니다';

  @override
  String get addAlertsSubtitle => '금리 변동을 추적하는 알림 추가';

  @override
  String get addAlert => '알림 추가';

  @override
  String get alertNameHint => '알림명 (예: 주택담보대출 금리)';

  @override
  String get loanType => '대출 유형';

  @override
  String get alertWhen => '알림 조건';

  @override
  String get rateDrops => '금리 하락 시';

  @override
  String get rateRises => '금리 상승 시';

  @override
  String get targetRate => '목표 금리';

  @override
  String get when => '시점';

  @override
  String get current => '현재';

  @override
  String get triggered => '발동됨';

  @override
  String get editMarketRates => '시장 금리 편집';

  @override
  String get personalLoan => '개인 대출';

  @override
  String get carLoan => '자동차 대출';

  @override
  String get savingsRate => '저축 금리';

  @override
  String get homeShort => '주택';

  @override
  String get personalShort => '개인';

  @override
  String get carShort => '자동차';

  @override
  String get savingsShort => '저축';

  @override
  String get rateDropAlert => '금리 하락 알림!';

  @override
  String get rateIncreaseAlert => '금리 상승 알림!';

  @override
  String get updated => '업데이트됨';

  @override
  String get newUpdateAvailable => '업데이트 가능';

  @override
  String get updateAppMessage => '새로운 버전이 있습니다. 최신 기능과 개선 사항을 받으려면 업데이트하세요.';

  @override
  String get updateNow => '지금 업데이트';

  @override
  String get later => '나중에';

  @override
  String get qrTools => 'QR 도구';

  @override
  String get createQRCode => 'QR 코드 생성';

  @override
  String get createQRSubtitle => 'QR 코드 만들기';

  @override
  String get scanQRCode => 'QR 코드 스캔';

  @override
  String get scanQRSubtitle => '모든 QR 코드 스캔';

  @override
  String get selectQRType => 'QR 유형 선택';

  @override
  String get qrLink => '링크';

  @override
  String get qrText => '텍스트';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => '연락처';

  @override
  String get qrCode => 'QR 코드';

  @override
  String get websiteAddress => '웹사이트 주소';

  @override
  String get textContent => '텍스트 내용';

  @override
  String get enterContent => '여기에 내용을 입력하세요';

  @override
  String get networkNameSSID => '네트워크 이름 (SSID)';

  @override
  String get wifiPasswordLabel => '비밀번호';

  @override
  String get encryptionType => '암호화 유형';

  @override
  String get noEncryption => '암호화 없음';

  @override
  String get contactName => '연락처 이름';

  @override
  String get contactNameHint => '홍길동';

  @override
  String get phoneNumber => '전화번호';

  @override
  String get generateQRButton => 'QR 코드 생성';

  @override
  String get qrGeneratedOnDevice => 'QR 코드가 기기에서 생성됩니다';

  @override
  String get qrLinkInfo => '웹사이트 URL을 입력하여 스캔 시 링크를 여는 QR 코드를 만드세요.';

  @override
  String get qrWifiInfo => 'WiFi 네트워크에 빠르게 연결할 수 있는 QR 코드를 만드세요.';

  @override
  String get pleaseEnterWebsite => '웹사이트 주소를 입력하세요';

  @override
  String get pleaseEnterTextContent => '텍스트 내용을 입력하세요';

  @override
  String get pleaseEnterWifiName => 'WiFi 네트워크 이름을 입력하세요';

  @override
  String get pleaseEnterContactName => '연락처 이름을 입력하세요';

  @override
  String get copy => '복사';

  @override
  String get copyData => '데이터 복사';

  @override
  String get dataCopied => '클립보드에 복사되었습니다';

  @override
  String get saveToGallery => '갤러리에 저장';

  @override
  String get qrPrivacyNote => '이 QR 코드는 기기에서 로컬로 생성되며 서버로 전송되지 않습니다.';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return '연락처: $name';
  }

  @override
  String get cannotCreateQRImage => 'QR 이미지를 생성할 수 없습니다';

  @override
  String get cannotSaveQR => 'QR 코드를 저장할 수 없습니다';

  @override
  String get qrSavedToGallerySuccess => 'QR 코드가 갤러리에 저장되었습니다';

  @override
  String errorWithMessage(String message) {
    return '오류: $message';
  }

  @override
  String get scanAgain => '다시 스캔';

  @override
  String get openLink => '링크 열기';

  @override
  String get copyPassword => '비밀번호 복사';

  @override
  String get passwordCopied => '비밀번호가 클립보드에 복사되었습니다';

  @override
  String get noQRCodeFound => '이미지에서 QR 코드를 찾을 수 없습니다';

  @override
  String get pointCameraAtQR => '카메라를 QR 코드에 맞추세요';

  @override
  String get scanFromGallery => '갤러리에서 스캔';

  @override
  String get websiteLink => '웹사이트 링크';

  @override
  String get wifiNetworkLabel => 'WiFi 네트워크';

  @override
  String get openInBrowser => '브라우저에서 열기';

  @override
  String get wifiCredentials => 'WiFi 자격 증명';

  @override
  String get contactInformation => '연락처 정보';

  @override
  String get plainTextContent => '일반 텍스트';

  @override
  String get reportIssue => '문제 신고';

  @override
  String get reportIssueSubtitle => '피드백 보내기';

  @override
  String get earlyWithdrawal => '조기 출금';

  @override
  String get earlyWithdrawalSubtitle => '조기 출금 시 손실 계산';

  @override
  String get depositAmount => '예금 금액';

  @override
  String get termDepositRate => '정기 예금 금리';

  @override
  String get demandDepositRate => '보통 예금 금리';

  @override
  String get originalTerm => '원래 기간';

  @override
  String get actualHoldingPeriod => '실제 보유 기간';

  @override
  String get withdrawalResult => '출금 결과';

  @override
  String get amountReceived => '수령 금액';

  @override
  String get actualInterestReceived => '실제 이자 수령';

  @override
  String get interestLost => '손실 이자';

  @override
  String get lossPercentage => '손실 비율';

  @override
  String get ifHeldToMaturity => '만기까지 보유 시';

  @override
  String get youWillLose => '손실 금액';

  @override
  String get earlyWithdrawalWarning => '조기 출금 경고';

  @override
  String get earlyWithdrawalWarningDesc =>
      '조기 출금 시 정기 예금 이자가 아닌 보통 예금 이자율로 계산됩니다.';
}
