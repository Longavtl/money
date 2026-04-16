import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/constants/glass_settings.dart';
import 'package:money_mate/presentation/premium/premium_provider.dart';
import 'package:money_mate/presentation/premium/widgets/premium_gate.dart';

/// Settings page
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumStatus = ref.watch(premiumStatusProvider);
    final premiumNotifier = ref.read(premiumStatusProvider.notifier);

    // AppShell provides LiquidGlassScope.stack and GlassBottomBar
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
                  'Cài đặt',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                        iconColor: Colors.amber,
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
                        const Divider(height: 1, color: Colors.white24),
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
                      const Divider(height: 1, color: Colors.white24),
                      _SettingsItem(
                        icon: CupertinoIcons.doc_text_fill,
                        title: 'Điều khoản sử dụng',
                        onTap: () {},
                      ),
                      const Divider(height: 1, color: Colors.white24),
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? Colors.white70,
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
                      color: Colors.white,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white60,
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
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white60,
                ),
              )
            else if (trailing != null)
              trailing!
            else
              Icon(
                CupertinoIcons.chevron_right,
                color: Colors.white.withValues(alpha: 0.3),
                size: 18.sp,
              ),
          ],
        ),
      ),
    );
  }
}
