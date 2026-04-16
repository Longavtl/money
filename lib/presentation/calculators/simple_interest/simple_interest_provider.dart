import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/services/financial_calculator.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// Simple Interest calculator input state
class SimpleInterestInputState extends Equatable {
  final double principal;
  final double annualRate;
  final int termMonths;

  const SimpleInterestInputState({
    this.principal = AppConstants.defaultPrincipal,
    this.annualRate = AppConstants.defaultRate,
    this.termMonths = AppConstants.defaultTermMonths,
  });

  SimpleInterestInputState copyWith({
    double? principal,
    double? annualRate,
    int? termMonths,
  }) {
    return SimpleInterestInputState(
      principal: principal ?? this.principal,
      annualRate: annualRate ?? this.annualRate,
      termMonths: termMonths ?? this.termMonths,
    );
  }

  @override
  List<Object?> get props => [principal, annualRate, termMonths];
}

/// Simple Interest calculator state
class SimpleInterestCalculatorState extends Equatable {
  final SimpleInterestInputState inputs;
  final SimpleInterestResult? result;
  final bool isCalculating;

  const SimpleInterestCalculatorState({
    this.inputs = const SimpleInterestInputState(),
    this.result,
    this.isCalculating = false,
  });

  SimpleInterestCalculatorState copyWith({
    SimpleInterestInputState? inputs,
    SimpleInterestResult? result,
    bool? isCalculating,
  }) {
    return SimpleInterestCalculatorState(
      inputs: inputs ?? this.inputs,
      result: result ?? this.result,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }

  bool get hasResult => result != null;

  @override
  List<Object?> get props => [inputs, result, isCalculating];
}

/// Simple Interest calculator notifier
class SimpleInterestCalculatorNotifier
    extends Notifier<SimpleInterestCalculatorState> {
  Timer? _debounceTimer;

  @override
  SimpleInterestCalculatorState build() {
    // Auto-calculate on first build
    Future.microtask(() => _calculate());
    return const SimpleInterestCalculatorState();
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

  void _debounceCalculate() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: AppConstants.calculatorDebounceMs),
      _calculate,
    );
  }

  void _calculate() {
    state = state.copyWith(isCalculating: true);

    final result = FinancialCalculator.calculateSimpleInterest(
      principal: state.inputs.principal,
      annualRate: state.inputs.annualRate,
      termMonths: state.inputs.termMonths,
    );

    state = state.copyWith(
      result: result,
      isCalculating: false,
    );
  }

  void reset() {
    state = const SimpleInterestCalculatorState();
    _calculate();
  }
}

/// Provider
final simpleInterestCalculatorProvider = NotifierProvider<
    SimpleInterestCalculatorNotifier, SimpleInterestCalculatorState>(
  SimpleInterestCalculatorNotifier.new,
);

/// Convenience providers
final simpleInterestResultProvider = Provider<SimpleInterestResult?>((ref) {
  return ref.watch(simpleInterestCalculatorProvider).result;
});
