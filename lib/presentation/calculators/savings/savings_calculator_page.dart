import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/l10n/app_localizations.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';
import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/constants/app_constants.dart';
import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/services/pdf_export_service.dart';
import 'package:money/core/services/share_service.dart';
import 'package:money/core/storage/local_storage_service.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/presentation/calculators/savings/savings_provider.dart';
import 'package:money/presentation/premium/premium_provider.dart';

/// Savings Calculator Page with real-time calculations
class SavingsCalculatorPage extends ConsumerWidget {
  const SavingsCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(savingsCalculatorProvider);
    final notifier = ref.read(savingsCalculatorProvider.notifier);
    final premiumStatus = ref.watch(premiumStatusProvider);
    final storage = ref.watch(localStorageProvider);

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
          l10n.calculatorSavings,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightTextPrimary,
          ),
        ),
        actions: [
          if (state.hasResult)
            IconButton(
              icon: const Icon(CupertinoIcons.bookmark),
              onPressed: () => _showSaveDialog(
                context,
                ref,
                state.result!,
                premiumStatus,
                storage,
              ),
            ),
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
              _buildInputCard(context, state, notifier),
              SizedBox(height: 16.h),
              if (state.hasResult) ...[
                _buildResultsCard(context, state.result!),
                SizedBox(height: 16.h),
                _buildBreakdownCard(context, state.result!),
                SizedBox(height: 16.h),
                _buildActionButtons(
                    context, state.result!, premiumStatus.isPremium),
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
  ) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.savingsType,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.lightTextSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          AppSegmentedControl(
            segments: [l10n.savingsTypeReinvest, l10n.savingsTypeWithdraw],
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
          AppSliderInput(
            label: l10n.initialDeposit,
            value: state.inputs.initialDeposit.clamp(0, CurrencyFormatter.defaultLoanMax),
            min: 0,
            max: CurrencyFormatter.defaultLoanMax,
            divisions: 1000,
            activeColor: AppColors.warning,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updateInitialDeposit,
          ),
          SizedBox(height: 8.h),
          AppSliderInput(
            label: l10n.monthlyDeposit,
            value: state.inputs.monthlyDeposit.clamp(0, CurrencyFormatter.defaultSavings * 10),
            min: 0,
            max: CurrencyFormatter.defaultSavings * 10,
            divisions: 500,
            activeColor: AppColors.primary,
            valueFormatter: (v) => CurrencyFormatter.formatShort(v),
            onChanged: notifier.updateMonthlyDeposit,
          ),
          SizedBox(height: 8.h),
          AppSliderInput(
            label: l10n.annualRate,
            value: state.inputs.annualRate,
            min: AppConstants.minRate,
            max: AppConstants.maxRate,
            divisions: 499,
            activeColor: AppColors.success,
            valueFormatter: (v) => CurrencyFormatter.formatPercent(v),
            onChanged: notifier.updateRate,
          ),
          SizedBox(height: 8.h),
          AppSliderInput(
            label: l10n.term,
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
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.calculationResults,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildResultRow(
            result.type == SavingsType.withReinvestment ? l10n.finalBalance : l10n.totalDeposited,
            CurrencyFormatter.format(result.finalValue),
            AppColors.success,
            true,
          ),
          SizedBox(height: 12.h),
          _buildResultRow(l10n.interestEarned, CurrencyFormatter.format(result.totalInterest), AppColors.chartInterest, false),
          SizedBox(height: 12.h),
          _buildResultRow(l10n.totalDeposited, CurrencyFormatter.format(result.totalDeposited), AppColors.chartPrincipal, false),
          SizedBox(height: 12.h),
          _buildResultRow(l10n.returnRate, '${result.returnPercentage.toStringAsFixed(1)}%', null, false),
          if (result.type == SavingsType.withoutReinvestment &&
              result.monthlyInterestPayouts.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildResultRow(
              l10n.avgMonthlyInterest,
              CurrencyFormatter.format(result.monthlyInterestPayouts.reduce((a, b) => a + b) / result.monthlyInterestPayouts.length),
              null,
              false,
            ),
          ],
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

  Widget _buildBreakdownCard(BuildContext context, SavingsResult result) {
    final l10n = AppLocalizations.of(context)!;
    final totalValue = result.type == SavingsType.withReinvestment
        ? result.finalValue
        : result.totalDeposited + result.totalInterest;

    final depositedPercent = (result.totalDeposited / totalValue * 100);
    final interestPercent = (result.totalInterest / totalValue * 100);

    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.detailedAnalysis,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightTextPrimary,
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
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
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
                                  color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _buildLegendItem(l10n.deposits, result.totalDeposited,
              depositedPercent, AppColors.chartPrincipal),
          SizedBox(height: 8.h),
          _buildLegendItem(l10n.interest, result.totalInterest, interestPercent,
              AppColors.chartInterest),
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
                        ? l10n.reinvestInfo
                        : l10n.withdrawInfo,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.lightTextSecondary,
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

  Widget _buildActionButtons(
      BuildContext context, SavingsResult result, bool isPremium) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => ShareService.shareSavingsResult(result),
            child: AppCard(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.share, size: 20.sp, color: AppColors.lightTextPrimary),
                  SizedBox(width: 8.w),
                  Text(l10n.share,
                      style: TextStyle(fontSize: 14.sp, color: AppColors.lightTextPrimary)),
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
            child: AppCard(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.doc_text_fill,
                    size: 20.sp,
                    color: isPremium ? AppColors.lightTextPrimary : AppColors.warning,
                  ),
                  SizedBox(width: 8.w),
                  Text(l10n.exportPdf,
                      style: TextStyle(fontSize: 14.sp, color: AppColors.lightTextPrimary)),
                  if (!isPremium) ...[
                    SizedBox(width: 4.w),
                    Icon(CupertinoIcons.lock_fill,
                        size: 14.sp, color: AppColors.warning),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(
      String label, double value, double percent, Color color) {
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
                  color: AppColors.lightTextSecondary,
                ),
              ),
              Text(
                '${CurrencyFormatter.formatShort(value)} (${percent.toStringAsFixed(1)}%)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightTextPrimary,
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
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a2e),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          l10n.saveSavings,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: l10n.savingsNameHint,
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
                  _buildSummaryRow(l10n.initialDeposit,
                      CurrencyFormatter.formatShort(result.initialDeposit)),
                  SizedBox(height: 4.h),
                  _buildSummaryRow(l10n.monthlyDeposit,
                      CurrencyFormatter.formatShort(result.monthlyDeposit)),
                  SizedBox(height: 4.h),
                  _buildSummaryRow(
                      l10n.rate, '${result.rate.toStringAsFixed(1)}%'),
                  SizedBox(height: 4.h),
                  _buildSummaryRow(l10n.term, '${result.termMonths}'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel, style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            onPressed: () async {
              final savedSavings = SavedSavings.fromResult(
                result,
                name:
                    nameController.text.isNotEmpty ? nameController.text : null,
              );
              await storage.saveSavings(savedSavings);
              ref.invalidate(savedSavingsProvider);
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.savingsSaved),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.info,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(l10n.save, style: const TextStyle(color: Colors.white)),
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
        Text(value,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
      ],
    );
  }
}
