/// App constants for MoneyMate
class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'Money Nest';
  static const String appTagline = 'Calculate Your Future';

  // Premium
  static const String premiumProductId = 'moneymate_premium_lifetime';

  // Free tier limits
  static const int freeSavedLoansLimit = 3;
  static const int freeSavedSavingsLimit = 3;
  static const int freeHistoryLimit = 10;

  // Calculator defaults
  static const double defaultPrincipal = 100000000; // 100 million VND
  static const double defaultRate = 8.0; // 8% per year
  static const int defaultTermMonths = 60; // 5 years
  static const double defaultMonthlyDeposit = 5000000; // 5 million VND

  // Calculator limits
  static const double minPrincipal = 1000000; // 1 million
  static const double maxPrincipal = 100000000000; // 100 billion
  static const double minRate = 0.1;
  static const double maxRate = 50.0;
  static const int minTermMonths = 1;
  static const int maxTermMonths = 600; // 50 years

  // Debounce
  static const int calculatorDebounceMs = 150;

  // Animation durations
  static const int animationDurationMs = 300;
  static const int chartAnimationDurationMs = 800;
}
