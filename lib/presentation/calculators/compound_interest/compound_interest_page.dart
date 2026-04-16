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
import 'package:money_mate/presentation/calculators/compound_interest/compound_interest_provider.dart';

/// Compound Interest Calculator Page with real-time calculations
class CompoundInterestPage extends ConsumerWidget {
  const CompoundInterestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(compoundInterestCalculatorProvider);
    final notifier = ref.read(compoundInterestCalculatorProvider.notifier);

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
                  'Lãi kép',
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
                        _buildComparisonCard(context, state, isDark),
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
    CompoundInterestCalculatorState state,
    CompoundInterestCalculatorNotifier notifier,
    bool isDark,
  ) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Frequency selector
            Text(
              'Chu kỳ ghép lãi',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : AppColors.lightTextSecondary,
              ),
            ),
            SizedBox(height: 8.h),
            GlassSegmentedControl(
              segments: const ['Ngày', 'Tháng', 'Quý', 'Năm'],
              selectedIndex: _frequencyToIndex(state.inputs.frequency),
              onSegmentSelected: (index) {
                notifier.updateFrequency(_indexToFrequency(index));
              },
            ),

            SizedBox(height: 20.h),

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
    CompoundInterestResult result,
    bool isDark,
  ) {
    final returnPercent =
        (result.interest / result.principal * 100).toStringAsFixed(1);

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
        label: 'Tỷ suất sinh lời',
        value: '$returnPercent%',
      ),
      ResultItem(
        label: 'Chu kỳ ghép lãi',
        value: _getFrequencyLabel(result.frequency),
      ),
    ];

    return ResultCard(
      title: 'Kết quả tính toán',
      items: items,
    );
  }

  Widget _buildComparisonCard(
    BuildContext context,
    CompoundInterestCalculatorState state,
    bool isDark,
  ) {
    // Compare with simple interest
    final simpleInterest = state.inputs.principal *
        (state.inputs.annualRate / 100) *
        (state.inputs.termMonths / 12);
    final compoundInterest = state.result?.interest ?? 0;
    final advantage = compoundInterest - simpleInterest;

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'So sánh với lãi đơn',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            // Simple interest
            _buildComparisonRow(
              context,
              'Lãi đơn',
              simpleInterest,
              AppColors.chartInterest.withValues(alpha: 0.6),
              isDark,
            ),
            SizedBox(height: 8.h),

            // Compound interest
            _buildComparisonRow(
              context,
              'Lãi kép',
              compoundInterest,
              AppColors.success,
              isDark,
            ),

            SizedBox(height: 16.h),

            // Advantage
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.arrow_up_circle_fill,
                        color: AppColors.success,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Lợi ích lãi kép',
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
                    '+${CurrencyFormatter.formatShort(advantage)}',
                    style: TextStyle(
                      fontSize: 16.sp,
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

  Widget _buildComparisonRow(
    BuildContext context,
    String label,
    double value,
    Color color,
    bool isDark,
  ) {
    return Row(
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
                fontSize: 14.sp,
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
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
      ],
    );
  }

  String _getFrequencyLabel(CompoundingFrequency frequency) {
    switch (frequency) {
      case CompoundingFrequency.daily:
        return 'Hàng ngày';
      case CompoundingFrequency.monthly:
        return 'Hàng tháng';
      case CompoundingFrequency.quarterly:
        return 'Hàng quý';
      case CompoundingFrequency.annually:
        return 'Hàng năm';
      default:
        return 'Hàng tháng';
    }
  }

  int _frequencyToIndex(CompoundingFrequency frequency) {
    switch (frequency) {
      case CompoundingFrequency.daily:
        return 0;
      case CompoundingFrequency.monthly:
        return 1;
      case CompoundingFrequency.quarterly:
        return 2;
      case CompoundingFrequency.annually:
        return 3;
      default:
        return 1;
    }
  }

  CompoundingFrequency _indexToFrequency(int index) {
    switch (index) {
      case 0:
        return CompoundingFrequency.daily;
      case 1:
        return CompoundingFrequency.monthly;
      case 2:
        return CompoundingFrequency.quarterly;
      case 3:
        return CompoundingFrequency.annually;
      default:
        return CompoundingFrequency.monthly;
    }
  }
}
