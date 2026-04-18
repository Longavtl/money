import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/domain/entities/gamification.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/achievements/achievements_provider.dart';
import 'package:money/common/widgets/app_card.dart';

class AchievementsPage extends ConsumerWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(achievementsProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.achievements,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: textPrimary),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Health Score Card
                  _buildHealthScoreCard(state, l10n, textPrimary, textSecondary),
                  SizedBox(height: 16.h),

                  // Streak Card
                  _buildStreakCard(state.streak, l10n, textPrimary, textSecondary),
                  SizedBox(height: 20.h),

                  // Unlocked Achievements
                  if (state.unlockedAchievements.isNotEmpty) ...[
                    _buildSectionHeader(l10n.unlocked, AppColors.success, state.unlockedAchievements.length, textPrimary),
                    SizedBox(height: 8.h),
                    ...state.unlockedAchievements.map((a) => _AchievementCard(
                      achievement: a,
                      isUnlocked: true,
                      l10n: l10n,
                    )),
                    SizedBox(height: 16.h),
                  ],

                  // Locked Achievements
                  if (state.lockedAchievements.isNotEmpty) ...[
                    _buildSectionHeader(l10n.locked, textSecondary, state.lockedAchievements.length, textPrimary),
                    SizedBox(height: 8.h),
                    ...state.lockedAchievements.map((a) => _AchievementCard(
                      achievement: a,
                      isUnlocked: false,
                      l10n: l10n,
                    )),
                  ],

                  SizedBox(height: 100.h),
                ],
              ),
            ),
    );
  }

  Widget _buildHealthScoreCard(AchievementsState state, AppLocalizations l10n, Color textPrimary, Color textSecondary) {
    final gradeColor = _getGradeColor(state.healthGrade);

    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              // Score Circle
              SizedBox(
                width: 100.w,
                height: 100.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 90.w,
                      height: 90.h,
                      child: CircularProgressIndicator(
                        value: state.healthScore / 100,
                        strokeWidth: 10.w,
                        backgroundColor: textSecondary.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(gradeColor),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.healthGrade,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: gradeColor,
                          ),
                        ),
                        Text(
                          '${state.healthScore.toInt()}',
                          style: TextStyle(fontSize: 12.sp, color: textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.financialHealthScore,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getHealthMessage(state.healthScore, l10n),
                      style: TextStyle(fontSize: 12.sp, color: textSecondary),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(CupertinoIcons.star_fill, color: AppColors.warning, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          '${state.totalPoints} ${l10n.points}',
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: textPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(UserStreak streak, AppLocalizations l10n, Color textPrimary, Color textSecondary) {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.warning, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              CupertinoIcons.flame_fill,
              color: Colors.white,
              size: 32.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.paymentStreak,
                  style: TextStyle(fontSize: 14.sp, color: textSecondary),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${streak.currentStreak}',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warning,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      l10n.days,
                      style: TextStyle(fontSize: 16.sp, color: textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(l10n.longest, style: TextStyle(fontSize: 12.sp, color: textSecondary)),
              Text(
                '${streak.longestStreak} ${l10n.days}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: textPrimary),
              ),
              if (streak.lastPaymentDate != null) ...[
                SizedBox(height: 4.h),
                Text(
                  DateFormat('dd MMM').format(streak.lastPaymentDate!),
                  style: TextStyle(fontSize: 11.sp, color: textSecondary),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color, int count, Color textPrimary) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: color),
          ),
        ),
      ],
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return AppColors.success;
      case 'B+':
      case 'B':
        return AppColors.primary;
      case 'C':
        return AppColors.warning;
      default:
        return AppColors.danger;
    }
  }

  String _getHealthMessage(double score, AppLocalizations l10n) {
    if (score >= 90) return l10n.healthExcellent;
    if (score >= 70) return l10n.healthGood;
    if (score >= 50) return l10n.healthFair;
    return l10n.healthNeedsWork;
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final bool isUnlocked;
  final AppLocalizations l10n;

  const _AchievementCard({
    required this.achievement,
    required this.isUnlocked,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final locale = Localizations.localeOf(context).languageCode;

    final title = locale == 'vi' ? achievement.titleVi : achievement.titleEn;
    final description = locale == 'vi' ? achievement.descriptionVi : achievement.descriptionEn;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: AppCard(
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: isUnlocked
                    ? _getTypeColor(achievement.type).withValues(alpha: 0.1)
                    : textSecondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  achievement.icon,
                  style: TextStyle(fontSize: 28.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isUnlocked ? textPrimary : textSecondary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: textSecondary.withValues(alpha: isUnlocked ? 1 : 0.6),
                    ),
                  ),
                  if (!isUnlocked) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: LinearProgressIndicator(
                              value: achievement.currentValue / achievement.targetValue,
                              backgroundColor: textSecondary.withValues(alpha: 0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(_getTypeColor(achievement.type)),
                              minHeight: 6.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${achievement.currentValue}/${achievement.targetValue}',
                          style: TextStyle(fontSize: 10.sp, color: textSecondary),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (isUnlocked)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.star_fill, size: 12.sp, color: AppColors.warning),
                    SizedBox(width: 4.w),
                    Text(
                      '${achievement.points}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
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

  Color _getTypeColor(AchievementType type) {
    switch (type) {
      case AchievementType.paymentStreak:
        return AppColors.warning;
      case AchievementType.totalPaid:
        return AppColors.success;
      case AchievementType.goalsReached:
        return AppColors.primary;
      case AchievementType.onTimePayments:
        return AppColors.info;
      case AchievementType.earlyPayments:
        return AppColors.success;
      case AchievementType.savingsGrowth:
        return AppColors.primary;
      case AchievementType.firstPayment:
        return AppColors.warning;
      case AchievementType.firstGoal:
        return AppColors.info;
    }
  }
}
