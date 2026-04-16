import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// A stacked bar chart showing yearly amortization breakdown
class AmortizationBarChart extends StatefulWidget {
  final List<AmortizationEntry> schedule;
  final double height;

  const AmortizationBarChart({
    super.key,
    required this.schedule,
    this.height = 220,
  });

  @override
  State<AmortizationBarChart> createState() => _AmortizationBarChartState();
}

class _AmortizationBarChartState extends State<AmortizationBarChart> {
  int _touchedBarIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.schedule.isEmpty) {
      return SizedBox(
        height: widget.height.h,
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

    // Group by year
    final yearlyData = _groupByYear();

    return Column(
      children: [
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem('Gốc', AppColors.chartPrincipal, isDark),
            SizedBox(width: 24.w),
            _buildLegendItem('Lãi', AppColors.chartInterest, isDark),
          ],
        ),
        SizedBox(height: 16.h),

        // Chart
        SizedBox(
          height: widget.height.h,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _calculateMaxY(yearlyData),
              barTouchData: _buildTouchData(isDark, yearlyData),
              titlesData: _buildTitlesData(isDark, yearlyData),
              gridData: _buildGridData(isDark),
              borderData: FlBorderData(show: false),
              barGroups: _buildBarGroups(yearlyData),
            ),
            swapAnimationDuration: const Duration(milliseconds: 250),
          ),
        ),
      ],
    );
  }

  List<_YearlyAmortization> _groupByYear() {
    final Map<int, _YearlyAmortization> yearMap = {};

    for (final entry in widget.schedule) {
      final year = ((entry.month - 1) ~/ 12) + 1;
      if (!yearMap.containsKey(year)) {
        yearMap[year] = _YearlyAmortization(year: year);
      }
      yearMap[year]!.principalPaid += entry.principalPaid;
      yearMap[year]!.interestPaid += entry.interestPaid;
    }

    return yearMap.values.toList()..sort((a, b) => a.year.compareTo(b.year));
  }

  double _calculateMaxY(List<_YearlyAmortization> data) {
    if (data.isEmpty) return 1000000;
    final maxPayment = data
        .map((d) => d.principalPaid + d.interestPaid)
        .reduce((a, b) => a > b ? a : b);
    return maxPayment * 1.1;
  }

  BarTouchData _buildTouchData(
    bool isDark,
    List<_YearlyAmortization> data,
  ) {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => isDark ? Colors.grey[800]! : Colors.white,
        tooltipRoundedRadius: 8,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          if (groupIndex >= data.length) return null;
          final yearData = data[groupIndex];
          return BarTooltipItem(
            'Năm ${yearData.year}\n'
            'Gốc: ${CurrencyFormatter.formatShort(yearData.principalPaid)}\n'
            'Lãi: ${CurrencyFormatter.formatShort(yearData.interestPaid)}',
            TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          );
        },
      ),
      touchCallback: (event, response) {
        setState(() {
          if (!event.isInterestedForInteractions ||
              response == null ||
              response.spot == null) {
            _touchedBarIndex = -1;
            return;
          }
          _touchedBarIndex = response.spot!.touchedBarGroupIndex;
        });
      },
    );
  }

  FlTitlesData _buildTitlesData(
    bool isDark,
    List<_YearlyAmortization> data,
  ) {
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
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= data.length) return const SizedBox();

            // Show every year if <= 10 years, else show every 2-5 years
            final interval = data.length <= 10
                ? 1
                : data.length <= 20
                    ? 2
                    : 5;
            if (data[index].year % interval != 1 &&
                index != 0 &&
                index != data.length - 1) {
              return const SizedBox();
            }

            return Text(
              'Y${data[index].year}',
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

  FlGridData _buildGridData(bool isDark) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
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

  List<BarChartGroupData> _buildBarGroups(List<_YearlyAmortization> data) {
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final yearData = entry.value;
      final isTouched = index == _touchedBarIndex;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: yearData.principalPaid + yearData.interestPaid,
            width: _calculateBarWidth(data.length),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.r),
              topRight: Radius.circular(4.r),
            ),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                yearData.principalPaid,
                isTouched
                    ? AppColors.chartPrincipal.withValues(alpha: 0.8)
                    : AppColors.chartPrincipal,
              ),
              BarChartRodStackItem(
                yearData.principalPaid,
                yearData.principalPaid + yearData.interestPaid,
                isTouched
                    ? AppColors.chartInterest.withValues(alpha: 0.8)
                    : AppColors.chartInterest,
              ),
            ],
          ),
        ],
      );
    }).toList();
  }

  double _calculateBarWidth(int count) {
    if (count <= 5) return 30;
    if (count <= 10) return 20;
    if (count <= 20) return 12;
    return 8;
  }

  Widget _buildLegendItem(String label, Color color, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark
                ? Colors.white.withValues(alpha: 0.7)
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _YearlyAmortization {
  final int year;
  double principalPaid = 0;
  double interestPaid = 0;

  _YearlyAmortization({required this.year});
}
