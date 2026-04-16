import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';
import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/constants/app_constants.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/presentation/calculators/simple_interest/simple_interest_provider.dart';

/// Simple Interest Calculator Page with real-time calculations
class SimpleInterestPage extends ConsumerWidget {
  const SimpleInterestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(simpleInterestCalculatorProvider);
    final notifier = ref.read(simpleInterestCalculatorProvider.notifier);

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
          'Lãi đơn',
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
                _buildGrowthVisualization(context, state.result!),
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
  ) {
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Principal slider
          AppSliderInput(
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
          AppSliderInput(
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
          AppSliderInput(
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

  Widget _buildResultsCard(
    BuildContext context,
    SimpleInterestResult result,
  ) {
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kết quả tính toán',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildResultRow('Tiền lãi', CurrencyFormatter.format(result.interest), AppColors.success, true),
          SizedBox(height: 12.h),
          _buildResultRow('Tổng tiền nhận', CurrencyFormatter.format(result.totalAmount), AppColors.primary, false),
          SizedBox(height: 12.h),
          _buildResultRow('Lãi trung bình/tháng', CurrencyFormatter.format(result.monthlyInterest), null, false),
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

  Widget _buildGrowthVisualization(
    BuildContext context,
    SimpleInterestResult result,
  ) {
    final principalPercent = (result.principal / result.totalAmount * 100);
    final interestPercent = (result.interest / result.totalAmount * 100);

    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cơ cấu tổng tiền',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
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
              ),
              SizedBox(width: 16.w),
              _buildLegendItem(
                'Tiền lãi',
                CurrencyFormatter.formatShort(result.interest),
                AppColors.chartInterest,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    String label,
    String value,
    Color color,
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
                    color: AppColors.lightTextSecondary,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightTextPrimary,
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
