import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/savings_goal.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/presentation/goals/widgets/milestone_progress.dart';
import 'package:money/l10n/app_localizations.dart';

class GoalCard extends StatelessWidget {
  final SavingsGoal goal;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final l10n = AppLocalizations.of(context)!;

    final statusColor = _getStatusColor();
    final dateFormat = DateFormat('dd MMM yyyy');

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Dismissible(
        key: Key(goal.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
            color: AppColors.danger.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(CupertinoIcons.trash, color: AppColors.danger, size: 24.sp),
        ),
        onDismissed: (_) => onDelete?.call(),
        child: GestureDetector(
          onTap: onTap,
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        _getStatusIcon(),
                        color: statusColor,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goal.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(CupertinoIcons.calendar, size: 12.sp, color: textSecondary),
                              SizedBox(width: 4.w),
                              Text(
                                dateFormat.format(goal.deadline),
                                style: TextStyle(fontSize: 12.sp, color: textSecondary),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${goal.daysRemaining} days left',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: goal.daysRemaining <= 7 ? AppColors.warning : textSecondary,
                                  fontWeight: goal.daysRemaining <= 7 ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(CupertinoIcons.chevron_right, color: textSecondary, size: 16.sp),
                  ],
                ),
                SizedBox(height: 16.h),

                // Progress Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CurrencyFormatter.formatShort(goal.currentAmount),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                        Text(
                          'of ${CurrencyFormatter.formatShort(goal.targetAmount)}',
                          style: TextStyle(fontSize: 12.sp, color: textSecondary),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '${goal.progressPercentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Milestone Progress
                MilestoneProgress(
                  currentMilestone: goal.currentMilestone,
                  percentage: goal.progressPercentage,
                ),

                SizedBox(height: 8.h),

                // Suggested Monthly
                if (goal.status == GoalStatus.active && goal.suggestedMonthlyContribution > 0)
                  Text(
                    l10n.savePerMonth(CurrencyFormatter.formatShort(goal.suggestedMonthlyContribution)),
                    style: TextStyle(fontSize: 11.sp, color: textSecondary, fontStyle: FontStyle.italic),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (goal.status) {
      case GoalStatus.active:
        return goal.progressPercentage >= 75 ? AppColors.success : AppColors.primary;
      case GoalStatus.completed:
        return AppColors.success;
      case GoalStatus.paused:
        return AppColors.warning;
      case GoalStatus.expired:
        return AppColors.danger;
    }
  }

  IconData _getStatusIcon() {
    switch (goal.status) {
      case GoalStatus.active:
        return CupertinoIcons.flag_fill;
      case GoalStatus.completed:
        return CupertinoIcons.checkmark_circle_fill;
      case GoalStatus.paused:
        return CupertinoIcons.pause_circle_fill;
      case GoalStatus.expired:
        return CupertinoIcons.xmark_circle_fill;
    }
  }
}
