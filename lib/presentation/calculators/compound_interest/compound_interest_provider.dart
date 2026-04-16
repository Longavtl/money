import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/services/financial_calculator.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// Compound Interest calculator input state
class CompoundInterestInputState extends Equatable {
  final double principal;
  final double annualRate;
  final int termMonths;
  final CompoundingFrequency frequency;

  const CompoundInterestInputState({
    this.principal = AppConstants.defaultPrincipal,
    this.annualRate = AppConstants.defaultRate,
    this.termMonths = AppConstants.defaultTermMonths,
    this.frequency = CompoundingFrequency.monthly,
  });

  CompoundInterestInputState copyWith({
    double? principal,
    double? annualRate,
    int? termMonths,
    CompoundingFrequency? frequency,
  }) {
    return CompoundInterestInputState(
      principal: principal ?? this.principal,
      annualRate: annualRate ?? this.annualRate,
      termMonths: termMonths ?? this.termMonths,
      frequency: frequency ?? this.frequency,
    );
  }

  @override
  List<Object?> get props => [principal, annualRate, termMonths, frequency];
}

/// Compound Interest calculator state
class CompoundInterestCalculatorState extends Equatable {
  final CompoundInterestInputState inputs;
  final CompoundInterestResult? result;
  final bool isCalculating;

  const CompoundInterestCalculatorState({
    this.inputs = const CompoundInterestInputState(),
    this.result,
    this.isCalculating = false,
  });

  CompoundInterestCalculatorState copyWith({
    CompoundInterestInputState? inputs,
    CompoundInterestResult? result,
    bool? isCalculating,
  }) {
    return CompoundInterestCalculatorState(
      inputs: inputs ?? this.inputs,
      result: result ?? this.result,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }

  bool get hasResult => result != null;

  @override
  List<Object?> get props => [inputs, result, isCalculating];
}

/// Compound Interest calculator notifier
class CompoundInterestCalculatorNotifier
    extends Notifier<CompoundInterestCalculatorState> {
  Timer? _debounceTimer;

  @override
  CompoundInterestCalculatorState build() {
    // Auto-calculate on first build
    Future.microtask(() => _calculate());
    return const CompoundInterestCalculatorState();
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

  void updateFrequency(CompoundingFrequency frequency) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(frequency: frequency),
    );
    _calculate(); // No debounce for frequency change
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

    final result = FinancialCalculator.calculateCompoundInterest(
      principal: state.inputs.principal,
      annualRate: state.inputs.annualRate,
      termMonths: state.inputs.termMonths,
      frequency: state.inputs.frequency,
    );

    state = state.copyWith(
      result: result,
      isCalculating: false,
    );
  }

  void reset() {
    state = const CompoundInterestCalculatorState();
    _calculate();
  }
}

/// Provider
final compoundInterestCalculatorProvider = NotifierProvider<
    CompoundInterestCalculatorNotifier, CompoundInterestCalculatorState>(
  CompoundInterestCalculatorNotifier.new,
);

/// Convenience providers
final compoundInterestResultProvider =
    Provider<CompoundInterestResult?>((ref) {
  return ref.watch(compoundInterestCalculatorProvider).result;
});
