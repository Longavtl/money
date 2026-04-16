import 'dart:math';
import 'package:money/domain/entities/calculation_results.dart';

/// Core financial calculation engine
/// All methods are static and pure - no side effects
class FinancialCalculator {
  FinancialCalculator._();

  // ============================================================================
  // SIMPLE INTEREST
  // Formula: A = P(1 + rt)
  // P = Principal, r = annual rate (decimal), t = time in years
  // ============================================================================

  static SimpleInterestResult calculateSimpleInterest({
    required double principal,
    required double annualRate,
    required int termMonths,
  }) {
    final rateDecimal = annualRate / 100;
    final years = termMonths / 12;
    final interest = principal * rateDecimal * years;
    final totalAmount = principal + interest;

    // Generate growth data
    final growthData = <GrowthDataPoint>[];
    for (int m = 0; m <= termMonths; m++) {
      final t = m / 12;
      final currentInterest = principal * rateDecimal * t;
      growthData.add(GrowthDataPoint(
        month: m,
        balance: principal + currentInterest,
        interest: currentInterest,
        principal: principal,
      ));
    }

    return SimpleInterestResult(
      principal: principal,
      rate: annualRate,
      termMonths: termMonths,
      interest: interest,
      totalAmount: totalAmount,
      growthData: growthData,
    );
  }

  // ============================================================================
  // COMPOUND INTEREST
  // Formula: A = P(1 + r/n)^(nt)
  // n = compounding frequency per year
  // ============================================================================

  static CompoundInterestResult calculateCompoundInterest({
    required double principal,
    required double annualRate,
    required int termMonths,
    CompoundingFrequency frequency = CompoundingFrequency.monthly,
  }) {
    final rateDecimal = annualRate / 100;
    final n = frequency.periodsPerYear;
    final years = termMonths / 12;
    final nt = n * years;
    final totalAmount = principal * pow(1 + rateDecimal / n, nt);
    final interest = totalAmount - principal;

    // Generate monthly growth data
    final growthData = <GrowthDataPoint>[];
    for (int m = 0; m <= termMonths; m++) {
      final t = m / 12;
      final periodsElapsed = n * t;
      final currentValue = principal * pow(1 + rateDecimal / n, periodsElapsed);
      growthData.add(GrowthDataPoint(
        month: m,
        balance: currentValue,
        interest: currentValue - principal,
        principal: principal,
      ));
    }

    return CompoundInterestResult(
      principal: principal,
      rate: annualRate,
      termMonths: termMonths,
      frequency: frequency,
      interest: interest,
      totalAmount: totalAmount,
      growthData: growthData,
    );
  }

  // ============================================================================
  // LOAN - FIXED PAYMENT (EMI)
  // Formula: EMI = P × r × (1+r)^n / ((1+r)^n - 1)
  // P = Principal, r = monthly rate, n = total months
  // ============================================================================

  static LoanResult calculateLoanFixedPayment({
    required double principal,
    required double annualRate,
    required int termMonths,
  }) {
    final monthlyRate = annualRate / 12 / 100;

    double emi;
    if (monthlyRate == 0) {
      emi = principal / termMonths;
    } else {
      final factor = pow(1 + monthlyRate, termMonths);
      emi = principal * monthlyRate * factor / (factor - 1);
    }

    final totalPayment = emi * termMonths;
    final totalInterest = totalPayment - principal;

    // Generate amortization schedule
    final schedule = <AmortizationEntry>[];
    final balanceData = <GrowthDataPoint>[];
    double balance = principal;
    double cumulativeInterest = 0;
    double cumulativePrincipal = 0;

    balanceData.add(GrowthDataPoint(
      month: 0,
      balance: principal,
      interest: 0,
      principal: 0,
    ));

    for (int month = 1; month <= termMonths; month++) {
      final interestPayment = balance * monthlyRate;
      final principalPayment = emi - interestPayment;
      balance -= principalPayment;
      cumulativeInterest += interestPayment;
      cumulativePrincipal += principalPayment;

      schedule.add(AmortizationEntry(
        month: month,
        payment: emi,
        principalPaid: principalPayment,
        interestPaid: interestPayment,
        balance: balance.clamp(0, double.infinity),
        cumulativeInterest: cumulativeInterest,
        cumulativePrincipal: cumulativePrincipal,
      ));

      balanceData.add(GrowthDataPoint(
        month: month,
        balance: balance.clamp(0, double.infinity),
        interest: cumulativeInterest,
        principal: cumulativePrincipal,
      ));
    }

    return LoanResult(
      principal: principal,
      rate: annualRate,
      termMonths: termMonths,
      type: LoanType.fixedPayment,
      monthlyPayment: emi,
      totalPayment: totalPayment,
      totalInterest: totalInterest,
      schedule: schedule,
      balanceData: balanceData,
    );
  }

