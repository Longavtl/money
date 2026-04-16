import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/routes/app_routes.dart';
import 'package:money_mate/core/configs/theme/app_colors.dart';

/// Main app shell with bottom navigation
class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: GlassBottomBar(
        tabs: const [
          GlassBottomBarTab(
            label: 'Home',
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
          ),
          GlassBottomBarTab(
            label: 'Saved',
            icon: Icon(CupertinoIcons.bookmark),
            activeIcon: Icon(CupertinoIcons.bookmark_fill),
          ),
          GlassBottomBarTab(
            label: 'Settings',
            icon: Icon(CupertinoIcons.gear),
            activeIcon: Icon(CupertinoIcons.gear_alt_fill),
          ),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onTabSelected: (index) => _onItemTapped(index, context),
        glassSettings: LiquidGlassSettings(
          thickness: 30,
          blur: 3,
          chromaticAberration: 0.3,
          lightIntensity: 0.6,
          refractiveIndex: 1.59,
          saturation: 0.7,
          ambientStrength: 1,
          glassColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.glassDark
              : AppColors.glassLight,
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.home)) {
      return 0;
    }
    if (location.startsWith(AppRoutes.saved)) {
      return 1;
    }
    if (location.startsWith(AppRoutes.settings)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.saved);
        break;
      case 2:
        context.go(AppRoutes.settings);
        break;
    }
  }
}
