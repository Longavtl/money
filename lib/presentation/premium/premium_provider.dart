import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/services/premium_service.dart';

/// Premium service provider
final premiumServiceProvider = Provider<PremiumService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PremiumService(prefs);
});

/// Premium status provider (reactive)
final premiumStatusProvider =
    StateNotifierProvider<PremiumStatusNotifier, PremiumStatus>(
  (ref) => PremiumStatusNotifier(ref.watch(premiumServiceProvider)),
);

/// Premium products provider
final premiumProductsProvider =
    FutureProvider<List<ProductDetails>>((ref) async {
  final service = ref.watch(premiumServiceProvider);
  await service.initialize();
  return service.products;
});

/// Premium status model
class PremiumStatus {
  final bool isPremium;
  final bool isLoading;
  final String? error;
  final DateTime? purchaseDate;

  const PremiumStatus({
    this.isPremium = false,
    this.isLoading = false,
    this.error,
    this.purchaseDate,
  });

  PremiumStatus copyWith({
    bool? isPremium,
    bool? isLoading,
    String? error,
    DateTime? purchaseDate,
  }) {
    return PremiumStatus(
      isPremium: isPremium ?? this.isPremium,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }
}

/// Premium status notifier
class PremiumStatusNotifier extends StateNotifier<PremiumStatus> {
  final PremiumService _service;

  PremiumStatusNotifier(this._service)
      : super(PremiumStatus(
          isPremium: _service.isPremium,
          purchaseDate: _service.purchaseDate,
        ));

  /// Purchase premium
  Future<void> purchasePremium() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _service.purchasePremium();
      if (!success) {
        state = state.copyWith(
          isLoading: false,
          error: 'Không thể thực hiện mua hàng',
        );
      }
      // Success will be handled by purchase stream
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _service.restorePurchases();
      // Check status after restore
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(
        isPremium: _service.isPremium,
        purchaseDate: _service.purchaseDate,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Refresh status
  void refresh() {
    state = state.copyWith(
      isPremium: _service.isPremium,
      purchaseDate: _service.purchaseDate,
    );
  }
}
