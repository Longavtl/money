import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Premium feature limits for free tier
class PremiumLimits {
  static const int maxSavedLoans = 3;
  static const int maxSavedSavings = 3;
  static const bool canCompare = false;
  static const bool canExportPdf = false;
  static const bool hasFullCharts = false;
}

/// Premium product IDs
class PremiumProducts {
  static const String lifetimePremium = 'moneymate_premium_lifetime';

  static Set<String> get all => {lifetimePremium};
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
    final response = await _iap.queryProductDetails(PremiumProducts.all);

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('Products not found: ${response.notFoundIDs}');
    }

    _products = response.productDetails;
    debugPrint('Loaded ${_products.length} products');
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
    } else if (purchase.status == PurchaseStatus.error) {
      // Show error
      debugPrint('Purchase error: ${purchase.error}');
    } else if (purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored) {
      // Verify and deliver
      final valid = await _verifyPurchase(purchase);
      if (valid) {
        await _deliverPremium();
      }
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
    return purchase.productID == PremiumProducts.lifetimePremium;
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

  /// Get lifetime premium product
  ProductDetails? get lifetimeProduct {
    try {
      return _products.firstWhere(
        (p) => p.id == PremiumProducts.lifetimePremium,
      );
    } catch (e) {
      return null;
    }
  }

  /// Purchase premium
  Future<bool> purchasePremium() async {
    final product = lifetimeProduct;
    if (product == null) {
      debugPrint('Product not found');
      return false;
    }

    final purchaseParam = PurchaseParam(productDetails: product);

    try {
      // Non-consumable for lifetime
      return await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      debugPrint('Purchase failed: $e');
      return false;
    }
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
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

  /// Get formatted price
  String get formattedPrice {
    final product = lifetimeProduct;
    if (product == null) {
      return Platform.isIOS ? '\$4.99' : '99.000đ';
    }
    return product.price;
  }
}
