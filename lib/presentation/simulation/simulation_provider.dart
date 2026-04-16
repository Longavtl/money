import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

enum ScenarioType { loan, savings }

class Scenario {
  final String id;
  final String name;
  final ScenarioType type;
  final double principal;
  final double annualRate;
  final int termMonths;
  final DateTime startDate;

  Scenario({
    String? id,
    required this.name,
    required this.type,
    required this.principal,
    required this.annualRate,
    required this.termMonths,
    DateTime? startDate,
  })  : id = id ?? const Uuid().v4(),
        startDate = startDate ?? DateTime.now();

  // Calculate remaining balance at a specific month
  double getBalanceAtMonth(int month) {
    if (month <= 0) return principal;
    if (month >= termMonths) return 0;

    if (type == ScenarioType.loan) {
      // Loan: reducing balance over time
      final monthlyRate = annualRate / 100 / 12;
      final monthlyPayment = principal *
          (monthlyRate * _pow(1 + monthlyRate, termMonths)) /
          (_pow(1 + monthlyRate, termMonths) - 1);

      double balance = principal;
      for (int i = 0; i < month; i++) {
        final interest = balance * monthlyRate;
        final principalPaid = monthlyPayment - interest;
        balance -= principalPaid;
      }
      return balance.clamp(0, double.infinity);
    } else {
      // Savings: growing balance over time (compound interest)
      final monthlyRate = annualRate / 100 / 12;
      return principal * _pow(1 + monthlyRate, month);
    }
  }

  // Get monthly payment for loans
  double get monthlyPayment {
    if (type != ScenarioType.loan) return 0;
    final monthlyRate = annualRate / 100 / 12;
    if (monthlyRate == 0) return principal / termMonths;
    return principal *
        (monthlyRate * _pow(1 + monthlyRate, termMonths)) /
        (_pow(1 + monthlyRate, termMonths) - 1);
  }

  // Get final value for savings
  double get finalValue {
    if (type != ScenarioType.savings) return 0;
    final monthlyRate = annualRate / 100 / 12;
    return principal * _pow(1 + monthlyRate, termMonths);
  }

  // Get total interest
  double get totalInterest {
    if (type == ScenarioType.loan) {
      return (monthlyPayment * termMonths) - principal;
    } else {
      return finalValue - principal;
    }
  }

  double _pow(double base, int exp) {
    double result = 1;
    for (int i = 0; i < exp; i++) {
      result *= base;
    }
    return result;
  }

  Scenario copyWith({
    String? name,
    ScenarioType? type,
    double? principal,
    double? annualRate,
    int? termMonths,
    DateTime? startDate,
  }) {
    return Scenario(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      principal: principal ?? this.principal,
      annualRate: annualRate ?? this.annualRate,
      termMonths: termMonths ?? this.termMonths,
      startDate: startDate ?? this.startDate,
    );
  }
}

class TimelinePoint {
  final int month;
  final DateTime date;
  final Map<String, double> balances; // scenarioId -> balance

  TimelinePoint({
    required this.month,
    required this.date,
    required this.balances,
  });

  double get totalLoans =>
      balances.entries.fold(0, (sum, e) => sum + (e.value < 0 ? 0 : e.value));
}

class SimulationState {
  final List<Scenario> scenarios;
  final int viewMonths; // How many months to show in timeline
  final int currentMonth; // Currently selected month to view details

  const SimulationState({
    this.scenarios = const [],
    this.viewMonths = 60, // 5 years default
    this.currentMonth = 0,
  });

  bool get hasScenarios => scenarios.isNotEmpty;

  List<Scenario> get loans =>
      scenarios.where((s) => s.type == ScenarioType.loan).toList();

  List<Scenario> get savings =>
      scenarios.where((s) => s.type == ScenarioType.savings).toList();

  // Get timeline data
  List<TimelinePoint> get timeline {
    if (scenarios.isEmpty) return [];

    final points = <TimelinePoint>[];
    final now = DateTime.now();

    for (int month = 0; month <= viewMonths; month++) {
      final date = DateTime(now.year, now.month + month, 1);
      final balances = <String, double>{};

      for (final scenario in scenarios) {
        balances[scenario.id] = scenario.getBalanceAtMonth(month);
      }

      points.add(TimelinePoint(
        month: month,
        date: date,
        balances: balances,
      ));
    }

    return points;
  }

  // Get net worth at specific month (savings - loans)
  double getNetWorthAtMonth(int month) {
    double netWorth = 0;
    for (final scenario in scenarios) {
      final balance = scenario.getBalanceAtMonth(month);
      if (scenario.type == ScenarioType.savings) {
        netWorth += balance;
      } else {
        netWorth -= balance;
      }
    }
    return netWorth;
  }

  SimulationState copyWith({
    List<Scenario>? scenarios,
    int? viewMonths,
    int? currentMonth,
  }) {
    return SimulationState(
      scenarios: scenarios ?? this.scenarios,
      viewMonths: viewMonths ?? this.viewMonths,
      currentMonth: currentMonth ?? this.currentMonth,
    );
  }
}

class SimulationNotifier extends AutoDisposeNotifier<SimulationState> {
  @override
  SimulationState build() => const SimulationState();

  void addScenario(Scenario scenario) {
    state = state.copyWith(
      scenarios: [...state.scenarios, scenario],
    );
  }

  void updateScenario(Scenario scenario) {
    state = state.copyWith(
      scenarios: state.scenarios
          .map((s) => s.id == scenario.id ? scenario : s)
          .toList(),
    );
  }

  void removeScenario(String id) {
    state = state.copyWith(
      scenarios: state.scenarios.where((s) => s.id != id).toList(),
    );
  }

  void setViewMonths(int months) {
    state = state.copyWith(viewMonths: months);
  }

  void setCurrentMonth(int month) {
    state = state.copyWith(currentMonth: month.clamp(0, state.viewMonths));
  }

  void clear() {
    state = const SimulationState();
  }
}

final simulationProvider =
    AutoDisposeNotifierProvider<SimulationNotifier, SimulationState>(
  SimulationNotifier.new,
);
