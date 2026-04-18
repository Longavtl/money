import 'package:uuid/uuid.dart';

enum GoalStatus { active, completed, paused, expired }

class SavingsGoal {
  final String id;
  final String name;
  final String? description;
  final double targetAmount;
  final double currentAmount;
  final DateTime deadline;
  final String? iconName;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<GoalContribution> contributions;
  final GoalStatus status;

  SavingsGoal({
    String? id,
    required this.name,
    this.description,
    required this.targetAmount,
    this.currentAmount = 0,
    required this.deadline,
    this.iconName,
    DateTime? createdAt,
    this.updatedAt,
    this.contributions = const [],
    this.status = GoalStatus.active,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  double get progressPercentage =>
      targetAmount > 0 ? (currentAmount / targetAmount * 100).clamp(0, 100) : 0;

  bool get isCompleted => currentAmount >= targetAmount;

  double get remainingAmount => (targetAmount - currentAmount).clamp(0, double.infinity);

  int get daysRemaining => deadline.difference(DateTime.now()).inDays;

  double get suggestedMonthlyContribution {
    final monthsRemaining = daysRemaining / 30;
    if (monthsRemaining <= 0) return remainingAmount;
    return remainingAmount / monthsRemaining;
  }

  GoalMilestone get currentMilestone {
    final percentage = progressPercentage;
    if (percentage >= 100) return GoalMilestone.complete;
    if (percentage >= 75) return GoalMilestone.seventyFive;
    if (percentage >= 50) return GoalMilestone.fifty;
    if (percentage >= 25) return GoalMilestone.twentyFive;
    return GoalMilestone.start;
  }

  List<GoalMilestone> get reachedMilestones {
    final percentage = progressPercentage;
    final milestones = <GoalMilestone>[];
    if (percentage >= 25) milestones.add(GoalMilestone.twentyFive);
    if (percentage >= 50) milestones.add(GoalMilestone.fifty);
    if (percentage >= 75) milestones.add(GoalMilestone.seventyFive);
    if (percentage >= 100) milestones.add(GoalMilestone.complete);
    return milestones;
  }

  SavingsGoal copyWith({
    String? name,
    String? description,
    double? targetAmount,
    double? currentAmount,
    DateTime? deadline,
    String? iconName,
    List<GoalContribution>? contributions,
    GoalStatus? status,
  }) {
    return SavingsGoal(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      deadline: deadline ?? this.deadline,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      contributions: contributions ?? this.contributions,
      status: status ?? this.status,
    );
  }

  SavingsGoal addContribution(GoalContribution contribution) {
    return copyWith(
      currentAmount: currentAmount + contribution.amount,
      contributions: [...contributions, contribution],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'deadline': deadline.toIso8601String(),
      'iconName': iconName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'contributions': contributions.map((c) => c.toJson()).toList(),
      'status': status.index,
    };
  }

  factory SavingsGoal.fromJson(Map<String, dynamic> json) {
    return SavingsGoal(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      targetAmount: (json['targetAmount'] as num).toDouble(),
      currentAmount: (json['currentAmount'] as num?)?.toDouble() ?? 0,
      deadline: DateTime.parse(json['deadline'] as String),
      iconName: json['iconName'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      contributions: (json['contributions'] as List<dynamic>?)
              ?.map((c) => GoalContribution.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      status: GoalStatus.values[json['status'] as int? ?? 0],
    );
  }
}

class GoalContribution {
  final String id;
  final double amount;
  final DateTime date;
  final String? notes;

  GoalContribution({
    String? id,
    required this.amount,
    DateTime? date,
    this.notes,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  factory GoalContribution.fromJson(Map<String, dynamic> json) {
    return GoalContribution(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String?,
    );
  }
}

enum GoalMilestone {
  start(0, 'Just Started', 'Bắt đầu'),
  twentyFive(25, '25% - Great Start!', '25% - Khởi đầu tốt!'),
  fifty(50, '50% - Halfway There!', '50% - Đã đi nửa đường!'),
  seventyFive(75, '75% - Almost There!', '75% - Sắp đạt được!'),
  complete(100, '100% - Goal Reached!', '100% - Đạt mục tiêu!');

  final int percentage;
  final String titleEn;
  final String titleVi;

  const GoalMilestone(this.percentage, this.titleEn, this.titleVi);
}

const goalIcons = [
  'house',
  'car',
  'vacation',
  'education',
  'emergency',
  'retirement',
  'wedding',
  'baby',
  'electronics',
  'other',
];
