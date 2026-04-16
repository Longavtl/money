import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/constants/glass_settings.dart';
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
    final state = ref.watch(compoundInterestCalculatorProvider);
    final notifier = ref.read(compoundInterestCalculatorProvider.notifier);

    return LiquidGlassScope.stack(
      background: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper_dark.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      content: Positioned.fill(
        child: AdaptiveLiquidGlassLayer(
          settings: RecommendedGlassSettings.standard,
          quality: GlassQuality.standard,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: GlassAppBar(
              leading: GlassIconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () => context.pop(),
              ),
              title: Text(
                'Lãi kép',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              actions: [
                GlassIconButton(
                  icon: const Icon(CupertinoIcons.arrow_counterclockwise),
                  onPressed: () => notifier.reset(),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // Input card
                    _buildInputCard(context, state, notifier),

                    SizedBox(height: 16.h),

                    // Results
                    if (state.hasResult) ...[
                      _buildResultsCard(context, state.result!),
                      SizedBox(height: 16.h),
                      _buildComparisonCard(context, state),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(
    BuildContext context,
    CompoundInterestCalculatorState state,
    CompoundInterestCalculatorNotifier notifier,
  ) {
    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Frequency selector
          Text(
            'Chu kỳ ghép lãi',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 8.h),
          GlassSegmentedControl(
            segments: const ['Ngày', 'Tháng', 'Quý', 'Năm'],
            selectedIndex: _frequencyToIndex(state.inputs.frequency),
            onSegmentSelected: (index) =>
                notifier.updateFrequency(_indexToFrequency(index)),
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
    );
  }

  int _frequencyToIndex(CompoundingFrequency frequency) {
    switch (frequency) {
      case CompoundingFrequency.daily:
        return 0;
      case CompoundingFrequency.weekly:
      case CompoundingFrequency.monthly:
        return 1;
      case CompoundingFrequency.quarterly:
        return 2;
      case CompoundingFrequency.semiAnnually:
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
          value: '${(result.frequency.periodsPerYear * result.termMonths / 12).round()}',
        ),
      ],
    );
  }

  Widget _buildComparisonCard(
    BuildContext context,
    CompoundInterestCalculatorState state,
  ) {
    // Compare with simple interest
    final simpleInterest = state.inputs.principal *
        (state.inputs.annualRate / 100) *
        (state.inputs.termMonths / 12);
    final simpleTotal = state.inputs.principal + simpleInterest;
    final compoundTotal = state.result?.totalAmount ?? 0;
    final difference = compoundTotal - simpleTotal;

    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'So sánh với Lãi đơn',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildComparisonRow(
            'Lãi đơn',
            CurrencyFormatter.formatShort(simpleTotal),
            AppColors.info,
          ),
          SizedBox(height: 8.h),
          _buildComparisonRow(
            'Lãi kép',
            CurrencyFormatter.formatShort(compoundTotal),
            AppColors.success,
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.2),
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
    );
  }

  Widget _buildComparisonRow(
    String label,
    String value,
    Color color,
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
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
