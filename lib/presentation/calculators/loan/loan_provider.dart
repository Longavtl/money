import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/services/financial_calculator.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// Loan calculator input state
class LoanInputState extends Equatable {
  final double principal;
  final double annualRate;
  final int termMonths;
  final LoanType type;

  const LoanInputState({
    this.principal = AppConstants.defaultPrincipal,
    this.annualRate = AppConstants.defaultRate,
    this.termMonths = AppConstants.defaultTermMonths,
    this.type = LoanType.fixedPayment,
  });

  LoanInputState copyWith({
    double? principal,
    double? annualRate,
    int? termMonths,
    LoanType? type,
  }) {
    return LoanInputState(
      principal: principal ?? this.principal,
      annualRate: annualRate ?? this.annualRate,
      termMonths: termMonths ?? this.termMonths,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [principal, annualRate, termMonths, type];
}

/// Loan calculator state
class LoanCalculatorState extends Equatable {
  final LoanInputState inputs;
  final LoanResult? result;
  final bool isCalculating;

  const LoanCalculatorState({
    this.inputs = const LoanInputState(),
    this.result,
    this.isCalculating = false,
  });

  LoanCalculatorState copyWith({
    LoanInputState? inputs,
    LoanResult? result,
    bool? isCalculating,
  }) {
    return LoanCalculatorState(
      inputs: inputs ?? this.inputs,
      result: result ?? this.result,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }

  bool get hasResult => result != null;

  @override
  List<Object?> get props => [inputs, result, isCalculating];
}

/// Loan calculator notifier
class LoanCalculatorNotifier extends Notifier<LoanCalculatorState> {
  Timer? _debounceTimer;

  @override
  LoanCalculatorState build() {
    // Auto-calculate on first build
    Future.microtask(() => _calculate());
    return const LoanCalculatorState();
  }

  void updatePrincipal(double value) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(principal: value),
    );
    _debounceCalculate();
  }

  void updateRate(double value) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(annualRate: value),
    );
    _debounceCalculate();
  }

  void updateTerm(int months) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(termMonths: months),
    );
    _debounceCalculate();
  }

  void updateType(LoanType type) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(type: type),
    );
    _calculate(); // No debounce for type change
  }

  void _debounceCalculate() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: AppConstants.calculatorDebounceMs),
      _calculate,
    );
  }

  void _calculate() {
    state = state.copyWith(isCalculating: true);

    final result = FinancialCalculator.calculateLoan(
      principal: state.inputs.principal,
      annualRate: state.inputs.annualRate,
      termMonths: state.inputs.termMonths,
      type: state.inputs.type,
    );

    state = state.copyWith(
      result: result,
      isCalculating: false,
    );
  }

  void reset() {
    state = const LoanCalculatorState();
    _calculate();
  }
}

/// Provider
final loanCalculatorProvider =
    NotifierProvider<LoanCalculatorNotifier, LoanCalculatorState>(
  LoanCalculatorNotifier.new,
);

/// Convenience providers
final loanResultProvider = Provider<LoanResult?>((ref) {
  return ref.watch(loanCalculatorProvider).result;
});

final loanScheduleProvider = Provider<List<AmortizationEntry>>((ref) {
  return ref.watch(loanCalculatorProvider).result?.schedule ?? [];
});
