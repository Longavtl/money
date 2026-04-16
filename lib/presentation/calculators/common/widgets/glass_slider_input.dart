import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money/core/configs/theme/app_colors.dart';

/// Reusable glass slider input with label and value display
class GlassSliderInput extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double) valueFormatter;
  final ValueChanged<double> onChanged;
  final Color? activeColor;

  const GlassSliderInput({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.valueFormatter,
    required this.onChanged,
    this.divisions,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.7)
                      : AppColors.lightTextSecondary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: (activeColor ?? AppColors.primary)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  valueFormatter(value),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: activeColor ?? AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GlassSlider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
            activeColor: activeColor ?? AppColors.primary,
          ),
        ],
      ),
    );
  }
}
