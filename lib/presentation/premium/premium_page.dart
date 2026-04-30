import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/success_dialog.dart';
import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/constants/app_constants.dart';
import 'package:money/core/services/premium_service.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/premium/premium_provider.dart';

/// Selected subscription type provider
final selectedSubscriptionProvider = StateProvider<SubscriptionType>((ref) => SubscriptionType.yearly);

/// Premium upgrade page
class PremiumPage extends ConsumerWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(premiumStatusProvider);
    final notifier = ref.read(premiumStatusProvider.notifier);
    final service = ref.watch(premiumServiceProvider);
    final selectedType = ref.watch(selectedSubscriptionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // Listen for purchase success to show dialog
    ref.listen<PremiumStatus>(premiumStatusProvider, (previous, next) {
      if (next.justPurchased && !(previous?.justPurchased ?? false)) {
        // Show success dialog
        SuccessDialog.show(
          context,
          title: l10n.premiumActivated,
          message: l10n.premiumThanks,
          buttonText: l10n.ok,
          lottieAsset: 'assets/lottie/premium_success.json',
          onDismiss: () {
            notifier.clearJustPurchased();
          },
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                        Colors.black,
                        AppColors.warning.withValues(alpha: 0.2),
                        Colors.black,
                      ]
                    : [
                        AppColors.lightBackground,
                        AppColors.warning.withValues(alpha: 0.15),
                        AppColors.lightBackground,
                      ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.back,
                          size: 20.sp,
                          color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),

                        // Premium icon with animation
                        _buildPremiumIcon()
                            .animate()
                            .scale(
                              begin: const Offset(0, 0),
                              end: const Offset(1, 1),
                              duration: 600.ms,
                              curve: Curves.elasticOut,
                            )
                            .then(delay: 200.ms)
                            .shimmer(duration: 1500.ms, color: Colors.white38),

                        SizedBox(height: 24.h),

                        // Title with animation
                        Text(
                          status.isPremium
                              ? l10n.premiumActivated
                              : l10n.premium,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 400.ms)
                            .slideY(begin: 0.2, end: 0),

                        SizedBox(height: 8.h),

                        Text(
                          status.isPremium
                              ? l10n.premiumThanks
                              : l10n.premiumDescription,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 300.ms, duration: 400.ms)
                            .slideY(begin: 0.2, end: 0),

                        SizedBox(height: 32.h),

                        // Features list with animation
                        _buildFeaturesList(isDark, l10n)
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 500.ms)
                            .slideY(begin: 0.1, end: 0),

                        SizedBox(height: 32.h),

                        // Price options with stagger animation
                        if (!status.isPremium) ...[
                          _buildPriceOptions(context, ref, service, selectedType, isDark, l10n),
                          SizedBox(height: 24.h),
                        ],

                        // Purchase button with animation
                        if (!status.isPremium)
                          _buildPurchaseButton(notifier, status, selectedType, isDark, l10n)
                              .animate()
                              .fadeIn(delay: 800.ms, duration: 400.ms)
                              .slideY(begin: 0.3, end: 0)
                              .then()
                              .shimmer(delay: 500.ms, duration: 1800.ms),

                        SizedBox(height: 16.h),

                        // Restore button
                        if (!status.isPremium)
                          _buildRestoreButton(notifier, status, isDark, l10n),

                        // Terms and Privacy links (required for App Store)
                        if (!status.isPremium)
                          _buildLegalLinks(isDark, l10n),

                        // Error message
                        if (status.error != null) ...[
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.danger.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.exclamationmark_circle,
                                  color: AppColors.danger,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    status.error!,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.danger,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Premium info for premium users
                        if (status.isPremium &&
                            status.purchaseDate != null) ...[
                          SizedBox(height: 24.h),
                          _buildPremiumInfo(status, isDark, l10n),
                        ],

                        // Test mode: reset button
                        if (kTestPremiumMode && status.isPremium) ...[
                          SizedBox(height: 16.h),
                          TextButton(
                            onPressed: () => notifier.clearPremium(),
                            child: Text(
                              '[TEST] Reset Premium',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.danger,
                              ),
                            ),
                          ),
                        ],

                        SizedBox(height: 40.h),
                      ],
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

  Widget _buildPremiumIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.warning,
            AppColors.warning.withValues(alpha: 0.7),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.warning.withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        CupertinoIcons.star_fill,
        size: 48.sp,
        color: Colors.white,
      ),
    );
  }

  Widget _buildFeaturesList(bool isDark, AppLocalizations l10n) {
    final features = [
      _FeatureItem(
        icon: CupertinoIcons.bell_fill,
        title: l10n.premiumFeature1,
        description: l10n.premiumFeature1Desc,
      ),
      _FeatureItem(
        icon: CupertinoIcons.calendar,
        title: l10n.calendar,
        description: l10n.calendarSubtitle,
      ),
      _FeatureItem(
        icon: CupertinoIcons.chart_bar_alt_fill,
        title: l10n.premiumFeature2,
        description: l10n.premiumFeature2Desc,
      ),
      _FeatureItem(
        icon: CupertinoIcons.arrow_right_arrow_left,
        title: l10n.premiumFeature3,
        description: l10n.premiumFeature3Desc,
      ),
      _FeatureItem(
        icon: CupertinoIcons.doc_text_fill,
        title: l10n.premiumFeature4,
        description: l10n.premiumFeature4Desc,
      ),
    ];

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.premiumFeatures,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            ...features.map((feature) => _buildFeatureRow(feature, isDark)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(_FeatureItem feature, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              feature.icon,
              size: 20.sp,
              color: AppColors.warning,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  feature.description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.checkmark_circle_fill,
            size: 22.sp,
            color: AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceOptions(
    BuildContext context,
    WidgetRef ref,
    PremiumService service,
    SubscriptionType selectedType,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        // Monthly option
        _buildPriceOption(
          context: context,
          ref: ref,
          type: SubscriptionType.monthly,
          selectedType: selectedType,
          price: service.getFormattedPrice(SubscriptionType.monthly),
          label: l10n.premiumMonthlyTitle,
          description: l10n.perMonth,
          isDark: isDark,
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 400.ms)
            .slideX(begin: -0.1, end: 0),
        SizedBox(height: 12.h),

        // Yearly option (recommended)
        _buildPriceOption(
          context: context,
          ref: ref,
          type: SubscriptionType.yearly,
          selectedType: selectedType,
          price: service.getFormattedPrice(SubscriptionType.yearly),
          label: l10n.premiumYearlyTitle,
          description: l10n.perYear,
          badge: 'Save 58%',
          isRecommended: true,
          isDark: isDark,
        )
            .animate()
            .fadeIn(delay: 600.ms, duration: 400.ms)
            .slideX(begin: -0.1, end: 0),
        SizedBox(height: 12.h),

        // Lifetime option
        _buildPriceOption(
          context: context,
          ref: ref,
          type: SubscriptionType.lifetime,
          selectedType: selectedType,
          price: service.getFormattedPrice(SubscriptionType.lifetime),
          label: l10n.premiumLifetimeTitle,
          description: l10n.payOnceOwnForever,
          isDark: isDark,
        )
            .animate()
            .fadeIn(delay: 700.ms, duration: 400.ms)
            .slideX(begin: -0.1, end: 0),
      ],
    );
  }

  Widget _buildPriceOption({
    required BuildContext context,
    required WidgetRef ref,
    required SubscriptionType type,
    required SubscriptionType selectedType,
    required String price,
    required String label,
    required String description,
    required bool isDark,
    String? badge,
    bool isRecommended = false,
  }) {
    final isSelected = type == selectedType;
    final borderColor = isSelected
        ? AppColors.warning
        : (isDark ? Colors.white24 : Colors.black12);
    final bgColor = isSelected
        ? AppColors.warning.withValues(alpha: 0.1)
        : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white);

    return GestureDetector(
      onTap: () => ref.read(selectedSubscriptionProvider.notifier).state = type,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.warning : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.warning,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 14.w),

            // Label and description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title - single line
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Description with badges
                  Row(
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                        ),
                      ),
                      if (badge != null) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      if (isRecommended) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.warning, AppColors.warning.withValues(alpha: 0.8)],
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Best',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Price
            Text(
              price,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.warning
                    : (isDark ? Colors.white : AppColors.lightTextPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseButton(
    PremiumStatusNotifier notifier,
    PremiumStatus status,
    SubscriptionType selectedType,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: status.isLoading ? null : () => notifier.purchasePremium(selectedType),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.warning,
              AppColors.warning.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.warning.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: status.isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.star_fill,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.upgradeNow,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildRestoreButton(
    PremiumStatusNotifier notifier,
    PremiumStatus status,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return TextButton(
      onPressed: status.isLoading ? null : () => notifier.restorePurchases(),
      child: Text(
        l10n.restorePurchase,
        style: TextStyle(
          fontSize: 15.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildLegalLinks(bool isDark, AppLocalizations l10n) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        children: [
          // Payment info text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              l10n.subscriptionPaymentInfo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark ? Colors.white54 : Colors.black54,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // Subscription info text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              l10n.subscriptionAutoRenewInfo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark ? Colors.white54 : Colors.black54,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Terms of Use (EULA), Terms of Service, and Privacy Policy links
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton(
                onPressed: () => _openUrl(AppConstants.eulaUrl),
                child: Text(
                  l10n.termsOfUse,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  '•',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _openUrl(AppConstants.termsOfServiceUrl),
                child: Text(
                  l10n.termsOfService,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  '•',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _openUrl(AppConstants.privacyPolicyUrl),
                child: Text(
                  l10n.privacyPolicy,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildPremiumInfo(PremiumStatus status, bool isDark, AppLocalizations l10n) {
    final dateStr = status.purchaseDate != null
        ? '${status.purchaseDate!.day}/${status.purchaseDate!.month}/${status.purchaseDate!.year}'
        : '';

    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Icon(
              CupertinoIcons.checkmark_seal_fill,
              size: 48.sp,
              color: AppColors.success,
            ),
            SizedBox(height: 12.h),
            Text(
              l10n.premiumActivated,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.purchaseDate(dateStr),
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
