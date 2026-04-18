import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/services/premium_service.dart';
import 'package:money/core/storage/local_storage_service.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/calculation_results.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/premium/premium_provider.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loansAsync = ref.watch(savedLoansProvider);
    final savingsAsync = ref.watch(savedSavingsProvider);
    final premiumStatus = ref.watch(premiumStatusProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final l10n = AppLocalizations.of(context)!;

    final loans = loansAsync.valueOrNull ?? [];
    final savings = savingsAsync.valueOrNull ?? [];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.saved,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                  ),
                  if (!premiumStatus.isPremium) _buildLimitIndicator(loans.length, savings.length),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AppTabSegmentedControl(
                segments: [l10n.loansCount(loans.length), l10n.savingsCount(savings.length)],
                tabController: _tabController,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLoansList(loansAsync, l10n),
                  _buildSavingsList(savingsAsync, l10n),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitIndicator(int loans, int savings) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.lock_fill, size: 14.sp, color: AppColors.warning),
          SizedBox(width: 6.w),
          Text(
            '$loans/${PremiumLimits.maxSavedLoans} | $savings/${PremiumLimits.maxSavedSavings}',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.warning),
          ),
        ],
      ),
    );
  }

  Widget _buildLoansList(AsyncValue<List<SavedLoan>> loansAsync, AppLocalizations l10n) {
    return loansAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(l10n.errorLoading(error.toString()))),
      data: (loans) {
        if (loans.isEmpty) {
          return _buildEmptyState(
            icon: CupertinoIcons.building_2_fill,
            title: l10n.noSavedLoans,
            subtitle: l10n.noSavedLoansSubtitle,
          );
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: loans.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) => _buildLoanCard(loans[index], l10n),
        );
      },
    );
  }

  Widget _buildLoanCard(SavedLoan loan, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final typeLabel = loan.type == LoanType.fixedPayment ? l10n.loanTypeFixed : l10n.loanTypeReducing;
    final dateStr = '${loan.createdAt.day}/${loan.createdAt.month}/${loan.createdAt.year}';

    return Dismissible(
      key: Key(loan.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: AppColors.danger.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(CupertinoIcons.trash, color: AppColors.danger, size: 24.sp),
      ),
      onDismissed: (_) => ref.read(savedLoansProvider.notifier).deleteLoan(loan.id),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(CupertinoIcons.building_2_fill, color: AppColors.warning, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan.name ?? 'Loan ${loan.id.substring(loan.id.length - 4)}',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
                      ),
                      Text('$typeLabel • $dateStr', style: TextStyle(fontSize: 12.sp, color: textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.monthlyPayment, style: TextStyle(fontSize: 11.sp, color: textSecondary)),
                      Text(CurrencyFormatter.format(loan.monthlyPayment),
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(l10n.totalInterest, style: TextStyle(fontSize: 11.sp, color: textSecondary)),
                      Text(CurrencyFormatter.formatShort(loan.totalInterest),
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.danger)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavingsList(AsyncValue<List<SavedSavings>> savingsAsync, AppLocalizations l10n) {
    return savingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(l10n.errorLoading(error.toString()))),
      data: (savings) {
        if (savings.isEmpty) {
          return _buildEmptyState(
            icon: CupertinoIcons.money_dollar_circle_fill,
            title: l10n.noSavedSavings,
            subtitle: l10n.noSavedSavingsSubtitle,
          );
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: savings.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) => _buildSavingsCard(savings[index], l10n),
        );
      },
    );
  }

  Widget _buildSavingsCard(SavedSavings savings, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final typeLabel = savings.type == SavingsType.withReinvestment ? l10n.savingsTypeReinvest : l10n.savingsTypeWithdraw;
    final dateStr = '${savings.createdAt.day}/${savings.createdAt.month}/${savings.createdAt.year}';

    return Dismissible(
      key: Key(savings.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: AppColors.danger.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(CupertinoIcons.trash, color: AppColors.danger, size: 24.sp),
      ),
      onDismissed: (_) => ref.read(savedSavingsProvider.notifier).deleteSavings(savings.id),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(CupertinoIcons.money_dollar_circle_fill, color: AppColors.success, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        savings.name ?? 'Savings ${savings.id.substring(savings.id.length - 4)}',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
                      ),
                      Text('$typeLabel • $dateStr', style: TextStyle(fontSize: 12.sp, color: textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.finalBalance, style: TextStyle(fontSize: 11.sp, color: textSecondary)),
                      Text(CurrencyFormatter.formatShort(savings.finalValue),
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.success)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(l10n.interestEarned, style: TextStyle(fontSize: 11.sp, color: textSecondary)),
                      Text('+${CurrencyFormatter.formatShort(savings.totalInterest)}',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.success)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String title, required String subtitle}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64.sp, color: textSecondary.withOpacity(0.3)),
          SizedBox(height: 16.h),
          Text(title, style: TextStyle(fontSize: 16.sp, color: textSecondary)),
          SizedBox(height: 8.h),
          Text(subtitle, style: TextStyle(fontSize: 14.sp, color: textSecondary.withOpacity(0.6))),
        ],
      ),
    );
  }
}
