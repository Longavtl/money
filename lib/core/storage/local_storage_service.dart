import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/domain/entities/payment_reminder.dart';
import 'package:money/domain/entities/savings_goal.dart';
import 'package:money/domain/entities/gamification.dart';
import 'package:money/domain/entities/rate_alert.dart';

/// Local storage service using SharedPreferences
/// Simple JSON-based storage for saved calculations
class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static const _savedLoansKey = 'saved_loans';
  static const _savedSavingsKey = 'saved_savings';
  static const _premiumStatusKey = 'premium_status';
  static const _paymentRemindersKey = 'payment_reminders';
  static const _paymentHistoryKey = 'payment_history';
  static const _savingsGoalsKey = 'savings_goals';
  static const _userStreakKey = 'user_streak';
  static const _achievementsKey = 'achievements';
  static const _rateAlertsKey = 'rate_alerts';
  static const _marketRatesKey = 'market_rates';

  // ============================================================================
  // LOAN OPERATIONS
  // ============================================================================

  List<SavedLoan> getAllLoans() {
    final jsonString = _prefs.getString(_savedLoansKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => SavedLoan.fromJson(e)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveLoan(SavedLoan loan) async {
    final loans = getAllLoans();

    // Check if updating existing loan
    final existingIndex = loans.indexWhere((l) => l.id == loan.id);
    if (existingIndex >= 0) {
      loans[existingIndex] = loan.copyWith(updatedAt: DateTime.now());
    } else {
      loans.add(loan);
    }

    return _saveLoans(loans);
  }

  Future<bool> deleteLoan(String id) async {
    final loans = getAllLoans();
    loans.removeWhere((l) => l.id == id);
    return _saveLoans(loans);
  }

  Future<bool> _saveLoans(List<SavedLoan> loans) {
    final jsonList = loans.map((l) => l.toJson()).toList();
    return _prefs.setString(_savedLoansKey, json.encode(jsonList));
  }

  int getLoanCount() => getAllLoans().length;

  // ============================================================================
  // SAVINGS OPERATIONS
  // ============================================================================

  List<SavedSavings> getAllSavings() {
    final jsonString = _prefs.getString(_savedSavingsKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => SavedSavings.fromJson(e)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveSavings(SavedSavings savings) async {
    final allSavings = getAllSavings();

    // Check if updating existing
    final existingIndex = allSavings.indexWhere((s) => s.id == savings.id);
    if (existingIndex >= 0) {
      allSavings[existingIndex] = savings.copyWith(updatedAt: DateTime.now());
    } else {
      allSavings.add(savings);
    }

    return _saveSavingsList(allSavings);
  }

  Future<bool> deleteSavings(String id) async {
    final allSavings = getAllSavings();
    allSavings.removeWhere((s) => s.id == id);
    return _saveSavingsList(allSavings);
  }

  Future<bool> _saveSavingsList(List<SavedSavings> savings) {
    final jsonList = savings.map((s) => s.toJson()).toList();
    return _prefs.setString(_savedSavingsKey, json.encode(jsonList));
  }

  int getSavingsCount() => getAllSavings().length;

  // ============================================================================
  // PREMIUM OPERATIONS
  // ============================================================================

  bool isPremium() {
    return _prefs.getBool(_premiumStatusKey) ?? false;
  }

  Future<bool> setPremiumStatus(bool isPremium) {
    return _prefs.setBool(_premiumStatusKey, isPremium);
  }

  // ============================================================================
  // PAYMENT REMINDERS OPERATIONS
  // ============================================================================

  List<PaymentReminder> getAllReminders() {
    final jsonString = _prefs.getString(_paymentRemindersKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => PaymentReminder.fromJson(e)).toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } catch (e) {
      return [];
    }
  }

  List<PaymentReminder> getUpcomingReminders({int days = 7}) {
    final now = DateTime.now();
    final upcoming = now.add(Duration(days: days));
    return getAllReminders()
        .where((r) =>
            r.status == PaymentStatus.pending &&
            r.dueDate.isAfter(now) &&
            r.dueDate.isBefore(upcoming))
        .toList();
  }

  Future<bool> saveReminder(PaymentReminder reminder) async {
    final reminders = getAllReminders();
    final existingIndex = reminders.indexWhere((r) => r.id == reminder.id);
    if (existingIndex >= 0) {
      reminders[existingIndex] = reminder;
    } else {
      reminders.add(reminder);
    }
    return _saveReminders(reminders);
  }

  Future<bool> deleteReminder(String id) async {
    final reminders = getAllReminders();
    reminders.removeWhere((r) => r.id == id);
    return _saveReminders(reminders);
  }

  Future<bool> _saveReminders(List<PaymentReminder> reminders) {
    final jsonList = reminders.map((r) => r.toJson()).toList();
    return _prefs.setString(_paymentRemindersKey, json.encode(jsonList));
  }

  int getReminderCount() => getAllReminders().length;

  // Payment History
  List<PaymentHistory> getPaymentHistory() {
    final jsonString = _prefs.getString(_paymentHistoryKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => PaymentHistory.fromJson(e)).toList()
        ..sort((a, b) => b.paidDate.compareTo(a.paidDate));
    } catch (e) {
      return [];
    }
  }

  Future<bool> addPaymentHistory(PaymentHistory history) async {
    final allHistory = getPaymentHistory();
    allHistory.add(history);
    final jsonList = allHistory.map((h) => h.toJson()).toList();
    return _prefs.setString(_paymentHistoryKey, json.encode(jsonList));
  }

  // ============================================================================
  // SAVINGS GOALS OPERATIONS
  // ============================================================================

  List<SavingsGoal> getAllGoals() {
    final jsonString = _prefs.getString(_savingsGoalsKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => SavingsGoal.fromJson(e)).toList()
        ..sort((a, b) => a.deadline.compareTo(b.deadline));
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveGoal(SavingsGoal goal) async {
    final goals = getAllGoals();
    final existingIndex = goals.indexWhere((g) => g.id == goal.id);
    if (existingIndex >= 0) {
      goals[existingIndex] = goal;
    } else {
      goals.add(goal);
    }
    return _saveGoals(goals);
  }

  Future<bool> deleteGoal(String id) async {
    final goals = getAllGoals();
    goals.removeWhere((g) => g.id == id);
    return _saveGoals(goals);
  }

  Future<bool> _saveGoals(List<SavingsGoal> goals) {
    final jsonList = goals.map((g) => g.toJson()).toList();
    return _prefs.setString(_savingsGoalsKey, json.encode(jsonList));
  }

  int getGoalCount() => getAllGoals().length;
  int getCompletedGoalCount() => getAllGoals().where((g) => g.isCompleted).length;

  // ============================================================================
  // GAMIFICATION OPERATIONS
  // ============================================================================

  UserStreak getUserStreak() {
    final jsonString = _prefs.getString(_userStreakKey);
    if (jsonString == null) return const UserStreak();

    try {
      return UserStreak.fromJson(json.decode(jsonString));
    } catch (e) {
      return const UserStreak();
    }
  }

  Future<bool> saveUserStreak(UserStreak streak) {
    return _prefs.setString(_userStreakKey, json.encode(streak.toJson()));
  }

  List<Achievement> getAchievements() {
    final jsonString = _prefs.getString(_achievementsKey);
    if (jsonString == null) {
      // Return default achievements if none saved
      return List.from(defaultAchievements);
    }

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => Achievement.fromJson(e)).toList();
    } catch (e) {
      return List.from(defaultAchievements);
    }
  }

  Future<bool> saveAchievements(List<Achievement> achievements) {
    final jsonList = achievements.map((a) => a.toJson()).toList();
    return _prefs.setString(_achievementsKey, json.encode(jsonList));
  }

  Future<bool> unlockAchievement(String achievementId) async {
    final achievements = getAchievements();
    final index = achievements.indexWhere((a) => a.id == achievementId);
    if (index >= 0 && !achievements[index].isUnlocked) {
      achievements[index] = achievements[index].unlock();
      return saveAchievements(achievements);
    }
    return false;
  }

  Future<bool> saveAchievement(Achievement achievement) async {
    final achievements = getAchievements();
    final existingIndex = achievements.indexWhere((a) => a.id == achievement.id);
    if (existingIndex >= 0) {
      achievements[existingIndex] = achievement;
    } else {
      achievements.add(achievement);
    }
    return saveAchievements(achievements);
  }

  // ============================================================================
  // RATE ALERTS OPERATIONS
  // ============================================================================

  List<RateAlert> getAllRateAlerts() {
    final jsonString = _prefs.getString(_rateAlertsKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => RateAlert.fromJson(e)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveRateAlert(RateAlert alert) async {
    final alerts = getAllRateAlerts();
    final existingIndex = alerts.indexWhere((a) => a.id == alert.id);
    if (existingIndex >= 0) {
      alerts[existingIndex] = alert;
    } else {
      alerts.add(alert);
    }
    return _saveRateAlerts(alerts);
  }

  Future<bool> deleteRateAlert(String id) async {
    final alerts = getAllRateAlerts();
    alerts.removeWhere((a) => a.id == id);
    return _saveRateAlerts(alerts);
  }

  Future<bool> _saveRateAlerts(List<RateAlert> alerts) {
    final jsonList = alerts.map((a) => a.toJson()).toList();
    return _prefs.setString(_rateAlertsKey, json.encode(jsonList));
  }

  List<MarketRate> getMarketRates() {
    final jsonString = _prefs.getString(_marketRatesKey);
    if (jsonString == null) return List.from(defaultMarketRates);

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => MarketRate.fromJson(e)).toList();
    } catch (e) {
      return List.from(defaultMarketRates);
    }
  }

  Future<bool> saveMarketRates(List<MarketRate> rates) {
    final jsonList = rates.map((r) => r.toJson()).toList();
    return _prefs.setString(_marketRatesKey, json.encode(jsonList));
  }

  Future<bool> saveMarketRate(MarketRate rate) async {
    final rates = getMarketRates();
    final existingIndex = rates.indexWhere((r) => r.type == rate.type);
    if (existingIndex >= 0) {
      rates[existingIndex] = rate;
    } else {
      rates.add(rate);
    }
    return saveMarketRates(rates);
  }
}

