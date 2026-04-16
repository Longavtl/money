import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
      backgroundColor: isDark ? const Color(0xFF1a1a2e) : const Color(0xFFe8f4f8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
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
          IconButton(
            icon: Icon(
              CupertinoIcons.arrow_counterclockwise,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
            onPressed: () => notifier.reset(),
          ),
        ],
      ),
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
                _buildGrowthVisualization(context, state.result!, isDark),
              ],
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
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.grey.withValues(alpha: 0.3),
        ),
      ),
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
    return ResultCard(
      title: 'Kết quả tính toán',
      items: [
        ResultItem(
          label: 'Tiền lãi',
          value: CurrencyFormatter.format(result.interest),
          isHighlighted: true,
          valueColor: AppColors.success,
        ),
        ResultItem(
          label: 'Tổng tiền nhận',
          value: CurrencyFormatter.format(result.totalAmount),
          color: AppColors.primary,
        ),
        ResultItem(
          label: 'Lãi trung bình/tháng',
          value: CurrencyFormatter.format(result.monthlyInterest),
        ),
      ],
    );
  }

  Widget _buildGrowthVisualization(
    BuildContext context,
    SimpleInterestResult result,
    bool isDark,
  ) {
    final principalPercent = (result.principal / result.totalAmount * 100);
    final interestPercent = (result.interest / result.totalAmount * 100);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cơ cấu tổng tiền',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            // Progress bar visualization
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                height: 24.h,
                child: Row(
                  children: [
                    Expanded(
                      flex: principalPercent.round(),
                      child: Container(
                        color: AppColors.chartPrincipal,
                        alignment: Alignment.center,
                        child: principalPercent > 20
                            ? Text(
                                '${principalPercent.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ),
                    Expanded(
                      flex: interestPercent.round().clamp(1, 100),
                      child: Container(
                        color: AppColors.chartInterest,
                        alignment: Alignment.center,
                        child: interestPercent > 20
                            ? Text(
                                '${interestPercent.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Legend
            Row(
              children: [
                _buildLegendItem(
                  'Tiền gốc',
                  CurrencyFormatter.formatShort(result.principal),
                  AppColors.chartPrincipal,
                  isDark,
                ),
                SizedBox(width: 16.w),
                _buildLegendItem(
                  'Tiền lãi',
                  CurrencyFormatter.formatShort(result.interest),
                  AppColors.chartInterest,
                  isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    String label,
    String value,
    Color color,
    bool isDark,
  ) {
    return Expanded(
      child: Row(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
