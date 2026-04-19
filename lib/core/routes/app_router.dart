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
import 'package:money/presentation/reminders/pages/reminders_page.dart';
import 'package:money/presentation/goals/pages/goals_page.dart';
import 'package:money/presentation/goals/pages/goal_detail_page.dart';
import 'package:money/presentation/calendar/pages/calendar_page.dart';
import 'package:money/presentation/reports/pages/reports_page.dart';
import 'package:money/presentation/achievements/pages/achievements_page.dart';
import 'package:money/presentation/alerts/pages/rate_alerts_page.dart';
import 'package:money/presentation/qr/pages/create_qr_page.dart';
import 'package:money/presentation/qr/pages/qr_preview_page.dart';
import 'package:money/presentation/qr/pages/qr_scanner_page.dart';
import 'package:money/presentation/settings/pages/webview_page.dart';

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

    // Financial Features
    GoRoute(
      path: AppRoutes.reminders,
      name: 'reminders',
      builder: (context, state) => const RemindersPage(),
    ),
    GoRoute(
      path: AppRoutes.goals,
      name: 'goals',
      builder: (context, state) => const GoalsPage(),
    ),
    GoRoute(
      path: AppRoutes.goalDetail,
      name: 'goal-detail',
      builder: (context, state) {
        final goalId = state.pathParameters['id']!;
        return GoalDetailPage(goalId: goalId);
      },
    ),
    GoRoute(
      path: AppRoutes.calendar,
      name: 'calendar',
      builder: (context, state) => const CalendarPage(),
    ),
    GoRoute(
      path: AppRoutes.reports,
      name: 'reports',
      builder: (context, state) => const ReportsPage(),
    ),
    GoRoute(
      path: AppRoutes.achievements,
      name: 'achievements',
      builder: (context, state) => const AchievementsPage(),
    ),
    GoRoute(
      path: AppRoutes.rateAlerts,
      name: 'rate-alerts',
      builder: (context, state) => const RateAlertsPage(),
    ),

    // QR Code routes
    GoRoute(
      path: AppRoutes.createQR,
      name: 'create-qr',
      builder: (context, state) => const CreateQRPage(),
    ),
    GoRoute(
      path: AppRoutes.qrPreview,
      name: 'qr-preview',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return QRPreviewPage(
          data: extra['data'] as String,
          title: extra['title'] as String,
          type: extra['type'] as String,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.qrScanner,
      name: 'qr-scanner',
      builder: (context, state) => const QRScannerPage(),
    ),

    // Legal routes
    GoRoute(
      path: AppRoutes.termsOfService,
      name: 'terms-of-service',
      builder: (context, state) {
        final title = state.extra as String? ?? 'Terms of Service';
        return WebViewPage(
          url: 'https://sites.google.com/view/moneynest1/terms-of-service',
          title: title,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.privacyPolicy,
      name: 'privacy-policy',
      builder: (context, state) {
        final title = state.extra as String? ?? 'Privacy Policy';
        return WebViewPage(
          url: 'https://sites.google.com/view/moneynest1/privacy-policy',
          title: title,
        );
      },
    ),
  ],
);
