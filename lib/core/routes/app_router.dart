import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:money_mate/core/routes/app_routes.dart';
import 'package:money_mate/presentation/home/pages/home_page.dart';
import 'package:money_mate/presentation/calculators/simple_interest/simple_interest_page.dart';
import 'package:money_mate/presentation/calculators/compound_interest/compound_interest_page.dart';
import 'package:money_mate/presentation/calculators/loan/loan_calculator_page.dart';
import 'package:money_mate/presentation/calculators/savings/savings_calculator_page.dart';
import 'package:money_mate/presentation/saved/pages/saved_page.dart';
import 'package:money_mate/presentation/settings/pages/settings_page.dart';
import 'package:money_mate/presentation/premium/premium_page.dart';
import 'package:money_mate/presentation/comparison/comparison_page.dart';
import 'package:money_mate/presentation/app/pages/app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

/// App router configuration
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    // Shell route with bottom navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.saved,
          name: 'saved',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SavedPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          name: 'settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsPage(),
          ),
        ),
      ],
    ),

    // Calculator routes (full screen, no bottom nav)
    GoRoute(
      path: AppRoutes.simpleInterest,
      name: 'simple-interest',
      builder: (context, state) => const SimpleInterestPage(),
    ),
    GoRoute(
      path: AppRoutes.compoundInterest,
      name: 'compound-interest',
      builder: (context, state) => const CompoundInterestPage(),
    ),
    GoRoute(
      path: AppRoutes.loan,
      name: 'loan',
      builder: (context, state) => const LoanCalculatorPage(),
    ),
    GoRoute(
      path: AppRoutes.savings,
      name: 'savings',
      builder: (context, state) => const SavingsCalculatorPage(),
    ),

    // Premium route
    GoRoute(
      path: AppRoutes.premium,
      name: 'premium',
      builder: (context, state) => const PremiumPage(),
    ),

    // Comparison route (Premium feature)
    GoRoute(
      path: AppRoutes.comparison,
      name: 'comparison',
      builder: (context, state) => const ComparisonPage(),
    ),
  ],
);
