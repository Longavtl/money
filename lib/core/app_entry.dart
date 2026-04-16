import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:money/l10n/app_localizations.dart';
import 'package:money/core/routes/app_router.dart';
import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/providers/settings_provider.dart';
import 'package:money/core/configs/app_flavor.dart';
import 'package:money/core/configs/theme/app_theme.dart';

class AppEntry {
  Future<void> runWithFlavor({required AppFlavor flavor}) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Lock orientation to portrait
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize flavor config
    switch (flavor) {
      case AppFlavor.dev:
        AppConfig.dev();
        break;
      case AppFlavor.staging:
        AppConfig.staging();
        break;
      case AppFlavor.production:
        AppConfig.production();
        break;
    }

    // Initialize shared preferences
    final sharedPreferences = await SharedPreferences.getInstance();

    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const MoneyMateApp(),
      ),
    );
  }
}

class MoneyMateApp extends ConsumerWidget {
  const MoneyMateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConfig.instance.appName,
          debugShowCheckedModeBanner: !AppConfig.instance.isProduction,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: settings.flutterThemeMode,
          routerConfig: appRouter,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
            Locale('zh'),
            Locale('ja'),
            Locale('ko'),
            Locale('es'),
            Locale('fr'),
            Locale('de'),
            Locale('pt'),
            Locale('id'),
            Locale('th'),
            Locale('hi'),
          ],
          locale: settings.locale,
        );
      },
    );
  }
}
