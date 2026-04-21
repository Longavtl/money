import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_th.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('th'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Money Wave'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Calculate Your Future'**
  String get appTagline;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @compare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get compare;

  /// No description provided for @simulate.
  ///
  /// In en, this message translates to:
  /// **'Simulate'**
  String get simulate;

  /// No description provided for @mainTools.
  ///
  /// In en, this message translates to:
  /// **'Main Tools'**
  String get mainTools;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'{count} CATEGORIES'**
  String categories(int count);

  /// No description provided for @loanCalc.
  ///
  /// In en, this message translates to:
  /// **'Loan Calc'**
  String get loanCalc;

  /// No description provided for @loanCalcSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly payments'**
  String get loanCalcSubtitle;

  /// No description provided for @interestCalc.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get interestCalc;

  /// No description provided for @interestCalcSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Simple & compound'**
  String get interestCalcSubtitle;

  /// No description provided for @vault.
  ///
  /// In en, this message translates to:
  /// **'Vault'**
  String get vault;

  /// No description provided for @vaultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plan your future'**
  String get vaultSubtitle;

  /// No description provided for @historySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Past calculations'**
  String get historySubtitle;

  /// No description provided for @proAccess.
  ///
  /// In en, this message translates to:
  /// **'PRO ACCESS'**
  String get proAccess;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @premiumBannerDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlock advanced charts\nand ad-free experience.'**
  String get premiumBannerDesc;

  /// No description provided for @marketPulse.
  ///
  /// In en, this message translates to:
  /// **'MARKET PULSE'**
  String get marketPulse;

  /// No description provided for @currentRates.
  ///
  /// In en, this message translates to:
  /// **'Current Rates'**
  String get currentRates;

  /// No description provided for @homeLoan.
  ///
  /// In en, this message translates to:
  /// **'Home Loan'**
  String get homeLoan;

  /// No description provided for @savingsApy.
  ///
  /// In en, this message translates to:
  /// **'Savings APY'**
  String get savingsApy;

  /// No description provided for @calculatorSimpleInterest.
  ///
  /// In en, this message translates to:
  /// **'Simple Interest'**
  String get calculatorSimpleInterest;

  /// No description provided for @calculatorCompoundInterest.
  ///
  /// In en, this message translates to:
  /// **'Compound Interest'**
  String get calculatorCompoundInterest;

  /// No description provided for @calculatorLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan Calculator'**
  String get calculatorLoan;

  /// No description provided for @calculatorSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings Calculator'**
  String get calculatorSavings;

  /// No description provided for @principal.
  ///
  /// In en, this message translates to:
  /// **'Principal'**
  String get principal;

  /// No description provided for @interestRate.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate'**
  String get interestRate;

  /// No description provided for @annualInterestRate.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate (Annual)'**
  String get annualInterestRate;

  /// No description provided for @term.
  ///
  /// In en, this message translates to:
  /// **'Term'**
  String get term;

  /// No description provided for @termMonths.
  ///
  /// In en, this message translates to:
  /// **'Term (months)'**
  String get termMonths;

  /// No description provided for @termYears.
  ///
  /// In en, this message translates to:
  /// **'Term (years)'**
  String get termYears;

  /// No description provided for @monthlyPayment.
  ///
  /// In en, this message translates to:
  /// **'Monthly Payment'**
  String get monthlyPayment;

  /// No description provided for @firstMonthPayment.
  ///
  /// In en, this message translates to:
  /// **'First Month Payment'**
  String get firstMonthPayment;

  /// No description provided for @lastMonthPayment.
  ///
  /// In en, this message translates to:
  /// **'Last Month Payment'**
  String get lastMonthPayment;

  /// No description provided for @totalInterest.
  ///
  /// In en, this message translates to:
  /// **'Total Interest'**
  String get totalInterest;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get totalPayment;

  /// No description provided for @interest.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get interest;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @interestPrincipalRatio.
  ///
  /// In en, this message translates to:
  /// **'Interest/Principal Ratio'**
  String get interestPrincipalRatio;

  /// No description provided for @loanAmount.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount'**
  String get loanAmount;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @loanTypeFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed EMI'**
  String get loanTypeFixed;

  /// No description provided for @loanTypeReducing.
  ///
  /// In en, this message translates to:
  /// **'Reducing Balance'**
  String get loanTypeReducing;

  /// No description provided for @savingsTypeReinvest.
  ///
  /// In en, this message translates to:
  /// **'Reinvest'**
  String get savingsTypeReinvest;

  /// No description provided for @savingsTypeWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get savingsTypeWithdraw;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @paymentStructure.
  ///
  /// In en, this message translates to:
  /// **'Payment Structure'**
  String get paymentStructure;

  /// No description provided for @amortizationSchedule.
  ///
  /// In en, this message translates to:
  /// **'Amortization Schedule'**
  String get amortizationSchedule;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @principalPaid.
  ///
  /// In en, this message translates to:
  /// **'Principal'**
  String get principalPaid;

  /// No description provided for @interestPaid.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get interestPaid;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @storageLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Storage Limit'**
  String get storageLimitTitle;

  /// No description provided for @storageLimitLoans.
  ///
  /// In en, this message translates to:
  /// **'You have saved the maximum of {count} loans. Upgrade to Premium for unlimited saves!'**
  String storageLimitLoans(int count);

  /// No description provided for @storageLimitSavings.
  ///
  /// In en, this message translates to:
  /// **'You have saved the maximum of {count} savings. Upgrade to Premium for unlimited saves!'**
  String storageLimitSavings(int count);

  /// No description provided for @saveLoan.
  ///
  /// In en, this message translates to:
  /// **'Save Loan'**
  String get saveLoan;

  /// No description provided for @loanNameHint.
  ///
  /// In en, this message translates to:
  /// **'Loan name (optional)'**
  String get loanNameHint;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @loanSaved.
  ///
  /// In en, this message translates to:
  /// **'Loan saved'**
  String get loanSaved;

  /// No description provided for @saveSavings.
  ///
  /// In en, this message translates to:
  /// **'Save Savings'**
  String get saveSavings;

  /// No description provided for @savingsNameHint.
  ///
  /// In en, this message translates to:
  /// **'Savings name (optional)'**
  String get savingsNameHint;

  /// No description provided for @savingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Savings saved'**
  String get savingsSaved;

  /// No description provided for @savedLoans.
  ///
  /// In en, this message translates to:
  /// **'Saved Loans'**
  String get savedLoans;

  /// No description provided for @savedSavings.
  ///
  /// In en, this message translates to:
  /// **'Saved Savings'**
  String get savedSavings;

  /// No description provided for @loansCount.
  ///
  /// In en, this message translates to:
  /// **'Loans ({count})'**
  String loansCount(int count);

  /// No description provided for @savingsCount.
  ///
  /// In en, this message translates to:
  /// **'Savings ({count})'**
  String savingsCount(int count);

  /// No description provided for @noSavedItems.
  ///
  /// In en, this message translates to:
  /// **'No saved items yet'**
  String get noSavedItems;

  /// No description provided for @noSavedLoans.
  ///
  /// In en, this message translates to:
  /// **'No saved loans'**
  String get noSavedLoans;

  /// No description provided for @noSavedLoansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate and save loans to view later'**
  String get noSavedLoansSubtitle;

  /// No description provided for @noSavedSavings.
  ///
  /// In en, this message translates to:
  /// **'No saved savings'**
  String get noSavedSavings;

  /// No description provided for @noSavedSavingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate and save savings to view later'**
  String get noSavedSavingsSubtitle;

  /// No description provided for @errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorLoading(String error);

  /// No description provided for @compoundingFrequency.
  ///
  /// In en, this message translates to:
  /// **'Compounding Frequency'**
  String get compoundingFrequency;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @quarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get quarterly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @calculationResults.
  ///
  /// In en, this message translates to:
  /// **'Calculation Results'**
  String get calculationResults;

  /// No description provided for @totalReceived.
  ///
  /// In en, this message translates to:
  /// **'Total Received'**
  String get totalReceived;

  /// No description provided for @interestEarned.
  ///
  /// In en, this message translates to:
  /// **'Interest Earned'**
  String get interestEarned;

  /// No description provided for @effectiveAnnualRate.
  ///
  /// In en, this message translates to:
  /// **'Effective Annual Rate'**
  String get effectiveAnnualRate;

  /// No description provided for @compoundingPeriods.
  ///
  /// In en, this message translates to:
  /// **'Compounding Periods'**
  String get compoundingPeriods;

  /// No description provided for @compareWithSimple.
  ///
  /// In en, this message translates to:
  /// **'Compare with Simple Interest'**
  String get compareWithSimple;

  /// No description provided for @simpleInterest.
  ///
  /// In en, this message translates to:
  /// **'Simple Interest'**
  String get simpleInterest;

  /// No description provided for @compoundInterest.
  ///
  /// In en, this message translates to:
  /// **'Compound Interest'**
  String get compoundInterest;

  /// No description provided for @compoundBenefit.
  ///
  /// In en, this message translates to:
  /// **'Compound interest earns you {amount} more'**
  String compoundBenefit(String amount);

  /// No description provided for @savingsType.
  ///
  /// In en, this message translates to:
  /// **'Savings Type'**
  String get savingsType;

  /// No description provided for @initialDeposit.
  ///
  /// In en, this message translates to:
  /// **'Initial Deposit'**
  String get initialDeposit;

  /// No description provided for @monthlyDeposit.
  ///
  /// In en, this message translates to:
  /// **'Monthly Deposit'**
  String get monthlyDeposit;

  /// No description provided for @annualRate.
  ///
  /// In en, this message translates to:
  /// **'Annual Rate'**
  String get annualRate;

  /// No description provided for @finalBalance.
  ///
  /// In en, this message translates to:
  /// **'Final Balance'**
  String get finalBalance;

  /// No description provided for @totalDeposited.
  ///
  /// In en, this message translates to:
  /// **'Total Deposited'**
  String get totalDeposited;

  /// No description provided for @returnRate.
  ///
  /// In en, this message translates to:
  /// **'Return Rate'**
  String get returnRate;

  /// No description provided for @avgMonthlyInterest.
  ///
  /// In en, this message translates to:
  /// **'Avg Monthly Interest'**
  String get avgMonthlyInterest;

  /// No description provided for @detailedAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Detailed Analysis'**
  String get detailedAnalysis;

  /// No description provided for @deposits.
  ///
  /// In en, this message translates to:
  /// **'Deposits'**
  String get deposits;

  /// No description provided for @reinvestInfo.
  ///
  /// In en, this message translates to:
  /// **'Interest is compounded monthly'**
  String get reinvestInfo;

  /// No description provided for @withdrawInfo.
  ///
  /// In en, this message translates to:
  /// **'Interest is paid out monthly, not compounded'**
  String get withdrawInfo;

  /// No description provided for @averageMonthlyInterest.
  ///
  /// In en, this message translates to:
  /// **'Avg Interest/Month'**
  String get averageMonthlyInterest;

  /// No description provided for @totalStructure.
  ///
  /// In en, this message translates to:
  /// **'Total Structure'**
  String get totalStructure;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get premium;

  /// No description provided for @premiumActivated.
  ///
  /// In en, this message translates to:
  /// **'You are Premium!'**
  String get premiumActivated;

  /// No description provided for @premiumMember.
  ///
  /// In en, this message translates to:
  /// **'Premium Member'**
  String get premiumMember;

  /// No description provided for @premiumThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your support!'**
  String get premiumThanks;

  /// No description provided for @premiumDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features'**
  String get premiumDescription;

  /// No description provided for @premiumFeature1.
  ///
  /// In en, this message translates to:
  /// **'Unlimited saves'**
  String get premiumFeature1;

  /// No description provided for @premiumFeature1Desc.
  ///
  /// In en, this message translates to:
  /// **'Store all your loans and savings'**
  String get premiumFeature1Desc;

  /// No description provided for @premiumFeature2.
  ///
  /// In en, this message translates to:
  /// **'Full chart suite'**
  String get premiumFeature2;

  /// No description provided for @premiumFeature2Desc.
  ///
  /// In en, this message translates to:
  /// **'View details with all chart types'**
  String get premiumFeature2Desc;

  /// No description provided for @premiumFeature3.
  ///
  /// In en, this message translates to:
  /// **'Scenario comparison'**
  String get premiumFeature3;

  /// No description provided for @premiumFeature3Desc.
  ///
  /// In en, this message translates to:
  /// **'Compare multiple options side by side'**
  String get premiumFeature3Desc;

  /// No description provided for @premiumFeature4.
  ///
  /// In en, this message translates to:
  /// **'PDF export'**
  String get premiumFeature4;

  /// No description provided for @premiumFeature4Desc.
  ///
  /// In en, this message translates to:
  /// **'Create detailed reports to print or share'**
  String get premiumFeature4Desc;

  /// No description provided for @premiumFeature5.
  ///
  /// In en, this message translates to:
  /// **'Support development'**
  String get premiumFeature5;

  /// No description provided for @premiumFeature5Desc.
  ///
  /// In en, this message translates to:
  /// **'Help us improve the app'**
  String get premiumFeature5Desc;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @lifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get lifetime;

  /// No description provided for @oneTimePurchase.
  ///
  /// In en, this message translates to:
  /// **'Pay once, use forever'**
  String get oneTimePurchase;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restorePurchase;

  /// No description provided for @purchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date: {date}'**
  String purchaseDate(String date);

  /// No description provided for @premiumRequired.
  ///
  /// In en, this message translates to:
  /// **'Premium Required'**
  String get premiumRequired;

  /// No description provided for @premiumMonthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Monthly Subscription'**
  String get premiumMonthlyTitle;

  /// No description provided for @premiumYearlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Yearly Subscription'**
  String get premiumYearlyTitle;

  /// No description provided for @premiumLifetimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Lifetime Access'**
  String get premiumLifetimeTitle;

  /// No description provided for @billedMonthly.
  ///
  /// In en, this message translates to:
  /// **'Billed monthly'**
  String get billedMonthly;

  /// No description provided for @billedAnnually.
  ///
  /// In en, this message translates to:
  /// **'Billed annually'**
  String get billedAnnually;

  /// No description provided for @payOnceOwnForever.
  ///
  /// In en, this message translates to:
  /// **'Pay once, own forever'**
  String get payOnceOwnForever;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'per month'**
  String get perMonth;

  /// No description provided for @perYear.
  ///
  /// In en, this message translates to:
  /// **'per year'**
  String get perYear;

  /// No description provided for @oneTime.
  ///
  /// In en, this message translates to:
  /// **'one-time'**
  String get oneTime;

  /// No description provided for @subscriptionPaymentInfo.
  ///
  /// In en, this message translates to:
  /// **'Payment will be charged to your Apple ID account at confirmation of purchase.'**
  String get subscriptionPaymentInfo;

  /// No description provided for @subscriptionAutoRenewInfo.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period. You can manage and cancel subscriptions in your App Store account settings.'**
  String get subscriptionAutoRenewInfo;

  /// No description provided for @upgradeTo.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to {feature}'**
  String upgradeTo(String feature);

  /// No description provided for @pro.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get pro;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get activated;

  /// No description provided for @unlockAllFeatures.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features'**
  String get unlockAllFeatures;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneric;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @compareScenarios.
  ///
  /// In en, this message translates to:
  /// **'Compare Scenarios'**
  String get compareScenarios;

  /// No description provided for @upgradeToCompare.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to compare scenarios'**
  String get upgradeToCompare;

  /// No description provided for @loanSettings.
  ///
  /// In en, this message translates to:
  /// **'Loan Settings'**
  String get loanSettings;

  /// No description provided for @scenarioA.
  ///
  /// In en, this message translates to:
  /// **'Scenario A'**
  String get scenarioA;

  /// No description provided for @scenarioB.
  ///
  /// In en, this message translates to:
  /// **'Scenario B'**
  String get scenarioB;

  /// No description provided for @comparison.
  ///
  /// In en, this message translates to:
  /// **'Comparison'**
  String get comparison;

  /// No description provided for @scenarioSaves.
  ///
  /// In en, this message translates to:
  /// **'Scenario {scenario} saves {amount}'**
  String scenarioSaves(String scenario, String amount);

  /// No description provided for @simulation.
  ///
  /// In en, this message translates to:
  /// **'Simulation'**
  String get simulation;

  /// No description provided for @noScenariosYet.
  ///
  /// In en, this message translates to:
  /// **'No scenarios yet'**
  String get noScenariosYet;

  /// No description provided for @addScenariosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add loans or savings to simulate\nyour finances over time'**
  String get addScenariosSubtitle;

  /// No description provided for @addLoan.
  ///
  /// In en, this message translates to:
  /// **'Add Loan'**
  String get addLoan;

  /// No description provided for @addSavings.
  ///
  /// In en, this message translates to:
  /// **'Add Savings'**
  String get addSavings;

  /// No description provided for @loans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get loans;

  /// No description provided for @savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @monthNumber.
  ///
  /// In en, this message translates to:
  /// **'Month {number}'**
  String monthNumber(int number);

  /// No description provided for @netWorth.
  ///
  /// In en, this message translates to:
  /// **'Net Worth'**
  String get netWorth;

  /// No description provided for @positive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get positive;

  /// No description provided for @negativeDebt.
  ///
  /// In en, this message translates to:
  /// **'Negative (debt)'**
  String get negativeDebt;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @yearsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} years'**
  String yearsCount(int count);

  /// No description provided for @debt.
  ///
  /// In en, this message translates to:
  /// **'Debt'**
  String get debt;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All?'**
  String get clearAll;

  /// No description provided for @allScenariosDeleted.
  ///
  /// In en, this message translates to:
  /// **'All scenarios will be deleted.'**
  String get allScenariosDeleted;

  /// No description provided for @loanNameHintExample.
  ///
  /// In en, this message translates to:
  /// **'Loan name (e.g., Home Loan)'**
  String get loanNameHintExample;

  /// No description provided for @savingsNameHintExample.
  ///
  /// In en, this message translates to:
  /// **'Name (e.g., Retirement)'**
  String get savingsNameHintExample;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @loan.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get loan;

  /// No description provided for @selectThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose a theme for your app'**
  String get selectThemeDescription;

  /// No description provided for @selectLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get selectLanguageDescription;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @financialTools.
  ///
  /// In en, this message translates to:
  /// **'Financial Tools'**
  String get financialTools;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @paymentRemindersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track due dates'**
  String get paymentRemindersSubtitle;

  /// No description provided for @savingsGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reach your goals'**
  String get savingsGoalsSubtitle;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @calendarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all events'**
  String get calendarSubtitle;

  /// No description provided for @achievementsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get achievementsSubtitle;

  /// No description provided for @reportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View statistics'**
  String get reportsSubtitle;

  /// No description provided for @rateAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor rates'**
  String get rateAlertsSubtitle;

  /// No description provided for @paymentReminders.
  ///
  /// In en, this message translates to:
  /// **'Payment Reminders'**
  String get paymentReminders;

  /// No description provided for @noRemindersYet.
  ///
  /// In en, this message translates to:
  /// **'No reminders yet'**
  String get noRemindersYet;

  /// No description provided for @addRemindersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add payment reminders to stay on track'**
  String get addRemindersSubtitle;

  /// No description provided for @addReminder.
  ///
  /// In en, this message translates to:
  /// **'Add Reminder'**
  String get addReminder;

  /// No description provided for @editReminder.
  ///
  /// In en, this message translates to:
  /// **'Edit Reminder'**
  String get editReminder;

  /// No description provided for @reminderNameHint.
  ///
  /// In en, this message translates to:
  /// **'Reminder name (e.g., Credit Card)'**
  String get reminderNameHint;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @remindBefore.
  ///
  /// In en, this message translates to:
  /// **'Remind Before'**
  String get remindBefore;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @totalDue.
  ///
  /// In en, this message translates to:
  /// **'Total Due'**
  String get totalDue;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @markAsPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark as Paid'**
  String get markAsPaid;

  /// No description provided for @markAsPaidConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to mark this as paid?'**
  String get markAsPaidConfirm;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get skipped;

  /// No description provided for @markPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark Paid'**
  String get markPaid;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @biWeekly.
  ///
  /// In en, this message translates to:
  /// **'Bi-weekly'**
  String get biWeekly;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get dueToday;

  /// No description provided for @dueTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Due tomorrow'**
  String get dueTomorrow;

  /// No description provided for @dueInDays.
  ///
  /// In en, this message translates to:
  /// **'Due in {days} days'**
  String dueInDays(int days);

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterName;

  /// No description provided for @savingsGoals.
  ///
  /// In en, this message translates to:
  /// **'Savings Goals'**
  String get savingsGoals;

  /// No description provided for @noGoalsYet.
  ///
  /// In en, this message translates to:
  /// **'No goals yet'**
  String get noGoalsYet;

  /// No description provided for @addGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set savings goals and track your progress'**
  String get addGoalsSubtitle;

  /// No description provided for @addGoal.
  ///
  /// In en, this message translates to:
  /// **'Add Goal'**
  String get addGoal;

  /// No description provided for @editGoal.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get editGoal;

  /// No description provided for @goalNameHint.
  ///
  /// In en, this message translates to:
  /// **'Goal name (e.g., Vacation)'**
  String get goalNameHint;

  /// No description provided for @targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmount;

  /// No description provided for @initialAmount.
  ///
  /// In en, this message translates to:
  /// **'Initial Amount'**
  String get initialAmount;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @suggestedMonthly.
  ///
  /// In en, this message translates to:
  /// **'Suggested Monthly'**
  String get suggestedMonthly;

  /// No description provided for @activeGoals.
  ///
  /// In en, this message translates to:
  /// **'Active Goals'**
  String get activeGoals;

  /// No description provided for @completedGoals.
  ///
  /// In en, this message translates to:
  /// **'Completed Goals'**
  String get completedGoals;

  /// No description provided for @totalSaved.
  ///
  /// In en, this message translates to:
  /// **'Total Saved'**
  String get totalSaved;

  /// No description provided for @totalTarget.
  ///
  /// In en, this message translates to:
  /// **'Total Target'**
  String get totalTarget;

  /// No description provided for @ofTotalTarget.
  ///
  /// In en, this message translates to:
  /// **'of total target'**
  String get ofTotalTarget;

  /// No description provided for @milestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get milestones;

  /// No description provided for @addMoney.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get addMoney;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @addContribution.
  ///
  /// In en, this message translates to:
  /// **'Add Contribution'**
  String get addContribution;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @withdrawReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for withdrawal'**
  String get withdrawReason;

  /// No description provided for @noContributionsYet.
  ///
  /// In en, this message translates to:
  /// **'No contributions yet'**
  String get noContributionsYet;

  /// No description provided for @pauseGoal.
  ///
  /// In en, this message translates to:
  /// **'Pause Goal'**
  String get pauseGoal;

  /// No description provided for @deleteGoal.
  ///
  /// In en, this message translates to:
  /// **'Delete Goal'**
  String get deleteGoal;

  /// No description provided for @deleteGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this goal?'**
  String get deleteGoalConfirm;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @savePerMonth.
  ///
  /// In en, this message translates to:
  /// **'Save {amount}/month to reach goal'**
  String savePerMonth(String amount);

  /// No description provided for @pleaseEnterGoalName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a goal name'**
  String get pleaseEnterGoalName;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @goalReached.
  ///
  /// In en, this message translates to:
  /// **'Goal!'**
  String get goalReached;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @financialHealthScore.
  ///
  /// In en, this message translates to:
  /// **'Financial Health Score'**
  String get financialHealthScore;

  /// No description provided for @financialHealth.
  ///
  /// In en, this message translates to:
  /// **'Financial Health'**
  String get financialHealth;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get points;

  /// No description provided for @healthExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent! Keep up the great work!'**
  String get healthExcellent;

  /// No description provided for @healthGood.
  ///
  /// In en, this message translates to:
  /// **'Good progress! You\'re on the right track.'**
  String get healthGood;

  /// No description provided for @healthFair.
  ///
  /// In en, this message translates to:
  /// **'Fair. There\'s room for improvement.'**
  String get healthFair;

  /// No description provided for @healthNeedsWork.
  ///
  /// In en, this message translates to:
  /// **'Needs attention. Let\'s improve together!'**
  String get healthNeedsWork;

  /// No description provided for @paymentStreak.
  ///
  /// In en, this message translates to:
  /// **'Payment Streak'**
  String get paymentStreak;

  /// No description provided for @dayStreak.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get dayStreak;

  /// No description provided for @keepItUp.
  ///
  /// In en, this message translates to:
  /// **'Keep it up!'**
  String get keepItUp;

  /// No description provided for @longest.
  ///
  /// In en, this message translates to:
  /// **'Longest'**
  String get longest;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @financialCalendar.
  ///
  /// In en, this message translates to:
  /// **'Financial Calendar'**
  String get financialCalendar;

  /// No description provided for @monthView.
  ///
  /// In en, this message translates to:
  /// **'Month View'**
  String get monthView;

  /// No description provided for @weekView.
  ///
  /// In en, this message translates to:
  /// **'Week View'**
  String get weekView;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @noEventsForDay.
  ///
  /// In en, this message translates to:
  /// **'No events for this day'**
  String get noEventsForDay;

  /// No description provided for @goalDeadline.
  ///
  /// In en, this message translates to:
  /// **'Goal Deadline'**
  String get goalDeadline;

  /// No description provided for @contribution.
  ///
  /// In en, this message translates to:
  /// **'Contribution'**
  String get contribution;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @quarter.
  ///
  /// In en, this message translates to:
  /// **'Quarter'**
  String get quarter;

  /// No description provided for @allTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get allTime;

  /// No description provided for @totalPaid.
  ///
  /// In en, this message translates to:
  /// **'Total Paid'**
  String get totalPaid;

  /// No description provided for @totalDebt.
  ///
  /// In en, this message translates to:
  /// **'Total Debt'**
  String get totalDebt;

  /// No description provided for @debtVsPaid.
  ///
  /// In en, this message translates to:
  /// **'Debt vs Paid'**
  String get debtVsPaid;

  /// No description provided for @outstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get outstanding;

  /// No description provided for @noDataYet.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get noDataYet;

  /// No description provided for @monthlyOverview.
  ///
  /// In en, this message translates to:
  /// **'Monthly Overview'**
  String get monthlyOverview;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @paymentPerformance.
  ///
  /// In en, this message translates to:
  /// **'Payment Performance'**
  String get paymentPerformance;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On Time'**
  String get onTime;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get late;

  /// No description provided for @onTimeRate.
  ///
  /// In en, this message translates to:
  /// **'On Time Rate'**
  String get onTimeRate;

  /// No description provided for @rateAlerts.
  ///
  /// In en, this message translates to:
  /// **'Rate Alerts'**
  String get rateAlerts;

  /// No description provided for @currentMarketRates.
  ///
  /// In en, this message translates to:
  /// **'Current Market Rates'**
  String get currentMarketRates;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @triggeredAlerts.
  ///
  /// In en, this message translates to:
  /// **'Triggered Alerts'**
  String get triggeredAlerts;

  /// No description provided for @activeAlerts.
  ///
  /// In en, this message translates to:
  /// **'Active Alerts'**
  String get activeAlerts;

  /// No description provided for @inactiveAlerts.
  ///
  /// In en, this message translates to:
  /// **'Inactive Alerts'**
  String get inactiveAlerts;

  /// No description provided for @noAlertsYet.
  ///
  /// In en, this message translates to:
  /// **'No alerts yet'**
  String get noAlertsYet;

  /// No description provided for @addAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add alerts to track interest rate changes'**
  String get addAlertsSubtitle;

  /// No description provided for @addAlert.
  ///
  /// In en, this message translates to:
  /// **'Add Alert'**
  String get addAlert;

  /// No description provided for @alertNameHint.
  ///
  /// In en, this message translates to:
  /// **'Alert name (e.g., Home Loan Rate)'**
  String get alertNameHint;

  /// No description provided for @loanType.
  ///
  /// In en, this message translates to:
  /// **'Loan Type'**
  String get loanType;

  /// No description provided for @alertWhen.
  ///
  /// In en, this message translates to:
  /// **'Alert When'**
  String get alertWhen;

  /// No description provided for @rateDrops.
  ///
  /// In en, this message translates to:
  /// **'Rate Drops'**
  String get rateDrops;

  /// No description provided for @rateRises.
  ///
  /// In en, this message translates to:
  /// **'Rate Rises'**
  String get rateRises;

  /// No description provided for @targetRate.
  ///
  /// In en, this message translates to:
  /// **'Target Rate'**
  String get targetRate;

  /// No description provided for @when.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get when;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @triggered.
  ///
  /// In en, this message translates to:
  /// **'Triggered'**
  String get triggered;

  /// No description provided for @editMarketRates.
  ///
  /// In en, this message translates to:
  /// **'Edit Market Rates'**
  String get editMarketRates;

  /// No description provided for @personalLoan.
  ///
  /// In en, this message translates to:
  /// **'Personal Loan'**
  String get personalLoan;

  /// No description provided for @carLoan.
  ///
  /// In en, this message translates to:
  /// **'Car Loan'**
  String get carLoan;

  /// No description provided for @savingsRate.
  ///
  /// In en, this message translates to:
  /// **'Savings Rate'**
  String get savingsRate;

  /// No description provided for @homeShort.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeShort;

  /// No description provided for @personalShort.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personalShort;

  /// No description provided for @carShort.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get carShort;

  /// No description provided for @savingsShort.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savingsShort;

  /// No description provided for @rateDropAlert.
  ///
  /// In en, this message translates to:
  /// **'Rate Drop Alert!'**
  String get rateDropAlert;

  /// No description provided for @rateIncreaseAlert.
  ///
  /// In en, this message translates to:
  /// **'Rate Increase Alert!'**
  String get rateIncreaseAlert;

  /// No description provided for @updated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get updated;

  /// No description provided for @newUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get newUpdateAvailable;

  /// No description provided for @updateAppMessage.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available. Please update to get the latest features and improvements.'**
  String get updateAppMessage;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get updateNow;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @qrTools.
  ///
  /// In en, this message translates to:
  /// **'QR Tools'**
  String get qrTools;

  /// No description provided for @createQRCode.
  ///
  /// In en, this message translates to:
  /// **'Create QR Code'**
  String get createQRCode;

  /// No description provided for @createQRSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate QR codes'**
  String get createQRSubtitle;

  /// No description provided for @scanQRCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQRCode;

  /// No description provided for @scanQRSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan any QR code'**
  String get scanQRSubtitle;

  /// No description provided for @selectQRType.
  ///
  /// In en, this message translates to:
  /// **'Select QR Type'**
  String get selectQRType;

  /// No description provided for @qrLink.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get qrLink;

  /// No description provided for @qrText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get qrText;

  /// No description provided for @qrWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get qrWifi;

  /// No description provided for @qrContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get qrContact;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// No description provided for @websiteAddress.
  ///
  /// In en, this message translates to:
  /// **'Website Address'**
  String get websiteAddress;

  /// No description provided for @textContent.
  ///
  /// In en, this message translates to:
  /// **'Text Content'**
  String get textContent;

  /// No description provided for @enterContent.
  ///
  /// In en, this message translates to:
  /// **'Enter your content here'**
  String get enterContent;

  /// No description provided for @networkNameSSID.
  ///
  /// In en, this message translates to:
  /// **'Network Name (SSID)'**
  String get networkNameSSID;

  /// No description provided for @wifiPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get wifiPasswordLabel;

  /// No description provided for @encryptionType.
  ///
  /// In en, this message translates to:
  /// **'Encryption Type'**
  String get encryptionType;

  /// No description provided for @noEncryption.
  ///
  /// In en, this message translates to:
  /// **'No Encryption'**
  String get noEncryption;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Contact Name'**
  String get contactName;

  /// No description provided for @contactNameHint.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get contactNameHint;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @generateQRButton.
  ///
  /// In en, this message translates to:
  /// **'Generate QR Code'**
  String get generateQRButton;

  /// No description provided for @qrGeneratedOnDevice.
  ///
  /// In en, this message translates to:
  /// **'QR code is generated on your device'**
  String get qrGeneratedOnDevice;

  /// No description provided for @qrLinkInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter a website URL to create a QR code that opens the link when scanned.'**
  String get qrLinkInfo;

  /// No description provided for @qrWifiInfo.
  ///
  /// In en, this message translates to:
  /// **'Create a QR code that allows others to quickly connect to your WiFi network.'**
  String get qrWifiInfo;

  /// No description provided for @pleaseEnterWebsite.
  ///
  /// In en, this message translates to:
  /// **'Please enter a website address'**
  String get pleaseEnterWebsite;

  /// No description provided for @pleaseEnterTextContent.
  ///
  /// In en, this message translates to:
  /// **'Please enter text content'**
  String get pleaseEnterTextContent;

  /// No description provided for @pleaseEnterWifiName.
  ///
  /// In en, this message translates to:
  /// **'Please enter WiFi network name'**
  String get pleaseEnterWifiName;

  /// No description provided for @pleaseEnterContactName.
  ///
  /// In en, this message translates to:
  /// **'Please enter contact name'**
  String get pleaseEnterContactName;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copyData.
  ///
  /// In en, this message translates to:
  /// **'Copy Data'**
  String get copyData;

  /// No description provided for @dataCopied.
  ///
  /// In en, this message translates to:
  /// **'Data copied to clipboard'**
  String get dataCopied;

  /// No description provided for @saveToGallery.
  ///
  /// In en, this message translates to:
  /// **'Save to Gallery'**
  String get saveToGallery;

  /// No description provided for @qrPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'This QR code is generated locally on your device and is not sent to any server.'**
  String get qrPrivacyNote;

  /// No description provided for @wifiNetwork.
  ///
  /// In en, this message translates to:
  /// **'WiFi: {name}'**
  String wifiNetwork(String name);

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact: {name}'**
  String contactInfo(String name);

  /// No description provided for @cannotCreateQRImage.
  ///
  /// In en, this message translates to:
  /// **'Cannot create QR image'**
  String get cannotCreateQRImage;

  /// No description provided for @cannotSaveQR.
  ///
  /// In en, this message translates to:
  /// **'Cannot save QR code'**
  String get cannotSaveQR;

  /// No description provided for @qrSavedToGallerySuccess.
  ///
  /// In en, this message translates to:
  /// **'QR code saved to gallery'**
  String get qrSavedToGallerySuccess;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(String message);

  /// No description provided for @scanAgain.
  ///
  /// In en, this message translates to:
  /// **'Scan Again'**
  String get scanAgain;

  /// No description provided for @openLink.
  ///
  /// In en, this message translates to:
  /// **'Open Link'**
  String get openLink;

  /// No description provided for @copyPassword.
  ///
  /// In en, this message translates to:
  /// **'Copy Password'**
  String get copyPassword;

  /// No description provided for @passwordCopied.
  ///
  /// In en, this message translates to:
  /// **'Password copied to clipboard'**
  String get passwordCopied;

  /// No description provided for @noQRCodeFound.
  ///
  /// In en, this message translates to:
  /// **'No QR code found in image'**
  String get noQRCodeFound;

  /// No description provided for @pointCameraAtQR.
  ///
  /// In en, this message translates to:
  /// **'Point camera at QR code'**
  String get pointCameraAtQR;

  /// No description provided for @scanFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Scan from gallery'**
  String get scanFromGallery;

  /// No description provided for @websiteLink.
  ///
  /// In en, this message translates to:
  /// **'Website Link'**
  String get websiteLink;

  /// No description provided for @wifiNetworkLabel.
  ///
  /// In en, this message translates to:
  /// **'WiFi Network'**
  String get wifiNetworkLabel;

  /// No description provided for @openInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open in browser'**
  String get openInBrowser;

  /// No description provided for @wifiCredentials.
  ///
  /// In en, this message translates to:
  /// **'WiFi credentials'**
  String get wifiCredentials;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get contactInformation;

  /// No description provided for @plainTextContent.
  ///
  /// In en, this message translates to:
  /// **'Plain text content'**
  String get plainTextContent;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get reportIssue;

  /// No description provided for @reportIssueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send us feedback'**
  String get reportIssueSubtitle;

  /// No description provided for @earlyWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Early Withdrawal'**
  String get earlyWithdrawal;

  /// No description provided for @earlyWithdrawalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate penalty for early withdrawal'**
  String get earlyWithdrawalSubtitle;

  /// No description provided for @depositAmount.
  ///
  /// In en, this message translates to:
  /// **'Deposit Amount'**
  String get depositAmount;

  /// No description provided for @termDepositRate.
  ///
  /// In en, this message translates to:
  /// **'Term Deposit Rate'**
  String get termDepositRate;

  /// No description provided for @demandDepositRate.
  ///
  /// In en, this message translates to:
  /// **'Demand Deposit Rate'**
  String get demandDepositRate;

  /// No description provided for @originalTerm.
  ///
  /// In en, this message translates to:
  /// **'Original Term'**
  String get originalTerm;

  /// No description provided for @actualHoldingPeriod.
  ///
  /// In en, this message translates to:
  /// **'Actual Holding Period'**
  String get actualHoldingPeriod;

  /// No description provided for @withdrawalResult.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Result'**
  String get withdrawalResult;

  /// No description provided for @amountReceived.
  ///
  /// In en, this message translates to:
  /// **'Amount Received'**
  String get amountReceived;

  /// No description provided for @actualInterestReceived.
  ///
  /// In en, this message translates to:
  /// **'Interest Received'**
  String get actualInterestReceived;

  /// No description provided for @interestLost.
  ///
  /// In en, this message translates to:
  /// **'Interest Lost'**
  String get interestLost;

  /// No description provided for @lossPercentage.
  ///
  /// In en, this message translates to:
  /// **'Loss Percentage'**
  String get lossPercentage;

  /// No description provided for @ifHeldToMaturity.
  ///
  /// In en, this message translates to:
  /// **'If held to maturity'**
  String get ifHeldToMaturity;

  /// No description provided for @youWillLose.
  ///
  /// In en, this message translates to:
  /// **'You will lose'**
  String get youWillLose;

  /// No description provided for @earlyWithdrawalWarning.
  ///
  /// In en, this message translates to:
  /// **'Early Withdrawal Warning'**
  String get earlyWithdrawalWarning;

  /// No description provided for @earlyWithdrawalWarningDesc.
  ///
  /// In en, this message translates to:
  /// **'Withdrawing before maturity will result in significantly lower interest. Consider waiting until the term ends.'**
  String get earlyWithdrawalWarningDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'ja',
        'ko',
        'pt',
        'th',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
