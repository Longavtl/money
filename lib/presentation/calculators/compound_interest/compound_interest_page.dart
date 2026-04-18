import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/l10n/app_localizations.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';
import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/constants/app_constants.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/presentation/calculators/compound_interest/compound_interest_provider.dart';

/// Compound Interest Calculator Page with real-time calculations
class CompoundInterestPage extends ConsumerWidget {
  const CompoundInterestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(compoundInterestCalculatorProvider);
    final notifier = ref.read(compoundInterestCalculatorProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.calculatorCompoundInterest,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightTextPrimary,
          ),
        ),
        actions: [
          IconButton(
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
    );
  }

  Widget _buildInputCard(
    BuildContext context,
    CompoundInterestCalculatorState state,
    CompoundInterestCalculatorNotifier notifier,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Frequency selector
          Text(
            l10n.compoundingFrequency,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.lightTextSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          AppSegmentedControl(
            segments: [l10n.daily, l10n.monthly, l10n.quarterly, l10n.yearly],
            selectedIndex: _frequencyToIndex(state.inputs.frequency),
            onSegmentSelected: (index) =>
                notifier.updateFrequency(_indexToFrequency(index)),
          ),

          SizedBox(height: 20.h),

          // Principal slider
          AppSliderInput(
            label: l10n.principal,
            value: state.inputs.principal.clamp(0, CurrencyFormatter.defaultLoanMax),
            min: 0,
            max: CurrencyFormatter.defaultLoanMax,
            divisions: 1000,
            activeColor: AppColors.warning,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updatePrincipal,
          ),

          SizedBox(height: 8.h),

          // Rate slider
          AppSliderInput(
            label: l10n.annualRate,
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
          AppSliderInput(
            label: l10n.term,
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
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.calculationResults,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildResultRow(l10n.totalReceived, CurrencyFormatter.format(result.totalAmount), AppColors.success, true),
          SizedBox(height: 12.h),
          _buildResultRow(l10n.interestEarned, CurrencyFormatter.format(result.interest), AppColors.chartInterest, false),
          SizedBox(height: 12.h),
          _buildResultRow(l10n.effectiveAnnualRate, '${result.effectiveAnnualRate.toStringAsFixed(2)}%', null, false),
          SizedBox(height: 12.h),
          _buildResultRow(l10n.compoundingPeriods, '${(result.frequency.periodsPerYear * result.termMonths / 12).round()}', null, false),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value, Color? valueColor, bool isHighlighted) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isHighlighted
            ? (valueColor ?? AppColors.success).withOpacity(0.1)
            : AppColors.lightBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: isHighlighted ? Border.all(color: (valueColor ?? AppColors.success).withOpacity(0.3)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.lightTextSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(
    BuildContext context,
    CompoundInterestCalculatorState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    // Compare with simple interest
    final simpleInterest = state.inputs.principal *
        (state.inputs.annualRate / 100) *
        (state.inputs.termMonths / 12);
    final simpleTotal = state.inputs.principal + simpleInterest;
    final compoundTotal = state.result?.totalAmount ?? 0;
    final difference = compoundTotal - simpleTotal;

    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.compareWithSimple,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildComparisonRow(
            l10n.simpleInterest,
            CurrencyFormatter.formatShort(simpleTotal),
            AppColors.info,
          ),
          SizedBox(height: 8.h),
          _buildComparisonRow(
            l10n.compoundInterest,
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
                    l10n.compoundBenefit(CurrencyFormatter.formatShort(difference)),
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
                color: AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightTextPrimary,
          ),
        ),
      ],
    );
  }
}
