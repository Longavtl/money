import 'package:uuid/uuid.dart';

class UserStreak {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastPaymentDate;
  final DateTime? streakStartDate;
  final List<DateTime> paymentHistory;

  const UserStreak({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastPaymentDate,
    this.streakStartDate,
    this.paymentHistory = const [],
  });

  bool get hasActiveStreak => currentStreak > 0;

  UserStreak recordPayment(DateTime paymentDate) {
    final newHistory = [...paymentHistory, paymentDate];
    int newStreak = currentStreak;
    DateTime? newStreakStart = streakStartDate;

    if (lastPaymentDate == null) {
      newStreak = 1;
      newStreakStart = paymentDate;
    } else {
      final daysSinceLastPayment =
          paymentDate.difference(lastPaymentDate!).inDays;

      if (daysSinceLastPayment <= 35) {
        newStreak = currentStreak + 1;
        newStreakStart ??= lastPaymentDate;
      } else {
        newStreak = 1;
        newStreakStart = paymentDate;
      }
    }

    return UserStreak(
      currentStreak: newStreak,
      longestStreak: newStreak > longestStreak ? newStreak : longestStreak,
      lastPaymentDate: paymentDate,
      streakStartDate: newStreakStart,
      paymentHistory: newHistory,
    );
  }

  UserStreak resetStreak() {
    return UserStreak(
      currentStreak: 0,
      longestStreak: longestStreak,
      lastPaymentDate: lastPaymentDate,
      streakStartDate: null,
      paymentHistory: paymentHistory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastPaymentDate': lastPaymentDate?.toIso8601String(),
      'streakStartDate': streakStartDate?.toIso8601String(),
      'paymentHistory':
          paymentHistory.map((d) => d.toIso8601String()).toList(),
    };
  }

  factory UserStreak.fromJson(Map<String, dynamic> json) {
    return UserStreak(
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastPaymentDate: json['lastPaymentDate'] != null
          ? DateTime.parse(json['lastPaymentDate'] as String)
          : null,
      streakStartDate: json['streakStartDate'] != null
          ? DateTime.parse(json['streakStartDate'] as String)
          : null,
      paymentHistory: (json['paymentHistory'] as List<dynamic>?)
              ?.map((d) => DateTime.parse(d as String))
              .toList() ??
          [],
    );
  }
}

enum AchievementType {
  paymentStreak,
  totalPaid,
  goalsReached,
  onTimePayments,
  earlyPayments,
  savingsGrowth,
  firstPayment,
  firstGoal,
}

class Achievement {
  final String id;
  final String titleEn;
  final String titleVi;
  final String descriptionEn;
  final String descriptionVi;
  final String icon;
  final AchievementType type;
  final int targetValue;
  final int currentValue;
  final int points;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  Achievement({
    String? id,
    required this.titleEn,
    required this.titleVi,
    required this.descriptionEn,
    required this.descriptionVi,
    required this.icon,
    required this.type,
    required this.targetValue,
    this.currentValue = 0,
    this.points = 10,
    this.isUnlocked = false,
    this.unlockedAt,
  }) : id = id ?? const Uuid().v4();

  double get progressPercentage =>
      targetValue > 0 ? (currentValue / targetValue * 100).clamp(0, 100) : 0;

