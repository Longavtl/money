import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/constants/glass_settings.dart';

/// A scaffold wrapper that provides the correct LiquidGlassScope.stack setup
/// with wallpaper background for the glass effect to work properly.
class GlassScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const GlassScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.extendBody = true,
    this.extendBodyBehindAppBar = true,
  });

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
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          body: AdaptiveLiquidGlassLayer(
            settings: RecommendedGlassSettings.standard,
            quality: GlassQuality.standard,
            child: body,
          ),
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}

/// A simple glass page wrapper without bottom navigation
class GlassPage extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const GlassPage({
    super.key,
    required this.child,
    this.appBar,
  });

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
          extendBodyBehindAppBar: true,
          appBar: appBar,
          body: AdaptiveLiquidGlassLayer(
            settings: RecommendedGlassSettings.standard,
            quality: GlassQuality.standard,
            child: child,
          ),
        ),
      ),
    );
  }
}
