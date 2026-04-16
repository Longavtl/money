import 'package:flutter/material.dart';

/// App color palette for MoneyMate
class AppColors {
  AppColors._();

  // Primary colors (iOS Blue)
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryLight = Color(0xFF5AC8FA);
  static const Color primaryDark = Color(0xFF0056B3);

  // Semantic colors
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color danger = Color(0xFFFF3B30);
  static const Color info = Color(0xFF5AC8FA);

  // Chart colors
  static const Color chartPrincipal = Color(0xFF007AFF);
  static const Color chartInterest = Color(0xFF34C759);
  static const Color chartPayment = Color(0xFFFF9500);
  static const Color chartBalance = Color(0xFF5856D6);

  // Comparison colors
  static const Color scenarioA = Color(0xFF007AFF);
  static const Color scenarioB = Color(0xFFFF9500);

  // Light theme
  static const Color lightBackground = Color(0xFFF2F2F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1C1C1E);
  static const Color lightTextSecondary = Color(0xFF8E8E93);
  static const Color lightBorder = Color(0xFFE5E5EA);

  // Dark theme
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E8E93);
  static const Color darkBorder = Color(0xFF38383A);

  // Glass colors
  static const Color glassLight = Color(0x32D2DCF0);
  static const Color glassDark = Color(0x26FFFFFF);
}
