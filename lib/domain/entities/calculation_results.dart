import 'dart:math';
import 'package:equatable/equatable.dart';

/// Compounding frequency options
enum CompoundingFrequency {
  daily(365, 'Hàng ngày', 'Daily'),
  weekly(52, 'Hàng tuần', 'Weekly'),
  monthly(12, 'Hàng tháng', 'Monthly'),
  quarterly(4, 'Hàng quý', 'Quarterly'),
  semiAnnually(2, 'Nửa năm', 'Semi-Annually'),
  annually(1, 'Hàng năm', 'Annually');

  final int periodsPerYear;
  final String displayNameVi;
  final String displayNameEn;

  const CompoundingFrequency(
      this.periodsPerYear, this.displayNameVi, this.displayNameEn);
}

/// Loan payment type
enum LoanType {
  fixedPayment('Trả góp đều', 'Fixed EMI'),
  reducingBalance('Dư nợ giảm dần', 'Reducing Balance');

  final String displayNameVi;
  final String displayNameEn;

  const LoanType(this.displayNameVi, this.displayNameEn);
}

/// Savings type
enum SavingsType {
  withReinvestment('Tái tục lãi', 'Reinvest Interest'),
  withoutReinvestment('Không tái tục', 'No Reinvestment');

  final String displayNameVi;
  final String displayNameEn;

  const SavingsType(this.displayNameVi, this.displayNameEn);
}

/// Single data point for growth chart
class GrowthDataPoint extends Equatable {
  final int month;
  final double balance;
  final double interest;
  final double principal;

  const GrowthDataPoint({
    required this.month,
    required this.balance,
    this.interest = 0,
    this.principal = 0,
  });

  @override
  List<Object?> get props => [month, balance, interest, principal];
}

/// Amortization schedule entry for loans
class AmortizationEntry extends Equatable {
  final int month;
  final double payment;
  final double principalPaid;
  final double interestPaid;
  final double balance;
  final double cumulativeInterest;
  final double cumulativePrincipal;

  const AmortizationEntry({
    required this.month,
    required this.payment,
    required this.principalPaid,
    required this.interestPaid,
    required this.balance,
    required this.cumulativeInterest,
    required this.cumulativePrincipal,
  });

  @override
  List<Object?> get props => [
        month,
        payment,
        principalPaid,
        interestPaid,
        balance,
        cumulativeInterest,
        cumulativePrincipal,
      ];
}

/// Simple Interest Result
class SimpleInterestResult extends Equatable {
  final double principal;
  final double rate;
  final int termMonths;
  final double interest;
  final double totalAmount;
  final List<GrowthDataPoint> growthData;

  const SimpleInterestResult({
    required this.principal,
    required this.rate,
    required this.termMonths,
    required this.interest,
    required this.totalAmount,
    required this.growthData,
  });

  double get interestPercentage => (interest / principal) * 100;
  double get monthlyInterest => interest / termMonths;
  int get termYears => termMonths ~/ 12;

  @override
  List<Object?> get props =>
      [principal, rate, termMonths, interest, totalAmount];
}

/// Compound Interest Result
class CompoundInterestResult extends Equatable {
  final double principal;
  final double rate;
  final int termMonths;
  final CompoundingFrequency frequency;
  final double interest;
  final double totalAmount;
  final List<GrowthDataPoint> growthData;

  const CompoundInterestResult({
    required this.principal,
    required this.rate,
    required this.termMonths,
    required this.frequency,
    required this.interest,
    required this.totalAmount,
    required this.growthData,
  });

  double get interestPercentage => (interest / principal) * 100;
  int get termYears => termMonths ~/ 12;

  /// Effective Annual Rate (EAR)
  double get effectiveAnnualRate {
    final r = rate / 100;
    final n = frequency.periodsPerYear;
    return (pow(1 + r / n, n) - 1) * 100;
  }

