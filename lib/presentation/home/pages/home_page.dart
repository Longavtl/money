import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/routes/app_routes.dart';
import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';
import 'package:money_mate/presentation/premium/widgets/premium_gate.dart';

/// Home page with calculator type selection
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final premiumStatus = ref.watch(premiumStatusProvider);

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
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MoneyMate',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Tính toán tương lai của bạn',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: isDark
                              ? Colors.white70
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Calculator cards
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.95,
                  ),
                  delegate: SliverChildListDelegate([
                    _CalculatorCard(
                      title: 'Lãi đơn',
                      subtitle: 'Simple Interest',
                      icon: CupertinoIcons.percent,
                      color: AppColors.primary,
                      onTap: () => context.push(AppRoutes.simpleInterest),
                    ),
                    _CalculatorCard(
                      title: 'Lãi kép',
                      subtitle: 'Compound Interest',
                      icon: CupertinoIcons.chart_bar_alt_fill,
                      color: AppColors.success,
                      onTap: () => context.push(AppRoutes.compoundInterest),
                    ),
                    _CalculatorCard(
                      title: 'Vay ngân hàng',
                      subtitle: 'Loan Calculator',
                      icon: CupertinoIcons.building_2_fill,
                      color: AppColors.warning,
                      onTap: () => context.push(AppRoutes.loan),
                    ),
                    _CalculatorCard(
                      title: 'Gửi tiết kiệm',
                      subtitle: 'Savings Calculator',
                      icon: CupertinoIcons.money_dollar_circle_fill,
                      color: AppColors.info,
                      onTap: () => context.push(AppRoutes.savings),
                    ),
                  ]),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 16.h),
              ),

              // Compare feature card (Premium)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _CompareCard(
                    isPremium: premiumStatus.isPremium,
                    onTap: () => context.push(AppRoutes.comparison),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 16.h),
              ),

              // Quick tips card
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GlassCard(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.lightbulb_fill,
                                color: AppColors.warning,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Mẹo nhanh',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Kéo slider để điều chỉnh số tiền và lãi suất. Kết quả sẽ được tính toán ngay lập tức!',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDark
                                  ? Colors.white70
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 100.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalculatorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CalculatorCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassCard(
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24.sp,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  final bool isPremium;
  final VoidCallback onTap;

  const _CompareCard({
    required this.isPremium,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  CupertinoIcons.arrow_right_arrow_left,
                  color: AppColors.warning,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'So sánh kịch bản',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        if (!isPremium) ...[
                          SizedBox(width: 8.w),
                          const PremiumBadge(size: 16),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'So sánh nhiều phương án vay song song',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark
                            ? Colors.white60
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.4)
                    : AppColors.lightTextSecondary.withValues(alpha: 0.6),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
