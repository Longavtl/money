import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:money/l10n/app_localizations.dart';
import 'package:money/core/configs/theme/app_colors.dart';

/// Market rates data model
class MarketRates {
  final String homeLoanRate;
  final String savingsRate;
  final String personalLoanRate;
  final String carLoanRate;
  final String currency;
  final String country;

  const MarketRates({
    required this.homeLoanRate,
    required this.savingsRate,
    required this.personalLoanRate,
    required this.carLoanRate,
    required this.currency,
    required this.country,
  });

  factory MarketRates.fromJson(Map<String, dynamic> json) {
    return MarketRates(
      homeLoanRate: json['home_loan_rate'] as String? ?? '0.00%',
      savingsRate: json['savings_rate'] as String? ?? '0.00%',
      personalLoanRate: json['personal_loan_rate'] as String? ?? '0.00%',
      carLoanRate: json['car_loan_rate'] as String? ?? '0.00%',
      currency: json['currency'] as String? ?? 'USD',
      country: json['country'] as String? ?? 'US',
    );
  }

  // Default rates by locale
  static const Map<String, MarketRates> defaults = {
    'en': MarketRates(
      homeLoanRate: '6.75%',
      savingsRate: '4.50%',
      personalLoanRate: '10.50%',
      carLoanRate: '7.25%',
      currency: 'USD',
      country: 'US',
    ),
    'vi': MarketRates(
      homeLoanRate: '8.50%',
      savingsRate: '5.50%',
      personalLoanRate: '12.00%',
      carLoanRate: '9.00%',
      currency: 'VND',
      country: 'VN',
    ),
    'ja': MarketRates(
      homeLoanRate: '1.50%',
      savingsRate: '0.10%',
      personalLoanRate: '3.00%',
      carLoanRate: '2.50%',
      currency: 'JPY',
      country: 'JP',
    ),
    'ko': MarketRates(
      homeLoanRate: '4.50%',
      savingsRate: '3.50%',
      personalLoanRate: '8.00%',
      carLoanRate: '6.00%',
      currency: 'KRW',
      country: 'KR',
    ),
    'zh': MarketRates(
      homeLoanRate: '4.20%',
      savingsRate: '2.50%',
      personalLoanRate: '6.00%',
      carLoanRate: '5.00%',
      currency: 'CNY',
      country: 'CN',
    ),
    'es': MarketRates(
      homeLoanRate: '3.50%',
      savingsRate: '2.00%',
      personalLoanRate: '7.00%',
      carLoanRate: '5.50%',
      currency: 'EUR',
      country: 'ES',
    ),
    'fr': MarketRates(
      homeLoanRate: '3.80%',
      savingsRate: '2.25%',
      personalLoanRate: '6.50%',
      carLoanRate: '5.25%',
      currency: 'EUR',
      country: 'FR',
    ),
    'de': MarketRates(
      homeLoanRate: '3.60%',
      savingsRate: '2.00%',
      personalLoanRate: '6.00%',
      carLoanRate: '5.00%',
      currency: 'EUR',
      country: 'DE',
    ),
    'pt': MarketRates(
      homeLoanRate: '11.50%',
      savingsRate: '8.00%',
      personalLoanRate: '15.00%',
      carLoanRate: '12.00%',
      currency: 'BRL',
      country: 'BR',
    ),
    'id': MarketRates(
      homeLoanRate: '9.00%',
      savingsRate: '5.00%',
      personalLoanRate: '12.00%',
      carLoanRate: '8.50%',
      currency: 'IDR',
      country: 'ID',
    ),
    'th': MarketRates(
      homeLoanRate: '7.00%',
      savingsRate: '2.50%',
      personalLoanRate: '10.00%',
      carLoanRate: '6.50%',
      currency: 'THB',
      country: 'TH',
    ),
    'hi': MarketRates(
      homeLoanRate: '8.50%',
      savingsRate: '6.50%',
      personalLoanRate: '12.00%',
      carLoanRate: '9.00%',
      currency: 'INR',
      country: 'IN',
    ),
  };
}

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Default market rates JSON
  static const String _defaultMarketRates = '''
{
  "en": {"home_loan_rate": "6.75%", "savings_rate": "4.50%", "personal_loan_rate": "10.50%", "car_loan_rate": "7.25%", "currency": "USD", "country": "US"},
  "vi": {"home_loan_rate": "8.50%", "savings_rate": "5.50%", "personal_loan_rate": "12.00%", "car_loan_rate": "9.00%", "currency": "VND", "country": "VN"},
  "ja": {"home_loan_rate": "1.50%", "savings_rate": "0.10%", "personal_loan_rate": "3.00%", "car_loan_rate": "2.50%", "currency": "JPY", "country": "JP"},
  "ko": {"home_loan_rate": "4.50%", "savings_rate": "3.50%", "personal_loan_rate": "8.00%", "car_loan_rate": "6.00%", "currency": "KRW", "country": "KR"},
  "zh": {"home_loan_rate": "4.20%", "savings_rate": "2.50%", "personal_loan_rate": "6.00%", "car_loan_rate": "5.00%", "currency": "CNY", "country": "CN"},
  "es": {"home_loan_rate": "3.50%", "savings_rate": "2.00%", "personal_loan_rate": "7.00%", "car_loan_rate": "5.50%", "currency": "EUR", "country": "ES"},
  "fr": {"home_loan_rate": "3.80%", "savings_rate": "2.25%", "personal_loan_rate": "6.50%", "car_loan_rate": "5.25%", "currency": "EUR", "country": "FR"},
  "de": {"home_loan_rate": "3.60%", "savings_rate": "2.00%", "personal_loan_rate": "6.00%", "car_loan_rate": "5.00%", "currency": "EUR", "country": "DE"},
  "pt": {"home_loan_rate": "11.50%", "savings_rate": "8.00%", "personal_loan_rate": "15.00%", "car_loan_rate": "12.00%", "currency": "BRL", "country": "BR"},
  "id": {"home_loan_rate": "9.00%", "savings_rate": "5.00%", "personal_loan_rate": "12.00%", "car_loan_rate": "8.50%", "currency": "IDR", "country": "ID"},
  "th": {"home_loan_rate": "7.00%", "savings_rate": "2.50%", "personal_loan_rate": "10.00%", "car_loan_rate": "6.50%", "currency": "THB", "country": "TH"},
  "hi": {"home_loan_rate": "8.50%", "savings_rate": "6.50%", "personal_loan_rate": "12.00%", "car_loan_rate": "9.00%", "currency": "INR", "country": "IN"}
}
''';

  /// Initialize Remote Config
  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      // Set default values
      await _remoteConfig.setDefaults({
        'app_update_info': '{}',
        'feature_flags': '{}',
        'market_rates': _defaultMarketRates,
      });

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Remote Config initialization error: $e');
    }
  }

  /// Check for app update
  static Future<void> checkForUpdate(BuildContext context) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));

      await remoteConfig.fetchAndActivate();

      final updateInfoJson = remoteConfig.getString('app_update_info');
      if (updateInfoJson.isEmpty) return;

      final updateInfo = json.decode(updateInfoJson);
      final androidVersion = updateInfo['android_version'] as String? ?? '1.0.0';
      final iosVersion = updateInfo['ios_version'] as String? ?? '1.0.0';
      final updateRequired = updateInfo['update_required'] as bool? ?? false;
      final updateMessage = updateInfo['update_message'] as String? ?? '';
      final updateUrlAndroid = updateInfo['update_url_android'] as String? ?? '';
      final updateUrlIos = updateInfo['update_url_ios'] as String? ?? '';

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final latestVersion = Platform.isAndroid
          ? androidVersion
          : Platform.isIOS
              ? iosVersion
              : '1.0.0';

      if (_isVersionNewer(latestVersion, currentVersion)) {
        if (!context.mounted) return;
        _showUpdateDialog(
          context,
          updateRequired: updateRequired,
          updateMessage: updateMessage,
          updateUrlAndroid: updateUrlAndroid,
          updateUrlIos: updateUrlIos,
        );
      }
    } catch (e) {
      debugPrint("Update check failed: $e");
    }
  }

  static bool _isVersionNewer(String latest, String current) {
    try {
      if (latest.isEmpty || current.isEmpty) return false;

      List<String> latestParts = latest.split('.').map((part) => part.split('-')[0]).toList();
      List<String> currentParts = current.split('.').map((part) => part.split('-')[0]).toList();

      while (latestParts.length < 3) latestParts.add('0');
      while (currentParts.length < 3) currentParts.add('0');

      List<int> latestNumbers = latestParts.map((part) => int.tryParse(part) ?? 0).toList();
      List<int> currentNumbers = currentParts.map((part) => int.tryParse(part) ?? 0).toList();

      for (int i = 0; i < latestNumbers.length; i++) {
        if (latestNumbers[i] > currentNumbers[i]) return true;
        if (latestNumbers[i] < currentNumbers[i]) return false;
      }
      return false;
    } catch (e) {
      debugPrint("Version comparison failed: $e");
      return false;
    }
  }

  static void _showUpdateDialog(
    BuildContext context, {
    required bool updateRequired,
    required String updateMessage,
    required String updateUrlAndroid,
    required String updateUrlIos,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    showDialog(
      context: context,
      barrierDismissible: !updateRequired,
      useRootNavigator: true,
      builder: (ctx) {
        return PopScope(
          canPop: !updateRequired,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: cardColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF5B9EF4),
                          Color(0xFF3D7DD8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.arrow_down_circle_fill,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    l10n.newUpdateAvailable,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Message
                  Text(
                    updateMessage.isNotEmpty
                        ? updateMessage
                        : l10n.updateAppMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  // Update button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => _launchUpdateUrl(
                        context,
                        updateUrlAndroid: updateUrlAndroid,
                        updateUrlIos: updateUrlIos,
                      ),
                      child: Text(
                        l10n.updateNow,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Later button
                  if (!updateRequired) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        l10n.later,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: textSecondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> _launchUpdateUrl(
    BuildContext context, {
    required String updateUrlAndroid,
    required String updateUrlIos,
  }) async {
    final url = Platform.isAndroid
        ? updateUrlAndroid
        : Platform.isIOS
            ? updateUrlIos
            : '';

    if (url.isEmpty) return;

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching update URL: $e');
    }
  }

  /// Get string value from Remote Config
  String getString(String key) => _remoteConfig.getString(key);

  /// Get bool value from Remote Config
  bool getBool(String key) => _remoteConfig.getBool(key);

  /// Get int value from Remote Config
  int getInt(String key) => _remoteConfig.getInt(key);

  /// Get double value from Remote Config
  double getDouble(String key) => _remoteConfig.getDouble(key);

  /// Get market rates for a specific locale
  MarketRates getMarketRates(String localeCode) {
    try {
      final ratesJson = _remoteConfig.getString('market_rates');
      if (ratesJson.isNotEmpty) {
        final rates = json.decode(ratesJson) as Map<String, dynamic>;
        if (rates.containsKey(localeCode)) {
          return MarketRates.fromJson(rates[localeCode] as Map<String, dynamic>);
        }
        // Fallback to English
        if (rates.containsKey('en')) {
          return MarketRates.fromJson(rates['en'] as Map<String, dynamic>);
        }
      }
    } catch (e) {
      debugPrint('Error getting market rates: $e');
    }
    // Return default rates
    return MarketRates.defaults[localeCode] ?? MarketRates.defaults['en']!;
  }

  /// Get market rates synchronously (uses cached/default values)
  static MarketRates getMarketRatesSync(String localeCode) {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      final ratesJson = remoteConfig.getString('market_rates');
      if (ratesJson.isNotEmpty) {
        final rates = json.decode(ratesJson) as Map<String, dynamic>;
        if (rates.containsKey(localeCode)) {
          return MarketRates.fromJson(rates[localeCode] as Map<String, dynamic>);
        }
        if (rates.containsKey('en')) {
          return MarketRates.fromJson(rates['en'] as Map<String, dynamic>);
        }
      }
    } catch (e) {
      debugPrint('Error getting market rates sync: $e');
    }
    return MarketRates.defaults[localeCode] ?? MarketRates.defaults['en']!;
  }
}
