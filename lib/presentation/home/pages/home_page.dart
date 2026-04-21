import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:money/l10n/app_localizations.dart';

import 'package:money/core/routes/app_routes.dart';
import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/services/remote_config_service.dart';
import 'package:money/presentation/premium/premium_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Check for app update after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RemoteConfigService.checkForUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final premiumStatus = ref.watch(premiumStatusProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Premium Banner with animation
              _PremiumBanner(
                isPremium: premiumStatus.isPremium,
                onTap: () => context.push(AppRoutes.premium),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0),

              SizedBox(height: 24.h),

              // Main Tools Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.mainTools,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  Text(
                    l10n.categories(4),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: textSecondary,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 400.ms)
                  .slideX(begin: -0.05, end: 0),

              SizedBox(height: 16.h),

              // Calculator Cards Grid - Row 1
              Row(
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: l10n.loanCalc,
                      subtitle: l10n.loanCalcSubtitle,
                      icon: CupertinoIcons.square_grid_2x2_fill,
                      iconColor: AppColors.warning,
                      onTap: () => context.push(AppRoutes.loan),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ToolCard(
                      title: l10n.interestCalc,
                      subtitle: l10n.interestCalcSubtitle,
                      icon: CupertinoIcons.graph_square,
                      iconColor: textPrimary,
                      onTap: () => context.push(AppRoutes.compoundInterest),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 150.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 12.h),

              // Calculator Cards Grid - Row 2
              Row(
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: l10n.vault,
                      subtitle: l10n.vaultSubtitle,
                      icon: CupertinoIcons.square_on_square,
                      iconColor: AppColors.warning,
                      onTap: () => context.push(AppRoutes.savings),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ToolCard(
                      title: l10n.earlyWithdrawal,
                      subtitle: l10n.earlyWithdrawalSubtitle,
                      icon: CupertinoIcons.arrow_down_circle_fill,
                      iconColor: AppColors.warning,
                      onTap: () => context.push(AppRoutes.earlyWithdrawal),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 24.h),

              // Financial Tools Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.financialTools,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 250.ms, duration: 400.ms)
                  .slideX(begin: -0.05, end: 0),

              SizedBox(height: 16.h),

              // Financial Tools Grid - Row 1
              Row(
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: l10n.reminders,
                      subtitle: l10n.paymentRemindersSubtitle,
                      icon: CupertinoIcons.bell_fill,
                      iconColor: AppColors.info,
                      onTap: () => context.push(AppRoutes.reminders),
                      isPremiumFeature: true,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ToolCard(
                      title: l10n.savingsGoals,
                      subtitle: l10n.savingsGoalsSubtitle,
                      icon: CupertinoIcons.flag_fill,
                      iconColor: AppColors.success,
                      onTap: () => context.push(AppRoutes.goals),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 12.h),

              // Financial Tools Grid - Row 2
              Row(
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: l10n.calendar,
                      subtitle: l10n.calendarSubtitle,
                      icon: CupertinoIcons.calendar,
                      iconColor: AppColors.primary,
                      onTap: () => context.push(AppRoutes.calendar),
                      isPremiumFeature: true,
                      isLocked: !premiumStatus.isPremium,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ToolCard(
                      title: l10n.achievements,
                      subtitle: l10n.achievementsSubtitle,
                      icon: CupertinoIcons.rosette,
                      iconColor: AppColors.warning,
                      onTap: () => context.push(AppRoutes.achievements),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 350.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 24.h),

              // QR Tools Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.qrTools,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 400.ms)
                  .slideX(begin: -0.05, end: 0),

              SizedBox(height: 16.h),

              // QR Tools Grid
              Row(
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: l10n.createQRCode,
                      subtitle: l10n.createQRSubtitle,
                      icon: CupertinoIcons.qrcode,
                      iconColor: AppColors.primary,
                      onTap: () => context.push(AppRoutes.createQR),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _ToolCard(
                      title: l10n.scanQRCode,
                      subtitle: l10n.scanQRSubtitle,
                      icon: CupertinoIcons.qrcode_viewfinder,
                      iconColor: AppColors.success,
                      onTap: () => context.push(AppRoutes.qrScanner),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 450.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 24.h),

              // Current Rates Section with animation
              _CurrentRatesCard()
                  .animate()
                  .fadeIn(delay: 500.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

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
    final l10n = AppLocalizations.of(context)!;

    // Premium user banner
    if (isPremium) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFD700),
                Color(0xFFFFA500),
                Color(0xFFFF8C00),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  CupertinoIcons.star_fill,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.premiumMember,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      l10n.premiumThanks,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.checkmark_seal_fill,
                      color: const Color(0xFFFF8C00),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      l10n.pro,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF8C00),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Non-premium user banner (upgrade CTA)
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
              Color(0xFF667EEA),
              Color(0xFF764BA2),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        size: 10.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        l10n.proAccess,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: Colors.white.withOpacity(0.7),
                  size: 24.sp,
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.upgradeToPremium,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        l10n.premiumBannerDesc,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    CupertinoIcons.sparkles,
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
  final bool isPremiumFeature;
  final bool isLocked;

  const _ToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.isPremiumFeature = false,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GestureDetector(
      onTap: isLocked ? () => context.push(AppRoutes.premium) : onTap,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    color: isLocked ? textSecondary : iconColor,
                    size: 22.sp,
                  ),
                ),
                if (isPremiumFeature || isLocked)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      gradient: isLocked
                          ? null
                          : const LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                            ),
                      color: isLocked ? textSecondary.withOpacity(0.2) : null,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isLocked)
                          Icon(
                            CupertinoIcons.lock_fill,
                            size: 10.sp,
                            color: textSecondary,
                          ),
                        if (isLocked) SizedBox(width: 2.w),
                        Text(
                          l10n.pro,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: isLocked ? textSecondary : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isLocked ? textSecondary : textPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              height: 32.h, // Fixed height for 2 lines
              child: Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: textSecondary,
                  height: 1.3,
                ),
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor =
        isDark ? const Color(0xFF1A2A3A) : const Color(0xFFE8F4FC);
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final chartBgColor =
        isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5);

    // Get market rates based on current locale
    final locale = Localizations.localeOf(context);
    final rates = RemoteConfigService.getMarketRatesSync(locale.languageCode);

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
            l10n.marketPulse,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.currentRates,
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
                      label: l10n.homeLoan,
                      rate: rates.homeLoanRate,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 12.h),
                    _RateItem(
                      label: l10n.savingsApy,
                      rate: rates.savingsRate,
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
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

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
