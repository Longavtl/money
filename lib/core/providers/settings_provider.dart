import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

class AppSettings {
  final AppThemeMode themeMode;
  final String languageCode;

  const AppSettings({
    this.themeMode = AppThemeMode.system,
    this.languageCode = 'en',
  });

  AppSettings copyWith({
    AppThemeMode? themeMode,
    String? languageCode,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  ThemeMode get flutterThemeMode {
    switch (themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  Locale get locale => Locale(languageCode);
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  static const _themeKey = 'theme_mode';
  static const _languageKey = 'language_code';

  SettingsNotifier() : super(const AppSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 2; // default: system
    final languageCode = prefs.getString(_languageKey) ?? 'en';

    state = AppSettings(
      themeMode: AppThemeMode.values[themeIndex],
      languageCode: languageCode,
    );
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setLanguage(String languageCode) async {
    state = state.copyWith(languageCode: languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(),
);

// Supported languages
class SupportedLanguage {
  final String code;
  final String name;
  final String nativeName;

  const SupportedLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

const supportedLanguages = [
  SupportedLanguage(code: 'en', name: 'English', nativeName: 'English'),
  SupportedLanguage(code: 'vi', name: 'Vietnamese', nativeName: 'Tiếng Việt'),
  SupportedLanguage(code: 'zh', name: 'Chinese', nativeName: '中文'),
  SupportedLanguage(code: 'ja', name: 'Japanese', nativeName: '日本語'),
  SupportedLanguage(code: 'ko', name: 'Korean', nativeName: '한국어'),
  SupportedLanguage(code: 'es', name: 'Spanish', nativeName: 'Español'),
  SupportedLanguage(code: 'fr', name: 'French', nativeName: 'Français'),
  SupportedLanguage(code: 'de', name: 'German', nativeName: 'Deutsch'),
  SupportedLanguage(code: 'pt', name: 'Portuguese', nativeName: 'Português'),
  SupportedLanguage(code: 'id', name: 'Indonesian', nativeName: 'Bahasa Indonesia'),
  SupportedLanguage(code: 'th', name: 'Thai', nativeName: 'ไทย'),
  SupportedLanguage(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी'),
];
