import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/services/financial_calculator.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// Comparison type
enum ComparisonType {
  loan,
  savings,
}

/// Loan comparison inputs
class LoanComparisonInputs {
  final double principal;
  final double rateA;
  final double rateB;
  final int termMonths;
  final LoanType type;

  const LoanComparisonInputs({
    this.principal = 500000000,
    this.rateA = 10.0,
    this.rateB = 12.0,
    this.termMonths = 240,
    this.type = LoanType.fixedPayment,
  });

  LoanComparisonInputs copyWith({
    double? principal,
    double? rateA,
    double? rateB,
    int? termMonths,
    LoanType? type,
  }) {
    return LoanComparisonInputs(
      principal: principal ?? this.principal,
      rateA: rateA ?? this.rateA,
      rateB: rateB ?? this.rateB,
      termMonths: termMonths ?? this.termMonths,
      type: type ?? this.type,
    );
  }
}

/// Comparison results
class ComparisonResult {
  final LoanResult? loanA;
  final LoanResult? loanB;
  final SavingsResult? savingsA;
  final SavingsResult? savingsB;

  const ComparisonResult({
    this.loanA,
    this.loanB,
    this.savingsA,
    this.savingsB,
  });

  /// Difference in total payment (positive means A pays more)
  double get loanPaymentDifference {
    if (loanA == null || loanB == null) return 0;
    return loanA!.totalPayment - loanB!.totalPayment;
  }

  /// Difference in total interest (positive means A pays more)
  double get loanInterestDifference {
    if (loanA == null || loanB == null) return 0;
    return loanA!.totalInterest - loanB!.totalInterest;
  }

  /// Difference in monthly payment (positive means A pays more)
  double get loanMonthlyDifference {
    if (loanA == null || loanB == null) return 0;
    return loanA!.monthlyPayment - loanB!.monthlyPayment;
  }

  /// Which loan scenario is better (lower total payment)
  String get betterLoanScenario {
    if (loanPaymentDifference > 0) return 'B';
    if (loanPaymentDifference < 0) return 'A';
    return 'Equal';
  }
}

/// Comparison state
class ComparisonState {
  final ComparisonType type;
  final LoanComparisonInputs loanInputs;
  final ComparisonResult result;
  final bool isCalculating;

  const ComparisonState({
    this.type = ComparisonType.loan,
    this.loanInputs = const LoanComparisonInputs(),
    this.result = const ComparisonResult(),
    this.isCalculating = false,
  });

  ComparisonState copyWith({
    ComparisonType? type,
    LoanComparisonInputs? loanInputs,
    ComparisonResult? result,
    bool? isCalculating,
  }) {
    return ComparisonState(
      type: type ?? this.type,
      loanInputs: loanInputs ?? this.loanInputs,
      result: result ?? this.result,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }
}

/// Comparison state notifier
class ComparisonNotifier extends Notifier<ComparisonState> {
  Timer? _debounceTimer;

  @override
  ComparisonState build() {
    const initialState = ComparisonState();
    // Calculate initial results
    Future.microtask(_calculate);
    return initialState;
  }

  void updatePrincipal(double value) {
    state = state.copyWith(
      loanInputs: state.loanInputs.copyWith(principal: value),
    );
    _debounceCalculate();
  }

  void updateRateA(double value) {
    state = state.copyWith(
      loanInputs: state.loanInputs.copyWith(rateA: value),
    );
    _debounceCalculate();
  }

  void updateRateB(double value) {
    state = state.copyWith(
      loanInputs: state.loanInputs.copyWith(rateB: value),
    );
    _debounceCalculate();
  }

  void updateTermMonths(int value) {
    state = state.copyWith(
      loanInputs: state.loanInputs.copyWith(termMonths: value),
    );
    _debounceCalculate();
  }

  void updateLoanType(LoanType type) {
    state = state.copyWith(
      loanInputs: state.loanInputs.copyWith(type: type),
    );
    _debounceCalculate();
  }

  void _debounceCalculate() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: AppConstants.calculatorDebounceMs),
      _calculate,
    );
  }

  void _calculate() {
    final inputs = state.loanInputs;

    if (state.type == ComparisonType.loan) {
      // Calculate loan A
      final loanA = inputs.type == LoanType.fixedPayment
          ? FinancialCalculator.calculateLoanFixedPayment(
              principal: inputs.principal,
              annualRate: inputs.rateA,
              termMonths: inputs.termMonths,
            )
          : FinancialCalculator.calculateLoanReducingBalance(
              principal: inputs.principal,
              annualRate: inputs.rateA,
              termMonths: inputs.termMonths,
            );

      // Calculate loan B
      final loanB = inputs.type == LoanType.fixedPayment
          ? FinancialCalculator.calculateLoanFixedPayment(
              principal: inputs.principal,
              annualRate: inputs.rateB,
              termMonths: inputs.termMonths,
            )
          : FinancialCalculator.calculateLoanReducingBalance(
              principal: inputs.principal,
              annualRate: inputs.rateB,
              termMonths: inputs.termMonths,
            );

      state = state.copyWith(
        result: ComparisonResult(loanA: loanA, loanB: loanB),
      );
    }
  }
}

/// Comparison provider
final comparisonProvider =
    NotifierProvider<ComparisonNotifier, ComparisonState>(
  ComparisonNotifier.new,
);