  // ============================================================================
  // LOAN - REDUCING BALANCE
  // Interest each period = Outstanding Balance × Monthly Rate
  // Principal per month is fixed = Principal / Term
  // ============================================================================

  static LoanResult calculateLoanReducingBalance({
    required double principal,
    required double annualRate,
    required int termMonths,
  }) {
    final monthlyRate = annualRate / 12 / 100;
    final principalPerMonth = principal / termMonths;

    final schedule = <AmortizationEntry>[];
    final balanceData = <GrowthDataPoint>[];
    double balance = principal;
    double totalInterest = 0;
    double cumulativeInterest = 0;
    double cumulativePrincipal = 0;

    balanceData.add(GrowthDataPoint(
      month: 0,
      balance: principal,
      interest: 0,
      principal: 0,
    ));

    for (int month = 1; month <= termMonths; month++) {
      final interestPayment = balance * monthlyRate;
      final payment = principalPerMonth + interestPayment;
      balance -= principalPerMonth;
      totalInterest += interestPayment;
      cumulativeInterest += interestPayment;
      cumulativePrincipal += principalPerMonth;

      schedule.add(AmortizationEntry(
        month: month,
        payment: payment,
        principalPaid: principalPerMonth,
        interestPaid: interestPayment,
        balance: balance.clamp(0, double.infinity),
        cumulativeInterest: cumulativeInterest,
        cumulativePrincipal: cumulativePrincipal,
      ));

      balanceData.add(GrowthDataPoint(
        month: month,
        balance: balance.clamp(0, double.infinity),
        interest: cumulativeInterest,
        principal: cumulativePrincipal,
      ));
    }

    // First month payment (highest)
    final firstPayment =
        schedule.isNotEmpty ? schedule.first.payment : principalPerMonth;

    return LoanResult(
      principal: principal,
      rate: annualRate,
      termMonths: termMonths,
      type: LoanType.reducingBalance,
      monthlyPayment: firstPayment,
      totalPayment: principal + totalInterest,
      totalInterest: totalInterest,
      schedule: schedule,
      balanceData: balanceData,
    );
  }

  // ============================================================================
  // LOAN - UNIFIED METHOD
  // ============================================================================

  static LoanResult calculateLoan({
    required double principal,
    required double annualRate,
    required int termMonths,
    required LoanType type,
  }) {
    if (type == LoanType.fixedPayment) {
      return calculateLoanFixedPayment(
        principal: principal,
        annualRate: annualRate,
        termMonths: termMonths,
      );
    } else {
      return calculateLoanReducingBalance(
        principal: principal,
        annualRate: annualRate,
        termMonths: termMonths,
      );
    }
  }

  // ============================================================================
  // SAVINGS - REGULAR DEPOSIT WITH COMPOUND GROWTH
  // Future Value of Annuity: FV = PMT × [((1 + r)^n - 1) / r]
  // Plus initial deposit growth: FV_initial = P × (1 + r)^n
  // ============================================================================

  static SavingsResult calculateSavingsWithReinvestment({
    required double initialDeposit,
    required double monthlyDeposit,
    required double annualRate,
    required int termMonths,
  }) {
    final monthlyRate = annualRate / 12 / 100;

    // Future value of initial deposit
    final fvInitial = initialDeposit * pow(1 + monthlyRate, termMonths);

    // Future value of monthly deposits (ordinary annuity - deposits at end of period)
    double fvMonthly = 0;
    if (monthlyRate > 0 && monthlyDeposit > 0) {
      fvMonthly = monthlyDeposit *
          ((pow(1 + monthlyRate, termMonths) - 1) / monthlyRate);
    } else if (monthlyDeposit > 0) {
      fvMonthly = monthlyDeposit * termMonths;
    }

    final finalValue = fvInitial + fvMonthly;
    final totalDeposited = initialDeposit + (monthlyDeposit * termMonths);
    final totalInterest = finalValue - totalDeposited;

    // Generate growth data
    final growthData = <GrowthDataPoint>[];
    double balance = initialDeposit;
    double totalContributions = initialDeposit;

    growthData.add(GrowthDataPoint(
      month: 0,
      balance: initialDeposit,
      interest: 0,
      principal: initialDeposit,
    ));

    for (int m = 1; m <= termMonths; m++) {
      // Add monthly deposit
      balance += monthlyDeposit;
      totalContributions += monthlyDeposit;
      // Apply interest
      final interestThisMonth = balance * monthlyRate;
      balance += interestThisMonth;

      growthData.add(GrowthDataPoint(
        month: m,
        balance: balance,
        interest: balance - totalContributions,
        principal: totalContributions,
      ));
    }

    return SavingsResult(
      initialDeposit: initialDeposit,
      monthlyDeposit: monthlyDeposit,
      rate: annualRate,
      termMonths: termMonths,
      type: SavingsType.withReinvestment,
      finalValue: finalValue,
      totalDeposited: totalDeposited,
      totalInterest: totalInterest,
      growthData: growthData,
    );
  }

