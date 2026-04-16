import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// A line chart widget for displaying growth data over time
class GlassLineChart extends StatelessWidget {
  final List<GrowthDataPoint> data;
  final bool showPrincipal;
  final bool showInterest;
  final bool showBalance;
  final double height;

  const GlassLineChart({
    super.key,
    required this.data,
    this.showPrincipal = true,
    this.showInterest = true,
    this.showBalance = true,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (data.isEmpty) {
      return SizedBox(
        height: height.h,
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

    return SizedBox(
      height: height.h,
      child: LineChart(
        LineChartData(
          gridData: _buildGridData(isDark),
          titlesData: _buildTitlesData(isDark),
          borderData: FlBorderData(show: false),
          lineBarsData: _buildLineBarsData(),
          lineTouchData: _buildTouchData(isDark),
          minY: 0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      ),
    );
  }

  FlGridData _buildGridData(bool isDark) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: _calculateYInterval(),
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.1),
          strokeWidth: 1,
        );
      },
    );
  }

  FlTitlesData _buildTitlesData(bool isDark) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                CurrencyFormatter.formatShort(value, showSymbol: false),
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: _calculateXInterval(),
          getTitlesWidget: (value, meta) {
            final month = value.toInt();
            if (month < 0 || month >= data.length) return const SizedBox();

            return Text(
              _formatMonth(month),
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            );
          },
        ),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  List<LineChartBarData> _buildLineBarsData() {
    final lines = <LineChartBarData>[];

    if (showBalance) {
      lines.add(
        LineChartBarData(
          spots: data
              .map((d) => FlSpot(d.month.toDouble(), d.balance))
              .toList(),
          isCurved: true,
          curveSmoothness: 0.3,
          color: AppColors.primary,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: AppColors.primary.withValues(alpha: 0.15),
          ),
        ),
      );
    }

    if (showPrincipal) {
      lines.add(
        LineChartBarData(
          spots: data
              .map((d) => FlSpot(d.month.toDouble(), d.principal))
              .toList(),
          isCurved: true,
          curveSmoothness: 0.3,
          color: AppColors.chartPrincipal,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          dashArray: [5, 5],
        ),
      );
    }

    if (showInterest) {
      lines.add(
        LineChartBarData(
          spots: data
              .map((d) => FlSpot(d.month.toDouble(), d.interest))
              .toList(),
          isCurved: true,
          curveSmoothness: 0.3,
          color: AppColors.chartInterest,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
        ),
      );
    }

    return lines;
  }

  LineTouchData _buildTouchData(bool isDark) {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) =>
            isDark ? Colors.grey[800]! : Colors.white,
        tooltipRoundedRadius: 8,
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            String label;
            if (spot.barIndex == 0 && showBalance) {
              label = 'Số dư';
            } else if ((spot.barIndex == 0 && !showBalance && showPrincipal) ||
                (spot.barIndex == 1 && showBalance && showPrincipal)) {
              label = 'Gốc';
            } else {
              label = 'Lãi';
            }

            return LineTooltipItem(
              '$label: ${CurrencyFormatter.formatShort(spot.y)}',
              TextStyle(
                color: spot.bar.color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            );
          }).toList();
        },
      ),
      handleBuiltInTouches: true,
    );
  }

  double _calculateYInterval() {
    if (data.isEmpty) return 1000000;
    final maxValue = data.map((d) => d.balance).reduce((a, b) => a > b ? a : b);
    return (maxValue / 4).ceilToDouble();
  }

  double _calculateXInterval() {
    if (data.length <= 12) return 1;
    if (data.length <= 36) return 3;
    if (data.length <= 120) return 12;
    return 24;
  }

  String _formatMonth(int month) {
    if (month == 0) return '0';
    if (month % 12 == 0) {
      return '${month ~/ 12}y';
    }
    return '${month}m';
  }
}
