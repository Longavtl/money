import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Recommended glass settings optimized for Apple iOS 26 liquid glass appearance.
///
/// ## lightAngle Convention
/// `lightAngle` is in radians, measured from positive-x axis (right).
/// Apple uses 0.75 * pi = 135° (upper-left) across all glass surfaces.
///
/// ## refractiveIndex Guide:
/// - 0.7-1.0: Thin delicate rim (iOS 26 default aesthetic)
/// - 1.0-1.5: Moderate rim visibility
/// - 1.5-2.0: Bold prominent rim
class RecommendedGlassSettings {
  const RecommendedGlassSettings._();

  /// Standard settings for scrollable content.
  /// Use with `GlassQuality.standard` (default).
  static const standard = LiquidGlassSettings(
    blur: 10,
    thickness: 0,
    glassColor: Color.fromRGBO(255, 255, 255, 0.12),
    lightAngle: 0.75 * math.pi, // 135° — upper-left, matches iOS 26
    lightIntensity: 0.7,
    ambientStrength: 0.4,
    saturation: 1.2,
    refractiveIndex: 0.7, // Thin rim (iOS 26 aesthetic)
    chromaticAberration: 0.0,
  );

  /// Settings for buttons and interactive elements.
  /// saturation: 0.0 at rest, animated to 1.0 on press.
  static const interactive = LiquidGlassSettings(
    blur: 10,
    thickness: 10,
    glassColor: Color.fromRGBO(255, 255, 255, 0.2),
    lightAngle: 0.75 * math.pi,
    lightIntensity: 0.7,
    ambientStrength: 0.3,
    saturation: 0.0, // Glow intensity (animated on press)
    refractiveIndex: 0.7,
    chromaticAberration: 0.0,
  );

  /// Settings for static surfaces (app bars, toolbars).
  static const surface = LiquidGlassSettings(
    blur: 10,
    thickness: 10,
    glassColor: Color.fromRGBO(255, 255, 255, 0.2),
    lightAngle: 0.75 * math.pi,
    lightIntensity: 0.7,
    ambientStrength: 0.3,
    saturation: 1.2,
    refractiveIndex: 1.15, // Moderate rim
    chromaticAberration: 0.0,
  );

  /// Settings for bottom navigation bars.
  /// Tuned to Apple's iOS 26 bottom bar specification.
  static const bottomBar = LiquidGlassSettings(
    blur: 20,
    thickness: 20,
    glassColor: Color.fromRGBO(255, 255, 255, 0.15),
    lightAngle: 0.75 * math.pi,
    lightIntensity: 0.7,
    ambientStrength: 0.5,
    saturation: 1.2,
    refractiveIndex: 1.2, // Moderate rim / noticeable refraction
    chromaticAberration: 0.0,
  );

  /// Settings for overlays and sheets.
  static const overlay = LiquidGlassSettings(
    blur: 10,
    thickness: 10,
    glassColor: Color.fromRGBO(255, 255, 255, 0.12),
    lightAngle: 0.75 * math.pi,
    lightIntensity: 0.7,
    ambientStrength: 0.4,
    saturation: 1.2,
    refractiveIndex: 0.7,
    chromaticAberration: 0.0,
  );

  /// Settings for input fields.
  static const input = LiquidGlassSettings(
    blur: 20,
    thickness: 10,
    glassColor: Color.fromRGBO(255, 255, 255, 0.12),
    lightAngle: 0.75 * math.pi,
    lightIntensity: 0.7,
    ambientStrength: 0.4,
    saturation: 1.2,
    refractiveIndex: 0.7,
    chromaticAberration: 0.0,
  );
}
