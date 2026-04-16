import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/providers/dependency_providers.dart';
import 'package:money_mate/core/services/pdf_export_service.dart';
import 'package:money_mate/core/services/premium_service.dart';
import 'package:money_mate/core/services/share_service.dart';
import 'package:money_mate/core/storage/local_storage_service.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';
import 'package:money_mate/presentation/calculators/common/widgets/glass_slider_input.dart';
import 'package:money_mate/presentation/calculators/common/widgets/result_card.dart';
import 'package:money_mate/presentation/calculators/savings/savings_provider.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';

/// Savings Calculator Page with real-time calculations
class SavingsCalculatorPage extends ConsumerWidget {
  const SavingsCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(savingsCalculatorProvider);
    final notifier = ref.read(savingsCalculatorProvider.notifier);
    final premiumStatus = ref.watch(premiumStatusProvider);
    final storage = ref.watch(localStorageProvider);

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
          'Gửi tiết kiệm',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
        actions: [
          // Save button
          if (state.hasResult)
            IconButton(
              icon: Icon(
                CupertinoIcons.bookmark,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
              onPressed: () => _showSaveDialog(
                context,
                ref,
                state.result!,
                premiumStatus,
                storage,
                isDark,
              ),
            ),
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
                _buildBreakdownCard(context, state.result!, isDark),
                SizedBox(height: 16.h),
                _buildActionButtons(
                  context,
                  state.result!,
                  premiumStatus.isPremium,
                  isDark,
                ),
              ],
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
            _buildSavingsTypeSelector(state, notifier, isDark),

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

  Widget _buildSavingsTypeSelector(
    SavingsCalculatorState state,
    SavingsCalculatorNotifier notifier,
    bool isDark,
  ) {
    final types = ['Tái đầu tư', 'Lĩnh lãi'];
    final selectedIndex =
        state.inputs.type == SavingsType.withReinvestment ? 0 : 1;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: List.generate(types.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => notifier.updateType(
                index == 0
                    ? SavingsType.withReinvestment
                    : SavingsType.withoutReinvestment,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.info : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    types[index],
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

  Widget _buildActionButtons(
    BuildContext context,
    SavingsResult result,
    bool isPremium,
    bool isDark,
  ) {
    return Row(
      children: [
        // Share button
        Expanded(
          child: GestureDetector(
            onTap: () => ShareService.shareSavingsResult(result),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.share,
                      size: 20.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Chia sẻ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // PDF export button (Premium)
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (isPremium) {
                PdfExportService.exportSavingsReport(result);
              } else {
                context.push('/premium');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.doc_text_fill,
                      size: 20.sp,
                      color: isPremium ? AppColors.success : AppColors.warning,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Xuất PDF',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    if (!isPremium) ...[
                      SizedBox(width: 4.w),
                      Icon(
                        CupertinoIcons.lock_fill,
                        size: 14.sp,
                        color: AppColors.warning,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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

  void _showSaveDialog(
    BuildContext context,
    WidgetRef ref,
    SavingsResult result,
    PremiumStatus premiumStatus,
    LocalStorageService storage,
    bool isDark,
  ) {
    final currentCount = storage.getSavingsCount();
    final canSave = premiumStatus.isPremium ||
        currentCount < PremiumLimits.maxSavedSavings;

    if (!canSave) {
      // Show premium required dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1a1a2e) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(
                CupertinoIcons.lock_fill,
                color: AppColors.warning,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Giới hạn lưu trữ',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          content: Text(
            'Bạn đã lưu tối đa ${PremiumLimits.maxSavedSavings} khoản tiết kiệm. '
            'Nâng cấp Premium để lưu không giới hạn!',
            style: TextStyle(
              fontSize: 14.sp,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Đóng',
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black45,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/premium');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warning,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const Text(
                'Nâng cấp',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
      return;
    }

    // Show save dialog
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1a1a2e) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Lưu khoản tiết kiệm',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Tên khoản tiết kiệm (tùy chọn)',
                hintStyle: TextStyle(
                  color: isDark ? Colors.white38 : Colors.black26,
                ),
                filled: true,
                fillColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            // Summary
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Tiền gửi ban đầu',
                    CurrencyFormatter.formatShort(result.initialDeposit),
                    isDark,
                  ),
                  SizedBox(height: 4.h),
                  _buildSummaryRow(
                    'Gửi thêm/tháng',
                    CurrencyFormatter.formatShort(result.monthlyDeposit),
                    isDark,
                  ),
                  SizedBox(height: 4.h),
                  _buildSummaryRow(
                    'Lãi suất',
                    '${result.rate.toStringAsFixed(1)}%/năm',
                    isDark,
                  ),
                  SizedBox(height: 4.h),
                  _buildSummaryRow(
                    'Kỳ hạn',
                    '${result.termMonths} tháng',
                    isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Hủy',
              style: TextStyle(
                color: isDark ? Colors.white60 : Colors.black45,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final savedSavings = SavedSavings.fromResult(
                result,
                name: nameController.text.isNotEmpty
                    ? nameController.text
                    : null,
              );
              await storage.saveSavings(savedSavings);
              ref.invalidate(savedSavingsProvider);
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Đã lưu khoản tiết kiệm'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.info,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text(
              'Lưu',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? Colors.white60 : Colors.black45,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
