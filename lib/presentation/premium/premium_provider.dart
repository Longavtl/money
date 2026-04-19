import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/services/premium_service.dart';

export 'package:money/core/services/premium_service.dart' show SubscriptionType;

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

/// TODO: Set to false before release to production
const bool kTestPremiumMode = false;

/// Premium status notifier
class PremiumStatusNotifier extends StateNotifier<PremiumStatus> {
  final PremiumService _service;
  bool _initialized = false;

  PremiumStatusNotifier(this._service)
      : super(PremiumStatus(
          isPremium: _service.isPremium,
          purchaseDate: _service.purchaseDate,
        )) {
    _initializeService();
  }

  /// Initialize the IAP service
  Future<void> _initializeService() async {
    if (_initialized) return;
    _initialized = true;

    // Setup callbacks
    _service.onPurchaseSuccess = (purchase) {
      state = state.copyWith(
        isPremium: true,
        isLoading: false,
        purchaseDate: DateTime.now(),
      );
    };

    _service.onPurchaseRestored = (purchase) {
      state = state.copyWith(
        isPremium: true,
        isLoading: false,
        purchaseDate: _service.purchaseDate,
      );
    };

    _service.onPurchaseError = (error) {
      state = state.copyWith(
        isLoading: false,
        error: error,
      );
    };

    _service.onPurchasePending = () {
      state = state.copyWith(isLoading: true);
    };

    await _service.initialize();
  }

  /// Purchase premium by type
  Future<void> purchasePremium([SubscriptionType type = SubscriptionType.lifetime]) async {
    state = state.copyWith(isLoading: true, error: null);

    // Test mode: fake purchase for testing
    if (kTestPremiumMode) {
      await Future.delayed(const Duration(milliseconds: 500));
      await _service.fakePurchase();
      state = state.copyWith(
        isPremium: true,
        isLoading: false,
        purchaseDate: DateTime.now(),
      );
      return;
    }

    try {
      final success = await _service.purchasePremium(type);
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

  /// Clear premium for testing
  Future<void> clearPremium() async {
    if (kTestPremiumMode) {
      await _service.clearPremium();
      state = const PremiumStatus(isPremium: false);
    }
  }
}