  // ============================================================================
  // SAVINGS - WITHOUT REINVESTMENT (Simple interest, interest paid out)
  // Interest is calculated on principal only and paid out monthly
  // ============================================================================

  static SavingsResult calculateSavingsWithoutReinvestment({
    required double initialDeposit,
    required double monthlyDeposit,
    required double annualRate,
    required int termMonths,
  }) {
    final monthlyRate = annualRate / 12 / 100;

    final growthData = <GrowthDataPoint>[];
    final monthlyPayouts = <double>[];
    double balance = initialDeposit;
    double totalInterest = 0;
    double totalDeposited = initialDeposit;

    growthData.add(GrowthDataPoint(
      month: 0,
      balance: initialDeposit,
      interest: 0,
      principal: initialDeposit,
    ));

    for (int m = 1; m <= termMonths; m++) {
      // Add monthly deposit to principal
      balance += monthlyDeposit;
      totalDeposited += monthlyDeposit;

      // Calculate interest on current balance (but don't add to balance)
      final interestThisMonth = balance * monthlyRate;
      totalInterest += interestThisMonth;
      monthlyPayouts.add(interestThisMonth);

      growthData.add(GrowthDataPoint(
        month: m,
        balance: balance, // Balance stays at deposits only
        interest: totalInterest,
        principal: totalDeposited,
      ));
    }

    return SavingsResult(
      initialDeposit: initialDeposit,
      monthlyDeposit: monthlyDeposit,
      rate: annualRate,
      termMonths: termMonths,
      type: SavingsType.withoutReinvestment,
      finalValue: balance, // Final value is just the deposits
      totalDeposited: totalDeposited,
      totalInterest: totalInterest,
      growthData: growthData,
      monthlyInterestPayouts: monthlyPayouts,
    );
  }

  // ============================================================================
  // SAVINGS - UNIFIED METHOD
  // ============================================================================

  static SavingsResult calculateSavings({
    required double initialDeposit,
    required double monthlyDeposit,
    required double annualRate,
    required int termMonths,
    required SavingsType type,
  }) {
    if (type == SavingsType.withReinvestment) {
      return calculateSavingsWithReinvestment(
        initialDeposit: initialDeposit,
        monthlyDeposit: monthlyDeposit,
        annualRate: annualRate,
        termMonths: termMonths,
      );
    } else {
      return calculateSavingsWithoutReinvestment(
        initialDeposit: initialDeposit,
        monthlyDeposit: monthlyDeposit,
        annualRate: annualRate,
        termMonths: termMonths,
      );
    }
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Get pie chart data for principal vs interest visualization
  static List<PieChartItem> getPrincipalVsInterestPie({
    required double principal,
    required double interest,
  }) {
    final total = principal + interest;
    if (total == 0) return [];

    return [
      PieChartItem(
        label: 'Gốc',
        value: principal,
        percentage: (principal / total) * 100,
      ),
      PieChartItem(
        label: 'Lãi',
        value: interest,
        percentage: (interest / total) * 100,
      ),
    ];
  }

  /// Compare two loan scenarios
  static Map<String, double> compareLoanScenarios({
    required LoanResult scenarioA,
    required LoanResult scenarioB,
  }) {
    return {
      'monthlyPaymentDiff': scenarioB.monthlyPayment - scenarioA.monthlyPayment,
      'totalPaymentDiff': scenarioB.totalPayment - scenarioA.totalPayment,
      'totalInterestDiff': scenarioB.totalInterest - scenarioA.totalInterest,
      'interestSavings': scenarioA.totalInterest - scenarioB.totalInterest,
    };
  }

  /// Compare two savings scenarios
  static Map<String, double> compareSavingsScenarios({
    required SavingsResult scenarioA,
    required SavingsResult scenarioB,
  }) {
    return {
      'finalValueDiff': scenarioB.finalValue - scenarioA.finalValue,
      'totalInterestDiff': scenarioB.totalInterest - scenarioA.totalInterest,
      'returnPercentageDiff':
          scenarioB.returnPercentage - scenarioA.returnPercentage,
    };
  }
}
