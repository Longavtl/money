import 'app_config_contract.dart';

enum AppFlavor { dev, staging, production }

class AppConfig implements AppConfigContract {
  @override
  final AppFlavor flavor;
  @override
  final String appName;
  @override
  final String baseUrl;

  static AppConfig? _instance;

  factory AppConfig.dev() {
    _instance = AppConfig._internal(
      flavor: AppFlavor.dev,
      appName: 'MoneyMate Dev',
      baseUrl: 'https://api-dev.example.com',
    );
    return _instance!;
  }

  factory AppConfig.staging() {
    _instance = AppConfig._internal(
      flavor: AppFlavor.staging,
      appName: 'MoneyMate Staging',
      baseUrl: 'https://api-staging.example.com',
    );
    return _instance!;
  }

  factory AppConfig.production() {
    _instance = AppConfig._internal(
      flavor: AppFlavor.production,
      appName: 'MoneyMate',
      baseUrl: 'https://api.example.com',
    );
    return _instance!;
  }

  AppConfig._internal({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  static AppConfig get instance {
    if (_instance == null) {
      throw Exception('AppConfig has not been initialized');
    }
    return _instance!;
  }

  bool get isDev => flavor == AppFlavor.dev;
  bool get isStaging => flavor == AppFlavor.staging;
  bool get isProduction => flavor == AppFlavor.production;
}
