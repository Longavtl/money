import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/savings_goal.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/goals/goals_provider.dart';
import 'package:money/presentation/goals/widgets/goal_card.dart';
import 'package:money/presentation/goals/widgets/add_goal_sheet.dart';
import 'package:money/presentation/goals/pages/goal_detail_page.dart';
import 'package:money/common/widgets/app_card.dart';

class GoalsPage extends ConsumerWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalsProvider);
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
          l10n.savingsGoals,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: textPrimary),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.plus, color: AppColors.primary),
            onPressed: () => _showAddGoalSheet(context, ref),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.goals.isEmpty
              ? _buildEmptyState(context, ref, l10n, textSecondary)
              : _buildGoalsList(context, ref, state, l10n, textPrimary, textSecondary),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, AppLocalizations l10n, Color textSecondary) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.flag_slash, size: 64.sp, color: textSecondary.withValues(alpha: 0.3)),
            SizedBox(height: 16.h),
            Text(
              l10n.noGoalsYet,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: textSecondary),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.addGoalsSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: textSecondary.withValues(alpha: 0.6)),
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => _showAddGoalSheet(context, ref),
              icon: const Icon(CupertinoIcons.plus),
              label: Text(l10n.addGoal),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsList(
    BuildContext context,
    WidgetRef ref,
    GoalsState state,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    final active = state.activeGoals;
    final completed = state.completedGoals;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Card
          _buildSummaryCard(context, state, l10n, textPrimary, textSecondary),
          SizedBox(height: 20.h),

          // Active Goals Section
          if (active.isNotEmpty) ...[
            _buildSectionHeader(l10n.activeGoals, AppColors.primary, active.length, textPrimary),
            SizedBox(height: 8.h),
            ...active.map((g) => GoalCard(
              goal: g,
              onTap: () => _navigateToDetail(context, g),
              onDelete: () => ref.read(goalsProvider.notifier).deleteGoal(g.id),
            )),
            SizedBox(height: 16.h),
          ],

          // Completed Goals Section
          if (completed.isNotEmpty) ...[
            _buildSectionHeader(l10n.completedGoals, AppColors.success, completed.length, textPrimary),
            SizedBox(height: 8.h),
            ...completed.take(5).map((g) => GoalCard(
              goal: g,
              onTap: () => _navigateToDetail(context, g),
              onDelete: () => ref.read(goalsProvider.notifier).deleteGoal(g.id),
            )),
          ],

          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    GoalsState state,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    final progress = state.totalTarget > 0 ? state.totalSaved / state.totalTarget : 0.0;

    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  label: l10n.totalSaved,
                  value: CurrencyFormatter.formatShort(state.totalSaved),
                  color: AppColors.success,
                  icon: CupertinoIcons.money_dollar_circle_fill,
                ),
              ),
              Container(
                width: 1,
                height: 50.h,
                color: textSecondary.withValues(alpha: 0.2),
              ),
              Expanded(
                child: _SummaryItem(
                  label: l10n.totalTarget,
                  value: CurrencyFormatter.formatShort(state.totalTarget),
                  color: AppColors.primary,
                  icon: CupertinoIcons.flag_fill,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: textSecondary.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
              minHeight: 8.h,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${(progress * 100).toStringAsFixed(1)}% ${l10n.ofTotalTarget}',
            style: TextStyle(fontSize: 12.sp, color: textSecondary),
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

  void _showAddGoalSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddGoalSheet(
        onAdd: (goal) {
          ref.read(goalsProvider.notifier).addGoal(goal);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _navigateToDetail(BuildContext context, SavingsGoal goal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GoalDetailPage(goalId: goal.id)),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 6.h),
        Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: textPrimary)),
        Text(label, style: TextStyle(fontSize: 12.sp, color: textSecondary)),
      ],
    );
  }
}
