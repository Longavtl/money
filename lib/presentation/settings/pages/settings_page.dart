import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/providers/settings_provider.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/premium/premium_provider.dart';
import 'package:money/presentation/premium/widgets/premium_gate.dart';
import 'package:money/common/widgets/app_card.dart';

/// SVG asset paths for settings icons
class _SettingsAssets {
  static const String theme = 'assets/svg/theme.svg';
  static const String lang = 'assets/svg/lang.svg';
  static const String report = 'assets/svg/report.svg';
  static const String notification = 'assets/svg/notification.svg';
  static const String about = 'assets/svg/about.svg';
  static const String term = 'assets/svg/term.svg';
  static const String privacy = 'assets/svg/privacy.svg';
  static const String issueReport = 'assets/svg/issue_report.svg';
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumStatus = ref.watch(premiumStatusProvider);
    final premiumNotifier = ref.read(premiumStatusProvider.notifier);
    final settings = ref.watch(settingsProvider);
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

    SupportedLanguage getCurrentLanguage() {
      return supportedLanguages.firstWhere(
        (l) => l.code == settings.languageCode,
        orElse: () => supportedLanguages.first,
      );
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
                        svgPath: _SettingsAssets.theme,
                        iconColor: Colors.orange,
                        title: l10n.theme,
                        subtitle: getThemeLabel(settings.themeMode),
                        onTap: () => _showThemePicker(context, ref, l10n),
                      ),
                      Divider(
                          height: 1,
                          indent: 56.w,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                      _SettingsItem(
                        svgPath: _SettingsAssets.lang,
                        iconColor: Colors.blue,
                        title: l10n.language,
                        subtitle:
                            '${getCurrentLanguage().flag} ${getCurrentLanguage().nativeName}',
                        onTap: () => _showLanguagePicker(context, ref),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: premiumStatus.isPremium
                    ? _PremiumCard(onTap: () => context.push('/premium'))
                    : AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            _SettingsItem(
                              icon: CupertinoIcons.star_fill,
                              iconColor: Colors.amber,
                              title: 'MoneyNest ${l10n.premium}',
                              subtitle: l10n.unlockAllFeatures,
                              onTap: () => context.push('/premium'),
                            ),
                            Divider(
                                height: 1,
                                indent: 56.w,
                                color: isDark
                                    ? AppColors.darkBorder
                                    : AppColors.lightBorder),
                            _SettingsItem(
                              icon: CupertinoIcons.arrow_counterclockwise,
                              iconColor: Colors.green,
                              title: l10n.restorePurchase,
                              isLoading: premiumStatus.isLoading,
                              onTap: () => premiumNotifier.restorePurchases(),
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
                        svgPath: _SettingsAssets.report,
                        iconColor: Colors.blue,
                        title: l10n.reports,
                        subtitle: l10n.reportsSubtitle,
                        onTap: () => context.push('/reports'),
                      ),
                      Divider(
                          height: 1,
                          indent: 56.w,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                      _SettingsItem(
                        svgPath: _SettingsAssets.notification,
                        iconColor: Colors.red,
                        title: l10n.rateAlerts,
                        subtitle: l10n.rateAlertsSubtitle,
                        onTap: () => context.push('/rate-alerts'),
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
                        svgPath: _SettingsAssets.about,
                        iconColor: Colors.purple,
                        title: l10n.about,
                        subtitle: l10n.version('1.0.0'),
                        onTap: () {},
                      ),
                      Divider(
                          height: 1,
                          indent: 56.w,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                      _SettingsItem(
                        svgPath: _SettingsAssets.term,
                        iconColor: Colors.teal,
                        title: l10n.termsOfService,
                        onTap: () => context.push('/legal/terms', extra: l10n.termsOfService),
                      ),
                      Divider(
                          height: 1,
                          indent: 56.w,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                      _SettingsItem(
                        svgPath: _SettingsAssets.privacy,
                        iconColor: Colors.indigo,
                        title: l10n.privacyPolicy,
                        onTap: () => context.push('/legal/privacy', extra: l10n.privacyPolicy),
                      ),
                      Divider(
                          height: 1,
                          indent: 56.w,
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                      _SettingsItem(
                        svgPath: _SettingsAssets.issueReport,
                        iconColor: Colors.red,
                        title: l10n.reportIssue,
                        subtitle: l10n.reportIssueSubtitle,
                        onTap: () => _openReportEmail(context),
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
      BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final settings = ref.read(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final sheetBackground = isDark ? AppColors.darkSurface : Colors.white;
    final cardBackground =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        AppThemeMode selectedMode = settings.themeMode;
        return StatefulBuilder(
          builder: (context, setModalState) => Container(
            decoration: BoxDecoration(
              color: sheetBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      l10n.theme,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: textPrimary),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.selectThemeDescription,
                      style: TextStyle(fontSize: 14.sp, color: textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    ...AppThemeMode.values.map((mode) {
                      final isSelected = mode == selectedMode;
                      final IconData icon;
                      final String label;
                      switch (mode) {
                        case AppThemeMode.light:
                          icon = CupertinoIcons.sun_max_fill;
                          label = l10n.themeLight;
                          break;
                        case AppThemeMode.dark:
                          icon = CupertinoIcons.moon_fill;
                          label = l10n.themeDark;
                          break;
                        case AppThemeMode.system:
                          icon = CupertinoIcons.device_phone_portrait;
                          label = l10n.themeSystem;
                          break;
                      }
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: GestureDetector(
                          onTap: () => setModalState(() => selectedMode = mode),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.1)
                                  : cardBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                            .withValues(alpha: 0.2)
                                        : (isDark
                                            ? Colors.grey[800]
                                            : Colors.grey[200]),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(icon,
                                      color: isSelected
                                          ? AppColors.primary
                                          : textSecondary,
                                      size: 22.sp),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? AppColors.primary
                                          : textPrimary,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(CupertinoIcons.checkmark_circle_fill,
                                      color: AppColors.primary, size: 24.sp),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          settingsNotifier.setThemeMode(selectedMode);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text(l10n.apply,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _openReportEmail(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = '${packageInfo.version} (${packageInfo.buildNumber})';
    final subject = 'MoneyNest Issue Report - v$version';
    final body =
        'Please describe the issue:\n\n\n\n---\nApp Version: $version\n';

    final url =
        'mailto:longavtl@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final sheetBackground = isDark ? AppColors.darkSurface : Colors.white;
    final cardBackground =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        String selectedCode = settings.languageCode;
        return StatefulBuilder(
          builder: (context, setModalState) => Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75),
            decoration: BoxDecoration(
              color: sheetBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[700] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          l10n.language,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: textPrimary),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          l10n.selectLanguageDescription,
                          style:
                              TextStyle(fontSize: 14.sp, color: textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: supportedLanguages.length,
                      itemBuilder: (context, index) {
                        final lang = supportedLanguages[index];
                        final isSelected = lang.code == selectedCode;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: GestureDetector(
                            onTap: () =>
                                setModalState(() => selectedCode = lang.code),
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.1)
                                    : cardBackground,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(lang.flag,
                                      style: TextStyle(fontSize: 28.sp)),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.nativeName,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                            color: isSelected
                                                ? AppColors.primary
                                                : textPrimary,
                                          ),
                                        ),
                                        Text(
                                          lang.name,
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: textSecondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(CupertinoIcons.checkmark_circle_fill,
                                        color: AppColors.primary, size: 24.sp),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          settingsNotifier.setLanguage(selectedCode);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text(l10n.apply,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PremiumCard extends StatelessWidget {
  final VoidCallback onTap;

  const _PremiumCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
              color: const Color(0xFFFFD700).withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                CupertinoIcons.star_fill,
                color: Colors.white,
                size: 26.sp,
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
                        l10n.premiumMember,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          l10n.pro,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF8C00),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
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
            Icon(
              CupertinoIcons.checkmark_seal_fill,
              color: Colors.white,
              size: 28.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isLoading;
  final VoidCallback onTap;

  const _SettingsItem({
    this.icon,
    this.svgPath,
    this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.isLoading = false,
    required this.onTap,
  }) : assert(icon != null || svgPath != null,
            'Either icon or svgPath must be provided');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final color = iconColor ?? textSecondary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: svgPath != null
                  ? SvgPicture.asset(
                      svgPath!,
                      width: 18.sp,
                      height: 18.sp,
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    )
                  : Icon(icon, color: color, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: textPrimary)),
                  if (subtitle != null)
                    Text(subtitle!,
                        style:
                            TextStyle(fontSize: 13.sp, color: textSecondary)),
                ],
              ),
            ),
            if (isLoading)
              SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: textSecondary),
              )
            else if (trailing != null)
              trailing!
            else
              Icon(CupertinoIcons.chevron_right,
                  color: textSecondary.withValues(alpha: 0.5), size: 18.sp),
          ],
        ),
      ),
    );
  }
}