// ============================================================================
// SAVED MODELS
// ============================================================================

class SavedLoan {
  final String id;
  final String? name;
  final double principal;
  final double annualRate;
  final int termMonths;
  final LoanType type;
  final double monthlyPayment;
  final double totalInterest;
  final double totalPayment;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;

  const SavedLoan({
    required this.id,
    this.name,
    required this.principal,
    required this.annualRate,
    required this.termMonths,
    required this.type,
    required this.monthlyPayment,
    required this.totalInterest,
    required this.totalPayment,
    required this.createdAt,
    this.updatedAt,
    this.notes,
  });

  SavedLoan copyWith({
    String? id,
    String? name,
    double? principal,
    double? annualRate,
    int? termMonths,
    LoanType? type,
    double? monthlyPayment,
    double? totalInterest,
    double? totalPayment,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
  }) {
    return SavedLoan(
      id: id ?? this.id,
      name: name ?? this.name,
      principal: principal ?? this.principal,
      annualRate: annualRate ?? this.annualRate,
      termMonths: termMonths ?? this.termMonths,
      type: type ?? this.type,
      monthlyPayment: monthlyPayment ?? this.monthlyPayment,
      totalInterest: totalInterest ?? this.totalInterest,
      totalPayment: totalPayment ?? this.totalPayment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'principal': principal,
        'annualRate': annualRate,
        'termMonths': termMonths,
        'type': type.name,
        'monthlyPayment': monthlyPayment,
        'totalInterest': totalInterest,
        'totalPayment': totalPayment,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'notes': notes,
      };

  factory SavedLoan.fromJson(Map<String, dynamic> json) => SavedLoan(
        id: json['id'] as String,
        name: json['name'] as String?,
        principal: (json['principal'] as num).toDouble(),
        annualRate: (json['annualRate'] as num).toDouble(),
        termMonths: json['termMonths'] as int,
        type: LoanType.values.firstWhere((e) => e.name == json['type']),
        monthlyPayment: (json['monthlyPayment'] as num).toDouble(),
        totalInterest: (json['totalInterest'] as num).toDouble(),
        totalPayment: (json['totalPayment'] as num).toDouble(),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        notes: json['notes'] as String?,
      );

  /// Create from LoanResult
  factory SavedLoan.fromResult(LoanResult result,
      {String? name, String? notes}) {
    return SavedLoan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      principal: result.principal,
      annualRate: result.rate,
      termMonths: result.termMonths,
      type: result.type,
      monthlyPayment: result.monthlyPayment,
      totalInterest: result.totalInterest,
      totalPayment: result.totalPayment,
      createdAt: DateTime.now(),
      notes: notes,
    );
  }
}

