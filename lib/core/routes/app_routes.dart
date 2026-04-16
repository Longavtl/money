/// Route paths constants for MoneyMate
class AppRoutes {
  AppRoutes._();

  // Root (AppShell with IndexedStack)
  static const String home = '/home';

  // Calculators (push routes)
  static const String simpleInterest = '/calculator/simple-interest';
  static const String compoundInterest = '/calculator/compound-interest';
  static const String loan = '/calculator/loan';
  static const String loanAmortization = '/calculator/loan/amortization';
  static const String savings = '/calculator/savings';

  // Comparison (Premium)
  static const String comparison = '/comparison';

  // Premium
  static const String premium = '/premium';
}
