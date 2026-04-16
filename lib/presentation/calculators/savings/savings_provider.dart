import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/services/financial_calculator.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// Savings calculator input state
class SavingsInputState extends Equatable {
  final double initialDeposit;
  final double monthlyDeposit;
  final double annualRate;
  final int termMonths;
  final SavingsType type;

  const SavingsInputState({
    this.initialDeposit = AppConstants.defaultPrincipal,
    this.monthlyDeposit = 5000000, // 5 million per month default
    this.annualRate = AppConstants.defaultRate,
    this.termMonths = AppConstants.defaultTermMonths,
    this.type = SavingsType.withReinvestment,
  });

  SavingsInputState copyWith({
    double? initialDeposit,
    double? monthlyDeposit,
    double? annualRate,
    int? termMonths,
    SavingsType? type,
  }) {
    return SavingsInputState(
      initialDeposit: initialDeposit ?? this.initialDeposit,
      monthlyDeposit: monthlyDeposit ?? this.monthlyDeposit,
      annualRate: annualRate ?? this.annualRate,
      termMonths: termMonths ?? this.termMonths,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props =>
      [initialDeposit, monthlyDeposit, annualRate, termMonths, type];
}

/// Savings calculator state
class SavingsCalculatorState extends Equatable {
  final SavingsInputState inputs;
  final SavingsResult? result;
  final bool isCalculating;

  const SavingsCalculatorState({
    this.inputs = const SavingsInputState(),
    this.result,
    this.isCalculating = false,
  });

  SavingsCalculatorState copyWith({
    SavingsInputState? inputs,
    SavingsResult? result,
    bool? isCalculating,
  }) {
    return SavingsCalculatorState(
      inputs: inputs ?? this.inputs,
      result: result ?? this.result,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }

  bool get hasResult => result != null;

  @override
  List<Object?> get props => [inputs, result, isCalculating];
}

/// Savings calculator notifier
class SavingsCalculatorNotifier extends Notifier<SavingsCalculatorState> {
  Timer? _debounceTimer;

  @override
  SavingsCalculatorState build() {
    // Auto-calculate on first build
    Future.microtask(() => _calculate());
    return const SavingsCalculatorState();
  }

  void updateInitialDeposit(double value) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(initialDeposit: value),
    );
    _debounceCalculate();
  }

  void updateMonthlyDeposit(double value) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(monthlyDeposit: value),
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

  void updateType(SavingsType type) {
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

    final result = FinancialCalculator.calculateSavings(
      initialDeposit: state.inputs.initialDeposit,
      monthlyDeposit: state.inputs.monthlyDeposit,
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
    state = const SavingsCalculatorState();
    _calculate();
  }
}

/// Provider
final savingsCalculatorProvider =
    NotifierProvider<SavingsCalculatorNotifier, SavingsCalculatorState>(
  SavingsCalculatorNotifier.new,
);

/// Convenience providers
final savingsResultProvider = Provider<SavingsResult?>((ref) {
  return ref.watch(savingsCalculatorProvider).result;
});
