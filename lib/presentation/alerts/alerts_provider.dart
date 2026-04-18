import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/storage/local_storage_service.dart';
import 'package:money/core/services/notification_service.dart';
import 'package:money/domain/entities/rate_alert.dart';

class AlertsState {
  final List<RateAlert> alerts;
  final List<MarketRate> marketRates;
  final bool isLoading;
  final String? error;

  const AlertsState({
    this.alerts = const [],
    this.marketRates = const [],
    this.isLoading = false,
    this.error,
  });

  List<RateAlert> get activeAlerts => alerts.where((a) => a.isActive).toList();

  List<RateAlert> get triggeredAlerts {
    return alerts.where((a) {
      if (!a.isActive) return false;

      final marketRate = marketRates.firstWhere(
        (m) => m.type == a.type,
        orElse: () => MarketRate(
          type: a.type,
          rate: 0,
          lastUpdated: DateTime.now(),
        ),
      );

      if (a.alertType == RateAlertType.below) {
        return marketRate.rate <= a.targetRate;
      } else {
        return marketRate.rate >= a.targetRate;
      }
    }).toList();
  }

  AlertsState copyWith({
    List<RateAlert>? alerts,
    List<MarketRate>? marketRates,
    bool? isLoading,
    String? error,
  }) {
    return AlertsState(
      alerts: alerts ?? this.alerts,
      marketRates: marketRates ?? this.marketRates,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AlertsNotifier extends StateNotifier<AlertsState> {
  final LocalStorageService _storage;
  final NotificationService _notifications;

  AlertsNotifier(this._storage, this._notifications) : super(const AlertsState()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      final alerts = _storage.getAllRateAlerts();
      var marketRates = _storage.getMarketRates();

      // Initialize with default rates if empty
      if (marketRates.isEmpty) {
        marketRates = defaultMarketRates;
        for (final rate in marketRates) {
          await _storage.saveMarketRate(rate);
        }
      }

      state = state.copyWith(
        alerts: alerts,
        marketRates: marketRates,
        isLoading: false,
      );

      // Check for triggered alerts
      await _checkTriggeredAlerts();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addAlert(RateAlert alert) async {
    await _storage.saveRateAlert(alert);
    await loadData();
  }

  Future<void> updateAlert(RateAlert alert) async {
    await _storage.saveRateAlert(alert);
    await loadData();
  }

  Future<void> deleteAlert(String id) async {
    await _storage.deleteRateAlert(id);
    await loadData();
  }

  Future<void> toggleAlert(String id) async {
    final alert = state.alerts.firstWhere((a) => a.id == id);
    final updated = alert.copyWith(isActive: !alert.isActive);
    await _storage.saveRateAlert(updated);
    await loadData();
  }

  Future<void> updateMarketRate(RateLoanType type, double rate) async {
    final existing = state.marketRates.firstWhere(
      (m) => m.type == type,
      orElse: () => MarketRate(type: type, rate: rate, lastUpdated: DateTime.now()),
    );

    final updated = existing.copyWith(
      rate: rate,
      previousRate: existing.rate,
      lastUpdated: DateTime.now(),
    );

    await _storage.saveMarketRate(updated);
    await loadData();
  }

  Future<void> _checkTriggeredAlerts() async {
    for (final alert in state.triggeredAlerts) {
      if (!alert.hasTriggered) {
        await _notifications.showRateAlert(
          id: alert.id.hashCode,
          title: _getAlertTitle(alert),
          body: _getAlertBody(alert),
        );

        // Mark as triggered
        final updated = alert.copyWith(hasTriggered: true, lastTriggered: DateTime.now());
        await _storage.saveRateAlert(updated);
      }
    }
  }

  String _getAlertTitle(RateAlert alert) {
    return alert.alertType == RateAlertType.below
        ? 'Rate Drop Alert!'
        : 'Rate Increase Alert!';
  }

  String _getAlertBody(RateAlert alert) {
    final typeLabel = _getLoanTypeLabel(alert.type);
    return '$typeLabel rate has reached ${alert.targetRate}%. Time to ${alert.alertType == RateAlertType.below ? 'consider refinancing!' : 'act now!'}';
  }

  String _getLoanTypeLabel(RateLoanType type) {
    switch (type) {
      case RateLoanType.homeLoan:
        return 'Home Loan';
      case RateLoanType.personalLoan:
        return 'Personal Loan';
      case RateLoanType.carLoan:
        return 'Car Loan';
      case RateLoanType.savings:
        return 'Savings';
    }
  }
}

final alertsProvider = StateNotifierProvider<AlertsNotifier, AlertsState>((ref) {
  final storage = ref.watch(localStorageProvider);
  final notifications = NotificationService();
  return AlertsNotifier(storage, notifications);
});

// Convenience providers
final activeAlertsProvider = Provider<List<RateAlert>>((ref) {
  return ref.watch(alertsProvider).activeAlerts;
});

final triggeredAlertsProvider = Provider<List<RateAlert>>((ref) {
  return ref.watch(alertsProvider).triggeredAlerts;
});

final marketRatesProvider = Provider<List<MarketRate>>((ref) {
  return ref.watch(alertsProvider).marketRates;
});
