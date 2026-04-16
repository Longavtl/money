import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';

/// Result card showing key calculation results
class ResultCard extends StatelessWidget {
  final String title;
  final List<ResultItem> items;
  final Widget? chart;

  const ResultCard({
    super.key,
    required this.title,
    required this.items,
    this.chart,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            ...items.map((item) => _buildResultItem(context, item)),
            if (chart != null) ...[
              SizedBox(height: 16.h),
              chart!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(BuildContext context, ResultItem item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (item.color != null)
                Container(
                  width: 12.w,
                  height: 12.w,
                  margin: EdgeInsets.only(right: 8.w),
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.7)
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
          Text(
            item.value,
            style: TextStyle(
              fontSize: item.isHighlighted ? 20.sp : 16.sp,
              fontWeight: item.isHighlighted ? FontWeight.bold : FontWeight.w500,
              color: item.valueColor ??
                  (isDark ? Colors.white : AppColors.lightTextPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultItem {
  final String label;
  final String value;
  final Color? color;
  final Color? valueColor;
  final bool isHighlighted;

  const ResultItem({
    required this.label,
    required this.value,
    this.color,
    this.valueColor,
    this.isHighlighted = false,
  });
}
