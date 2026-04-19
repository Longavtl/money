import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/reports/reports_provider.dart';
import 'package:money/common/widgets/app_card.dart';

class ReportsPage extends ConsumerStatefulWidget {
  const ReportsPage({super.key});

  @override
  ConsumerState<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends ConsumerState<ReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final currentPeriod = ref.read(reportsProvider).selectedPeriod;
    _tabController = TabController(
      length: ReportPeriod.values.length,
      vsync: this,
      initialIndex: ReportPeriod.values.indexOf(currentPeriod),
    );
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final period = ReportPeriod.values[_tabController.index];
      ref.read(reportsProvider.notifier).setPeriod(period);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(reportsSummaryProvider);
    final monthlyData = ref.watch(monthlyDataProvider);
    final debtPaidRatio = ref.watch(debtPaidRatioProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.reports,
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: textPrimary),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: _buildTabBar(l10n, textPrimary, textSecondary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            _buildSummaryCards(summary, l10n, textPrimary, textSecondary),
            SizedBox(height: 16.h),

            // Debt vs Paid Pie Chart
            _buildDebtPaidChart(
                debtPaidRatio, l10n, textPrimary, textSecondary),
            SizedBox(height: 16.h),

            // Monthly Bar Chart
            if (monthlyData.isNotEmpty)
              _buildMonthlyChart(monthlyData, l10n, textPrimary, textSecondary),
            SizedBox(height: 16.h),

            // Payment Performance
            _buildPaymentPerformance(summary, l10n, textPrimary, textSecondary),

            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(
      AppLocalizations l10n, Color textPrimary, Color textSecondary) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: textSecondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: textSecondary,
        labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),
        labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(4.w),
        tabs: ReportPeriod.values.map((period) {
          return Tab(
            height: 36.h,
            text: _getPeriodLabel(period, l10n),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryCards(
    Map<String, double> summary,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: l10n.totalPaid,
                value: CurrencyFormatter.formatShort(summary['totalPaid'] ?? 0),
                icon: CupertinoIcons.checkmark_circle_fill,
                color: AppColors.success,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _SummaryCard(
                label: l10n.totalDebt,
                value: CurrencyFormatter.formatShort(summary['totalDebt'] ?? 0),
                icon: CupertinoIcons.money_dollar_circle_fill,
                color: AppColors.danger,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: l10n.totalSaved,
                value:
                    CurrencyFormatter.formatShort(summary['totalSaved'] ?? 0),
                icon: CupertinoIcons.bitcoin_circle_fill,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _SummaryCard(
                label: l10n.netWorth,
                value: CurrencyFormatter.formatShort(summary['netWorth'] ?? 0),
                icon: CupertinoIcons.chart_bar_fill,
                color: (summary['netWorth'] ?? 0) >= 0
                    ? AppColors.success
                    : AppColors.danger,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDebtPaidChart(
    Map<String, double> ratio,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    final debtPercent = ratio['debt'] ?? 0;
    final paidPercent = ratio['paid'] ?? 0;
    final debtAmount = ratio['debtAmount'] ?? 0;
    final paidAmount = ratio['paidAmount'] ?? 0;

    if (debtPercent == 0 && paidPercent == 0) {
      return AppCard(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                Icon(CupertinoIcons.chart_pie,
                    size: 48.sp, color: textSecondary.withValues(alpha: 0.3)),
                SizedBox(height: 8.h),
                Text(l10n.noDataYet,
                    style: TextStyle(fontSize: 14.sp, color: textSecondary)),
              ],
            ),
          ),
        ),
      );
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.debtVsPaid,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              // Simple Pie Chart
              SizedBox(
                width: 120.w,
                height: 120.h,
                child: CustomPaint(
                  painter: _PieChartPainter(
                    debtPercent: debtPercent,
                    paidPercent: paidPercent,
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              // Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ChartLegendItem(
                      color: AppColors.danger,
                      label: l10n.outstanding,
                      value: CurrencyFormatter.formatShort(debtAmount),
                      percent: '${debtPercent.toStringAsFixed(1)}%',
                      textPrimary: textPrimary,
                      textSecondary: textSecondary,
                    ),
                    SizedBox(height: 12.h),
                    _ChartLegendItem(
                      color: AppColors.success,
                      label: l10n.paid,
                      value: CurrencyFormatter.formatShort(paidAmount),
                      percent: '${paidPercent.toStringAsFixed(1)}%',
                      textPrimary: textPrimary,
                      textSecondary: textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart(
    List<MonthlyData> data,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    final maxValue = data.fold<double>(0, (max, d) {
      final values = [d.paid, d.due, d.saved];
      final localMax = values.reduce((a, b) => a > b ? a : b);
      return localMax > max ? localMax : max;
    });

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.monthlyOverview,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBarLegend(AppColors.success, l10n.paid, textSecondary),
              SizedBox(width: 16.w),
              _buildBarLegend(AppColors.danger, l10n.due, textSecondary),
              SizedBox(width: 16.w),
              _buildBarLegend(AppColors.primary, l10n.saved, textSecondary),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.take(6).map((d) {
                return Expanded(
                  child: _MonthBarGroup(
                    data: d,
                    maxValue: maxValue,
                    textSecondary: textSecondary,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarLegend(Color color, String label, Color textSecondary) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(width: 4.w),
        Text(label, style: TextStyle(fontSize: 10.sp, color: textSecondary)),
      ],
    );
  }

  Widget _buildPaymentPerformance(
    Map<String, double> summary,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    final onTime = (summary['onTimePayments'] ?? 0).toInt();
    final late = (summary['latePayments'] ?? 0).toInt();
    final rate = summary['onTimeRate'] ?? 0;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.paymentPerformance,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$onTime',
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success),
                    ),
                    Text(l10n.onTime,
                        style:
                            TextStyle(fontSize: 12.sp, color: textSecondary)),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 50.h,
                color: textSecondary.withValues(alpha: 0.2),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$late',
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.danger),
                    ),
                    Text(l10n.late,
                        style:
                            TextStyle(fontSize: 12.sp, color: textSecondary)),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 50.h,
                color: textSecondary.withValues(alpha: 0.2),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${rate.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: rate >= 80
                            ? AppColors.success
                            : rate >= 50
                                ? AppColors.warning
                                : AppColors.danger,
                      ),
                    ),
                    Text(l10n.onTimeRate,
                        style:
                            TextStyle(fontSize: 12.sp, color: textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getPeriodLabel(ReportPeriod period, AppLocalizations l10n) {
    switch (period) {
      case ReportPeriod.week:
        return l10n.week;
      case ReportPeriod.month:
        return l10n.month;
      case ReportPeriod.quarter:
        return l10n.quarter;
      case ReportPeriod.year:
        return l10n.year;
      case ReportPeriod.all:
        return l10n.allTime;
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.sp),
              const Spacer(),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: textSecondary),
          ),
        ],
      ),
    );
  }
}

class _ChartLegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final String percent;
  final Color textPrimary;
  final Color textSecondary;

  const _ChartLegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.percent,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 12.sp, color: textSecondary)),
              Text(
                '$value ($percent)',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MonthBarGroup extends StatelessWidget {
  final MonthlyData data;
  final double maxValue;
  final Color textSecondary;

  const _MonthBarGroup({
    required this.data,
    required this.maxValue,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _buildBar(data.paid, AppColors.success)),
                SizedBox(width: 2.w),
                Expanded(child: _buildBar(data.due, AppColors.danger)),
                SizedBox(width: 2.w),
                Expanded(child: _buildBar(data.saved, AppColors.primary)),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            data.monthLabel,
            style: TextStyle(fontSize: 10.sp, color: textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double value, Color color) {
    final height = maxValue > 0 ? (value / maxValue) : 0.0;
    return FractionallySizedBox(
      heightFactor: height.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(top: Radius.circular(3.r)),
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final double debtPercent;
  final double paidPercent;

  _PieChartPainter({
    required this.debtPercent,
    required this.paidPercent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    // Background
    paint.color = Colors.grey.withValues(alpha: 0.1);
    canvas.drawCircle(center, radius, paint);

    // Paid arc (green)
    if (paidPercent > 0) {
      paint.color = AppColors.success;
      const startAngle = -3.14159 / 2; // Start from top
      final sweepAngle = 2 * 3.14159 * (paidPercent / 100);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Debt arc (red)
    if (debtPercent > 0) {
      paint.color = AppColors.danger;
      final startAngle = -3.14159 / 2 + 2 * 3.14159 * (paidPercent / 100);
      final sweepAngle = 2 * 3.14159 * (debtPercent / 100);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
