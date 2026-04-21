import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import 'package:money/core/constants/app_constants.dart';
import 'package:money/core/services/financial_calculator.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';

/// Early withdrawal calculator input state
class EarlyWithdrawalInputState extends Equatable {
  final double principal;
  final double originalRate; // Term deposit rate
  final double earlyRate; // Demand deposit rate
  final int originalTermMonths;
  final int actualHoldingMonths;

  const EarlyWithdrawalInputState({
    this.principal = 100000000, // Will be updated based on currency
    this.originalRate = 6.0, // 6% term deposit rate
    this.earlyRate = 0.5, // 0.5% demand deposit rate
    this.originalTermMonths = 12, // 12 months term
    this.actualHoldingMonths = 6, // Withdrawing after 6 months
  });

  EarlyWithdrawalInputState copyWith({
    double? principal,
    double? originalRate,
    double? earlyRate,
    int? originalTermMonths,
    int? actualHoldingMonths,
  }) {
    return EarlyWithdrawalInputState(
      principal: principal ?? this.principal,
      originalRate: originalRate ?? this.originalRate,
      earlyRate: earlyRate ?? this.earlyRate,
      originalTermMonths: originalTermMonths ?? this.originalTermMonths,
      actualHoldingMonths: actualHoldingMonths ?? this.actualHoldingMonths,
    );
  }

  @override
  List<Object?> get props => [
        principal,
        originalRate,
        earlyRate,
        originalTermMonths,
        actualHoldingMonths,
      ];
}

/// Early withdrawal calculator state
class EarlyWithdrawalCalculatorState extends Equatable {
  final EarlyWithdrawalInputState inputs;
  final EarlyWithdrawalResult? result;
  final bool isCalculating;

  const EarlyWithdrawalCalculatorState({
    this.inputs = const EarlyWithdrawalInputState(),
    this.result,
    this.isCalculating = false,
  });

  EarlyWithdrawalCalculatorState copyWith({
    EarlyWithdrawalInputState? inputs,
    EarlyWithdrawalResult? result,
    bool? isCalculating,
  }) {
    return EarlyWithdrawalCalculatorState(
      inputs: inputs ?? this.inputs,
      result: result ?? this.result,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }

  bool get hasResult => result != null;

  @override
  List<Object?> get props => [inputs, result, isCalculating];
}

/// Early withdrawal calculator notifier
class EarlyWithdrawalCalculatorNotifier
    extends Notifier<EarlyWithdrawalCalculatorState> {
  Timer? _debounceTimer;

  @override
  EarlyWithdrawalCalculatorState build() {
    // Initialize with currency-aware default
    final defaultPrincipal = CurrencyFormatter.defaultLoan;
    Future.microtask(() {
      state = state.copyWith(
        inputs: state.inputs.copyWith(principal: defaultPrincipal),
      );
      _calculate();
    });
    return const EarlyWithdrawalCalculatorState();
  }

  void updatePrincipal(double value) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(principal: value),
    );
    _debounceCalculate();
  }

  void updateOriginalRate(double value) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(originalRate: value),
    );
    _debounceCalculate();
  }

  void updateEarlyRate(double value) {
    state = state.copyWith(
      inputs: state.inputs.copyWith(earlyRate: value),
    );
    _debounceCalculate();
  }

  void updateOriginalTerm(int months) {
    // Ensure actual holding doesn't exceed original term
    final actualHolding = state.inputs.actualHoldingMonths > months
        ? months
        : state.inputs.actualHoldingMonths;
    state = state.copyWith(
      inputs: state.inputs.copyWith(
        originalTermMonths: months,
        actualHoldingMonths: actualHolding,
      ),
    );
    _debounceCalculate();
  }

  void updateActualHolding(int months) {
    // Ensure actual holding doesn't exceed original term
    final clamped = months.clamp(1, state.inputs.originalTermMonths);
    state = state.copyWith(
      inputs: state.inputs.copyWith(actualHoldingMonths: clamped),
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

    final result = FinancialCalculator.calculateEarlyWithdrawal(
      principal: state.inputs.principal,
      originalRate: state.inputs.originalRate,
      earlyRate: state.inputs.earlyRate,
      originalTermMonths: state.inputs.originalTermMonths,
      actualHoldingMonths: state.inputs.actualHoldingMonths,
    );

    state = state.copyWith(
      result: result,
      isCalculating: false,
    );
  }

  void reset() {
    final defaultPrincipal = CurrencyFormatter.defaultLoan;
    state = EarlyWithdrawalCalculatorState(
      inputs: EarlyWithdrawalInputState(principal: defaultPrincipal),
    );
    _calculate();
  }
}

/// Provider
final earlyWithdrawalCalculatorProvider = NotifierProvider<
    EarlyWithdrawalCalculatorNotifier, EarlyWithdrawalCalculatorState>(
  EarlyWithdrawalCalculatorNotifier.new,
);

/// Convenience providers
final earlyWithdrawalResultProvider = Provider<EarlyWithdrawalResult?>((ref) {
  return ref.watch(earlyWithdrawalCalculatorProvider).result;
});