  Achievement copyWith({
    int? currentValue,
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id,
      titleEn: titleEn,
      titleVi: titleVi,
      descriptionEn: descriptionEn,
      descriptionVi: descriptionVi,
      icon: icon,
      type: type,
      targetValue: targetValue,
      currentValue: currentValue ?? this.currentValue,
      points: points,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  Achievement unlock() {
    return copyWith(
      currentValue: targetValue,
      isUnlocked: true,
      unlockedAt: DateTime.now(),
    );
  }

  Achievement updateProgress(int newValue) {
    final shouldUnlock = newValue >= targetValue && !isUnlocked;
    return copyWith(
      currentValue: newValue,
      isUnlocked: shouldUnlock || isUnlocked,
      unlockedAt: shouldUnlock ? DateTime.now() : unlockedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleEn': titleEn,
      'titleVi': titleVi,
      'descriptionEn': descriptionEn,
      'descriptionVi': descriptionVi,
      'icon': icon,
      'type': type.index,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'points': points,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      titleEn: json['titleEn'] as String,
      titleVi: json['titleVi'] as String,
      descriptionEn: json['descriptionEn'] as String,
      descriptionVi: json['descriptionVi'] as String,
      icon: json['icon'] as String,
      type: AchievementType.values[json['type'] as int],
      targetValue: json['targetValue'] as int,
      currentValue: json['currentValue'] as int? ?? 0,
      points: json['points'] as int? ?? 10,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'] as String)
          : null,
    );
  }
}

final defaultAchievements = [
  Achievement(
    id: 'first_payment',
    titleEn: 'First Step',
    titleVi: 'Bước đầu tiên',
    descriptionEn: 'Make your first payment',
    descriptionVi: 'Thực hiện khoản thanh toán đầu tiên',
    icon: '⭐',
    type: AchievementType.firstPayment,
    targetValue: 1,
    points: 10,
  ),
  Achievement(
    id: 'payment_streak_7',
    titleEn: 'Week Warrior',
    titleVi: 'Chiến binh tuần',
    descriptionEn: '7 consecutive on-time payments',
    descriptionVi: '7 lần thanh toán đúng hạn liên tiếp',
    icon: '🔥',
    type: AchievementType.paymentStreak,
    targetValue: 7,
    points: 20,
  ),
  Achievement(
    id: 'payment_streak_30',
    titleEn: 'Monthly Master',
    titleVi: 'Bậc thầy tháng',
    descriptionEn: '30 consecutive on-time payments',
    descriptionVi: '30 lần thanh toán đúng hạn liên tiếp',
    icon: '🏆',
    type: AchievementType.paymentStreak,
    targetValue: 30,
    points: 50,
  ),
  Achievement(
    id: 'payment_streak_90',
    titleEn: 'Quarter Champion',
    titleVi: 'Nhà vô địch quý',
    descriptionEn: '90 consecutive on-time payments',
    descriptionVi: '90 lần thanh toán đúng hạn liên tiếp',
    icon: '👑',
    type: AchievementType.paymentStreak,
    targetValue: 90,
    points: 100,
  ),
  Achievement(
    id: 'first_goal',
    titleEn: 'Goal Setter',
    titleVi: 'Người đặt mục tiêu',
    descriptionEn: 'Create your first savings goal',
    descriptionVi: 'Tạo mục tiêu tiết kiệm đầu tiên',
    icon: '🎯',
    type: AchievementType.firstGoal,
    targetValue: 1,
    points: 10,
  ),
  Achievement(
    id: 'goal_crusher',
    titleEn: 'Dream Achiever',
    titleVi: 'Người chinh phục',
    descriptionEn: 'Complete your first savings goal',
    descriptionVi: 'Hoàn thành mục tiêu tiết kiệm đầu tiên',
    icon: '🎖️',
    type: AchievementType.goalsReached,
    targetValue: 1,
    points: 30,
  ),
  Achievement(
    id: 'goal_master',
    titleEn: 'Goal Master',
    titleVi: 'Bậc thầy mục tiêu',
    descriptionEn: 'Complete 5 savings goals',
    descriptionVi: 'Hoàn thành 5 mục tiêu tiết kiệm',
    icon: '💎',
    type: AchievementType.goalsReached,
    targetValue: 5,
    points: 100,
  ),
  Achievement(
    id: 'on_time_master',
    titleEn: 'Reliable Payer',
    titleVi: 'Người đáng tin cậy',
    descriptionEn: '10 on-time payments',
    descriptionVi: '10 lần thanh toán đúng hạn',
    icon: '⏰',
    type: AchievementType.onTimePayments,
    targetValue: 10,
    points: 25,
  ),
];

enum HealthScoreRating {
  poor(0, 40, 'Poor', 'Kém'),
  fair(40, 60, 'Fair', 'Trung bình'),
  good(60, 80, 'Good', 'Tốt'),
  excellent(80, 100, 'Excellent', 'Xuất sắc');

  final int minScore;
  final int maxScore;
  final String titleEn;
  final String titleVi;

  const HealthScoreRating(
      this.minScore, this.maxScore, this.titleEn, this.titleVi);

  static HealthScoreRating fromScore(int score) {
    if (score >= 80) return excellent;
    if (score >= 60) return good;
    if (score >= 40) return fair;
    return poor;
  }
}

class FinancialHealthScore {
  final int score;
  final HealthScoreRating rating;
  final List<ScoreFactor> factors;
  final DateTime calculatedAt;

  FinancialHealthScore({
    required this.score,
    required this.factors,
    DateTime? calculatedAt,
  })  : rating = HealthScoreRating.fromScore(score),
        calculatedAt = calculatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'factors': factors.map((f) => f.toJson()).toList(),
      'calculatedAt': calculatedAt.toIso8601String(),
    };
  }

  factory FinancialHealthScore.fromJson(Map<String, dynamic> json) {
    return FinancialHealthScore(
      score: json['score'] as int,
      factors: (json['factors'] as List<dynamic>)
          .map((f) => ScoreFactor.fromJson(f as Map<String, dynamic>))
          .toList(),
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
    );
  }
}

class ScoreFactor {
  final String nameEn;
  final String nameVi;
  final int impact;
  final String descriptionEn;
  final String descriptionVi;

  const ScoreFactor({
    required this.nameEn,
    required this.nameVi,
    required this.impact,
    required this.descriptionEn,
    required this.descriptionVi,
  });

  Map<String, dynamic> toJson() {
    return {
      'nameEn': nameEn,
      'nameVi': nameVi,
      'impact': impact,
      'descriptionEn': descriptionEn,
      'descriptionVi': descriptionVi,
    };
  }

  factory ScoreFactor.fromJson(Map<String, dynamic> json) {
    return ScoreFactor(
      nameEn: json['nameEn'] as String,
      nameVi: json['nameVi'] as String,
      impact: json['impact'] as int,
      descriptionEn: json['descriptionEn'] as String,
      descriptionVi: json['descriptionVi'] as String,
    );
  }
}
