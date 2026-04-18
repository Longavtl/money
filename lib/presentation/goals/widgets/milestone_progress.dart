import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/domain/entities/savings_goal.dart';
import 'package:money/l10n/app_localizations.dart';

class MilestoneProgress extends StatelessWidget {
  final GoalMilestone currentMilestone;
  final double percentage;

  const MilestoneProgress({
    super.key,
    required this.currentMilestone,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      children: [
        // Progress Bar with milestones
        Stack(
          children: [
            // Background
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                color: textSecondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            // Progress
            FractionallySizedBox(
              widthFactor: (percentage / 100).clamp(0.0, 1.0),
              child: Container(
                height: 8.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.success],
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            // Milestone markers
            Positioned.fill(
              child: Row(
                children: [
                  _buildMilestoneMarker(0, GoalMilestone.start, textSecondary),
                  Expanded(child: Container()),
                  _buildMilestoneMarker(25, GoalMilestone.twentyFive, textSecondary),
                  Expanded(child: Container()),
                  _buildMilestoneMarker(50, GoalMilestone.fifty, textSecondary),
                  Expanded(child: Container()),
                  _buildMilestoneMarker(75, GoalMilestone.seventyFive, textSecondary),
                  Expanded(child: Container()),
                  _buildMilestoneMarker(100, GoalMilestone.complete, textSecondary),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        // Milestone labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('0%', style: TextStyle(fontSize: 9.sp, color: textSecondary)),
            Text('25%', style: TextStyle(fontSize: 9.sp, color: textSecondary)),
            Text('50%', style: TextStyle(fontSize: 9.sp, color: textSecondary)),
            Text('75%', style: TextStyle(fontSize: 9.sp, color: textSecondary)),
            Text('100%', style: TextStyle(fontSize: 9.sp, color: textSecondary)),
          ],
        ),
      ],
    );
  }

  Widget _buildMilestoneMarker(int milestonePercent, GoalMilestone milestone, Color textSecondary) {
    final isReached = percentage >= milestonePercent;
    final isCurrent = currentMilestone == milestone;

    return Container(
      width: isCurrent ? 14.w : 10.w,
      height: isCurrent ? 14.h : 10.h,
      decoration: BoxDecoration(
        color: isReached ? AppColors.success : textSecondary.withValues(alpha: 0.3),
        shape: BoxShape.circle,
        border: isCurrent
            ? Border.all(color: AppColors.success, width: 2.w)
            : null,
        boxShadow: isCurrent
            ? [BoxShadow(color: AppColors.success.withValues(alpha: 0.3), blurRadius: 4, spreadRadius: 1)]
            : null,
      ),
    );
  }
}

class MilestoneProgressLarge extends StatelessWidget {
  final GoalMilestone currentMilestone;
  final double percentage;

  const MilestoneProgressLarge({
    super.key,
    required this.currentMilestone,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMilestoneItem(0, l10n.start, GoalMilestone.start, textPrimary, textSecondary),
            _buildMilestoneConnector(25, textSecondary),
            _buildMilestoneItem(25, '25%', GoalMilestone.twentyFive, textPrimary, textSecondary),
            _buildMilestoneConnector(50, textSecondary),
            _buildMilestoneItem(50, '50%', GoalMilestone.fifty, textPrimary, textSecondary),
            _buildMilestoneConnector(75, textSecondary),
            _buildMilestoneItem(75, '75%', GoalMilestone.seventyFive, textPrimary, textSecondary),
            _buildMilestoneConnector(100, textSecondary),
            _buildMilestoneItem(100, l10n.goalReached, GoalMilestone.complete, textPrimary, textSecondary),
          ],
        ),
      ],
    );
  }

  Widget _buildMilestoneItem(
    int milestonePercent,
    String label,
    GoalMilestone milestone,
    Color textPrimary,
    Color textSecondary,
  ) {
    final isReached = percentage >= milestonePercent;
    final isCurrent = currentMilestone == milestone;

    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: isReached ? AppColors.success : textSecondary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: isCurrent
                ? Border.all(color: AppColors.success, width: 3.w)
                : null,
            boxShadow: isCurrent
                ? [BoxShadow(color: AppColors.success.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 2)]
                : null,
          ),
          child: isReached
              ? Icon(Icons.check, color: Colors.white, size: 18.sp)
              : null,
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: isReached ? FontWeight.w600 : FontWeight.normal,
            color: isReached ? textPrimary : textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneConnector(int nextMilestonePercent, Color textSecondary) {
    final progress = percentage >= nextMilestonePercent
        ? 1.0
        : percentage >= (nextMilestonePercent - 25)
            ? (percentage - (nextMilestonePercent - 25)) / 25
            : 0.0;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Stack(
          children: [
            Container(
              height: 4.h,
              decoration: BoxDecoration(
                color: textSecondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
