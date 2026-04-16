import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/presentation/comparison/comparison_provider.dart';
import 'package:money/presentation/premium/premium_provider.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';

class ComparisonPage extends ConsumerWidget {
  const ComparisonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumStatus = ref.watch(premiumStatusProvider);
    final state = ref.watch(comparisonProvider);
    final notifier = ref.read(comparisonProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppColors.lightTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Compare Scenarios', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary)),
      ),
      body: SafeArea(
        child: premiumStatus.isPremium ? _buildContent(context, state, notifier) : _buildPremiumRequired(context),
      ),
    );
  }

  Widget _buildPremiumRequired(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.lock_fill, size: 48.sp, color: AppColors.warning),
              SizedBox(height: 16.h),
              Text('Premium Required', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.lightTextPrimary)),
              SizedBox(height: 8.h),
              Text('Upgrade to compare scenarios', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, color: AppColors.lightTextSecondary)),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => context.push('/premium'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
                child: const Text('Upgrade', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ComparisonState state, ComparisonNotifier notifier) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildInputCard(context, state, notifier),
          SizedBox(height: 16.h),
          if (state.result.loanA != null) _buildComparisonResults(context, state),
        ],
      ),
    );
  }

  Widget _buildInputCard(BuildContext context, ComparisonState state, ComparisonNotifier notifier) {
    final inputs = state.loanInputs;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Loan Settings', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary)),
          SizedBox(height: 16.h),
          AppSegmentedControl(
            segments: const ['Fixed EMI', 'Reducing'],
            selectedIndex: inputs.type == LoanType.fixedPayment ? 0 : 1,
            onSegmentSelected: (i) => notifier.updateLoanType(i == 0 ? LoanType.fixedPayment : LoanType.reducingBalance),
          ),
          SizedBox(height: 16.h),
          AppSliderInput(
            label: 'Amount',
            value: inputs.principal,
            min: 1000000,
            max: 10000000000,
            divisions: 1000,
            activeColor: AppColors.primary,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updatePrincipal,
          ),
          SizedBox(height: 16.h),
          AppSliderInput(
            label: 'Term',
            value: inputs.termMonths.toDouble(),
            min: 1,
            max: 360,
            divisions: 359,
            activeColor: AppColors.primary,
            valueFormatter: (v) => CurrencyFormatter.formatTerm(v.toInt()),
            onChanged: (v) => notifier.updateTermMonths(v.toInt()),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scenario A', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    SizedBox(height: 8.h),
                    AppSliderInput(
                      label: 'Interest Rate',
                      value: inputs.rateA,
                      min: 0.1,
                      max: 50,
                      divisions: 499,
                      activeColor: AppColors.primary,
                      valueFormatter: (v) => '${v.toStringAsFixed(1)}%',
                      onChanged: notifier.updateRateA,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scenario B', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.info)),
                    SizedBox(height: 8.h),
                    AppSliderInput(
                      label: 'Interest Rate',
                      value: inputs.rateB,
                      min: 0.1,
                      max: 50,
                      divisions: 499,
                      activeColor: AppColors.info,
                      valueFormatter: (v) => '${v.toStringAsFixed(1)}%',
                      onChanged: notifier.updateRateB,
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

  Widget _buildComparisonResults(BuildContext context, ComparisonState state) {
    final loanA = state.result.loanA!;
    final loanB = state.result.loanB!;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Comparison', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary)),
          SizedBox(height: 16.h),
          _buildComparisonRow('Monthly Payment', CurrencyFormatter.format(loanA.monthlyPayment), CurrencyFormatter.format(loanB.monthlyPayment), loanA.monthlyPayment < loanB.monthlyPayment),
          _buildComparisonRow('Total Interest', CurrencyFormatter.formatShort(loanA.totalInterest), CurrencyFormatter.formatShort(loanB.totalInterest), loanA.totalInterest < loanB.totalInterest),
          _buildComparisonRow('Total Payment', CurrencyFormatter.formatShort(loanA.totalPayment), CurrencyFormatter.formatShort(loanB.totalPayment), loanA.totalPayment < loanB.totalPayment),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
            child: Row(
              children: [
                Icon(CupertinoIcons.checkmark_circle_fill, color: AppColors.success, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Scenario ${state.result.betterLoanScenario} saves ${CurrencyFormatter.formatShort(state.result.loanPaymentDifference.abs())}',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.success),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String valueA, String valueB, bool aIsBetter) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12.sp, color: AppColors.lightTextSecondary)),
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: aIsBetter ? AppColors.success.withOpacity(0.1) : AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(8.r),
                    border: aIsBetter ? Border.all(color: AppColors.success.withOpacity(0.3)) : null,
                  ),
                  child: Column(
                    children: [
                      Text('A', style: TextStyle(fontSize: 10.sp, color: AppColors.primary)),
                      Text(valueA, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: aIsBetter ? AppColors.success : AppColors.lightTextPrimary)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: !aIsBetter ? AppColors.success.withOpacity(0.1) : AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(8.r),
                    border: !aIsBetter ? Border.all(color: AppColors.success.withOpacity(0.3)) : null,
                  ),
                  child: Column(
                    children: [
                      Text('B', style: TextStyle(fontSize: 10.sp, color: AppColors.info)),
                      Text(valueB, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: !aIsBetter ? AppColors.success : AppColors.lightTextPrimary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
