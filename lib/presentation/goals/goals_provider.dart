import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/storage/local_storage_service.dart';
import 'package:money/core/services/notification_service.dart';
import 'package:money/domain/entities/savings_goal.dart';

class GoalsState {
  final List<SavingsGoal> goals;
  final bool isLoading;
  final String? error;

  const GoalsState({
    this.goals = const [],
    this.isLoading = false,
    this.error,
  });

  List<SavingsGoal> get activeGoals =>
      goals.where((g) => g.status == GoalStatus.active).toList();

  List<SavingsGoal> get completedGoals =>
      goals.where((g) => g.status == GoalStatus.completed).toList();

  double get totalSaved =>
      goals.fold<double>(0, (sum, g) => sum + g.currentAmount);

  double get totalTarget =>
      goals.fold<double>(0, (sum, g) => sum + g.targetAmount);

  GoalsState copyWith({
    List<SavingsGoal>? goals,
    bool? isLoading,
    String? error,
  }) {
    return GoalsState(
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class GoalsNotifier extends StateNotifier<GoalsState> {
  final LocalStorageService _storage;
  final NotificationService _notifications;

  GoalsNotifier(this._storage, this._notifications) : super(const GoalsState()) {
    loadGoals();
  }

  Future<void> loadGoals() async {
    state = state.copyWith(isLoading: true);
    try {
      final goals = _storage.getAllGoals();

      // Check for deadline passed goals
      final updatedGoals = goals.map((g) {
        if (g.status == GoalStatus.active && g.deadline.isBefore(DateTime.now())) {
          if (g.currentAmount >= g.targetAmount) {
            return g.copyWith(status: GoalStatus.completed);
          } else {
            return g.copyWith(status: GoalStatus.expired);
          }
        }
        return g;
      }).toList();

      state = state.copyWith(goals: updatedGoals, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addGoal(SavingsGoal goal) async {
    await _storage.saveGoal(goal);
    await loadGoals();
  }

  Future<void> updateGoal(SavingsGoal goal) async {
    await _storage.saveGoal(goal);
    await loadGoals();
  }

  Future<void> deleteGoal(String id) async {
    await _storage.deleteGoal(id);
    await loadGoals();
  }

  Future<void> addContribution(String goalId, double amount, {String? notes}) async {
    final goal = state.goals.firstWhere((g) => g.id == goalId);

    final contribution = GoalContribution(
      amount: amount,
      date: DateTime.now(),
      notes: notes,
    );

    final previousMilestone = goal.currentMilestone;
    final newAmount = goal.currentAmount + amount;

    final updatedGoal = goal.copyWith(
      currentAmount: newAmount,
      contributions: [...goal.contributions, contribution],
      status: newAmount >= goal.targetAmount ? GoalStatus.completed : goal.status,
    );

    await _storage.saveGoal(updatedGoal);

    // Check if milestone reached
    final newMilestone = updatedGoal.currentMilestone;
    if (newMilestone != previousMilestone && newMilestone != GoalMilestone.start) {
      await _notifications.scheduleGoalMilestone(
        id: goalId.hashCode,
        goalName: goal.name,
        milestonePercentage: _getMilestonePercentage(newMilestone),
      );
    }

    await loadGoals();
  }

  int _getMilestonePercentage(GoalMilestone milestone) {
    switch (milestone) {
      case GoalMilestone.start:
        return 0;
      case GoalMilestone.twentyFive:
        return 25;
      case GoalMilestone.fifty:
        return 50;
      case GoalMilestone.seventyFive:
        return 75;
      case GoalMilestone.complete:
        return 100;
    }
  }

  Future<void> withdrawAmount(String goalId, double amount, {String? notes}) async {
    final goal = state.goals.firstWhere((g) => g.id == goalId);

    final contribution = GoalContribution(
      amount: -amount,
      date: DateTime.now(),
      notes: notes ?? 'Withdrawal',
    );

    final newAmount = (goal.currentAmount - amount).clamp(0.0, double.infinity);

    final updatedGoal = goal.copyWith(
      currentAmount: newAmount,
      contributions: [...goal.contributions, contribution],
      status: GoalStatus.active,
    );

    await _storage.saveGoal(updatedGoal);
    await loadGoals();
  }

  Future<void> pauseGoal(String goalId) async {
    final goal = state.goals.firstWhere((g) => g.id == goalId);
    final updatedGoal = goal.copyWith(status: GoalStatus.paused);
    await _storage.saveGoal(updatedGoal);
    await loadGoals();
  }

  Future<void> resumeGoal(String goalId) async {
    final goal = state.goals.firstWhere((g) => g.id == goalId);
    final updatedGoal = goal.copyWith(status: GoalStatus.active);
    await _storage.saveGoal(updatedGoal);
    await loadGoals();
  }
}

final goalsProvider = StateNotifierProvider<GoalsNotifier, GoalsState>((ref) {
  final storage = ref.watch(localStorageProvider);
  final notifications = NotificationService();
  return GoalsNotifier(storage, notifications);
});

// Convenience providers
final activeGoalsProvider = Provider<List<SavingsGoal>>((ref) {
  return ref.watch(goalsProvider).activeGoals;
});

final completedGoalsProvider = Provider<List<SavingsGoal>>((ref) {
  return ref.watch(goalsProvider).completedGoals;
});

final totalSavedProvider = Provider<double>((ref) {
  return ref.watch(goalsProvider).totalSaved;
});
