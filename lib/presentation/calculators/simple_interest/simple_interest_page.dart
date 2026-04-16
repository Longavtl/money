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
import 'package:money_mate/presentation/calculators/simple_interest/simple_interest_provider.dart';

/// Simple Interest Calculator Page with real-time calculations
class SimpleInterestPage extends ConsumerWidget {
  const SimpleInterestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(simpleInterestCalculatorProvider);
    final notifier = ref.read(simpleInterestCalculatorProvider.notifier);

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
                  'Lãi đơn',
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
                        _buildGrowthVisualization(
                            context, state.result!, isDark),
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
    SimpleInterestCalculatorState state,
    SimpleInterestCalculatorNotifier notifier,
    bool isDark,
  ) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Principal slider
            GlassSliderInput(
              label: 'Số tiền gốc',
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
              label: 'Thời hạn',
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
    SimpleInterestResult result,
    bool isDark,
  ) {
    final items = <ResultItem>[
      ResultItem(
        label: 'Tiền lãi',
        value: CurrencyFormatter.format(result.interest),
        isHighlighted: true,
        valueColor: AppColors.success,
      ),
      ResultItem(
        label: 'Tổng nhận được',
        value: CurrencyFormatter.format(result.totalAmount),
        color: AppColors.primary,
      ),
      ResultItem(
        label: 'Lãi suất tháng',
        value: CurrencyFormatter.formatPercent(result.rate / 12),
      ),
      ResultItem(
        label: 'Lãi mỗi tháng',
        value: CurrencyFormatter.format(result.interest / result.termMonths),
      ),
    ];

    return ResultCard(
      title: 'Kết quả tính toán',
      items: items,
    );
  }

  Widget _buildGrowthVisualization(
    BuildContext context,
    SimpleInterestResult result,
    bool isDark,
  ) {
    final principalPercent = (result.principal / result.totalAmount * 100);
    final interestPercent = (result.interest / result.totalAmount * 100);

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cơ cấu số tiền',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            // Progress bar visualization
            _buildProgressBar(
              context,
              'Tiền gốc',
              result.principal,
              principalPercent,
              AppColors.chartPrincipal,
              isDark,
            ),
            SizedBox(height: 12.h),
            _buildProgressBar(
              context,
              'Tiền lãi',
              result.interest,
              interestPercent,
              AppColors.chartInterest,
              isDark,
            ),

            SizedBox(height: 16.h),

            // Summary
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tỷ lệ sinh lời',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  Text(
                    '${interestPercent.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context,
    String label,
    double value,
    double percent,
    Color color,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.7)
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
            Text(
              CurrencyFormatter.formatShort(value),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }
}