class SavedSavings {
  final String id;
  final String? name;
  final double initialDeposit;
  final double monthlyDeposit;
  final double annualRate;
  final int termMonths;
  final SavingsType type;
  final double finalValue;
  final double totalDeposited;
  final double totalInterest;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;

  const SavedSavings({
    required this.id,
    this.name,
    required this.initialDeposit,
    required this.monthlyDeposit,
    required this.annualRate,
    required this.termMonths,
    required this.type,
    required this.finalValue,
    required this.totalDeposited,
    required this.totalInterest,
    required this.createdAt,
    this.updatedAt,
    this.notes,
  });

  SavedSavings copyWith({
    String? id,
    String? name,
    double? initialDeposit,
    double? monthlyDeposit,
    double? annualRate,
    int? termMonths,
    SavingsType? type,
    double? finalValue,
    double? totalDeposited,
    double? totalInterest,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
  }) {
    return SavedSavings(
      id: id ?? this.id,
      name: name ?? this.name,
      initialDeposit: initialDeposit ?? this.initialDeposit,
      monthlyDeposit: monthlyDeposit ?? this.monthlyDeposit,
      annualRate: annualRate ?? this.annualRate,
      termMonths: termMonths ?? this.termMonths,
      type: type ?? this.type,
      finalValue: finalValue ?? this.finalValue,
      totalDeposited: totalDeposited ?? this.totalDeposited,
      totalInterest: totalInterest ?? this.totalInterest,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'initialDeposit': initialDeposit,
        'monthlyDeposit': monthlyDeposit,
        'annualRate': annualRate,
        'termMonths': termMonths,
        'type': type.name,
        'finalValue': finalValue,
        'totalDeposited': totalDeposited,
        'totalInterest': totalInterest,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'notes': notes,
      };

  factory SavedSavings.fromJson(Map<String, dynamic> json) => SavedSavings(
        id: json['id'] as String,
        name: json['name'] as String?,
        initialDeposit: (json['initialDeposit'] as num).toDouble(),
        monthlyDeposit: (json['monthlyDeposit'] as num).toDouble(),
        annualRate: (json['annualRate'] as num).toDouble(),
        termMonths: json['termMonths'] as int,
        type: SavingsType.values.firstWhere((e) => e.name == json['type']),
        finalValue: (json['finalValue'] as num).toDouble(),
        totalDeposited: (json['totalDeposited'] as num).toDouble(),
        totalInterest: (json['totalInterest'] as num).toDouble(),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        notes: json['notes'] as String?,
      );

  /// Create from SavingsResult
  factory SavedSavings.fromResult(SavingsResult result,
      {String? name, String? notes}) {
    return SavedSavings(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      initialDeposit: result.initialDeposit,
      monthlyDeposit: result.monthlyDeposit,
      annualRate: result.rate,
      termMonths: result.termMonths,
      type: result.type,
      finalValue: result.finalValue,
      totalDeposited: result.totalDeposited,
      totalInterest: result.totalInterest,
      createdAt: DateTime.now(),
      notes: notes,
    );
  }
}
