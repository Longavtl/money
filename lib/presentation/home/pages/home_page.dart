import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/core/routes/app_routes.dart';
import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/presentation/premium/premium_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumStatus = ref.watch(premiumStatusProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Premium Banner
              _PremiumBanner(
                isPremium: premiumStatus.isPremium,
                onTap: () => context.push(AppRoutes.premium),
              ),

              SizedBox(height: 24.h),

              // Main Tools Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Main Tools',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  Text(
                    '4 CATEGORIES',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Calculator Cards Grid
              Row(
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: 'Loan Calc',
                      subtitle: 'Monthly payments',
                      icon: CupertinoIcons.square_grid_2x2_fill,
                      iconColor: AppColors.warning,
                      onTap: () => context.push(AppRoutes.loan),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ToolCard(
                      title: 'Interest',
                      subtitle: 'Simple & compound',
                      icon: CupertinoIcons.graph_square,
                      iconColor: textPrimary,
                      onTap: () => context.push(AppRoutes.compoundInterest),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              Row(
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: 'Vault',
                      subtitle: 'Plan your future',
                      icon: CupertinoIcons.square_on_square,
                      iconColor: AppColors.warning,
                      onTap: () => context.push(AppRoutes.savings),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ToolCard(
                      title: 'History',
                      subtitle: 'Past calculations',
                      icon: CupertinoIcons.clock,
                      iconColor: textPrimary,
                      onTap: () {},  // History page handled by bottom nav
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Current Rates Section
              _CurrentRatesCard(),

              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  final bool isPremium;
  final VoidCallback onTap;

  const _PremiumBanner({
    required this.isPremium,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isPremium) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5B9EF4),
              Color(0xFF3D7DD8),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                'PRO ACCESS',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upgrade to Premium',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Unlock advanced charts\nand ad-free experience.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.85),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    CupertinoIcons.rosette,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentRatesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1A2A3A) : const Color(0xFFE8F4FC);
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final chartBgColor = isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MARKET PULSE',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Current Rates',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _RateItem(
                      label: 'Home Loan',
                      rate: '3.25%',
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 12.h),
                    _RateItem(
                      label: 'Savings APY',
                      rate: '4.10%',
                      color: AppColors.warning,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Container(
                width: 100.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: chartBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CustomPaint(
                    painter: _ChartPainter(),
                    size: Size(100.w, 80.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RateItem extends StatelessWidget {
  final String label;
  final String rate;
  final Color color;

  const _RateItem({
    required this.label,
    required this.rate,
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
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          rate,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lightTextSecondary.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw simple bar chart lines
    for (int i = 0; i < 8; i++) {
      final x = (size.width / 8) * i + 8;
      final height = 20 + (i % 3) * 15 + (i * 5).toDouble();
      canvas.drawLine(
        Offset(x, size.height - 10),
        Offset(x, size.height - 10 - height.clamp(0, size.height - 20)),
        paint..strokeWidth = 6,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
