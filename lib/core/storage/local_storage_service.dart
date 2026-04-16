import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:money/domain/entities/calculation_results.dart';

/// Local storage service using SharedPreferences
/// Simple JSON-based storage for saved calculations
class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static const _savedLoansKey = 'saved_loans';
  static const _savedSavingsKey = 'saved_savings';
  static const _premiumStatusKey = 'premium_status';

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
