import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/services/premium_service.dart';
import 'package:money/presentation/premium/premium_provider.dart';

/// Premium upgrade page
class PremiumPage extends ConsumerWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(premiumStatusProvider);
    final notifier = ref.read(premiumStatusProvider.notifier);
    final service = ref.watch(premiumServiceProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
                        Colors.white,
                        AppColors.warning.withValues(alpha: 0.15),
                        Colors.white,
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
                      GlassButton(
                        icon: Icon(
                          CupertinoIcons.back,
                          size: 20.sp,
                        ),
                        onTap: () => context.pop(),
                        width: 44.w,
                        height: 44.w,
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

                        // Premium icon
                        _buildPremiumIcon(),

                        SizedBox(height: 24.h),

                        // Title
                        Text(
                          status.isPremium
                              ? 'Bạn đã là Premium!'
                              : 'Nâng cấp Premium',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          status.isPremium
                              ? 'Cảm ơn bạn đã ủng hộ!'
                              : 'Mở khóa tất cả tính năng',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Features list
                        _buildFeaturesList(isDark),

                        SizedBox(height: 32.h),

                        // Price card
                        if (!status.isPremium) ...[
                          _buildPriceCard(service, isDark),
                          SizedBox(height: 24.h),
                        ],

                        // Purchase button
                        if (!status.isPremium)
                          _buildPurchaseButton(notifier, status, isDark),

                        SizedBox(height: 16.h),

                        // Restore button
                        if (!status.isPremium)
                          _buildRestoreButton(notifier, status, isDark),

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
                          _buildPremiumInfo(status, isDark),
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

  Widget _buildFeaturesList(bool isDark) {
    const features = [
      _FeatureItem(
        icon: CupertinoIcons.infinite,
        title: 'Lưu không giới hạn',
        description: 'Lưu trữ tất cả các khoản vay và tiết kiệm',
      ),
      _FeatureItem(
        icon: CupertinoIcons.chart_bar_alt_fill,
        title: 'Biểu đồ đầy đủ',
        description: 'Xem chi tiết với tất cả loại biểu đồ',
      ),
      _FeatureItem(
        icon: CupertinoIcons.arrow_right_arrow_left,
        title: 'So sánh kịch bản',
        description: 'So sánh nhiều phương án song song',
      ),
      _FeatureItem(
        icon: CupertinoIcons.doc_text_fill,
        title: 'Xuất PDF',
        description: 'Tạo báo cáo chi tiết để in hoặc chia sẻ',
      ),
      _FeatureItem(
        icon: CupertinoIcons.heart_fill,
        title: 'Hỗ trợ phát triển',
        description: 'Giúp chúng tôi cải thiện ứng dụng',
      ),
    ];

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tính năng Premium',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
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
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  feature.description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark ? Colors.white60 : Colors.black54,
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

  Widget _buildPriceCard(PremiumService service, bool isDark) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Trọn đời',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              service.formattedPrice,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Thanh toán một lần, sử dụng mãi mãi',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? Colors.white60 : Colors.black54,
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
    bool isDark,
  ) {
    return GestureDetector(
      onTap: status.isLoading ? null : () => notifier.purchasePremium(),
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
                      'Nâng cấp ngay',
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
  ) {
    return TextButton(
      onPressed: status.isLoading ? null : () => notifier.restorePurchases(),
      child: Text(
        'Khôi phục giao dịch',
        style: TextStyle(
          fontSize: 15.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildPremiumInfo(PremiumStatus status, bool isDark) {
    final dateStr = status.purchaseDate != null
        ? '${status.purchaseDate!.day}/${status.purchaseDate!.month}/${status.purchaseDate!.year}'
        : '';

    return GlassCard(
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
              'Premium đã kích hoạt',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Ngày mua: $dateStr',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? Colors.white60 : Colors.black54,
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
