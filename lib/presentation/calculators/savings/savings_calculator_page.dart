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
import 'package:money_mate/presentation/calculators/savings/savings_provider.dart';

/// Savings Calculator Page with real-time calculations
class SavingsCalculatorPage extends ConsumerWidget {
  const SavingsCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(savingsCalculatorProvider);
    final notifier = ref.read(savingsCalculatorProvider.notifier);

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
                  'Gửi tiết kiệm',
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
                        _buildBreakdownCard(context, state.result!, isDark),
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
    SavingsCalculatorState state,
    SavingsCalculatorNotifier notifier,
    bool isDark,
  ) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type selector
            Text(
              'Hình thức tiết kiệm',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : AppColors.lightTextSecondary,
              ),
            ),
            SizedBox(height: 8.h),
            GlassSegmentedControl(
              segments: const ['Tái đầu tư', 'Lĩnh lãi'],
              selectedIndex:
                  state.inputs.type == SavingsType.withReinvestment ? 0 : 1,
              onSegmentSelected: (index) {
                notifier.updateType(
                  index == 0
                      ? SavingsType.withReinvestment
                      : SavingsType.withoutReinvestment,
                );
              },
            ),

            SizedBox(height: 20.h),

            // Initial deposit slider
            GlassSliderInput(
              label: 'Tiền gửi ban đầu',
              value: state.inputs.initialDeposit,
              min: 0,
              max: 10000000000, // 10 billion
              divisions: 1000,
              activeColor: AppColors.warning,
              valueFormatter: (v) => CurrencyFormatter.formatShort(v),
              onChanged: notifier.updateInitialDeposit,
            ),

            SizedBox(height: 8.h),

            // Monthly deposit slider
            GlassSliderInput(
              label: 'Gửi thêm hàng tháng',
              value: state.inputs.monthlyDeposit,
              min: 0,
              max: 500000000, // 500 million
              divisions: 500,
              activeColor: AppColors.primary,
              valueFormatter: (v) => CurrencyFormatter.formatShort(v),
              onChanged: notifier.updateMonthlyDeposit,
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
    SavingsResult result,
    bool isDark,
  ) {
    final items = <ResultItem>[
      ResultItem(
        label: result.type == SavingsType.withReinvestment
            ? 'Số dư cuối kỳ'
            : 'Tổng tiền gửi',
        value: CurrencyFormatter.format(result.finalValue),
        isHighlighted: true,
        valueColor: AppColors.success,
      ),
      ResultItem(
        label: 'Tiền lãi nhận được',
        value: CurrencyFormatter.format(result.totalInterest),
        color: AppColors.chartInterest,
      ),
      ResultItem(
        label: 'Tổng đã gửi',
        value: CurrencyFormatter.format(result.totalDeposited),
        color: AppColors.chartPrincipal,
      ),
      ResultItem(
        label: 'Tỷ suất sinh lời',
        value: '${result.returnPercentage.toStringAsFixed(1)}%',
      ),
    ];

    // Add monthly interest payout for non-reinvestment
    if (result.type == SavingsType.withoutReinvestment &&
        result.monthlyInterestPayouts.isNotEmpty) {
      final avgMonthlyPayout = result.monthlyInterestPayouts
              .reduce((a, b) => a + b) /
          result.monthlyInterestPayouts.length;
      items.add(
        ResultItem(
          label: 'Lãi bình quân/tháng',
          value: CurrencyFormatter.format(avgMonthlyPayout),
        ),
      );
    }

    return ResultCard(
      title: 'Kết quả tính toán',
      items: items,
    );
  }

  Widget _buildBreakdownCard(
    BuildContext context,
    SavingsResult result,
    bool isDark,
  ) {
    final totalValue = result.type == SavingsType.withReinvestment
        ? result.finalValue
        : result.totalDeposited + result.totalInterest;

    final depositedPercent = (result.totalDeposited / totalValue * 100);
    final interestPercent = (result.totalInterest / totalValue * 100);

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phân tích chi tiết',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            // Stacked bar
            _buildStackedBar(
              context,
              depositedPercent,
              interestPercent,
              isDark,
            ),

            SizedBox(height: 16.h),

            // Legend
            _buildLegendItem(
              context,
              'Tiền gửi vào',
              result.totalDeposited,
              depositedPercent,
              AppColors.chartPrincipal,
              isDark,
            ),
            SizedBox(height: 8.h),
            _buildLegendItem(
              context,
              'Tiền lãi',
              result.totalInterest,
              interestPercent,
              AppColors.chartInterest,
              isDark,
            ),

            SizedBox(height: 16.h),

            // Highlight box
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    result.type == SavingsType.withReinvestment
                        ? CupertinoIcons.arrow_2_circlepath
                        : CupertinoIcons.money_dollar,
                    color: AppColors.info,
                    size: 20.sp,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      result.type == SavingsType.withReinvestment
                          ? 'Lãi được cộng dồn vào gốc mỗi tháng'
                          : 'Lãi được trả ra mỗi tháng, không cộng vào gốc',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.7)
                            : AppColors.lightTextSecondary,
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

  Widget _buildStackedBar(
    BuildContext context,
    double depositedPercent,
    double interestPercent,
    bool isDark,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: SizedBox(
        height: 24.h,
        child: Row(
          children: [
            Expanded(
              flex: (depositedPercent * 10).round(),
              child: Container(
                color: AppColors.chartPrincipal,
                alignment: Alignment.center,
                child: depositedPercent > 15
                    ? Text(
                        '${depositedPercent.toStringAsFixed(0)}%',
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
              flex: (interestPercent * 10).round().clamp(1, 1000),
              child: Container(
                color: AppColors.chartInterest,
                alignment: Alignment.center,
                child: interestPercent > 15
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
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    double value,
    double percent,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                '${CurrencyFormatter.formatShort(value)} (${percent.toStringAsFixed(1)}%)',
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
