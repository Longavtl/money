import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:money_mate/core/routes/app_router.dart';
import 'package:money_mate/core/providers/dependency_providers.dart';
import 'package:money_mate/core/configs/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize liquid glass widgets
  await LiquidGlassWidgets.initialize();

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: LiquidGlassWidgets.wrap(const MoneyMateApp()),
    ),
  );
}

class MoneyMateApp extends StatelessWidget {
  const MoneyMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GlassTheme(
          data: _buildGlassTheme(),
          child: MaterialApp.router(
            title: 'MoneyMate',
            debugShowCheckedModeBanner: false,
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: ThemeMode.system,
            routerConfig: appRouter,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('vi', 'VN'),
              Locale('en', 'US'),
            ],
          ),
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  GlassThemeData _buildGlassTheme() {
    return const GlassThemeData(
      light: GlassThemeVariant(
        settings: LiquidGlassSettings(
          thickness: 30.0,
          blur: 3.0,
          glassColor: AppColors.glassLight,
          chromaticAberration: 0.5,
          refractiveIndex: 1.65,
          lightIntensity: 1.2,
          ambientStrength: 0.6,
          saturation: 1.2,
        ),
        quality: GlassQuality.standard,
        glowColors: GlassGlowColors(
          primary: AppColors.primary,
          secondary: Color(0xFF5856D6),
          success: AppColors.success,
          warning: AppColors.warning,
          danger: AppColors.danger,
          info: AppColors.info,
        ),
      ),
      dark: GlassThemeVariant(
        settings: LiquidGlassSettings(
          thickness: 40.0,
          blur: 5.0,
          glassColor: AppColors.glassDark,
          lightIntensity: 1.5,
          refractiveIndex: 1.2,
          saturation: 1.1,
        ),
        quality: GlassQuality.standard,
        glowColors: GlassGlowColors(
          primary: AppColors.primary,
          secondary: Color(0xFF5856D6),
          success: AppColors.success,
          warning: AppColors.warning,
          danger: AppColors.danger,
          info: AppColors.info,
        ),
      ),
    );
  }
}
