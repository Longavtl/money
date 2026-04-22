import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Premium feature limits for free tier
class PremiumLimits {
  // Unlimited for free users
  static const int maxSavedLoans = 999999;
  static const int maxSavedSavings = 999999;
  static const int maxSavedGoals = 999999;
  // Limited for free users
  static const int maxReminders = 3;
  // Features
  static const bool canCompare = false;
  static const bool canExportPdf = false;
  static const bool hasFullCharts = false;
  static const bool canAccessCalendar = false;
}

/// Subscription type
enum SubscriptionType {
  monthly,
  yearly,
  lifetime,
}

/// Premium product IDs
class PremiumProducts {
  static const String monthly = 'premium_monthly';
  static const String yearly = 'premium_yearly';
  static const String lifetime = 'premium_lifetime';

  static Set<String> get all => {monthly, yearly, lifetime};

  static Set<String> get subscriptions => {monthly, yearly};
}

/// Premium service for managing in-app purchases
class PremiumService {
  final SharedPreferences _prefs;
  final InAppPurchase _iap = InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];
  bool _isAvailable = false;

  static const _premiumKey = 'is_premium';
  static const _purchaseDateKey = 'premium_purchase_date';

  /// Callbacks for purchase events
  void Function(PurchaseDetails purchase)? onPurchaseSuccess;
  void Function(PurchaseDetails purchase)? onPurchaseRestored;
  void Function(String error)? onPurchaseError;
  void Function()? onPurchasePending;
  void Function()? onPurchaseCanceled;

  PremiumService(this._prefs);

  /// Initialize IAP
  Future<void> initialize() async {
    _isAvailable = await _iap.isAvailable();

    if (!_isAvailable) {
      debugPrint('IAP not available');
      return;
    }

    // Listen to purchase updates
    _subscription = _iap.purchaseStream.listen(
      _handlePurchaseUpdate,
      onError: (error) {
        debugPrint('IAP error: $error');
      },
    );

    // Load products
    await _loadProducts();
  }

  /// Dispose resources
  void dispose() {
    _subscription?.cancel();
  }

  /// Load available products
  Future<void> _loadProducts() async {
    debugPrint('Loading products with IDs: ${PremiumProducts.all}');
    final response = await _iap.queryProductDetails(PremiumProducts.all);

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('Products not found: ${response.notFoundIDs}');
    }

    if (response.error != null) {
      debugPrint('Product query error: ${response.error}');
    }

    _products = response.productDetails;
    debugPrint('Loaded ${_products.length} products:');
    for (final product in _products) {
      debugPrint('  - ${product.id}: ${product.price} (${product.title})');
    }
  }

  /// Handle purchase updates
  void _handlePurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      _processPurchase(purchase);
    }
  }

  /// Process a single purchase
  Future<void> _processPurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.pending) {
      // Show pending UI
      debugPrint('Purchase pending: ${purchase.productID}');
      onPurchasePending?.call();
    } else if (purchase.status == PurchaseStatus.error) {
      // Show error
      debugPrint('Purchase error: ${purchase.error}');
      onPurchaseError?.call(purchase.error?.message ?? 'Purchase failed');
    } else if (purchase.status == PurchaseStatus.purchased) {
      // Verify and deliver
      final valid = await _verifyPurchase(purchase);
      if (valid) {
        await _deliverPremium();
        onPurchaseSuccess?.call(purchase);
      }
    } else if (purchase.status == PurchaseStatus.restored) {
      // Verify and deliver restored purchase
      final valid = await _verifyPurchase(purchase);
      if (valid) {
        await _deliverPremium();
        onPurchaseRestored?.call(purchase);
      }
    } else if (purchase.status == PurchaseStatus.canceled) {
      // User canceled the purchase
      debugPrint('Purchase canceled: ${purchase.productID}');
      onPurchaseCanceled?.call();
    }

    // Complete purchase if needed
    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
  }

  /// Verify purchase (basic verification - production should use server)
  Future<bool> _verifyPurchase(PurchaseDetails purchase) async {
    // In production, verify with your server
    // For now, we trust the purchase
    return PremiumProducts.all.contains(purchase.productID);
  }

  /// Deliver premium features
  Future<void> _deliverPremium() async {
    await _prefs.setBool(_premiumKey, true);
    await _prefs.setString(_purchaseDateKey, DateTime.now().toIso8601String());
    debugPrint('Premium delivered!');
  }

  /// Check if user is premium
  bool get isPremium => _prefs.getBool(_premiumKey) ?? false;

  /// Get premium purchase date
  DateTime? get purchaseDate {
    final dateStr = _prefs.getString(_purchaseDateKey);
    return dateStr != null ? DateTime.parse(dateStr) : null;
  }

  /// Check if IAP is available
  bool get isAvailable => _isAvailable;

  /// Get available products
  List<ProductDetails> get products => _products;

  /// Get monthly product
  ProductDetails? get monthlyProduct {
    try {
      return _products.firstWhere((p) => p.id == PremiumProducts.monthly);
    } catch (e) {
      return null;
    }
  }

  /// Get yearly product
  ProductDetails? get yearlyProduct {
    try {
      return _products.firstWhere((p) => p.id == PremiumProducts.yearly);
    } catch (e) {
      return null;
    }
  }

  /// Get lifetime premium product
  ProductDetails? get lifetimeProduct {
    try {
      return _products.firstWhere((p) => p.id == PremiumProducts.lifetime);
    } catch (e) {
      return null;
    }
  }

  /// Get product by type
  ProductDetails? getProduct(SubscriptionType type) {
    switch (type) {
      case SubscriptionType.monthly:
        return monthlyProduct;
      case SubscriptionType.yearly:
        return yearlyProduct;
      case SubscriptionType.lifetime:
        return lifetimeProduct;
    }
  }

  /// Purchase premium by type
  Future<bool> purchasePremium([SubscriptionType type = SubscriptionType.lifetime]) async {
    final product = getProduct(type);
    if (product == null) {
      debugPrint('Product not found: $type');
      return false;
    }

    final purchaseParam = PurchaseParam(productDetails: product);

    try {
      if (type == SubscriptionType.lifetime) {
        // Non-consumable for lifetime
        return await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      } else {
        // Subscription for monthly/yearly
        return await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      }
    } catch (e) {
      debugPrint('Purchase failed: $e');
      return false;
    }
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  /// Fake purchase for testing
  Future<void> fakePurchase() async {
    await _deliverPremium();
  }

  /// Clear premium for testing
  Future<void> clearPremium() async {
    await _prefs.remove(_premiumKey);
    await _prefs.remove(_purchaseDateKey);
  }

  /// Check feature access
  bool canSaveLoan(int currentCount) {
    return isPremium || currentCount < PremiumLimits.maxSavedLoans;
  }

  bool canSaveSavings(int currentCount) {
    return isPremium || currentCount < PremiumLimits.maxSavedSavings;
  }

  bool get canCompare => isPremium || PremiumLimits.canCompare;

  bool get canExportPdf => isPremium || PremiumLimits.canExportPdf;

  bool get hasFullCharts => isPremium || PremiumLimits.hasFullCharts;

  bool get canAccessCalendar => isPremium || PremiumLimits.canAccessCalendar;

  bool canAddReminder(int currentCount) {
    return isPremium || currentCount < PremiumLimits.maxReminders;
  }

  /// Get formatted price for a product type
  String getFormattedPrice(SubscriptionType type) {
    final product = getProduct(type);
    if (product != null) {
      return product.price;
    }
    // Default prices if products not loaded
    switch (type) {
      case SubscriptionType.monthly:
        return Platform.isIOS ? '\$1.99' : '49.000đ';
      case SubscriptionType.yearly:
        return Platform.isIOS ? '\$9.99' : '199.000đ';
      case SubscriptionType.lifetime:
        return Platform.isIOS ? '\$19.99' : '399.000đ';
    }
  }

  /// Get formatted price (legacy - returns lifetime price)
  String get formattedPrice => getFormattedPrice(SubscriptionType.lifetime);
}