  @override
  List<Object?> get props =>
      [principal, rate, termMonths, frequency, interest, totalAmount];
}

/// Loan EMI (Fixed Payment) Result
class LoanResult extends Equatable {
  final double principal;
  final double rate;
  final int termMonths;
  final LoanType type;
  final double monthlyPayment;
  final double totalPayment;
  final double totalInterest;
  final List<AmortizationEntry> schedule;
  final List<GrowthDataPoint> balanceData;

  const LoanResult({
    required this.principal,
    required this.rate,
    required this.termMonths,
    required this.type,
    required this.monthlyPayment,
    required this.totalPayment,
    required this.totalInterest,
    required this.schedule,
    required this.balanceData,
  });

  double get interestPercentage => (totalInterest / principal) * 100;
  int get termYears => termMonths ~/ 12;
  double get effectiveMonthlyRate => rate / 12 / 100;

  /// First month payment (same as monthlyPayment for fixed, higher for reducing)
  double get firstPayment =>
      schedule.isNotEmpty ? schedule.first.payment : monthlyPayment;

  /// Last month payment (same as monthlyPayment for fixed, lower for reducing)
  double get lastPayment =>
      schedule.isNotEmpty ? schedule.last.payment : monthlyPayment;

  /// Get yearly summary for charts
  List<YearlySummary> get yearlySummary {
    Map<int, YearlySummary> years = {};

    for (final entry in schedule) {
      final year = ((entry.month - 1) / 12).floor() + 1;
      if (!years.containsKey(year)) {
        years[year] =
            YearlySummary(year: year, principalPaid: 0, interestPaid: 0);
      }
      years[year] = years[year]!.copyWith(
        principalPaid: years[year]!.principalPaid + entry.principalPaid,
        interestPaid: years[year]!.interestPaid + entry.interestPaid,
      );
    }

    return years.values.toList();
  }

  @override
  List<Object?> get props => [
        principal,
        rate,
        termMonths,
        type,
        monthlyPayment,
        totalPayment,
        totalInterest,
      ];
}

/// Savings Result
class SavingsResult extends Equatable {
  final double initialDeposit;
  final double monthlyDeposit;
  final double rate;
  final int termMonths;
  final SavingsType type;
  final double finalValue;
  final double totalDeposited;
  final double totalInterest;
  final List<GrowthDataPoint> growthData;
  final List<double> monthlyInterestPayouts;

  const SavingsResult({
    required this.initialDeposit,
    required this.monthlyDeposit,
    required this.rate,
    required this.termMonths,
    required this.type,
    required this.finalValue,
    required this.totalDeposited,
    required this.totalInterest,
    required this.growthData,
    this.monthlyInterestPayouts = const [],
  });

  double get returnPercentage =>
      totalDeposited > 0 ? (totalInterest / totalDeposited) * 100 : 0;
  int get termYears => termMonths ~/ 12;

  @override
  List<Object?> get props => [
        initialDeposit,
        monthlyDeposit,
        rate,
        termMonths,
        type,
        finalValue,
        totalDeposited,
        totalInterest,
      ];
}

/// Yearly summary for aggregated charts
class YearlySummary extends Equatable {
  final int year;
  final double principalPaid;
  final double interestPaid;

  const YearlySummary({
    required this.year,
    required this.principalPaid,
    required this.interestPaid,
  });

  double get total => principalPaid + interestPaid;

  YearlySummary copyWith({double? principalPaid, double? interestPaid}) {
    return YearlySummary(
      year: year,
      principalPaid: principalPaid ?? this.principalPaid,
      interestPaid: interestPaid ?? this.interestPaid,
    );
  }

  @override
  List<Object?> get props => [year, principalPaid, interestPaid];
}

/// Pie chart data for principal vs interest visualization
class PieChartItem extends Equatable {
  final String label;
  final double value;
  final double percentage;

  const PieChartItem({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  List<Object?> get props => [label, value, percentage];
}
