import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';
import 'package:money_mate/presentation/comparison/comparison_provider.dart';
import 'package:money_mate/presentation/calculators/common/widgets/glass_slider_input.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';

/// Comparison page for comparing loan scenarios
class ComparisonPage extends ConsumerWidget {
  const ComparisonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumStatus = ref.watch(premiumStatusProvider);
    final state = ref.watch(comparisonProvider);
    final notifier = ref.read(comparisonProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              // App Bar
              _buildAppBar(context, isDark),

              // Content
              Expanded(
                child: premiumStatus.isPremium
                    ? _buildContent(context, state, notifier, isDark)
                    : _buildPremiumRequired(context, isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GlassButton(
            icon: Icon(CupertinoIcons.back, size: 20.sp),
            onTap: () => context.pop(),
            width: 44.w,
            height: 44.w,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'So sánh kịch bản',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumRequired(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: GlassCard(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.lock_fill,
                  size: 64.sp,
                  color: AppColors.warning,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Tính năng Premium',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Nâng cấp Premium để so sánh nhiều kịch bản vay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () => context.push('/premium'),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.warning,
                          AppColors.warning.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Nâng cấp ngay',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ComparisonState state,
    ComparisonNotifier notifier,
    bool isDark,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Inputs section
          _buildInputsSection(state, notifier, isDark),

          SizedBox(height: 24.h),

          // Comparison results
          if (state.result.loanA != null && state.result.loanB != null)
            _buildComparisonResults(state, isDark),

          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildInputsSection(
    ComparisonState state,
    ComparisonNotifier notifier,
    bool isDark,
  ) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông số chung',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),

            // Principal
            GlassSliderInput(
              label: 'Số tiền vay',
              value: state.loanInputs.principal,
              min: 50000000,
              max: 10000000000,
              divisions: 199,
              valueFormatter: (v) => CurrencyFormatter.formatShort(v),
              onChanged: notifier.updatePrincipal,
            ),

            SizedBox(height: 16.h),

            // Term
            GlassSliderInput(
              label: 'Kỳ hạn',
              value: state.loanInputs.termMonths.toDouble(),
              min: 12,
              max: 360,
              divisions: 29,
              valueFormatter: (v) => '${v.toInt()} tháng',
              onChanged: (v) => notifier.updateTermMonths(v.toInt()),
            ),

            SizedBox(height: 16.h),

            // Loan type selector
            Row(
              children: [
                Text(
                  'Phương thức trả',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                const Spacer(),
                GlassSegmentedControl(
                  segments: const ['Trả góp đều', 'Dư nợ giảm dần'],
                  selectedIndex:
                      state.loanInputs.type == LoanType.fixedPayment ? 0 : 1,
                  onSegmentSelected: (index) {
                    notifier.updateLoanType(index == 0
                        ? LoanType.fixedPayment
                        : LoanType.reducingBalance);
                  },
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Rate inputs side by side
            Row(
              children: [
                Expanded(
                  child: _buildRateInput(
                    label: 'Lãi suất A',
                    color: AppColors.scenarioA,
                    value: state.loanInputs.rateA,
                    onChanged: notifier.updateRateA,
                    isDark: isDark,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildRateInput(
                    label: 'Lãi suất B',
                    color: AppColors.scenarioB,
                    value: state.loanInputs.rateB,
                    onChanged: notifier.updateRateB,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRateInput({
    required String label,
    required Color color,
    required double value,
    required ValueChanged<double> onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        GlassSlider(
          value: value,
          min: 1.0,
          max: 25.0,
          onChanged: onChanged,
        ),
        SizedBox(height: 4.h),
        Text(
          '${value.toStringAsFixed(1)}%/năm',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonResults(ComparisonState state, bool isDark) {
    final loanA = state.result.loanA!;
    final loanB = state.result.loanB!;
    final difference = state.result;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kết quả so sánh',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 16.h),

        // Side by side comparison cards
        Row(
          children: [
            Expanded(
              child: _buildScenarioCard(
                label: 'Kịch bản A',
                color: AppColors.scenarioA,
                rate: state.loanInputs.rateA,
                loan: loanA,
                isDark: isDark,
                isWinner: difference.betterLoanScenario == 'A',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildScenarioCard(
                label: 'Kịch bản B',
                color: AppColors.scenarioB,
                rate: state.loanInputs.rateB,
                loan: loanB,
                isDark: isDark,
                isWinner: difference.betterLoanScenario == 'B',
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Difference summary
        _buildDifferenceSummary(difference, isDark),
      ],
    );
  }

  Widget _buildScenarioCard({
    required String label,
    required Color color,
    required double rate,
    required LoanResult loan,
    required bool isDark,
    required bool isWinner,
  }) {
    return GlassCard(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: isWinner
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.5),
                  width: 2,
                ),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                if (isWinner) ...[
                  const Spacer(),
                  Icon(
                    CupertinoIcons.checkmark_circle_fill,
                    size: 16.sp,
                    color: AppColors.success,
                  ),
                ],
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              '${rate.toStringAsFixed(1)}%/năm',
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark ? Colors.white60 : Colors.black45,
              ),
            ),
            SizedBox(height: 16.h),

            _buildCompactStat(
              'Trả hàng tháng',
              CurrencyFormatter.formatShort(loan.monthlyPayment),
              isDark,
            ),
            SizedBox(height: 8.h),
            _buildCompactStat(
              'Tổng lãi',
              CurrencyFormatter.formatShort(loan.totalInterest),
              isDark,
            ),
            SizedBox(height: 8.h),
            _buildCompactStat(
              'Tổng trả',
              CurrencyFormatter.formatShort(loan.totalPayment),
              isDark,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactStat(String label, String value, bool isDark,
      {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: isDark ? Colors.white60 : Colors.black45,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDifferenceSummary(ComparisonResult difference, bool isDark) {
    final savesMore = difference.betterLoanScenario;
    final saving = difference.loanInterestDifference.abs();

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  CupertinoIcons.lightbulb_fill,
                  size: 24.sp,
                  color: AppColors.warning,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    savesMore == 'Equal'
                        ? 'Hai kịch bản có tổng trả bằng nhau'
                        : 'Kịch bản $savesMore tiết kiệm hơn',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            if (savesMore != 'Equal') ...[
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _buildDifferenceItem(
                      'Tiết kiệm lãi',
                      CurrencyFormatter.formatShort(saving),
                      AppColors.success,
                      isDark,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildDifferenceItem(
                      'Tiết kiệm/tháng',
                      CurrencyFormatter.formatShort(
                          difference.loanMonthlyDifference.abs()),
                      AppColors.primary,
                      isDark,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDifferenceItem(
      String label, String value, Color color, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? Colors.white60 : Colors.black45,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
