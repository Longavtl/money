import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/constants/app_constants.dart';
import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/services/pdf_export_service.dart';
import 'package:money/core/services/premium_service.dart';
import 'package:money/core/services/share_service.dart';
import 'package:money/core/storage/local_storage_service.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/presentation/calculators/loan/loan_provider.dart';
import 'package:money/presentation/premium/premium_provider.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';

class LoanCalculatorPage extends ConsumerWidget {
  const LoanCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loanCalculatorProvider);
    final notifier = ref.read(loanCalculatorProvider.notifier);
    final premiumStatus = ref.watch(premiumStatusProvider);
    final storage = ref.watch(localStorageProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

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
          'Loan Calculator',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
        ),
        actions: [
          if (state.hasResult)
            IconButton(
              icon: Icon(CupertinoIcons.bookmark, color: textSecondary),
              onPressed: () => _showSaveDialog(context, ref, state.result!, premiumStatus, storage),
            ),
          IconButton(
            icon: Icon(CupertinoIcons.arrow_counterclockwise, color: textSecondary),
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
                _buildPieChartCard(context, state.result!),
                SizedBox(height: 16.h),
                _buildActionButtons(context, state.result!, premiumStatus.isPremium),
              ],
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(BuildContext context, LoanCalculatorState state, LoanCalculatorNotifier notifier) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 14.sp,
              color: textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          AppSegmentedControl(
            segments: const ['Fixed EMI', 'Reducing Balance'],
            selectedIndex: state.inputs.type == LoanType.fixedPayment ? 0 : 1,
            onSegmentSelected: (index) {
              notifier.updateType(index == 0 ? LoanType.fixedPayment : LoanType.reducingBalance);
            },
          ),
          SizedBox(height: 20.h),
          AppSliderInput(
            label: 'Loan Amount',
            value: state.inputs.principal,
            min: AppConstants.minPrincipal,
            max: 10000000000,
            divisions: 1000,
            activeColor: AppColors.warning,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updatePrincipal,
          ),
          SizedBox(height: 16.h),
          AppSliderInput(
            label: 'Interest Rate (Annual)',
            value: state.inputs.annualRate,
            min: AppConstants.minRate,
            max: AppConstants.maxRate,
            divisions: 499,
            activeColor: AppColors.success,
            valueFormatter: (v) => CurrencyFormatter.formatPercent(v),
            onChanged: notifier.updateRate,
          ),
          SizedBox(height: 16.h),
          AppSliderInput(
            label: 'Loan Term',
            value: state.inputs.termMonths.toDouble(),
            min: AppConstants.minTermMonths.toDouble(),
            max: 360,
            divisions: 359,
            activeColor: AppColors.info,
            valueFormatter: (v) => CurrencyFormatter.formatTerm(v.toInt()),
            onChanged: (v) => notifier.updateTerm(v.toInt()),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsCard(BuildContext context, LoanResult result) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Results',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _ResultRow(
            label: result.type == LoanType.fixedPayment ? 'Monthly Payment' : 'First Month Payment',
            value: CurrencyFormatter.format(result.monthlyPayment),
            valueColor: AppColors.warning,
            isHighlighted: true,
          ),
          if (result.type == LoanType.reducingBalance)
            _ResultRow(
              label: 'Last Month Payment',
              value: CurrencyFormatter.format(result.lastPayment),
            ),
          _ResultRow(
            label: 'Total Interest',
            value: CurrencyFormatter.format(result.totalInterest),
            valueColor: AppColors.chartInterest,
          ),
          _ResultRow(
            label: 'Total Payment',
            value: CurrencyFormatter.format(result.totalPayment),
          ),
          _ResultRow(
            label: 'Interest/Principal Ratio',
            value: '${result.interestPercentage.toStringAsFixed(1)}%',
          ),
        ],
      ),
    );
  }

  Widget _buildPieChartCard(BuildContext context, LoanResult result) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final total = result.totalPayment;
    final principalPercent = (result.principal / total * 100);
    final interestPercent = (result.totalInterest / total * 100);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Structure',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: CustomPaint(
                  painter: _SimplePieChartPainter(
                    principalPercent: principalPercent,
                    interestPercent: interestPercent,
                    isDark: isDark,
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LegendItem(
                      label: 'Principal',
                      value: CurrencyFormatter.formatShort(result.principal),
                      percent: '${principalPercent.toStringAsFixed(1)}%',
                      color: AppColors.chartPrincipal,
                    ),
                    SizedBox(height: 12.h),
                    _LegendItem(
                      label: 'Interest',
                      value: CurrencyFormatter.formatShort(result.totalInterest),
                      percent: '${interestPercent.toStringAsFixed(1)}%',
                      color: AppColors.chartInterest,
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

  Widget _buildActionButtons(BuildContext context, LoanResult result, bool isPremium) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => ShareService.shareLoanResult(result),
            child: AppCard(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.share, size: 20.sp, color: textPrimary),
                  SizedBox(width: 8.w),
                  Text('Share', style: TextStyle(fontSize: 14.sp, color: textPrimary)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (isPremium) {
                PdfExportService.exportLoanReport(result);
              } else {
                context.push('/premium');
              }
            },
            child: AppCard(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              color: isPremium ? null : AppColors.warning.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.doc_text_fill,
                    size: 20.sp,
                    color: isPremium ? textPrimary : AppColors.warning,
                  ),
                  SizedBox(width: 8.w),
                  Text('Export PDF', style: TextStyle(fontSize: 14.sp, color: isPremium ? textPrimary : AppColors.warning)),
                  if (!isPremium) ...[
                    SizedBox(width: 4.w),
                    Icon(CupertinoIcons.lock_fill, size: 14.sp, color: AppColors.warning),
                  ],
                ],
              ),
            ),
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
  ) {
    final currentCount = storage.getLoanCount();
    final canSave = premiumStatus.isPremium || currentCount < PremiumLimits.maxSavedLoans;

    if (!canSave) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Row(
            children: [
              Icon(CupertinoIcons.lock_fill, color: AppColors.warning, size: 24.sp),
              SizedBox(width: 8.w),
              const Text('Storage Limit'),
            ],
          ),
          content: Text(
            'You have saved the maximum of ${PremiumLimits.maxSavedLoans} loans. Upgrade to Premium for unlimited saves!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/premium');
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
              child: const Text('Upgrade', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
      return;
    }

    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Save Loan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Loan name (optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
            SizedBox(height: 12.h),
            Builder(
              builder: (dialogContext) {
                final dialogTheme = Theme.of(dialogContext);
                final dialogIsDark = dialogTheme.brightness == Brightness.dark;
                final dialogBgColor = dialogIsDark ? AppColors.darkBackground : AppColors.lightBackground;
                return Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: dialogBgColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow(dialogContext, 'Amount', CurrencyFormatter.formatShort(result.principal)),
                      SizedBox(height: 4.h),
                      _buildSummaryRow(dialogContext, 'Rate', '${result.rate.toStringAsFixed(1)}%/year'),
                      SizedBox(height: 4.h),
                      _buildSummaryRow(dialogContext, 'Term', '${result.termMonths} months'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final savedLoan = SavedLoan.fromResult(
                result,
                name: nameController.text.isNotEmpty ? nameController.text : null,
              );
              await storage.saveLoan(savedLoan);
              ref.invalidate(savedLoansProvider);
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Loan saved'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: textSecondary)),
        Text(value, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: textPrimary)),
      ],
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
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

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

class _LegendItem extends StatelessWidget {
  final String label;
  final String value;
  final String percent;
  final Color color;

  const _LegendItem({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

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
                  color: textSecondary,
                ),
              ),
              Text(
                '$value ($percent)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimplePieChartPainter extends CustomPainter {
  final double principalPercent;
  final double interestPercent;
  final bool isDark;

  _SimplePieChartPainter({
    required this.principalPercent,
    required this.interestPercent,
    this.isDark = false,
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

    final principalSweep = (principalPercent / 100) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      principalSweep,
      true,
      principalPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2 + principalSweep,
      (interestPercent / 100) * 2 * 3.14159,
      true,
      interestPaint,
    );

    final centerPaint = Paint()
      ..color = isDark ? AppColors.darkSurface : Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
