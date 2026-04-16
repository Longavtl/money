import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/constants/app_constants.dart';
import 'package:money_mate/core/constants/glass_settings.dart';
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
    final state = ref.watch(loanCalculatorProvider);
    final notifier = ref.read(loanCalculatorProvider.notifier);
    final premiumStatus = ref.watch(premiumStatusProvider);
    final storage = ref.watch(localStorageProvider);

    return LiquidGlassScope.stack(
      background: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper2.jpeg'),
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
                'Vay ngân hàng',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              actions: [
                if (state.hasResult)
                  GlassIconButton(
                    icon: const Icon(CupertinoIcons.bookmark),
                    onPressed: () => _showSaveDialog(
                      context,
                      ref,
                      state.result!,
                      premiumStatus,
                      storage,
                    ),
                  ),
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
                    _buildInputCard(context, state, notifier),
                    SizedBox(height: 16.h),
                    if (state.hasResult) ...[
                      _buildResultsCard(context, state.result!),
                      SizedBox(height: 16.h),
                      _buildPieChartCard(context, state.result!),
                      SizedBox(height: 16.h),
                      _buildActionButtons(context, state.result!, premiumStatus.isPremium),
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
    LoanCalculatorState state,
    LoanCalculatorNotifier notifier,
  ) {
    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phương thức trả nợ',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 8.h),
          GlassSegmentedControl(
            segments: const ['Trả góp đều', 'Dư nợ giảm dần'],
            selectedIndex: state.inputs.type == LoanType.fixedPayment ? 0 : 1,
            onSegmentSelected: (index) {
              notifier.updateType(
                index == 0 ? LoanType.fixedPayment : LoanType.reducingBalance,
              );
            },
          ),
          SizedBox(height: 20.h),
          GlassSliderInput(
            label: 'Số tiền vay',
            value: state.inputs.principal,
            min: AppConstants.minPrincipal,
            max: 10000000000,
            divisions: 1000,
            activeColor: AppColors.warning,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updatePrincipal,
          ),
          SizedBox(height: 8.h),
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
          GlassSliderInput(
            label: 'Kỳ hạn vay',
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
    final items = <ResultItem>[
      ResultItem(
        label: result.type == LoanType.fixedPayment ? 'Trả hàng tháng' : 'Trả tháng đầu',
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

    if (result.type == LoanType.reducingBalance) {
      items.insert(
        1,
        ResultItem(
          label: 'Trả tháng cuối',
          value: CurrencyFormatter.format(result.lastPayment),
        ),
      );
    }

    return ResultCard(title: 'Kết quả tính toán', items: items);
  }

  Widget _buildPieChartCard(BuildContext context, LoanResult result) {
    final total = result.totalPayment;
    final principalPercent = (result.principal / total * 100);
    final interestPercent = (result.totalInterest / total * 100);

    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cơ cấu thanh toán',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      'Tiền gốc',
                      CurrencyFormatter.formatShort(result.principal),
                      '${principalPercent.toStringAsFixed(1)}%',
                      AppColors.chartPrincipal,
                    ),
                    SizedBox(height: 12.h),
                    _buildLegendItem(
                      'Tiền lãi',
                      CurrencyFormatter.formatShort(result.totalInterest),
                      '${interestPercent.toStringAsFixed(1)}%',
                      AppColors.chartInterest,
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
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => ShareService.shareLoanResult(result),
            child: GlassCard(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.share, size: 20.sp, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text('Chia sẻ', style: TextStyle(fontSize: 14.sp, color: Colors.white)),
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
            child: GlassCard(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.doc_text_fill,
                    size: 20.sp,
                    color: isPremium ? Colors.white : AppColors.warning,
                  ),
                  SizedBox(width: 8.w),
                  Text('Xuất PDF', style: TextStyle(fontSize: 14.sp, color: Colors.white)),
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

  Widget _buildLegendItem(String label, String value, String percent, Color color) {
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
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              Text(
                '$value ($percent)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
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
  ) {
    final currentCount = storage.getLoanCount();
    final canSave = premiumStatus.isPremium || currentCount < PremiumLimits.maxSavedLoans;

    if (!canSave) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1a1a2e),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Row(
            children: [
              Icon(CupertinoIcons.lock_fill, color: AppColors.warning, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                'Giới hạn lưu trữ',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          content: Text(
            'Bạn đã lưu tối đa ${PremiumLimits.maxSavedLoans} khoản vay. Nâng cấp Premium để lưu không giới hạn!',
            style: TextStyle(fontSize: 14.sp, color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Đóng', style: TextStyle(color: Colors.white60)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/premium');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warning,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              child: const Text('Nâng cấp', style: TextStyle(color: Colors.white)),
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
        backgroundColor: const Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Lưu khoản vay',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Tên khoản vay (tùy chọn)',
                hintStyle: TextStyle(color: Colors.white38),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Số tiền vay', CurrencyFormatter.formatShort(result.principal)),
                  SizedBox(height: 4.h),
                  _buildSummaryRow('Lãi suất', '${result.rate.toStringAsFixed(1)}%/năm'),
                  SizedBox(height: 4.h),
                  _buildSummaryRow('Kỳ hạn', '${result.termMonths} tháng'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Hủy', style: TextStyle(color: Colors.white60)),
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
                    content: const Text('Đã lưu khoản vay'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: const Text('Lưu', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.white60)),
        Text(value, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.white)),
      ],
    );
  }
}

class _SimplePieChartPainter extends CustomPainter {
  final double principalPercent;
  final double interestPercent;

  _SimplePieChartPainter({required this.principalPercent, required this.interestPercent});

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
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
