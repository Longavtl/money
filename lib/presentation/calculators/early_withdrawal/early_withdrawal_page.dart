import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/l10n/app_localizations.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';
import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/presentation/calculators/early_withdrawal/early_withdrawal_provider.dart';

/// Early Withdrawal Calculator Page
class EarlyWithdrawalPage extends ConsumerWidget {
  const EarlyWithdrawalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(earlyWithdrawalCalculatorProvider);
    final notifier = ref.read(earlyWithdrawalCalculatorProvider.notifier);
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
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.earlyWithdrawal,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.arrow_counterclockwise,
                color: textSecondary),
            onPressed: () => notifier.reset(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              _buildInputCard(context, state, notifier),
              SizedBox(height: 16.h),
              if (state.hasResult) ...[
                _buildResultsCard(context, state.result!),
                SizedBox(height: 16.h),
                _buildComparisonCard(context, state.result!),
                SizedBox(height: 16.h),
                _buildWarningCard(context, state.result!),
              ],
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(
    BuildContext context,
    EarlyWithdrawalCalculatorState state,
    EarlyWithdrawalCalculatorNotifier notifier,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Deposit amount
          AppSliderInput(
            label: l10n.depositAmount,
            value: state.inputs.principal
                .clamp(0, CurrencyFormatter.defaultLoanMax),
            min: 0,
            max: CurrencyFormatter.defaultLoanMax,
            divisions: 1000,
            activeColor: AppColors.warning,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updatePrincipal,
          ),

          SizedBox(height: 16.h),

          // Original term deposit rate
          AppSliderInput(
            label: l10n.termDepositRate,
            value: state.inputs.originalRate,
            min: 0.5,
            max: 15.0,
            divisions: 290,
            activeColor: AppColors.success,
            valueFormatter: (v) => CurrencyFormatter.formatPercent(v),
            onChanged: notifier.updateOriginalRate,
          ),

          SizedBox(height: 16.h),

          // Demand deposit rate (early withdrawal rate)
          AppSliderInput(
            label: l10n.demandDepositRate,
            value: state.inputs.earlyRate,
            min: 0.1,
            max: 2.0,
            divisions: 38,
            activeColor: AppColors.danger,
            valueFormatter: (v) => CurrencyFormatter.formatPercent(v),
            onChanged: notifier.updateEarlyRate,
          ),

          SizedBox(height: 16.h),

          // Original term
          AppSliderInput(
            label: l10n.originalTerm,
            value: state.inputs.originalTermMonths.toDouble(),
            min: 1,
            max: 36,
            divisions: 35,
            activeColor: AppColors.info,
            valueFormatter: (v) => CurrencyFormatter.formatTerm(v.toInt()),
            onChanged: (v) => notifier.updateOriginalTerm(v.toInt()),
          ),

          SizedBox(height: 16.h),

          // Actual holding period
          AppSliderInput(
            label: l10n.actualHoldingPeriod,
            value: state.inputs.actualHoldingMonths.toDouble(),
            min: 1,
            max: state.inputs.originalTermMonths.toDouble(),
            divisions: state.inputs.originalTermMonths - 1 > 0
                ? state.inputs.originalTermMonths - 1
                : 1,
            activeColor: AppColors.primary,
            valueFormatter: (v) => CurrencyFormatter.formatTerm(v.toInt()),
            onChanged: (v) => notifier.updateActualHolding(v.toInt()),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsCard(
      BuildContext context, EarlyWithdrawalResult result) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.withdrawalResult,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _ResultRow(
            label: l10n.amountReceived,
            value: CurrencyFormatter.format(result.finalAmount),
            valueColor: AppColors.success,
            isHighlighted: true,
          ),
          _ResultRow(
            label: l10n.actualInterestReceived,
            value: CurrencyFormatter.format(result.actualInterest),
            valueColor: AppColors.info,
          ),
          _ResultRow(
            label: l10n.interestLost,
            value: '-${CurrencyFormatter.format(result.interestLoss)}',
            valueColor: AppColors.danger,
          ),
          _ResultRow(
            label: l10n.lossPercentage,
            value: '${result.lossPercentage.toStringAsFixed(1)}%',
            valueColor: AppColors.danger,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(
      BuildContext context, EarlyWithdrawalResult result) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardBg = isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.comparison,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              // If held to maturity
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.checkmark_circle_fill,
                        color: AppColors.success,
                        size: 24.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.ifHeldToMaturity,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        CurrencyFormatter.formatShort(
                            result.principal + result.expectedInterest),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                      Text(
                        '+${CurrencyFormatter.formatShort(result.expectedInterest)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Early withdrawal
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.danger.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: AppColors.danger,
                        size: 24.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.earlyWithdrawal,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        CurrencyFormatter.formatShort(result.finalAmount),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.danger,
                        ),
                      ),
                      Text(
                        '+${CurrencyFormatter.formatShort(result.actualInterest)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.danger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Difference
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.arrow_down,
                  color: AppColors.danger,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  l10n.youWillLose,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: textSecondary,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  CurrencyFormatter.format(result.interestLoss),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.danger,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(
      BuildContext context, EarlyWithdrawalResult result) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.exclamationmark_triangle_fill,
            color: AppColors.warning,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.earlyWithdrawalWarning,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  l10n.earlyWithdrawalWarningDesc,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.warning,
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

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isHighlighted;

  const _ResultRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlighted ? 18.sp : 15.sp,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
              color: valueColor ?? textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
