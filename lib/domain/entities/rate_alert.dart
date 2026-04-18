import 'package:uuid/uuid.dart';

enum RateAlertType { below, above }

enum RateLoanType { homeLoan, personalLoan, carLoan, savings }

class RateAlert {
  final String id;
  final String name;
  final RateLoanType type;
  final double targetRate;
  final RateAlertType alertType;
  final bool isActive;
  final bool hasTriggered;
  final DateTime? lastTriggered;
  final DateTime createdAt;

  RateAlert({
    String? id,
    required this.name,
    required this.type,
    required this.targetRate,
    this.alertType = RateAlertType.below,
    this.isActive = true,
    this.hasTriggered = false,
    this.lastTriggered,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  RateAlert copyWith({
    String? name,
    RateLoanType? type,
    double? targetRate,
    RateAlertType? alertType,
    bool? isActive,
    bool? hasTriggered,
    DateTime? lastTriggered,
  }) {
    return RateAlert(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      targetRate: targetRate ?? this.targetRate,
      alertType: alertType ?? this.alertType,
      isActive: isActive ?? this.isActive,
      hasTriggered: hasTriggered ?? this.hasTriggered,
      lastTriggered: lastTriggered ?? this.lastTriggered,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'targetRate': targetRate,
      'alertType': alertType.index,
      'isActive': isActive,
      'hasTriggered': hasTriggered,
      'lastTriggered': lastTriggered?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RateAlert.fromJson(Map<String, dynamic> json) {
    return RateAlert(
      id: json['id'] as String,
      name: json['name'] as String,
      type: RateLoanType.values[json['type'] as int? ?? 0],
      targetRate: (json['targetRate'] as num).toDouble(),
      alertType: RateAlertType.values[json['alertType'] as int? ?? 0],
      isActive: json['isActive'] as bool? ?? true,
      hasTriggered: json['hasTriggered'] as bool? ?? false,
      lastTriggered: json['lastTriggered'] != null
          ? DateTime.parse(json['lastTriggered'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class MarketRate {
  final RateLoanType type;
  final double rate;
  final double? previousRate;
  final DateTime lastUpdated;

  const MarketRate({
    required this.type,
    required this.rate,
    this.previousRate,
    required this.lastUpdated,
  });

  MarketRate copyWith({
    double? rate,
    double? previousRate,
    DateTime? lastUpdated,
  }) {
    return MarketRate(
      type: type,
      rate: rate ?? this.rate,
      previousRate: previousRate ?? this.previousRate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'rate': rate,
      'previousRate': previousRate,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory MarketRate.fromJson(Map<String, dynamic> json) {
    return MarketRate(
      type: RateLoanType.values[json['type'] as int? ?? 0],
      rate: (json['rate'] as num).toDouble(),
      previousRate: json['previousRate'] != null
          ? (json['previousRate'] as num).toDouble()
          : null,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}

final defaultMarketRates = [
  MarketRate(
    type: RateLoanType.homeLoan,
    rate: 8.5,
    lastUpdated: DateTime.now(),
  ),
  MarketRate(
    type: RateLoanType.personalLoan,
    rate: 12.0,
    lastUpdated: DateTime.now(),
  ),
  MarketRate(
    type: RateLoanType.carLoan,
    rate: 9.5,
    lastUpdated: DateTime.now(),
  ),
  MarketRate(
    type: RateLoanType.savings,
    rate: 5.0,
    lastUpdated: DateTime.now(),
  ),
];
