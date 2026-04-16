import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/constants/glass_settings.dart';
import 'package:money_mate/presentation/home/pages/home_page.dart';
import 'package:money_mate/presentation/simulation/pages/simulation_page.dart';
import 'package:money_mate/presentation/saved/pages/saved_page.dart';
import 'package:money_mate/presentation/settings/pages/settings_page.dart';

/// Main app shell with bottom navigation and liquid glass background
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    SimulationPage(),
    SavedPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LiquidGlassScope.stack(
      background: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper2.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      content: Positioned.fill(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: GlassBottomBar(
            quality: GlassQuality.premium,
            indicatorColor: Colors.black26,
            glassSettings: RecommendedGlassSettings.bottomBar,
            tabs: [
              GlassBottomBarTab(
                label: 'Trang chủ',
                icon: const Icon(CupertinoIcons.home),
                activeIcon: const Icon(CupertinoIcons.house_fill),
              ),
              GlassBottomBarTab(
                label: 'Mô phỏng',
                icon: const Icon(CupertinoIcons.chart_bar),
                activeIcon: const Icon(CupertinoIcons.chart_bar_fill),
              ),
              GlassBottomBarTab(
                label: 'Đã lưu',
                icon: const Icon(CupertinoIcons.bookmark),
                activeIcon: const Icon(CupertinoIcons.bookmark_fill),
              ),
              GlassBottomBarTab(
                label: 'Cài đặt',
                icon: const Icon(CupertinoIcons.settings),
                activeIcon: const Icon(CupertinoIcons.settings_solid),
              ),
            ],
            selectedIndex: _currentIndex,
            onTabSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
