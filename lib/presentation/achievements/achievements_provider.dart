import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/storage/local_storage_service.dart';
import 'package:money/core/services/notification_service.dart';
import 'package:money/domain/entities/gamification.dart';

class AchievementsState {
  final UserStreak streak;
  final List<Achievement> achievements;
  final bool isLoading;
  final String? error;

  const AchievementsState({
    this.streak = const UserStreak(),
    this.achievements = const [],
    this.isLoading = false,
    this.error,
  });

  List<Achievement> get unlockedAchievements =>
      achievements.where((a) => a.isUnlocked).toList();

  List<Achievement> get lockedAchievements =>
      achievements.where((a) => !a.isUnlocked).toList();

  int get totalPoints =>
      unlockedAchievements.fold<int>(0, (sum, a) => sum + a.points);

  double get healthScore {
    // Calculate financial health score based on achievements and streak
    double score = 0;

    // Streak contribution (max 30 points)
    score += (streak.currentStreak / 30 * 30).clamp(0, 30);

    // Achievement contribution (max 50 points)
    final achievementRatio = achievements.isEmpty
        ? 0
        : unlockedAchievements.length / achievements.length;
    score += achievementRatio * 50;

    // Longest streak bonus (max 20 points)
    score += (streak.longestStreak / 60 * 20).clamp(0, 20);

    return score.clamp(0, 100);
  }

  String get healthGrade {
    if (healthScore >= 90) return 'A+';
    if (healthScore >= 80) return 'A';
    if (healthScore >= 70) return 'B+';
    if (healthScore >= 60) return 'B';
    if (healthScore >= 50) return 'C';
    if (healthScore >= 40) return 'D';
    return 'F';
  }

  AchievementsState copyWith({
    UserStreak? streak,
    List<Achievement>? achievements,
    bool? isLoading,
    String? error,
  }) {
    return AchievementsState(
      streak: streak ?? this.streak,
      achievements: achievements ?? this.achievements,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AchievementsNotifier extends StateNotifier<AchievementsState> {
  final LocalStorageService _storage;
  final NotificationService _notifications;

  AchievementsNotifier(this._storage, this._notifications)
      : super(const AchievementsState()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      final streak = _storage.getUserStreak();
      var achievements = _storage.getAchievements();

      // Initialize with default achievements if empty
      if (achievements.isEmpty) {
        achievements = defaultAchievements;
        for (final a in achievements) {
          await _storage.saveAchievement(a);
        }
      }

      state = state.copyWith(
        streak: streak,
        achievements: achievements,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> recordPayment() async {
    final updatedStreak = state.streak.recordPayment(DateTime.now());
    await _storage.saveUserStreak(updatedStreak);

    // Check for streak milestones
    if (updatedStreak.currentStreak % 7 == 0 && updatedStreak.currentStreak > 0) {
      await _notifications.showStreakNotification(
        streakDays: updatedStreak.currentStreak,
      );
    }

    // Update streak-related achievements
    await _updateAchievementProgress('payment_streak_7', updatedStreak.currentStreak);
    await _updateAchievementProgress('payment_streak_30', updatedStreak.currentStreak);
    await _updateAchievementProgress('payment_streak_90', updatedStreak.currentStreak);

    await loadData();
  }

  Future<void> recordOnTimePayment() async {
    await _incrementAchievement('on_time_master');
    await loadData();
  }

  Future<void> recordGoalCompleted() async {
    await _incrementAchievement('goal_crusher');
    await _incrementAchievement('goal_master');
    await loadData();
  }

  Future<void> recordTotalPaid(double amount) async {
    // Update total paid achievements
    final achievements = state.achievements;
    for (final a in achievements) {
      if (a.type == AchievementType.totalPaid) {
        final updated = a.copyWith(currentValue: a.currentValue + amount.toInt());
        await _storage.saveAchievement(updated);
      }
    }
    await loadData();
  }

  Future<void> _updateAchievementProgress(String id, int value) async {
    final achievement = state.achievements.firstWhere(
      (a) => a.id == id,
      orElse: () => throw Exception('Achievement not found'),
    );

    if (value > achievement.currentValue) {
      final updated = achievement.copyWith(
        currentValue: value,
        isUnlocked: value >= achievement.targetValue,
        unlockedAt: value >= achievement.targetValue && !achievement.isUnlocked
            ? DateTime.now()
            : achievement.unlockedAt,
      );
      await _storage.saveAchievement(updated);
    }
  }

  Future<void> _incrementAchievement(String id) async {
    final achievement = state.achievements.firstWhere(
      (a) => a.id == id,
      orElse: () => throw Exception('Achievement not found'),
    );

    final newValue = achievement.currentValue + 1;
    final updated = achievement.copyWith(
      currentValue: newValue,
      isUnlocked: newValue >= achievement.targetValue,
      unlockedAt: newValue >= achievement.targetValue && !achievement.isUnlocked
          ? DateTime.now()
          : achievement.unlockedAt,
    );
    await _storage.saveAchievement(updated);
  }

  Future<void> resetStreak() async {
    await _storage.saveUserStreak(const UserStreak());
    await loadData();
  }
}

final achievementsProvider =
    StateNotifierProvider<AchievementsNotifier, AchievementsState>((ref) {
  final storage = ref.watch(localStorageProvider);
  final notifications = NotificationService();
  return AchievementsNotifier(storage, notifications);
});

// Convenience providers
final currentStreakProvider = Provider<int>((ref) {
  return ref.watch(achievementsProvider).streak.currentStreak;
});

final healthScoreProvider = Provider<double>((ref) {
  return ref.watch(achievementsProvider).healthScore;
});

final unlockedAchievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.watch(achievementsProvider).unlockedAchievements;
});
