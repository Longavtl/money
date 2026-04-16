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
import 'package:money_mate/presentation/calculators/loan/loan_provider.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';

/// Loan Calculator Page with real-time calculations
class LoanCalculatorPage extends ConsumerWidget {
  const LoanCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(loanCalculatorProvider);
    final notifier = ref.read(loanCalculatorProvider.notifier);
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
          'Vay ngân hàng',
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
                _buildPieChartCard(context, state.result!, isDark),
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
    LoanCalculatorState state,
    LoanCalculatorNotifier notifier,
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
            // Loan type selector
            Text(
              'Phương thức trả nợ',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : AppColors.lightTextSecondary,
              ),
            ),
            SizedBox(height: 8.h),
            _buildLoanTypeSelector(state, notifier, isDark),

            SizedBox(height: 20.h),

            // Principal slider
            GlassSliderInput(
              label: 'Số tiền vay',
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
              label: 'Kỳ hạn vay',
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

  Widget _buildLoanTypeSelector(
    LoanCalculatorState state,
    LoanCalculatorNotifier notifier,
    bool isDark,
  ) {
    final types = ['Trả góp đều', 'Dư nợ giảm dần'];
    final selectedIndex = state.inputs.type == LoanType.fixedPayment ? 0 : 1;

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
                index == 0 ? LoanType.fixedPayment : LoanType.reducingBalance,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.warning : Colors.transparent,
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
    LoanResult result,
    bool isDark,
  ) {
    final items = <ResultItem>[
      ResultItem(
        label: result.type == LoanType.fixedPayment
            ? 'Trả hàng tháng'
            : 'Trả tháng đầu',
        value: CurrencyFormatter.format(result.monthlyPayment),
        isHighlighted: true,
        valueColor: AppColors.warning,
      ),
      ResultItem(
        label: 'Tổng tiền lãi',
        value: CurrencyFormatter.format(result.totalInterest),
        color: AppColors.chartInterest,
      ),
      ResultItem(
        label: 'Tổng thanh toán',
        value: CurrencyFormatter.format(result.totalPayment),
      ),
      ResultItem(
        label: 'Tỷ lệ lãi/gốc',
        value: '${result.interestPercentage.toStringAsFixed(1)}%',
      ),
    ];

    // Add last payment info for reducing balance
    if (result.type == LoanType.reducingBalance) {
      items.insert(
        1,
        ResultItem(
          label: 'Trả tháng cuối',
          value: CurrencyFormatter.format(result.lastPayment),
        ),
      );
    }

    return ResultCard(
      title: 'Kết quả tính toán',
      items: items,
    );
  }

  Widget _buildPieChartCard(
    BuildContext context,
    LoanResult result,
    bool isDark,
  ) {
    final total = result.totalPayment;
    final principalPercent = (result.principal / total * 100);
    final interestPercent = (result.totalInterest / total * 100);

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
              'Cơ cấu thanh toán',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                // Simple pie representation
                SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: CustomPaint(
                    painter: _SimplePieChartPainter(
                      principalPercent: principalPercent,
                      interestPercent: interestPercent,
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(
                        context,
                        'Tiền gốc',
                        CurrencyFormatter.formatShort(result.principal),
                        '${principalPercent.toStringAsFixed(1)}%',
                        AppColors.chartPrincipal,
                        isDark,
                      ),
                      SizedBox(height: 12.h),
                      _buildLegendItem(
                        context,
                        'Tiền lãi',
                        CurrencyFormatter.formatShort(result.totalInterest),
                        '${interestPercent.toStringAsFixed(1)}%',
                        AppColors.chartInterest,
                        isDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    LoanResult result,
    bool isPremium,
    bool isDark,
  ) {
    return Row(
      children: [
        // Share button
        Expanded(
          child: GestureDetector(
            onTap: () => ShareService.shareLoanResult(result),
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
                PdfExportService.exportLoanReport(result);
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
    String value,
    String percent,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                '$value ($percent)',
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
    LoanResult result,
    PremiumStatus premiumStatus,
    LocalStorageService storage,
    bool isDark,
  ) {
    final currentCount = storage.getLoanCount();
    final canSave = premiumStatus.isPremium ||
        currentCount < PremiumLimits.maxSavedLoans;

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
            'Bạn đã lưu tối đa ${PremiumLimits.maxSavedLoans} khoản vay. '
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
          'Lưu khoản vay',
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
                hintText: 'Tên khoản vay (tùy chọn)',
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
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Số tiền vay',
                    CurrencyFormatter.formatShort(result.principal),
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
              final savedLoan = SavedLoan.fromResult(
                result,
                name: nameController.text.isNotEmpty
                    ? nameController.text
                    : null,
              );
              await storage.saveLoan(savedLoan);
              ref.invalidate(savedLoansProvider);
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Đã lưu khoản vay'),
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
              backgroundColor: AppColors.warning,
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

/// Simple pie chart painter for quick visualization
class _SimplePieChartPainter extends CustomPainter {
  final double principalPercent;
  final double interestPercent;

  _SimplePieChartPainter({
    required this.principalPercent,
    required this.interestPercent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final principalPaint = Paint()
      ..color = AppColors.chartPrincipal
      ..style = PaintingStyle.fill;

    final interestPaint = Paint()
      ..color = AppColors.chartInterest
      ..style = PaintingStyle.fill;

    // Draw principal arc
    final principalSweep = (principalPercent / 100) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2, // Start from top
      principalSweep,
      true,
      principalPaint,
    );

    // Draw interest arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2 + principalSweep,
      (interestPercent / 100) * 2 * 3.14159,
      true,
      interestPaint,
    );

    // Draw center circle (donut effect)
    final centerPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
