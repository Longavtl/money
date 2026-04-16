import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';
import 'package:money_mate/presentation/premium/widgets/premium_gate.dart';

/// Settings page
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final premiumStatus = ref.watch(premiumStatusProvider);
    final premiumNotifier = ref.read(premiumStatusProvider.notifier);

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
                  child: Text(
                    'Cài đặt',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                ),
              ),

              // Settings groups
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GlassCard(
                    child: Column(
                      children: [
                        _SettingsItem(
                          icon: CupertinoIcons.moon_fill,
                          title: 'Giao diện',
                          subtitle: 'Hệ thống',
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        _SettingsItem(
                          icon: CupertinoIcons.globe,
                          title: 'Ngôn ngữ',
                          subtitle: 'Tiếng Việt',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // Premium section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GlassCard(
                    child: Column(
                      children: [
                        _SettingsItem(
                          icon: CupertinoIcons.star_fill,
                          iconColor: AppColors.warning,
                          title: 'MoneyMate Premium',
                          subtitle: premiumStatus.isPremium
                              ? 'Đã kích hoạt'
                              : 'Mở khóa tất cả tính năng',
                          trailing: premiumStatus.isPremium
                              ? const PremiumBadge(size: 16)
                              : null,
                          onTap: () => context.push('/premium'),
                        ),
                        if (!premiumStatus.isPremium) ...[
                          const Divider(height: 1),
                          _SettingsItem(
                            icon: CupertinoIcons.arrow_counterclockwise,
                            title: 'Khôi phục mua hàng',
                            isLoading: premiumStatus.isLoading,
                            onTap: () => premiumNotifier.restorePurchases(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // About section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GlassCard(
                    child: Column(
                      children: [
                        _SettingsItem(
                          icon: CupertinoIcons.info_circle_fill,
                          title: 'Về ứng dụng',
                          subtitle: 'Phiên bản 1.0.0',
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        _SettingsItem(
                          icon: CupertinoIcons.doc_text_fill,
                          title: 'Điều khoản sử dụng',
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        _SettingsItem(
                          icon: CupertinoIcons.shield_fill,
                          title: 'Chính sách bảo mật',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isLoading;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.isLoading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? (isDark ? Colors.white70 : AppColors.lightTextSecondary),
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isLoading)
              SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                ),
              )
            else if (trailing != null)
              trailing!
            else
              Icon(
                CupertinoIcons.chevron_right,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.3)
                    : AppColors.lightTextSecondary.withValues(alpha: 0.5),
                size: 18.sp,
              ),
          ],
        ),
      ),
    );
  }
}
