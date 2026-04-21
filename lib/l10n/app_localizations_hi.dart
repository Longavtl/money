// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'Money Wave';

  @override
  String get appTagline => 'अपने भविष्य की गणना करें';

  @override
  String get home => 'होम';

  @override
  String get saved => 'सहेजे गए';

  @override
  String get history => 'इतिहास';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get compare => 'तुलना';

  @override
  String get simulate => 'अनुकरण';

  @override
  String get mainTools => 'मुख्य उपकरण';

  @override
  String categories(int count) {
    return '$count श्रेणियां';
  }

  @override
  String get loanCalc => 'ऋण गणना';

  @override
  String get loanCalcSubtitle => 'मासिक भुगतान';

  @override
  String get interestCalc => 'ब्याज';

  @override
  String get interestCalcSubtitle => 'साधारण और चक्रवृद्धि';

  @override
  String get vault => 'तिजोरी';

  @override
  String get vaultSubtitle => 'अपने भविष्य की योजना बनाएं';

  @override
  String get historySubtitle => 'पिछली गणनाएं';

  @override
  String get proAccess => 'प्रो एक्सेस';

  @override
  String get upgradeToPremium => 'प्रीमियम में अपग्रेड करें';

  @override
  String get premiumBannerDesc =>
      'उन्नत चार्ट और विज्ञापन-मुक्त\nअनुभव अनलॉक करें।';

  @override
  String get marketPulse => 'बाजार नाड़ी';

  @override
  String get currentRates => 'वर्तमान दरें';

  @override
  String get homeLoan => 'होम लोन';

  @override
  String get savingsApy => 'बचत APY';

  @override
  String get calculatorSimpleInterest => 'साधारण ब्याज';

  @override
  String get calculatorCompoundInterest => 'चक्रवृद्धि ब्याज';

  @override
  String get calculatorLoan => 'ऋण कैलकुलेटर';

  @override
  String get calculatorSavings => 'बचत कैलकुलेटर';

  @override
  String get principal => 'मूलधन';

  @override
  String get interestRate => 'ब्याज दर';

  @override
  String get annualInterestRate => 'ब्याज दर (वार्षिक)';

  @override
  String get term => 'अवधि';

  @override
  String get termMonths => 'अवधि (महीने)';

  @override
  String get termYears => 'अवधि (वर्ष)';

  @override
  String get monthlyPayment => 'मासिक भुगतान';

  @override
  String get firstMonthPayment => 'पहले महीने का भुगतान';

  @override
  String get lastMonthPayment => 'अंतिम महीने का भुगतान';

  @override
  String get totalInterest => 'कुल ब्याज';

  @override
  String get totalPayment => 'कुल भुगतान';

  @override
  String get interest => 'ब्याज';

  @override
  String get totalAmount => 'कुल राशि';

  @override
  String get interestPrincipalRatio => 'ब्याज/मूलधन अनुपात';

  @override
  String get loanAmount => 'ऋण राशि';

  @override
  String get paymentMethod => 'भुगतान विधि';

  @override
  String get loanTypeFixed => 'समान किस्त';

  @override
  String get loanTypeReducing => 'घटता शेष';

  @override
  String get savingsTypeReinvest => 'पुनर्निवेश';

  @override
  String get savingsTypeWithdraw => 'निकासी';

  @override
  String get results => 'परिणाम';

  @override
  String get paymentStructure => 'भुगतान संरचना';

  @override
  String get amortizationSchedule => 'परिशोधन अनुसूची';

  @override
  String get month => 'महीना';

  @override
  String get year => 'वर्ष';

  @override
  String get years => 'वर्ष';

  @override
  String get payment => 'भुगतान';

  @override
  String get principalPaid => 'मूलधन';

  @override
  String get interestPaid => 'ब्याज';

  @override
  String get balance => 'शेष';

  @override
  String get save => 'सहेजें';

  @override
  String get delete => 'हटाएं';

  @override
  String get share => 'साझा करें';

  @override
  String get exportPdf => 'PDF निर्यात';

  @override
  String get calculate => 'गणना';

  @override
  String get reset => 'रीसेट';

  @override
  String get close => 'बंद करें';

  @override
  String get add => 'जोड़ें';

  @override
  String get storageLimitTitle => 'संग्रहण सीमा';

  @override
  String storageLimitLoans(int count) {
    return 'आपने अधिकतम $count ऋण सहेजे हैं। असीमित सेव के लिए प्रीमियम में अपग्रेड करें!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'आपने अधिकतम $count बचत सहेजी हैं। असीमित सेव के लिए प्रीमियम में अपग्रेड करें!';
  }

  @override
  String get saveLoan => 'ऋण सहेजें';

  @override
  String get loanNameHint => 'ऋण का नाम (वैकल्पिक)';

  @override
  String get amount => 'राशि';

  @override
  String get rate => 'दर';

  @override
  String get loanSaved => 'ऋण सहेजा गया';

  @override
  String get saveSavings => 'बचत सहेजें';

  @override
  String get savingsNameHint => 'बचत का नाम (वैकल्पिक)';

  @override
  String get savingsSaved => 'बचत सहेजी गई';

  @override
  String get savedLoans => 'सहेजे गए ऋण';

  @override
  String get savedSavings => 'सहेजी गई बचत';

  @override
  String loansCount(int count) {
    return 'ऋण ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'बचत ($count)';
  }

  @override
  String get noSavedItems => 'कोई सहेजे गए आइटम नहीं';

  @override
  String get noSavedLoans => 'कोई सहेजे गए ऋण नहीं';

  @override
  String get noSavedLoansSubtitle =>
      'बाद में देखने के लिए ऋण की गणना करें और सहेजें';

  @override
  String get noSavedSavings => 'कोई सहेजी गई बचत नहीं';

  @override
  String get noSavedSavingsSubtitle =>
      'बाद में देखने के लिए बचत की गणना करें और सहेजें';

  @override
  String errorLoading(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get compoundingFrequency => 'चक्रवृद्धि आवृत्ति';

  @override
  String get daily => 'दैनिक';

  @override
  String get monthly => 'मासिक';

  @override
  String get quarterly => 'त्रैमासिक';

  @override
  String get yearly => 'वार्षिक';

  @override
  String get calculationResults => 'गणना परिणाम';

  @override
  String get totalReceived => 'कुल प्राप्त';

  @override
  String get interestEarned => 'अर्जित ब्याज';

  @override
  String get effectiveAnnualRate => 'प्रभावी वार्षिक दर';

  @override
  String get compoundingPeriods => 'चक्रवृद्धि अवधि';

  @override
  String get compareWithSimple => 'साधारण ब्याज से तुलना करें';

  @override
  String get simpleInterest => 'साधारण ब्याज';

  @override
  String get compoundInterest => 'चक्रवृद्धि ब्याज';

  @override
  String compoundBenefit(String amount) {
    return 'चक्रवृद्धि ब्याज आपको $amount अधिक देता है';
  }

  @override
  String get savingsType => 'बचत प्रकार';

  @override
  String get initialDeposit => 'प्रारंभिक जमा';

  @override
  String get monthlyDeposit => 'मासिक जमा';

  @override
  String get annualRate => 'वार्षिक दर';

  @override
  String get finalBalance => 'अंतिम शेष';

  @override
  String get totalDeposited => 'कुल जमा';

  @override
  String get returnRate => 'रिटर्न दर';

  @override
  String get avgMonthlyInterest => 'औसत मासिक ब्याज';

  @override
  String get detailedAnalysis => 'विस्तृत विश्लेषण';

  @override
  String get deposits => 'जमा';

  @override
  String get reinvestInfo => 'ब्याज मासिक रूप से चक्रवृद्धि होता है';

  @override
  String get withdrawInfo =>
      'ब्याज मासिक रूप से भुगतान किया जाता है, चक्रवृद्धि नहीं होता';

  @override
  String get averageMonthlyInterest => 'औसत ब्याज/महीना';

  @override
  String get totalStructure => 'कुल संरचना';

  @override
  String get premium => 'प्रीमियम में अपग्रेड करें';

  @override
  String get premiumActivated => 'आप प्रीमियम हैं!';

  @override
  String get premiumMember => 'प्रीमियम सदस्य';

  @override
  String get premiumThanks => 'आपके समर्थन के लिए धन्यवाद!';

  @override
  String get premiumDescription => 'सभी सुविधाएं अनलॉक करें';

  @override
  String get premiumFeature1 => 'असीमित सेव';

  @override
  String get premiumFeature1Desc => 'अपने सभी ऋण और बचत संग्रहीत करें';

  @override
  String get premiumFeature2 => 'पूर्ण चार्ट सूट';

  @override
  String get premiumFeature2Desc => 'सभी चार्ट प्रकारों के साथ विवरण देखें';

  @override
  String get premiumFeature3 => 'परिदृश्य तुलना';

  @override
  String get premiumFeature3Desc => 'एक साथ कई विकल्पों की तुलना करें';

  @override
  String get premiumFeature4 => 'PDF निर्यात';

  @override
  String get premiumFeature4Desc =>
      'प्रिंट या साझा करने के लिए विस्तृत रिपोर्ट बनाएं';

  @override
  String get premiumFeature5 => 'विकास का समर्थन करें';

  @override
  String get premiumFeature5Desc => 'ऐप को बेहतर बनाने में हमारी मदद करें';

  @override
  String get premiumFeatures => 'प्रीमियम सुविधाएं';

  @override
  String get lifetime => 'आजीवन';

  @override
  String get oneTimePurchase => 'एक बार भुगतान करें, हमेशा उपयोग करें';

  @override
  String get upgradeNow => 'अभी अपग्रेड करें';

  @override
  String get restorePurchase => 'खरीद पुनर्स्थापित करें';

  @override
  String purchaseDate(String date) {
    return 'खरीद तिथि: $date';
  }

  @override
  String get premiumRequired => 'प्रीमियम आवश्यक';

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
    return '$feature के लिए अपग्रेड करें';
  }

  @override
  String get pro => 'प्रो';

  @override
  String get activated => 'सक्रिय';

  @override
  String get unlockAllFeatures => 'सभी सुविधाएं अनलॉक करें';

  @override
  String get theme => 'थीम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get language => 'भाषा';

  @override
  String get about => 'के बारे में';

  @override
  String version(String version) {
    return 'संस्करण $version';
  }

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get error => 'त्रुटि';

  @override
  String get errorGeneric => 'कुछ गलत हो गया';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get ok => 'ठीक है';

  @override
  String get upgrade => 'अपग्रेड';

  @override
  String get compareScenarios => 'परिदृश्यों की तुलना करें';

  @override
  String get upgradeToCompare => 'परिदृश्यों की तुलना करने के लिए अपग्रेड करें';

  @override
  String get loanSettings => 'ऋण सेटिंग्स';

  @override
  String get scenarioA => 'परिदृश्य A';

  @override
  String get scenarioB => 'परिदृश्य B';

  @override
  String get comparison => 'तुलना';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'परिदृश्य $scenario $amount बचाता है';
  }

  @override
  String get simulation => 'अनुकरण';

  @override
  String get noScenariosYet => 'अभी तक कोई परिदृश्य नहीं';

  @override
  String get addScenariosSubtitle =>
      'समय के साथ अपने वित्त का\nअनुकरण करने के लिए ऋण या बचत जोड़ें';

  @override
  String get addLoan => 'ऋण जोड़ें';

  @override
  String get addSavings => 'बचत जोड़ें';

  @override
  String get loans => 'ऋण';

  @override
  String get savings => 'बचत';

  @override
  String get timeline => 'समयरेखा';

  @override
  String monthNumber(int number) {
    return 'महीना $number';
  }

  @override
  String get netWorth => 'कुल संपत्ति';

  @override
  String get positive => 'सकारात्मक';

  @override
  String get negativeDebt => 'नकारात्मक (ऋण)';

  @override
  String get now => 'अभी';

  @override
  String yearsCount(int count) {
    return '$count वर्ष';
  }

  @override
  String get debt => 'ऋण';

  @override
  String get remaining => 'शेष';

  @override
  String get clearAll => 'सभी साफ़ करें?';

  @override
  String get allScenariosDeleted => 'सभी परिदृश्य हटा दिए जाएंगे।';

  @override
  String get loanNameHintExample => 'ऋण का नाम (जैसे, होम लोन)';

  @override
  String get savingsNameHintExample => 'नाम (जैसे, सेवानिवृत्ति)';

  @override
  String get deposit => 'जमा';

  @override
  String get loan => 'ऋण';

  @override
  String get selectThemeDescription => 'अपने ऐप के लिए एक थीम चुनें';

  @override
  String get selectLanguageDescription => 'अपनी पसंदीदा भाषा चुनें';

  @override
  String get apply => 'लागू करें';

  @override
  String get financialTools => 'वित्तीय उपकरण';

  @override
  String get reminders => 'अनुस्मारक';

  @override
  String get paymentRemindersSubtitle => 'नियत तिथियों को ट्रैक करें';

  @override
  String get savingsGoalsSubtitle => 'अपने लक्ष्यों तक पहुंचें';

  @override
  String get calendar => 'कैलेंडर';

  @override
  String get calendarSubtitle => 'सभी घटनाएं देखें';

  @override
  String get achievementsSubtitle => 'आपकी प्रगति';

  @override
  String get reportsSubtitle => 'आंकड़े देखें';

  @override
  String get rateAlertsSubtitle => 'दरों की निगरानी करें';

  @override
  String get paymentReminders => 'भुगतान अनुस्मारक';

  @override
  String get noRemindersYet => 'अभी तक कोई अनुस्मारक नहीं';

  @override
  String get addRemindersSubtitle =>
      'ट्रैक पर बने रहने के लिए भुगतान अनुस्मारक जोड़ें';

  @override
  String get addReminder => 'अनुस्मारक जोड़ें';

  @override
  String get editReminder => 'अनुस्मारक संपादित करें';

  @override
  String get reminderNameHint => 'अनुस्मारक का नाम (जैसे, क्रेडिट कार्ड)';

  @override
  String get dueDate => 'नियत तिथि';

  @override
  String get remindBefore => 'पहले याद दिलाएं';

  @override
  String get days => 'दिन';

  @override
  String get recurring => 'आवर्ती';

  @override
  String get totalDue => 'कुल बकाया';

  @override
  String get overdue => 'अतिदेय';

  @override
  String get upcoming => 'आगामी';

  @override
  String get completed => 'पूर्ण';

  @override
  String get markAsPaid => 'भुगतान के रूप में चिह्नित करें';

  @override
  String get markAsPaidConfirm =>
      'क्या आप वाकई इसे भुगतान के रूप में चिह्नित करना चाहते हैं?';

  @override
  String get pending => 'लंबित';

  @override
  String get paid => 'भुगतान';

  @override
  String get skipped => 'छोड़ा गया';

  @override
  String get markPaid => 'भुगतान चिह्नित करें';

  @override
  String get weekly => 'साप्ताहिक';

  @override
  String get biWeekly => 'पाक्षिक';

  @override
  String get dueToday => 'आज देय';

  @override
  String get dueTomorrow => 'कल देय';

  @override
  String dueInDays(int days) {
    return '$days दिनों में देय';
  }

  @override
  String get pleaseEnterName => 'कृपया एक नाम दर्ज करें';

  @override
  String get savingsGoals => 'बचत लक्ष्य';

  @override
  String get noGoalsYet => 'अभी तक कोई लक्ष्य नहीं';

  @override
  String get addGoalsSubtitle =>
      'बचत लक्ष्य निर्धारित करें और अपनी प्रगति ट्रैक करें';

  @override
  String get addGoal => 'लक्ष्य जोड़ें';

  @override
  String get editGoal => 'लक्ष्य संपादित करें';

  @override
  String get goalNameHint => 'लक्ष्य का नाम (जैसे, छुट्टी)';

  @override
  String get targetAmount => 'लक्ष्य राशि';

  @override
  String get initialAmount => 'प्रारंभिक राशि';

  @override
  String get deadline => 'अंतिम तिथि';

  @override
  String get suggestedMonthly => 'सुझाया गया मासिक';

  @override
  String get activeGoals => 'सक्रिय लक्ष्य';

  @override
  String get completedGoals => 'पूर्ण लक्ष्य';

  @override
  String get totalSaved => 'कुल बचत';

  @override
  String get totalTarget => 'कुल लक्ष्य';

  @override
  String get ofTotalTarget => 'कुल लक्ष्य का';

  @override
  String get milestones => 'मील के पत्थर';

  @override
  String get addMoney => 'पैसे जोड़ें';

  @override
  String get withdraw => 'निकालें';

  @override
  String get addContribution => 'योगदान जोड़ें';

  @override
  String get notesOptional => 'नोट्स (वैकल्पिक)';

  @override
  String get withdrawReason => 'निकासी का कारण';

  @override
  String get noContributionsYet => 'अभी तक कोई योगदान नहीं';

  @override
  String get pauseGoal => 'लक्ष्य रोकें';

  @override
  String get deleteGoal => 'लक्ष्य हटाएं';

  @override
  String get deleteGoalConfirm => 'क्या आप वाकई इस लक्ष्य को हटाना चाहते हैं?';

  @override
  String get target => 'लक्ष्य';

  @override
  String get goals => 'लक्ष्य';

  @override
  String savePerMonth(String amount) {
    return 'लक्ष्य तक पहुंचने के लिए $amount/महीना बचाएं';
  }

  @override
  String get pleaseEnterGoalName => 'कृपया एक लक्ष्य नाम दर्ज करें';

  @override
  String get withdrawal => 'निकासी';

  @override
  String get start => 'शुरू';

  @override
  String get goalReached => 'लक्ष्य!';

  @override
  String get progress => 'प्रगति';

  @override
  String get achievements => 'उपलब्धियां';

  @override
  String get financialHealthScore => 'वित्तीय स्वास्थ्य स्कोर';

  @override
  String get financialHealth => 'वित्तीय स्वास्थ्य';

  @override
  String get points => 'अंक';

  @override
  String get healthExcellent => 'उत्कृष्ट! शानदार काम जारी रखें!';

  @override
  String get healthGood => 'अच्छी प्रगति! आप सही रास्ते पर हैं।';

  @override
  String get healthFair => 'ठीक है। सुधार की गुंजाइश है।';

  @override
  String get healthNeedsWork =>
      'ध्यान देने की जरूरत है। आइए एक साथ सुधार करें!';

  @override
  String get paymentStreak => 'भुगतान स्ट्रीक';

  @override
  String get dayStreak => 'दिन की स्ट्रीक';

  @override
  String get keepItUp => 'इसे जारी रखें!';

  @override
  String get longest => 'सबसे लंबा';

  @override
  String get unlocked => 'अनलॉक किया गया';

  @override
  String get locked => 'लॉक किया गया';

  @override
  String get financialCalendar => 'वित्तीय कैलेंडर';

  @override
  String get monthView => 'महीना दृश्य';

  @override
  String get weekView => 'सप्ताह दृश्य';

  @override
  String get today => 'आज';

  @override
  String get noEventsForDay => 'इस दिन के लिए कोई घटना नहीं';

  @override
  String get goalDeadline => 'लक्ष्य की अंतिम तिथि';

  @override
  String get contribution => 'योगदान';

  @override
  String get reports => 'रिपोर्ट';

  @override
  String get week => 'सप्ताह';

  @override
  String get quarter => 'तिमाही';

  @override
  String get allTime => 'सभी समय';

  @override
  String get totalPaid => 'कुल भुगतान';

  @override
  String get totalDebt => 'कुल ऋण';

  @override
  String get debtVsPaid => 'ऋण बनाम भुगतान';

  @override
  String get outstanding => 'बकाया';

  @override
  String get noDataYet => 'अभी तक कोई डेटा नहीं';

  @override
  String get monthlyOverview => 'मासिक अवलोकन';

  @override
  String get due => 'देय';

  @override
  String get paymentPerformance => 'भुगतान प्रदर्शन';

  @override
  String get onTime => 'समय पर';

  @override
  String get late => 'देर से';

  @override
  String get onTimeRate => 'समय पर दर';

  @override
  String get rateAlerts => 'दर अलर्ट';

  @override
  String get currentMarketRates => 'वर्तमान बाजार दरें';

  @override
  String get edit => 'संपादित करें';

  @override
  String get triggeredAlerts => 'ट्रिगर किए गए अलर्ट';

  @override
  String get activeAlerts => 'सक्रिय अलर्ट';

  @override
  String get inactiveAlerts => 'निष्क्रिय अलर्ट';

  @override
  String get noAlertsYet => 'अभी तक कोई अलर्ट नहीं';

  @override
  String get addAlertsSubtitle =>
      'ब्याज दर परिवर्तनों को ट्रैक करने के लिए अलर्ट जोड़ें';

  @override
  String get addAlert => 'अलर्ट जोड़ें';

  @override
  String get alertNameHint => 'अलर्ट का नाम (जैसे, होम लोन दर)';

  @override
  String get loanType => 'ऋण प्रकार';

  @override
  String get alertWhen => 'अलर्ट कब';

  @override
  String get rateDrops => 'दर गिरती है';

  @override
  String get rateRises => 'दर बढ़ती है';

  @override
  String get targetRate => 'लक्ष्य दर';

  @override
  String get when => 'कब';

  @override
  String get current => 'वर्तमान';

  @override
  String get triggered => 'ट्रिगर किया गया';

  @override
  String get editMarketRates => 'बाजार दरें संपादित करें';

  @override
  String get personalLoan => 'व्यक्तिगत ऋण';

  @override
  String get carLoan => 'कार ऋण';

  @override
  String get savingsRate => 'बचत दर';

  @override
  String get homeShort => 'होम';

  @override
  String get personalShort => 'व्यक्तिगत';

  @override
  String get carShort => 'कार';

  @override
  String get savingsShort => 'बचत';

  @override
  String get rateDropAlert => 'दर गिरावट अलर्ट!';

  @override
  String get rateIncreaseAlert => 'दर वृद्धि अलर्ट!';

  @override
  String get updated => 'अपडेट किया गया';

  @override
  String get newUpdateAvailable => 'अपडेट उपलब्ध';

  @override
  String get updateAppMessage =>
      'ऐप का नया संस्करण उपलब्ध है। नवीनतम सुविधाओं और सुधारों के लिए अपडेट करें।';

  @override
  String get updateNow => 'अभी अपडेट करें';

  @override
  String get later => 'बाद में';

  @override
  String get qrTools => 'QR उपकरण';

  @override
  String get createQRCode => 'QR कोड बनाएं';

  @override
  String get createQRSubtitle => 'QR कोड उत्पन्न करें';

  @override
  String get scanQRCode => 'QR कोड स्कैन करें';

  @override
  String get scanQRSubtitle => 'कोई भी QR कोड स्कैन करें';

  @override
  String get selectQRType => 'QR प्रकार चुनें';

  @override
  String get qrLink => 'लिंक';

  @override
  String get qrText => 'टेक्स्ट';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => 'संपर्क';

  @override
  String get qrCode => 'QR कोड';

  @override
  String get websiteAddress => 'वेबसाइट पता';

  @override
  String get textContent => 'टेक्स्ट सामग्री';

  @override
  String get enterContent => 'अपनी सामग्री यहां दर्ज करें';

  @override
  String get networkNameSSID => 'नेटवर्क नाम (SSID)';

  @override
  String get wifiPasswordLabel => 'पासवर्ड';

  @override
  String get encryptionType => 'एन्क्रिप्शन प्रकार';

  @override
  String get noEncryption => 'कोई एन्क्रिप्शन नहीं';

  @override
  String get contactName => 'संपर्क नाम';

  @override
  String get contactNameHint => 'राज कुमार';

  @override
  String get phoneNumber => 'फोन नंबर';

  @override
  String get generateQRButton => 'QR कोड उत्पन्न करें';

  @override
  String get qrGeneratedOnDevice => 'QR कोड आपके डिवाइस पर उत्पन्न होता है';

  @override
  String get qrLinkInfo =>
      'एक QR कोड बनाने के लिए एक वेबसाइट URL दर्ज करें जो स्कैन करने पर लिंक खोलता है।';

  @override
  String get qrWifiInfo =>
      'एक QR कोड बनाएं जो दूसरों को आपके WiFi नेटवर्क से जल्दी कनेक्ट करने की अनुमति देता है।';

  @override
  String get pleaseEnterWebsite => 'कृपया एक वेबसाइट पता दर्ज करें';

  @override
  String get pleaseEnterTextContent => 'कृपया टेक्स्ट सामग्री दर्ज करें';

  @override
  String get pleaseEnterWifiName => 'कृपया WiFi नेटवर्क नाम दर्ज करें';

  @override
  String get pleaseEnterContactName => 'कृपया संपर्क नाम दर्ज करें';

  @override
  String get copy => 'कॉपी करें';

  @override
  String get copyData => 'डेटा कॉपी करें';

  @override
  String get dataCopied => 'डेटा क्लिपबोर्ड पर कॉपी किया गया';

  @override
  String get saveToGallery => 'गैलरी में सहेजें';

  @override
  String get qrPrivacyNote =>
      'यह QR कोड स्थानीय रूप से आपके डिवाइस पर उत्पन्न होता है और किसी भी सर्वर पर नहीं भेजा जाता है।';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return 'संपर्क: $name';
  }

  @override
  String get cannotCreateQRImage => 'QR छवि नहीं बना सकते';

  @override
  String get cannotSaveQR => 'QR कोड सहेज नहीं सकते';

  @override
  String get qrSavedToGallerySuccess => 'QR कोड गैलरी में सहेजा गया';

  @override
  String errorWithMessage(String message) {
    return 'त्रुटि: $message';
  }

  @override
  String get scanAgain => 'फिर से स्कैन करें';

  @override
  String get openLink => 'लिंक खोलें';

  @override
  String get copyPassword => 'पासवर्ड कॉपी करें';

  @override
  String get passwordCopied => 'पासवर्ड क्लिपबोर्ड पर कॉपी किया गया';

  @override
  String get noQRCodeFound => 'छवि में कोई QR कोड नहीं मिला';

  @override
  String get pointCameraAtQR => 'कैमरा को QR कोड पर इंगित करें';

  @override
  String get scanFromGallery => 'गैलरी से स्कैन करें';

  @override
  String get websiteLink => 'वेबसाइट लिंक';

  @override
  String get wifiNetworkLabel => 'WiFi नेटवर्क';

  @override
  String get openInBrowser => 'ब्राउज़र में खोलें';

  @override
  String get wifiCredentials => 'WiFi क्रेडेंशियल्स';

  @override
  String get contactInformation => 'संपर्क जानकारी';

  @override
  String get plainTextContent => 'सादा टेक्स्ट सामग्री';

  @override
  String get reportIssue => 'समस्या रिपोर्ट करें';

  @override
  String get reportIssueSubtitle => 'हमें प्रतिक्रिया भेजें';

  @override
  String get earlyWithdrawal => 'समय पूर्व निकासी';

  @override
  String get earlyWithdrawalSubtitle => 'समय पूर्व निकासी की हानि गणना';

  @override
  String get depositAmount => 'जमा राशि';

  @override
  String get termDepositRate => 'सावधि जमा दर';

  @override
  String get demandDepositRate => 'बचत खाता दर';

  @override
  String get originalTerm => 'मूल अवधि';

  @override
  String get actualHoldingPeriod => 'वास्तविक रखने की अवधि';

  @override
  String get withdrawalResult => 'निकासी परिणाम';

  @override
  String get amountReceived => 'प्राप्त राशि';

  @override
  String get actualInterestReceived => 'वास्तविक प्राप्त ब्याज';

  @override
  String get interestLost => 'खोया ब्याज';

  @override
  String get lossPercentage => 'हानि प्रतिशत';

  @override
  String get ifHeldToMaturity => 'परिपक्वता तक रखने पर';

  @override
  String get youWillLose => 'आप खो देंगे';

  @override
  String get earlyWithdrawalWarning => 'समय पूर्व निकासी चेतावनी';

  @override
  String get earlyWithdrawalWarningDesc =>
      'समय पूर्व निकासी पर सावधि जमा दर के बजाय बचत खाता दर लागू होती है।';
}
