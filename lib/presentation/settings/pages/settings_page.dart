import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/providers/settings_provider.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/premium/premium_provider.dart';
import 'package:money/presentation/premium/widgets/premium_gate.dart';
import 'package:money/common/widgets/app_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumStatus = ref.watch(premiumStatusProvider);
    final premiumNotifier = ref.read(premiumStatusProvider.notifier);
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    String getThemeLabel(AppThemeMode mode) {
      switch (mode) {
        case AppThemeMode.light:
          return l10n.themeLight;
        case AppThemeMode.dark:
          return l10n.themeDark;
        case AppThemeMode.system:
          return l10n.themeSystem;
      }
    }

    String getCurrentLanguageName() {
      final lang = supportedLanguages.firstWhere(
        (l) => l.code == settings.languageCode,
        orElse: () => supportedLanguages.first,
      );
      return lang.nativeName;
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  l10n.settings,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.headlineLarge?.color,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _SettingsItem(
                        icon: CupertinoIcons.sun_max_fill,
                        iconColor: Colors.orange,
                        title: l10n.theme,
                        subtitle: getThemeLabel(settings.themeMode),
                        onTap: () => _showThemePicker(context, settings.themeMode, settingsNotifier, l10n, isDark),
                      ),
                      Divider(height: 1, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      _SettingsItem(
                        icon: CupertinoIcons.globe,
                        iconColor: Colors.blue,
                        title: l10n.language,
                        subtitle: getCurrentLanguageName(),
                        onTap: () => _showLanguagePicker(context, settings.languageCode, settingsNotifier, isDark),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _SettingsItem(
                        icon: CupertinoIcons.star_fill,
                        iconColor: Colors.amber,
                        title: 'MoneyMate Premium',
                        subtitle: premiumStatus.isPremium ? 'Activated' : 'Unlock all features',
                        trailing: premiumStatus.isPremium ? const PremiumBadge(size: 16) : null,
                        onTap: () => context.push('/premium'),
                      ),
                      if (!premiumStatus.isPremium) ...[
                        Divider(height: 1, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                        _SettingsItem(
                          icon: CupertinoIcons.arrow_counterclockwise,
                          title: 'Restore Purchase',
                          isLoading: premiumStatus.isLoading,
                          onTap: () => premiumNotifier.restorePurchases(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _SettingsItem(
                        icon: CupertinoIcons.info_circle_fill,
                        title: 'About',
                        subtitle: 'Version 1.0.0',
                        onTap: () {},
                      ),
                      Divider(height: 1, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      _SettingsItem(
                        icon: CupertinoIcons.doc_text_fill,
                        title: 'Terms of Service',
                        onTap: () {},
                      ),
                      Divider(height: 1, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      _SettingsItem(
                        icon: CupertinoIcons.shield_fill,
                        title: 'Privacy Policy',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemePicker(
    BuildContext context,
    AppThemeMode currentMode,
    SettingsNotifier notifier,
    AppLocalizations l10n,
    bool isDark,
  ) {
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final sheetBackground = isDark ? AppColors.darkSurface : Colors.white;

    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.theme,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: textPrimary),
            ),
            SizedBox(height: 8.h),
            ...AppThemeMode.values.map((mode) => ListTile(
                  leading: Icon(
                    mode == AppThemeMode.light
                        ? CupertinoIcons.sun_max_fill
                        : mode == AppThemeMode.dark
                            ? CupertinoIcons.moon_fill
                            : CupertinoIcons.device_phone_portrait,
                    color: mode == currentMode ? AppColors.primary : textSecondary,
                  ),
                  title: Text(
                    mode == AppThemeMode.light
                        ? l10n.themeLight
                        : mode == AppThemeMode.dark
                            ? l10n.themeDark
                            : l10n.themeSystem,
                    style: TextStyle(
                      color: mode == currentMode ? AppColors.primary : textPrimary,
                      fontWeight: mode == currentMode ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: mode == currentMode
                      ? Icon(CupertinoIcons.checkmark, color: AppColors.primary)
                      : null,
                  onTap: () {
                    notifier.setThemeMode(mode);
                    Navigator.pop(context);
                  },
                )),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    String currentCode,
    SettingsNotifier notifier,
    bool isDark,
  ) {
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final sheetBackground = isDark ? AppColors.darkSurface : Colors.white;

    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBackground,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Language',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: textPrimary),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: supportedLanguages.length,
                  itemBuilder: (context, index) {
                    final lang = supportedLanguages[index];
                    final isSelected = lang.code == currentCode;
                    return ListTile(
                      title: Text(
                        lang.nativeName,
                        style: TextStyle(
                          color: isSelected ? AppColors.primary : textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        lang.name,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: textSecondary,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(CupertinoIcons.checkmark, color: AppColors.primary)
                          : null,
                      onTap: () {
                        notifier.setLanguage(lang.code);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? textSecondary, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16.sp, color: textPrimary)),
                  if (subtitle != null)
                    Text(subtitle!, style: TextStyle(fontSize: 13.sp, color: textSecondary)),
                ],
              ),
            ),
            if (isLoading)
              SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: CircularProgressIndicator(strokeWidth: 2, color: textSecondary),
              )
            else if (trailing != null)
              trailing!
            else
              Icon(CupertinoIcons.chevron_right, color: textSecondary.withOpacity(0.5), size: 18.sp),
          ],
        ),
      ),
    );
  }
}
