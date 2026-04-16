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
import 'package:money_mate/presentation/calculators/savings/savings_provider.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';

/// Savings Calculator Page with real-time calculations
class SavingsCalculatorPage extends ConsumerWidget {
  const SavingsCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savingsCalculatorProvider);
    final notifier = ref.read(savingsCalculatorProvider.notifier);
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
                'Gửi tiết kiệm',
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
                      _buildBreakdownCard(context, state.result!),
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
    SavingsCalculatorState state,
    SavingsCalculatorNotifier notifier,
  ) {
    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hình thức tiết kiệm',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 8.h),
          GlassSegmentedControl(
            segments: const ['Tái đầu tư', 'Lĩnh lãi'],
            selectedIndex: state.inputs.type == SavingsType.withReinvestment ? 0 : 1,
            onSegmentSelected: (index) {
              notifier.updateType(
                index == 0 ? SavingsType.withReinvestment : SavingsType.withoutReinvestment,
              );
            },
          ),
          SizedBox(height: 20.h),
          GlassSliderInput(
            label: 'Tiền gửi ban đầu',
            value: state.inputs.initialDeposit,
            min: 0,
            max: 10000000000,
            divisions: 1000,
            activeColor: AppColors.warning,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updateInitialDeposit,
          ),
          SizedBox(height: 8.h),
          GlassSliderInput(
            label: 'Gửi thêm hàng tháng',
            value: state.inputs.monthlyDeposit,
            min: 0,
            max: 500000000,
            divisions: 500,
            activeColor: AppColors.primary,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updateMonthlyDeposit,
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
            label: 'Thời hạn',
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

  Widget _buildResultsCard(BuildContext context, SavingsResult result) {
    final items = <ResultItem>[
      ResultItem(
        label: result.type == SavingsType.withReinvestment ? 'Số dư cuối kỳ' : 'Tổng tiền gửi',
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

    if (result.type == SavingsType.withoutReinvestment && result.monthlyInterestPayouts.isNotEmpty) {
      final avgMonthlyPayout = result.monthlyInterestPayouts.reduce((a, b) => a + b) /
          result.monthlyInterestPayouts.length;
      items.add(
        ResultItem(
          label: 'Lãi bình quân/tháng',
          value: CurrencyFormatter.format(avgMonthlyPayout),
        ),
      );
    }

    return ResultCard(title: 'Kết quả tính toán', items: items);
  }

  Widget _buildBreakdownCard(BuildContext context, SavingsResult result) {
    final totalValue = result.type == SavingsType.withReinvestment
        ? result.finalValue
        : result.totalDeposited + result.totalInterest;

    final depositedPercent = (result.totalDeposited / totalValue * 100);
    final interestPercent = (result.totalInterest / totalValue * 100);

    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tích chi tiết',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          ClipRRect(
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
                              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.white),
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
                              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _buildLegendItem('Tiền gửi vào', result.totalDeposited, depositedPercent, AppColors.chartPrincipal),
          SizedBox(height: 8.h),
          _buildLegendItem('Tiền lãi', result.totalInterest, interestPercent, AppColors.chartInterest),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.2),
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
                      color: Colors.white.withValues(alpha: 0.7),
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

  Widget _buildActionButtons(BuildContext context, SavingsResult result, bool isPremium) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => ShareService.shareSavingsResult(result),
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
                PdfExportService.exportSavingsReport(result);
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

  Widget _buildLegendItem(String label, double value, double percent, Color color) {
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
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              Text(
                '${CurrencyFormatter.formatShort(value)} (${percent.toStringAsFixed(1)}%)',
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
    SavingsResult result,
    PremiumStatus premiumStatus,
    LocalStorageService storage,
  ) {
    final currentCount = storage.getSavingsCount();
    final canSave = premiumStatus.isPremium || currentCount < PremiumLimits.maxSavedSavings;

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
            'Bạn đã lưu tối đa ${PremiumLimits.maxSavedSavings} khoản tiết kiệm. Nâng cấp Premium để lưu không giới hạn!',
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
          'Lưu khoản tiết kiệm',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Tên khoản tiết kiệm (tùy chọn)',
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
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Tiền gửi ban đầu', CurrencyFormatter.formatShort(result.initialDeposit)),
                  SizedBox(height: 4.h),
                  _buildSummaryRow('Gửi thêm/tháng', CurrencyFormatter.formatShort(result.monthlyDeposit)),
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
              final savedSavings = SavedSavings.fromResult(
                result,
                name: nameController.text.isNotEmpty ? nameController.text : null,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.info,
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
