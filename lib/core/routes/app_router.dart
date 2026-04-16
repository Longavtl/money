import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:money/core/routes/app_routes.dart';
import 'package:money/presentation/calculators/simple_interest/simple_interest_page.dart';
import 'package:money/presentation/calculators/compound_interest/compound_interest_page.dart';
import 'package:money/presentation/calculators/loan/loan_calculator_page.dart';
import 'package:money/presentation/calculators/savings/savings_calculator_page.dart';
import 'package:money/presentation/premium/premium_page.dart';
import 'package:money/presentation/comparison/comparison_page.dart';
import 'package:money/presentation/app/pages/app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// App router configuration
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    // Main shell with bottom navigation (IndexedStack inside)
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const AppShell(),
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
