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

  // Financial Features
  static const String reminders = '/reminders';
  static const String goals = '/goals';
  static const String goalDetail = '/goals/:id';
  static const String calendar = '/calendar';
  static const String reports = '/reports';
  static const String achievements = '/achievements';
  static const String rateAlerts = '/rate-alerts';
}
