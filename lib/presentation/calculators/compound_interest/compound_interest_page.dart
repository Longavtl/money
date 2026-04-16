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
          'Lãi kép',
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
                _buildComparisonCard(context, state, isDark),
              ],
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
            _buildFrequencySelector(state, notifier, isDark),

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

  Widget _buildFrequencySelector(
    CompoundInterestCalculatorState state,
    CompoundInterestCalculatorNotifier notifier,
    bool isDark,
  ) {
    final frequencies = ['Ngày', 'Tháng', 'Quý', 'Năm'];
    final selectedIndex = _frequencyToIndex(state.inputs.frequency);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: List.generate(frequencies.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => notifier.updateFrequency(_indexToFrequency(index)),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    frequencies[index],
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black54),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
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

  Widget _buildResultsCard(
    BuildContext context,
    CompoundInterestResult result,
    bool isDark,
  ) {
    return ResultCard(
      title: 'Kết quả tính toán',
      items: [
        ResultItem(
          label: 'Tổng tiền nhận',
          value: CurrencyFormatter.format(result.totalAmount),
          isHighlighted: true,
          valueColor: AppColors.success,
        ),
        ResultItem(
          label: 'Tiền lãi',
          value: CurrencyFormatter.format(result.interest),
          color: AppColors.chartInterest,
        ),
        ResultItem(
          label: 'Lãi suất thực/năm',
          value: '${result.effectiveAnnualRate.toStringAsFixed(2)}%',
        ),
        ResultItem(
          label: 'Số lần ghép lãi',
          value: '${result.compoundingPeriods}',
        ),
      ],
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
    final simpleTotal = state.inputs.principal + simpleInterest;
    final compoundTotal = state.result?.totalAmount ?? 0;
    final difference = compoundTotal - simpleTotal;

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
              'So sánh với Lãi đơn',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            _buildComparisonRow(
              'Lãi đơn',
              CurrencyFormatter.formatShort(simpleTotal),
              AppColors.info,
              isDark,
            ),
            SizedBox(height: 8.h),
            _buildComparisonRow(
              'Lãi kép',
              CurrencyFormatter.formatShort(compoundTotal),
              AppColors.success,
              isDark,
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.arrow_up_circle_fill,
                    color: AppColors.success,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Lãi kép giúp bạn nhận thêm ${CurrencyFormatter.formatShort(difference)}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.success,
                      ),
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
    String label,
    String value,
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
                color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
      ],
    );
  }
}
