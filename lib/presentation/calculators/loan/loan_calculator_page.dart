import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';
import 'package:money_mate/presentation/calculators/common/widgets/glass_slider_input.dart';
import 'package:money_mate/presentation/calculators/common/widgets/result_card.dart';
import 'package:money_mate/presentation/calculators/loan/loan_provider.dart';

/// Loan Calculator Page with real-time calculations
class LoanCalculatorPage extends ConsumerWidget {
  const LoanCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(loanCalculatorProvider);
    final notifier = ref.read(loanCalculatorProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1a1a2e),
                    const Color(0xFF16213e),
                    const Color(0xFF0f3460),
                  ]
                : [
                    const Color(0xFFe8f4f8),
                    const Color(0xFFd4e5f7),
                    const Color(0xFFc9dff7),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              GlassAppBar(
                leading: GlassIconButton(
                  icon: const Icon(CupertinoIcons.back),
                  onPressed: () => context.pop(),
                ),
                title: Text(
                  'Vay ngân hàng',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                actions: [
                  GlassIconButton(
                    icon: const Icon(CupertinoIcons.arrow_counterclockwise),
                    onPressed: () => notifier.reset(),
                  ),
                ],
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      // Input card
                      _buildInputCard(context, state, notifier, isDark),

                      SizedBox(height: 16.h),

                      // Results
                      if (state.hasResult) ...[
                        _buildResultsCard(context, state.result!, isDark),
                        SizedBox(height: 16.h),
                        _buildPieChartCard(context, state.result!, isDark),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(
    BuildContext context,
    LoanCalculatorState state,
    LoanCalculatorNotifier notifier,
    bool isDark,
  ) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loan type selector
            Text(
              'Phương thức trả nợ',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : AppColors.lightTextSecondary,
              ),
            ),
            SizedBox(height: 8.h),
            GlassSegmentedControl(
              segments: const ['Trả góp đều', 'Dư nợ giảm dần'],
              selectedIndex: state.inputs.type == LoanType.fixedPayment ? 0 : 1,
              onSegmentSelected: (index) {
                notifier.updateType(
                  index == 0 ? LoanType.fixedPayment : LoanType.reducingBalance,
                );
              },
            ),

            SizedBox(height: 20.h),

            // Principal slider
            GlassSliderInput(
              label: 'Số tiền vay',
              value: state.inputs.principal,
              min: AppConstants.minPrincipal,
              max: 10000000000, // 10 billion
              divisions: 1000,
              activeColor: AppColors.warning,
              valueFormatter: (v) => CurrencyFormatter.formatShort(v),
              onChanged: notifier.updatePrincipal,
            ),

            SizedBox(height: 8.h),

            // Rate slider
            GlassSliderInput(
              label: 'Lãi suất năm',
              value: state.inputs.annualRate,
              min: AppConstants.minRate,
              max: AppConstants.maxRate,
              divisions: 499,
              activeColor: AppColors.success,
              valueFormatter: (v) => CurrencyFormatter.formatPercent(v),
              onChanged: notifier.updateRate,
            ),

            SizedBox(height: 8.h),

            // Term slider
            GlassSliderInput(
              label: 'Kỳ hạn vay',
              value: state.inputs.termMonths.toDouble(),
              min: AppConstants.minTermMonths.toDouble(),
              max: 360, // 30 years
              divisions: 359,
              activeColor: AppColors.info,
              valueFormatter: (v) => CurrencyFormatter.formatTerm(v.toInt()),
              onChanged: (v) => notifier.updateTerm(v.toInt()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsCard(
    BuildContext context,
    LoanResult result,
    bool isDark,
  ) {
    final items = <ResultItem>[
      ResultItem(
        label: result.type == LoanType.fixedPayment
            ? 'Trả hàng tháng'
            : 'Trả tháng đầu',
        value: CurrencyFormatter.format(result.monthlyPayment),
        isHighlighted: true,
        valueColor: AppColors.warning,
      ),
      ResultItem(
        label: 'Tổng tiền lãi',
        value: CurrencyFormatter.format(result.totalInterest),
        color: AppColors.chartInterest,
      ),
      ResultItem(
        label: 'Tổng thanh toán',
        value: CurrencyFormatter.format(result.totalPayment),
      ),
      ResultItem(
        label: 'Tỷ lệ lãi/gốc',
        value: '${result.interestPercentage.toStringAsFixed(1)}%',
      ),
    ];

    // Add last payment info for reducing balance
    if (result.type == LoanType.reducingBalance) {
      items.insert(
        1,
        ResultItem(
          label: 'Trả tháng cuối',
          value: CurrencyFormatter.format(result.lastPayment),
        ),
      );
    }

    return ResultCard(
      title: 'Kết quả tính toán',
      items: items,
    );
  }

  Widget _buildPieChartCard(
    BuildContext context,
    LoanResult result,
    bool isDark,
  ) {
    final total = result.totalPayment;
    final principalPercent = (result.principal / total * 100);
    final interestPercent = (result.totalInterest / total * 100);

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cơ cấu thanh toán',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                // Simple pie representation
                SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: CustomPaint(
                    painter: _SimplePieChartPainter(
                      principalPercent: principalPercent,
                      interestPercent: interestPercent,
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(
                        context,
                        'Tiền gốc',
                        CurrencyFormatter.formatShort(result.principal),
                        '${principalPercent.toStringAsFixed(1)}%',
                        AppColors.chartPrincipal,
                        isDark,
                      ),
                      SizedBox(height: 12.h),
                      _buildLegendItem(
                        context,
                        'Tiền lãi',
                        CurrencyFormatter.formatShort(result.totalInterest),
                        '${interestPercent.toStringAsFixed(1)}%',
                        AppColors.chartInterest,
                        isDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    String value,
    String percent,
    Color color,
    bool isDark,
  ) {
    return Row(
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
        Expanded(
          child: Column(
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
                '$value ($percent)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Simple pie chart painter for quick visualization
class _SimplePieChartPainter extends CustomPainter {
  final double principalPercent;
  final double interestPercent;

  _SimplePieChartPainter({
    required this.principalPercent,
    required this.interestPercent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final principalPaint = Paint()
      ..color = AppColors.chartPrincipal
      ..style = PaintingStyle.fill;

    final interestPaint = Paint()
      ..color = AppColors.chartInterest
      ..style = PaintingStyle.fill;

    // Draw principal arc
    final principalSweep = (principalPercent / 100) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2, // Start from top
      principalSweep,
      true,
      principalPaint,
    );

    // Draw interest arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2 + principalSweep,
      (interestPercent / 100) * 2 * 3.14159,
      true,
      interestPaint,
    );

    // Draw center circle (donut effect)
    final centerPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
