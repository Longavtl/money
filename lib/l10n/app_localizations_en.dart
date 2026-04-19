// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Money Nest';

  @override
  String get appTagline => 'Calculate Your Future';

  @override
  String get home => 'Home';

  @override
  String get saved => 'Saved';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get compare => 'Compare';

  @override
  String get simulate => 'Simulate';

  @override
  String get mainTools => 'Main Tools';

  @override
  String categories(int count) {
    return '$count CATEGORIES';
  }

  @override
  String get loanCalc => 'Loan Calc';

  @override
  String get loanCalcSubtitle => 'Monthly payments';

  @override
  String get interestCalc => 'Interest';

  @override
  String get interestCalcSubtitle => 'Simple & compound';

  @override
  String get vault => 'Vault';

  @override
  String get vaultSubtitle => 'Plan your future';

  @override
  String get historySubtitle => 'Past calculations';

  @override
  String get proAccess => 'PRO ACCESS';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get premiumBannerDesc =>
      'Unlock advanced charts\nand ad-free experience.';

  @override
  String get marketPulse => 'MARKET PULSE';

  @override
  String get currentRates => 'Current Rates';

  @override
  String get homeLoan => 'Home Loan';

  @override
  String get savingsApy => 'Savings APY';

  @override
  String get calculatorSimpleInterest => 'Simple Interest';

  @override
  String get calculatorCompoundInterest => 'Compound Interest';

  @override
  String get calculatorLoan => 'Loan Calculator';

  @override
  String get calculatorSavings => 'Savings Calculator';

  @override
  String get principal => 'Principal';

  @override
  String get interestRate => 'Interest Rate';

  @override
  String get annualInterestRate => 'Interest Rate (Annual)';

  @override
  String get term => 'Term';

  @override
  String get termMonths => 'Term (months)';

  @override
  String get termYears => 'Term (years)';

  @override
  String get monthlyPayment => 'Monthly Payment';

  @override
  String get firstMonthPayment => 'First Month Payment';

  @override
  String get lastMonthPayment => 'Last Month Payment';

  @override
  String get totalInterest => 'Total Interest';

  @override
  String get totalPayment => 'Total Payment';

  @override
  String get interest => 'Interest';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get interestPrincipalRatio => 'Interest/Principal Ratio';

  @override
  String get loanAmount => 'Loan Amount';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get loanTypeFixed => 'Fixed EMI';

  @override
  String get loanTypeReducing => 'Reducing Balance';

  @override
  String get savingsTypeReinvest => 'Reinvest';

  @override
  String get savingsTypeWithdraw => 'Withdraw';

  @override
  String get results => 'Results';

  @override
  String get paymentStructure => 'Payment Structure';

  @override
  String get amortizationSchedule => 'Amortization Schedule';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get years => 'years';

  @override
  String get payment => 'Payment';

  @override
  String get principalPaid => 'Principal';

  @override
  String get interestPaid => 'Interest';

  @override
  String get balance => 'Balance';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get share => 'Share';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get calculate => 'Calculate';

  @override
  String get reset => 'Reset';

  @override
  String get close => 'Close';

  @override
  String get add => 'Add';

  @override
  String get storageLimitTitle => 'Storage Limit';

  @override
  String storageLimitLoans(int count) {
    return 'You have saved the maximum of $count loans. Upgrade to Premium for unlimited saves!';
  }

  @override
  String storageLimitSavings(int count) {
    return 'You have saved the maximum of $count savings. Upgrade to Premium for unlimited saves!';
  }

  @override
  String get saveLoan => 'Save Loan';

  @override
  String get loanNameHint => 'Loan name (optional)';

  @override
  String get amount => 'Amount';

  @override
  String get rate => 'Rate';

  @override
  String get loanSaved => 'Loan saved';

  @override
  String get saveSavings => 'Save Savings';

  @override
  String get savingsNameHint => 'Savings name (optional)';

  @override
  String get savingsSaved => 'Savings saved';

  @override
  String get savedLoans => 'Saved Loans';

  @override
  String get savedSavings => 'Saved Savings';

  @override
  String loansCount(int count) {
    return 'Loans ($count)';
  }

  @override
  String savingsCount(int count) {
    return 'Savings ($count)';
  }

  @override
  String get noSavedItems => 'No saved items yet';

  @override
  String get noSavedLoans => 'No saved loans';

  @override
  String get noSavedLoansSubtitle => 'Calculate and save loans to view later';

  @override
  String get noSavedSavings => 'No saved savings';

  @override
  String get noSavedSavingsSubtitle =>
      'Calculate and save savings to view later';

  @override
  String errorLoading(String error) {
    return 'Error: $error';
  }

  @override
  String get compoundingFrequency => 'Compounding Frequency';

  @override
  String get daily => 'Daily';

  @override
  String get monthly => 'Monthly';

  @override
  String get quarterly => 'Quarterly';

  @override
  String get yearly => 'Yearly';

  @override
  String get calculationResults => 'Calculation Results';

  @override
  String get totalReceived => 'Total Received';

  @override
  String get interestEarned => 'Interest Earned';

  @override
  String get effectiveAnnualRate => 'Effective Annual Rate';

  @override
  String get compoundingPeriods => 'Compounding Periods';

  @override
  String get compareWithSimple => 'Compare with Simple Interest';

  @override
  String get simpleInterest => 'Simple Interest';

  @override
  String get compoundInterest => 'Compound Interest';

  @override
  String compoundBenefit(String amount) {
    return 'Compound interest earns you $amount more';
  }

  @override
  String get savingsType => 'Savings Type';

  @override
  String get initialDeposit => 'Initial Deposit';

  @override
  String get monthlyDeposit => 'Monthly Deposit';

  @override
  String get annualRate => 'Annual Rate';

  @override
  String get finalBalance => 'Final Balance';

  @override
  String get totalDeposited => 'Total Deposited';

  @override
  String get returnRate => 'Return Rate';

  @override
  String get avgMonthlyInterest => 'Avg Monthly Interest';

  @override
  String get detailedAnalysis => 'Detailed Analysis';

  @override
  String get deposits => 'Deposits';

  @override
  String get reinvestInfo => 'Interest is compounded monthly';

  @override
  String get withdrawInfo => 'Interest is paid out monthly, not compounded';

  @override
  String get averageMonthlyInterest => 'Avg Interest/Month';

  @override
  String get totalStructure => 'Total Structure';

  @override
  String get premium => 'Upgrade to Premium';

  @override
  String get premiumActivated => 'You are Premium!';

  @override
  String get premiumMember => 'Premium Member';

  @override
  String get premiumThanks => 'Thank you for your support!';

  @override
  String get premiumDescription => 'Unlock all features';

  @override
  String get premiumFeature1 => 'Unlimited saves';

  @override
  String get premiumFeature1Desc => 'Store all your loans and savings';

  @override
  String get premiumFeature2 => 'Full chart suite';

  @override
  String get premiumFeature2Desc => 'View details with all chart types';

  @override
  String get premiumFeature3 => 'Scenario comparison';

  @override
  String get premiumFeature3Desc => 'Compare multiple options side by side';

  @override
  String get premiumFeature4 => 'PDF export';

  @override
  String get premiumFeature4Desc => 'Create detailed reports to print or share';

  @override
  String get premiumFeature5 => 'Support development';

  @override
  String get premiumFeature5Desc => 'Help us improve the app';

  @override
  String get premiumFeatures => 'Premium Features';

  @override
  String get lifetime => 'Lifetime';

  @override
  String get oneTimePurchase => 'Pay once, use forever';

  @override
  String get upgradeNow => 'Upgrade Now';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String purchaseDate(String date) {
    return 'Purchase date: $date';
  }

  @override
  String get premiumRequired => 'Premium Required';

  @override
  String upgradeTo(String feature) {
    return 'Upgrade to $feature';
  }

  @override
  String get pro => 'PRO';

  @override
  String get activated => 'Activated';

  @override
  String get unlockAllFeatures => 'Unlock all features';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get about => 'About';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get error => 'Error';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get ok => 'OK';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get compareScenarios => 'Compare Scenarios';

  @override
  String get upgradeToCompare => 'Upgrade to compare scenarios';

  @override
  String get loanSettings => 'Loan Settings';

  @override
  String get scenarioA => 'Scenario A';

  @override
  String get scenarioB => 'Scenario B';

  @override
  String get comparison => 'Comparison';

  @override
  String scenarioSaves(String scenario, String amount) {
    return 'Scenario $scenario saves $amount';
  }

  @override
  String get simulation => 'Simulation';

  @override
  String get noScenariosYet => 'No scenarios yet';

  @override
  String get addScenariosSubtitle =>
      'Add loans or savings to simulate\nyour finances over time';

  @override
  String get addLoan => 'Add Loan';

  @override
  String get addSavings => 'Add Savings';

  @override
  String get loans => 'Loans';

  @override
  String get savings => 'Savings';

  @override
  String get timeline => 'Timeline';

  @override
  String monthNumber(int number) {
    return 'Month $number';
  }

  @override
  String get netWorth => 'Net Worth';

  @override
  String get positive => 'Positive';

  @override
  String get negativeDebt => 'Negative (debt)';

  @override
  String get now => 'Now';

  @override
  String yearsCount(int count) {
    return '$count years';
  }

  @override
  String get debt => 'Debt';

  @override
  String get remaining => 'Remaining';

  @override
  String get clearAll => 'Clear All?';

  @override
  String get allScenariosDeleted => 'All scenarios will be deleted.';

  @override
  String get loanNameHintExample => 'Loan name (e.g., Home Loan)';

  @override
  String get savingsNameHintExample => 'Name (e.g., Retirement)';

  @override
  String get deposit => 'Deposit';

  @override
  String get loan => 'Loan';

  @override
  String get selectThemeDescription => 'Choose a theme for your app';

  @override
  String get selectLanguageDescription => 'Choose your preferred language';

  @override
  String get apply => 'Apply';

  @override
  String get financialTools => 'Financial Tools';

  @override
  String get reminders => 'Reminders';

  @override
  String get paymentRemindersSubtitle => 'Track due dates';

  @override
  String get savingsGoalsSubtitle => 'Reach your goals';

  @override
  String get calendar => 'Calendar';

  @override
  String get calendarSubtitle => 'View all events';

  @override
  String get achievementsSubtitle => 'Your progress';

  @override
  String get reportsSubtitle => 'View statistics';

  @override
  String get rateAlertsSubtitle => 'Monitor rates';

  @override
  String get paymentReminders => 'Payment Reminders';

  @override
  String get noRemindersYet => 'No reminders yet';

  @override
  String get addRemindersSubtitle => 'Add payment reminders to stay on track';

  @override
  String get addReminder => 'Add Reminder';

  @override
  String get editReminder => 'Edit Reminder';

  @override
  String get reminderNameHint => 'Reminder name (e.g., Credit Card)';

  @override
  String get dueDate => 'Due Date';

  @override
  String get remindBefore => 'Remind Before';

  @override
  String get days => 'days';

  @override
  String get recurring => 'Recurring';

  @override
  String get totalDue => 'Total Due';

  @override
  String get overdue => 'Overdue';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get completed => 'Completed';

  @override
  String get markAsPaid => 'Mark as Paid';

  @override
  String get markAsPaidConfirm => 'Are you sure you want to mark this as paid?';

  @override
  String get pending => 'Pending';

  @override
  String get paid => 'Paid';

  @override
  String get skipped => 'Skipped';

  @override
  String get markPaid => 'Mark Paid';

  @override
  String get weekly => 'Weekly';

  @override
  String get biWeekly => 'Bi-weekly';

  @override
  String get dueToday => 'Due today';

  @override
  String get dueTomorrow => 'Due tomorrow';

  @override
  String dueInDays(int days) {
    return 'Due in $days days';
  }

  @override
  String get pleaseEnterName => 'Please enter a name';

  @override
  String get savingsGoals => 'Savings Goals';

  @override
  String get noGoalsYet => 'No goals yet';

  @override
  String get addGoalsSubtitle => 'Set savings goals and track your progress';

  @override
  String get addGoal => 'Add Goal';

  @override
  String get editGoal => 'Edit Goal';

  @override
  String get goalNameHint => 'Goal name (e.g., Vacation)';

  @override
  String get targetAmount => 'Target Amount';

  @override
  String get initialAmount => 'Initial Amount';

  @override
  String get deadline => 'Deadline';

  @override
  String get suggestedMonthly => 'Suggested Monthly';

  @override
  String get activeGoals => 'Active Goals';

  @override
  String get completedGoals => 'Completed Goals';

  @override
  String get totalSaved => 'Total Saved';

  @override
  String get totalTarget => 'Total Target';

  @override
  String get ofTotalTarget => 'of total target';

  @override
  String get milestones => 'Milestones';

  @override
  String get addMoney => 'Add Money';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get addContribution => 'Add Contribution';

  @override
  String get notesOptional => 'Notes (optional)';

  @override
  String get withdrawReason => 'Reason for withdrawal';

  @override
  String get noContributionsYet => 'No contributions yet';

  @override
  String get pauseGoal => 'Pause Goal';

  @override
  String get deleteGoal => 'Delete Goal';

  @override
  String get deleteGoalConfirm => 'Are you sure you want to delete this goal?';

  @override
  String get target => 'Target';

  @override
  String get goals => 'Goals';

  @override
  String savePerMonth(String amount) {
    return 'Save $amount/month to reach goal';
  }

  @override
  String get pleaseEnterGoalName => 'Please enter a goal name';

  @override
  String get withdrawal => 'Withdrawal';

  @override
  String get start => 'Start';

  @override
  String get goalReached => 'Goal!';

  @override
  String get progress => 'Progress';

  @override
  String get achievements => 'Achievements';

  @override
  String get financialHealthScore => 'Financial Health Score';

  @override
  String get financialHealth => 'Financial Health';

  @override
  String get points => 'points';

  @override
  String get healthExcellent => 'Excellent! Keep up the great work!';

  @override
  String get healthGood => 'Good progress! You\'re on the right track.';

  @override
  String get healthFair => 'Fair. There\'s room for improvement.';

  @override
  String get healthNeedsWork => 'Needs attention. Let\'s improve together!';

  @override
  String get paymentStreak => 'Payment Streak';

  @override
  String get dayStreak => 'day streak';

  @override
  String get keepItUp => 'Keep it up!';

  @override
  String get longest => 'Longest';

  @override
  String get unlocked => 'Unlocked';

  @override
  String get locked => 'Locked';

  @override
  String get financialCalendar => 'Financial Calendar';

  @override
  String get monthView => 'Month View';

  @override
  String get weekView => 'Week View';

  @override
  String get today => 'Today';

  @override
  String get noEventsForDay => 'No events for this day';

  @override
  String get goalDeadline => 'Goal Deadline';

  @override
  String get contribution => 'Contribution';

  @override
  String get reports => 'Reports';

  @override
  String get week => 'Week';

  @override
  String get quarter => 'Quarter';

  @override
  String get allTime => 'All Time';

  @override
  String get totalPaid => 'Total Paid';

  @override
  String get totalDebt => 'Total Debt';

  @override
  String get debtVsPaid => 'Debt vs Paid';

  @override
  String get outstanding => 'Outstanding';

  @override
  String get noDataYet => 'No data yet';

  @override
  String get monthlyOverview => 'Monthly Overview';

  @override
  String get due => 'Due';

  @override
  String get paymentPerformance => 'Payment Performance';

  @override
  String get onTime => 'On Time';

  @override
  String get late => 'Late';

  @override
  String get onTimeRate => 'On Time Rate';

  @override
  String get rateAlerts => 'Rate Alerts';

  @override
  String get currentMarketRates => 'Current Market Rates';

  @override
  String get edit => 'Edit';

  @override
  String get triggeredAlerts => 'Triggered Alerts';

  @override
  String get activeAlerts => 'Active Alerts';

  @override
  String get inactiveAlerts => 'Inactive Alerts';

  @override
  String get noAlertsYet => 'No alerts yet';

  @override
  String get addAlertsSubtitle => 'Add alerts to track interest rate changes';

  @override
  String get addAlert => 'Add Alert';

  @override
  String get alertNameHint => 'Alert name (e.g., Home Loan Rate)';

  @override
  String get loanType => 'Loan Type';

  @override
  String get alertWhen => 'Alert When';

  @override
  String get rateDrops => 'Rate Drops';

  @override
  String get rateRises => 'Rate Rises';

  @override
  String get targetRate => 'Target Rate';

  @override
  String get when => 'When';

  @override
  String get current => 'Current';

  @override
  String get triggered => 'Triggered';

  @override
  String get editMarketRates => 'Edit Market Rates';

  @override
  String get personalLoan => 'Personal Loan';

  @override
  String get carLoan => 'Car Loan';

  @override
  String get savingsRate => 'Savings Rate';

  @override
  String get homeShort => 'Home';

  @override
  String get personalShort => 'Personal';

  @override
  String get carShort => 'Car';

  @override
  String get savingsShort => 'Savings';

  @override
  String get rateDropAlert => 'Rate Drop Alert!';

  @override
  String get rateIncreaseAlert => 'Rate Increase Alert!';

  @override
  String get updated => 'Updated';

  @override
  String get newUpdateAvailable => 'Update Available';

  @override
  String get updateAppMessage =>
      'A new version of the app is available. Please update to get the latest features and improvements.';

  @override
  String get updateNow => 'Update Now';

  @override
  String get later => 'Later';

  @override
  String get qrTools => 'QR Tools';

  @override
  String get createQRCode => 'Create QR Code';

  @override
  String get createQRSubtitle => 'Generate QR codes';

  @override
  String get scanQRCode => 'Scan QR Code';

  @override
  String get scanQRSubtitle => 'Scan any QR code';

  @override
  String get selectQRType => 'Select QR Type';

  @override
  String get qrLink => 'Link';

  @override
  String get qrText => 'Text';

  @override
  String get qrWifi => 'WiFi';

  @override
  String get qrContact => 'Contact';

  @override
  String get qrCode => 'QR Code';

  @override
  String get websiteAddress => 'Website Address';

  @override
  String get textContent => 'Text Content';

  @override
  String get enterContent => 'Enter your content here';

  @override
  String get networkNameSSID => 'Network Name (SSID)';

  @override
  String get wifiPasswordLabel => 'Password';

  @override
  String get encryptionType => 'Encryption Type';

  @override
  String get noEncryption => 'No Encryption';

  @override
  String get contactName => 'Contact Name';

  @override
  String get contactNameHint => 'John Doe';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get generateQRButton => 'Generate QR Code';

  @override
  String get qrGeneratedOnDevice => 'QR code is generated on your device';

  @override
  String get qrLinkInfo =>
      'Enter a website URL to create a QR code that opens the link when scanned.';

  @override
  String get qrWifiInfo =>
      'Create a QR code that allows others to quickly connect to your WiFi network.';

  @override
  String get pleaseEnterWebsite => 'Please enter a website address';

  @override
  String get pleaseEnterTextContent => 'Please enter text content';

  @override
  String get pleaseEnterWifiName => 'Please enter WiFi network name';

  @override
  String get pleaseEnterContactName => 'Please enter contact name';

  @override
  String get copy => 'Copy';

  @override
  String get copyData => 'Copy Data';

  @override
  String get dataCopied => 'Data copied to clipboard';

  @override
  String get saveToGallery => 'Save to Gallery';

  @override
  String get qrPrivacyNote =>
      'This QR code is generated locally on your device and is not sent to any server.';

  @override
  String wifiNetwork(String name) {
    return 'WiFi: $name';
  }

  @override
  String contactInfo(String name) {
    return 'Contact: $name';
  }

  @override
  String get cannotCreateQRImage => 'Cannot create QR image';

  @override
  String get cannotSaveQR => 'Cannot save QR code';

  @override
  String get qrSavedToGallerySuccess => 'QR code saved to gallery';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get scanAgain => 'Scan Again';

  @override
  String get openLink => 'Open Link';

  @override
  String get copyPassword => 'Copy Password';

  @override
  String get passwordCopied => 'Password copied to clipboard';

  @override
  String get noQRCodeFound => 'No QR code found in image';

  @override
  String get pointCameraAtQR => 'Point camera at QR code';

  @override
  String get scanFromGallery => 'Scan from gallery';

  @override
  String get websiteLink => 'Website Link';

  @override
  String get wifiNetworkLabel => 'WiFi Network';

  @override
  String get openInBrowser => 'Open in browser';

  @override
  String get wifiCredentials => 'WiFi credentials';

  @override
  String get contactInformation => 'Contact information';

  @override
  String get plainTextContent => 'Plain text content';

  @override
  String get reportIssue => 'Report Issue';

  @override
  String get reportIssueSubtitle => 'Send us feedback';
}
