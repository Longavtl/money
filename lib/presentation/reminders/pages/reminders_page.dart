import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/routes/app_routes.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/payment_reminder.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/premium/premium_provider.dart';
import 'package:money/presentation/reminders/reminders_provider.dart';
import 'package:money/presentation/reminders/widgets/add_reminder_sheet.dart';
import 'package:money/presentation/reminders/widgets/reminder_card.dart';
import 'package:money/common/widgets/app_card.dart';

const int _freeRemindersLimit = 3;

class RemindersPage extends ConsumerWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(remindersProvider);
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
          l10n.paymentReminders,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: textPrimary),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.plus, color: AppColors.primary),
            onPressed: () => _showAddReminderSheet(context, ref),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.reminders.isEmpty
              ? _buildEmptyState(context, ref, l10n, textSecondary)
              : _buildRemindersList(context, ref, state, l10n, textPrimary, textSecondary),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, AppLocalizations l10n, Color textSecondary) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.bell_slash, size: 64.sp, color: textSecondary.withValues(alpha: 0.3))
                .animate()
                .scale(duration: 500.ms, curve: Curves.elasticOut)
                .fadeIn(),
            SizedBox(height: 16.h),
            Text(
              l10n.noRemindersYet,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: textSecondary),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
            SizedBox(height: 8.h),
            Text(
              l10n.addRemindersSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: textSecondary.withValues(alpha: 0.6)),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => _showAddReminderSheet(context, ref),
              icon: const Icon(CupertinoIcons.plus),
              label: Text(l10n.addReminder),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildRemindersList(
    BuildContext context,
    WidgetRef ref,
    RemindersState state,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    final overdue = state.overdueReminders;
    final pending = state.pendingReminders.where((r) => !r.isOverdue).toList();
    final completed = state.reminders.where((r) => r.status == PaymentStatus.paid).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Card
          _buildSummaryCard(context, state, l10n, textPrimary, textSecondary),
          SizedBox(height: 20.h),

          // Overdue Section
          if (overdue.isNotEmpty) ...[
            _buildSectionHeader(l10n.overdue, AppColors.danger, overdue.length, textPrimary),
            SizedBox(height: 8.h),
            ...overdue.map((r) => ReminderCard(
              reminder: r,
              onMarkPaid: () => _showMarkPaidDialog(context, ref, r, l10n),
              onDelete: () => ref.read(remindersProvider.notifier).deleteReminder(r.id),
            )),
            SizedBox(height: 16.h),
          ],

          // Pending Section
          if (pending.isNotEmpty) ...[
            _buildSectionHeader(l10n.upcoming, AppColors.warning, pending.length, textPrimary),
            SizedBox(height: 8.h),
            ...pending.map((r) => ReminderCard(
              reminder: r,
              onMarkPaid: () => _showMarkPaidDialog(context, ref, r, l10n),
              onDelete: () => ref.read(remindersProvider.notifier).deleteReminder(r.id),
            )),
            SizedBox(height: 16.h),
          ],

          // Completed Section
          if (completed.isNotEmpty) ...[
            _buildSectionHeader(l10n.completed, AppColors.success, completed.length, textPrimary),
            SizedBox(height: 8.h),
            ...completed.take(5).map((r) => ReminderCard(
              reminder: r,
              onMarkPaid: null,
              onDelete: () => ref.read(remindersProvider.notifier).deleteReminder(r.id),
            )),
          ],

          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    RemindersState state,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    final totalDue = state.pendingReminders.fold<double>(0, (sum, r) => sum + r.amount);
    final overdueAmount = state.overdueReminders.fold<double>(0, (sum, r) => sum + r.amount);

    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  label: l10n.totalDue,
                  value: CurrencyFormatter.formatShort(totalDue),
                  color: AppColors.primary,
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
                  label: l10n.overdue,
                  value: CurrencyFormatter.formatShort(overdueAmount),
                  color: AppColors.danger,
                  icon: CupertinoIcons.exclamationmark_circle_fill,
                ),
              ),
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

  void _showAddReminderSheet(BuildContext context, WidgetRef ref) {
    final isPremium = ref.read(premiumStatusProvider).isPremium;
    final currentCount = ref.read(remindersProvider).reminders.length;

    // Check premium limit
    if (!isPremium && currentCount >= _freeRemindersLimit) {
      _showPremiumLimitDialog(context, ref);
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddReminderSheet(
        onAdd: (reminder) {
          ref.read(remindersProvider.notifier).addReminder(reminder);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _showPremiumLimitDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: cardColor,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(CupertinoIcons.bell_fill, color: Colors.white, size: 32.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                l10n.storageLimitLoans(_freeRemindersLimit),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.sp, color: textPrimary, height: 1.4),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.push(AppRoutes.premium);
                  },
                  child: Text(l10n.upgradeToPremium, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.later, style: TextStyle(color: textSecondary)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMarkPaidDialog(BuildContext context, WidgetRef ref, PaymentReminder reminder, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(l10n.markAsPaid),
        content: Text('${l10n.markAsPaidConfirm}\n\n${reminder.name}\n${CurrencyFormatter.format(reminder.amount)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(remindersProvider.notifier).markAsPaid(reminder.id);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
            child: Text(l10n.confirm, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
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
