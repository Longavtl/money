import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';

/// A pie/donut chart widget for displaying principal vs interest breakdown
class GlassPieChart extends StatefulWidget {
  final double principal;
  final double interest;
  final double size;
  final bool showLabels;

  const GlassPieChart({
    super.key,
    required this.principal,
    required this.interest,
    this.size = 150,
    this.showLabels = true,
  });

  @override
  State<GlassPieChart> createState() => _GlassPieChartState();
}

class _GlassPieChartState extends State<GlassPieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = widget.principal + widget.interest;

    if (total <= 0) {
      return SizedBox(
        width: widget.size.w,
        height: widget.size.w,
        child: Center(
          child: Text(
            'Không có dữ liệu',
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
        ),
      );
    }

    final principalPercent = (widget.principal / total * 100);
    final interestPercent = (widget.interest / total * 100);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pie chart
        SizedBox(
          width: widget.size.w,
          height: widget.size.w,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      _touchedIndex = -1;
                      return;
                    }
                    _touchedIndex =
                        response.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: widget.size.w * 0.25,
              sections: [
                PieChartSectionData(
                  color: AppColors.chartPrincipal,
                  value: widget.principal,
                  title: _touchedIndex == 0
                      ? '${principalPercent.toStringAsFixed(1)}%'
                      : '',
                  radius: _touchedIndex == 0
                      ? widget.size.w * 0.32
                      : widget.size.w * 0.28,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: AppColors.chartInterest,
                  value: widget.interest,
                  title: _touchedIndex == 1
                      ? '${interestPercent.toStringAsFixed(1)}%'
                      : '',
                  radius: _touchedIndex == 1
                      ? widget.size.w * 0.32
                      : widget.size.w * 0.28,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            swapAnimationDuration: const Duration(milliseconds: 150),
          ),
        ),

        // Legend
        if (widget.showLabels) ...[
          SizedBox(width: 24.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegendItem(
                'Tiền gốc',
                widget.principal,
                principalPercent,
                AppColors.chartPrincipal,
                isDark,
              ),
              SizedBox(height: 16.h),
              _buildLegendItem(
                'Tiền lãi',
                widget.interest,
                interestPercent,
                AppColors.chartInterest,
                isDark,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildLegendItem(
    String label,
    double value,
    double percent,
    Color color,
    bool isDark,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : AppColors.lightTextSecondary,
              ),
            ),
            Text(
              '${CurrencyFormatter.formatShort(value)} (${percent.toStringAsFixed(1)}%)',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
