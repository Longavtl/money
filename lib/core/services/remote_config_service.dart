import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:money/l10n/app_localizations.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

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

    showDialog(
      context: context,
      barrierDismissible: !updateRequired,
      useRootNavigator: true,
      builder: (ctx) {
        return PopScope(
          canPop: !updateRequired,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              l10n.newUpdateAvailable,
              textAlign: TextAlign.center,
            ),
            content: Text(
              updateMessage.isNotEmpty ? updateMessage : l10n.updateAppMessage,
              textAlign: TextAlign.center,
            ),
            actions: [
              if (!updateRequired)
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.later),
                ),
              ElevatedButton(
                onPressed: () => _launchUpdateUrl(
                  context,
                  updateUrlAndroid: updateUrlAndroid,
                  updateUrlIos: updateUrlIos,
                ),
                child: Text(l10n.updateNow),
              ),
            ],
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
}
