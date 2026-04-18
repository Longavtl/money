import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/savings_goal.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/goals/goals_provider.dart';
import 'package:money/presentation/goals/widgets/milestone_progress.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/common/widgets/app_slider.dart';

class GoalDetailPage extends ConsumerWidget {
  final String goalId;

  const GoalDetailPage({super.key, required this.goalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalsProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final goal = state.goals.firstWhere(
      (g) => g.id == goalId,
      orElse: () => throw Exception('Goal not found'),
    );

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
          goal.name,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: textPrimary),
        ),
        actions: [
          if (goal.status == GoalStatus.active)
            PopupMenuButton<String>(
              icon: Icon(CupertinoIcons.ellipsis, color: textPrimary),
              onSelected: (value) => _handleMenuAction(context, ref, goal, value),
              itemBuilder: (ctx) => [
                PopupMenuItem(value: 'pause', child: Text(l10n.pauseGoal)),
                PopupMenuItem(value: 'delete', child: Text(l10n.deleteGoal, style: TextStyle(color: AppColors.danger))),
              ],
            ),
          if (goal.status == GoalStatus.paused)
            IconButton(
              icon: Icon(CupertinoIcons.play_fill, color: AppColors.primary),
              onPressed: () => ref.read(goalsProvider.notifier).resumeGoal(goalId),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Card
            _buildProgressCard(goal, l10n, textPrimary, textSecondary),
            SizedBox(height: 16.h),

            // Milestone Progress (Large)
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.milestones,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
                  ),
                  SizedBox(height: 16.h),
                  MilestoneProgressLarge(
                    currentMilestone: goal.currentMilestone,
                    percentage: goal.progressPercentage,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Quick Actions
            if (goal.status == GoalStatus.active) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showAddContributionSheet(context, ref, goal, l10n),
                      icon: Icon(CupertinoIcons.plus, size: 18.sp),
                      label: Text(l10n.addMoney),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: goal.currentAmount > 0
                          ? () => _showWithdrawSheet(context, ref, goal, l10n)
                          : null,
                      icon: Icon(CupertinoIcons.minus, size: 18.sp),
                      label: Text(l10n.withdraw),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.warning,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        side: BorderSide(color: AppColors.warning),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],

            // Contribution History
            _buildHistorySection(context, goal, l10n, textPrimary, textSecondary),

            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(SavingsGoal goal, AppLocalizations l10n, Color textPrimary, Color textSecondary) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return AppCard(
      child: Column(
        children: [
          // Amount Progress Circle
          SizedBox(
            height: 160.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140.w,
                  height: 140.h,
                  child: CircularProgressIndicator(
                    value: (goal.progressPercentage / 100).clamp(0.0, 1.0),
                    strokeWidth: 12.w,
                    backgroundColor: textSecondary.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      goal.progressPercentage >= 100 ? AppColors.success : AppColors.primary,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${goal.progressPercentage.toStringAsFixed(1)}%',
                      style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: textPrimary),
                    ),
                    Text(
                      goal.status == GoalStatus.completed ? l10n.completed : l10n.progress,
                      style: TextStyle(fontSize: 12.sp, color: textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Amount Details
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      CurrencyFormatter.formatShort(goal.currentAmount),
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.success),
                    ),
                    Text(l10n.saved, style: TextStyle(fontSize: 12.sp, color: textSecondary)),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: textSecondary.withValues(alpha: 0.2),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      CurrencyFormatter.formatShort(goal.remainingAmount),
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary),
                    ),
                    Text(l10n.remaining, style: TextStyle(fontSize: 12.sp, color: textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Target & Deadline
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: textSecondary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.flag_fill, size: 16.sp, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.target, style: TextStyle(fontSize: 10.sp, color: textSecondary)),
                          Text(
                            CurrencyFormatter.formatShort(goal.targetAmount),
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: textPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.calendar, size: 16.sp, color: AppColors.info),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.deadline, style: TextStyle(fontSize: 10.sp, color: textSecondary)),
                          Text(
                            dateFormat.format(goal.deadline),
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: textPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context, SavingsGoal goal, AppLocalizations l10n, Color textPrimary, Color textSecondary) {
    final contributions = goal.contributions.reversed.toList();
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');

    if (contributions.isEmpty) {
      return AppCard(
        child: Column(
          children: [
            Icon(CupertinoIcons.doc_text, size: 40.sp, color: textSecondary.withValues(alpha: 0.3)),
            SizedBox(height: 8.h),
            Text(
              l10n.noContributionsYet,
              style: TextStyle(fontSize: 14.sp, color: textSecondary),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.history,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: textPrimary),
        ),
        SizedBox(height: 8.h),
        ...contributions.take(10).map((c) => Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: (c.amount >= 0 ? AppColors.success : AppColors.warning).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  c.amount >= 0 ? CupertinoIcons.plus : CupertinoIcons.minus,
                  color: c.amount >= 0 ? AppColors.success : AppColors.warning,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.notes ?? (c.amount >= 0 ? l10n.contribution : l10n.withdrawal),
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: textPrimary),
                    ),
                    Text(
                      dateFormat.format(c.date),
                      style: TextStyle(fontSize: 11.sp, color: textSecondary),
                    ),
                  ],
                ),
              ),
              Text(
                '${c.amount >= 0 ? '+' : ''}${CurrencyFormatter.formatShort(c.amount)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: c.amount >= 0 ? AppColors.success : AppColors.warning,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void _handleMenuAction(BuildContext context, WidgetRef ref, SavingsGoal goal, String action) {
    switch (action) {
      case 'pause':
        ref.read(goalsProvider.notifier).pauseGoal(goalId);
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref, goal);
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, SavingsGoal goal) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(l10n.deleteGoal),
        content: Text('${l10n.deleteGoalConfirm}\n\n${goal.name}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(goalsProvider.notifier).deleteGoal(goalId);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(l10n.delete, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddContributionSheet(BuildContext context, WidgetRef ref, SavingsGoal goal, AppLocalizations l10n) {
    double amount = goal.suggestedMonthlyContribution;
    final notesController = TextEditingController();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                l10n.addContribution,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary),
              ),
              SizedBox(height: 20.h),
              AppSliderInput(
                label: l10n.amount,
                value: amount,
                min: 100000,
                max: goal.remainingAmount > 0 ? goal.remainingAmount : 100000000,
                divisions: 100,
                activeColor: AppColors.success,
                valueFormatter: (v) => CurrencyFormatter.formatShort(v),
                onChanged: (v) => setState(() => amount = v),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  hintText: l10n.notesOptional,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(goalsProvider.notifier).addContribution(
                      goalId,
                      amount,
                      notes: notesController.text.isNotEmpty ? notesController.text : null,
                    );
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    l10n.add,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showWithdrawSheet(BuildContext context, WidgetRef ref, SavingsGoal goal, AppLocalizations l10n) {
    double amount = goal.currentAmount * 0.1;
    final notesController = TextEditingController();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                l10n.withdraw,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary),
              ),
              SizedBox(height: 20.h),
              AppSliderInput(
                label: l10n.amount,
                value: amount.clamp(100000, goal.currentAmount),
                min: 100000,
                max: goal.currentAmount,
                divisions: 100,
                activeColor: AppColors.warning,
                valueFormatter: (v) => CurrencyFormatter.formatShort(v),
                onChanged: (v) => setState(() => amount = v),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  hintText: l10n.withdrawReason,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(goalsProvider.notifier).withdrawAmount(
                      goalId,
                      amount,
                      notes: notesController.text.isNotEmpty ? notesController.text : null,
                    );
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    l10n.withdraw,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
