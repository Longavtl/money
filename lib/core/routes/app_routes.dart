/// Route paths constants for MoneyMate
class AppRoutes {
  AppRoutes._();

  // Root
  static const String splash = '/';
  static const String home = '/home';

  // Calculators
  static const String simpleInterest = '/calculator/simple-interest';
  static const String compoundInterest = '/calculator/compound-interest';
  static const String loan = '/calculator/loan';
  static const String loanAmortization = '/calculator/loan/amortization';
  static const String savings = '/calculator/savings';

  // Saved items
  static const String saved = '/saved';
  static const String savedLoanDetail = '/saved/loan/:id';
  static const String savedSavingsDetail = '/saved/savings/:id';

  // History
  static const String history = '/history';

  // Comparison (Premium)
  static const String comparison = '/comparison';

  // Settings
  static const String settings = '/settings';

  // Premium
  static const String premium = '/premium';
}
