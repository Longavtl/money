import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/constants/glass_settings.dart';
import 'package:money_mate/core/providers/dependency_providers.dart';
import 'package:money_mate/core/services/premium_service.dart';
import 'package:money_mate/core/storage/local_storage_service.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';

/// Saved items page - shows saved loans and savings
class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage>
    with SingleTickerProviderStateMixin {
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

    // Extract data from AsyncValue
    final loans = loansAsync.valueOrNull ?? [];
    final savings = savingsAsync.valueOrNull ?? [];

    // AppShell provides LiquidGlassScope.stack and GlassBottomBar
    return AdaptiveLiquidGlassLayer(
      settings: RecommendedGlassSettings.standard,
      quality: GlassQuality.standard,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Đã lưu',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (!premiumStatus.isPremium)
                    _buildLimitIndicator(loans.length, savings.length),
                ],
              ),
            ),

            // Tab bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GlassSegmentedControl(
                segments: [
                  'Khoản vay (${loans.length})',
                  'Tiết kiệm (${savings.length})',
                ],
                selectedIndex: _tabController.index,
                onSegmentSelected: (index) {
                  _tabController.animateTo(index);
                },
              ),
            ),

            SizedBox(height: 16.h),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLoansList(loansAsync),
                  _buildSavingsList(savingsAsync),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitIndicator(int loans, int savings) {
    const maxLoans = PremiumLimits.maxSavedLoans;
    const maxSavings = PremiumLimits.maxSavedSavings;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.lock_fill,
            size: 14.sp,
            color: AppColors.warning,
          ),
          SizedBox(width: 6.w),
          Text(
            '$loans/$maxLoans | $savings/$maxSavings',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoansList(AsyncValue<List<SavedLoan>> loansAsync) {
    return loansAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(
          'Error: $error',
          style: const TextStyle(color: Colors.white60),
        ),
      ),
      data: (loans) {
        if (loans.isEmpty) {
          return _buildEmptyState(
            icon: CupertinoIcons.building_2_fill,
            title: 'Chưa có khoản vay nào',
            subtitle: 'Tính toán và lưu khoản vay để xem lại sau',
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: loans.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final loan = loans[index];
            return _buildLoanCard(loan);
          },
        );
      },
    );
  }

  Widget _buildLoanCard(SavedLoan loan) {
    final typeLabel =
        loan.type == LoanType.fixedPayment ? 'Trả góp đều' : 'Dư nợ giảm dần';
    final dateStr =
        '${loan.createdAt.day}/${loan.createdAt.month}/${loan.createdAt.year}';

    return Dismissible(
      key: Key(loan.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          CupertinoIcons.trash,
          color: AppColors.danger,
          size: 24.sp,
        ),
      ),
      onDismissed: (_) {
        ref.read(savedLoansProvider.notifier).deleteLoan(loan.id);
      },
      child: GlassCard(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      CupertinoIcons.building_2_fill,
                      color: AppColors.warning,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan.name ?? 'Khoản vay ${loan.id.substring(loan.id.length - 4)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '$typeLabel • $dateStr',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _buildLoanStat(
                    'Số tiền vay',
                    CurrencyFormatter.formatShort(loan.principal),
                  ),
                  _buildLoanStat(
                    'Lãi suất',
                    '${loan.annualRate.toStringAsFixed(1)}%/năm',
                  ),
                  _buildLoanStat(
                    'Kỳ hạn',
                    '${loan.termMonths} tháng',
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trả hàng tháng',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          CurrencyFormatter.format(loan.monthlyPayment),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Tổng lãi',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          CurrencyFormatter.formatShort(loan.totalInterest),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.danger,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoanStat(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white60,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsList(AsyncValue<List<SavedSavings>> savingsAsync) {
    return savingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => const Center(
        child: Text(
          'Error loading savings',
          style: TextStyle(color: Colors.white60),
        ),
      ),
      data: (savings) {
        if (savings.isEmpty) {
          return _buildEmptyState(
            icon: CupertinoIcons.money_dollar_circle_fill,
            title: 'Chưa có khoản tiết kiệm nào',
            subtitle: 'Tính toán và lưu khoản tiết kiệm để xem lại sau',
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: savings.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final item = savings[index];
            return _buildSavingsCard(item);
          },
        );
      },
    );
  }

  Widget _buildSavingsCard(SavedSavings savings) {
    final typeLabel = savings.type == SavingsType.withReinvestment
        ? 'Lãi nhập gốc'
        : 'Lãi rút về';
    final dateStr =
        '${savings.createdAt.day}/${savings.createdAt.month}/${savings.createdAt.year}';

    return Dismissible(
      key: Key(savings.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          CupertinoIcons.trash,
          color: AppColors.danger,
          size: 24.sp,
        ),
      ),
      onDismissed: (_) {
        ref.read(savedSavingsProvider.notifier).deleteSavings(savings.id);
      },
      child: GlassCard(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      CupertinoIcons.money_dollar_circle_fill,
                      color: AppColors.info,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          savings.name ??
                              'Tiết kiệm ${savings.id.substring(savings.id.length - 4)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '$typeLabel • $dateStr',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  _buildLoanStat(
                    'Gửi ban đầu',
                    CurrencyFormatter.formatShort(savings.initialDeposit),
                  ),
                  _buildLoanStat(
                    'Gửi thêm/tháng',
                    CurrencyFormatter.formatShort(savings.monthlyDeposit),
                  ),
                  _buildLoanStat(
                    'Kỳ hạn',
                    '${savings.termMonths} tháng',
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Số tiền cuối kỳ',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          CurrencyFormatter.formatShort(savings.finalValue),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Tiền lãi',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          '+${CurrencyFormatter.formatShort(savings.totalInterest)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64.sp,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
