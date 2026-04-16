import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/constants/glass_settings.dart';
import 'package:money_mate/core/routes/app_routes.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';
import 'package:money_mate/presentation/premium/widgets/premium_gate.dart';

/// Tools page - additional calculators and utilities
class ToolsPage extends ConsumerWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumStatus = ref.watch(premiumStatusProvider);

    return AdaptiveLiquidGlassLayer(
      settings: RecommendedGlassSettings.standard,
      quality: GlassQuality.standard,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  'Công cụ',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Calculator tools
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Máy tính lãi suất'),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 1.1,
                ),
                delegate: SliverChildListDelegate([
                  _ToolCard(
                    title: 'Lãi đơn',
                    subtitle: 'Simple Interest',
                    icon: CupertinoIcons.percent,
                    color: AppColors.primary,
                    onTap: () => context.push(AppRoutes.simpleInterest),
                  ),
                  _ToolCard(
                    title: 'Lãi kép',
                    subtitle: 'Compound Interest',
                    icon: CupertinoIcons.chart_bar_alt_fill,
                    color: AppColors.success,
                    onTap: () => context.push(AppRoutes.compoundInterest),
                  ),
                  _ToolCard(
                    title: 'Vay ngân hàng',
                    subtitle: 'Loan Calculator',
                    icon: CupertinoIcons.building_2_fill,
                    color: AppColors.warning,
                    onTap: () => context.push(AppRoutes.loan),
                  ),
                  _ToolCard(
                    title: 'Gửi tiết kiệm',
                    subtitle: 'Savings Calculator',
                    icon: CupertinoIcons.money_dollar_circle_fill,
                    color: AppColors.info,
                    onTap: () => context.push(AppRoutes.savings),
                  ),
                ]),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24.h)),

            // Premium tools section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Công cụ Premium'),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _PremiumToolCard(
                  title: 'So sánh kịch bản',
                  subtitle: 'So sánh nhiều phương án vay song song',
                  icon: CupertinoIcons.arrow_right_arrow_left,
                  color: AppColors.warning,
                  isPremium: premiumStatus.isPremium,
                  onTap: () => context.push(AppRoutes.comparison),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 120.h)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withValues(alpha: 0.8),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 22.sp,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isPremium;
  final VoidCallback onTap;

  const _PremiumToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isPremium,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                icon,
                color: color,
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
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (!isPremium) ...[
                        SizedBox(width: 8.w),
                        const PremiumBadge(size: 14),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: Colors.white.withValues(alpha: 0.4),
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
