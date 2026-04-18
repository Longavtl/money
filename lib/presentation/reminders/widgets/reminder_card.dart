import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/payment_reminder.dart';
import 'package:money/common/widgets/app_card.dart';
import 'package:money/l10n/app_localizations.dart';

class ReminderCard extends StatelessWidget {
  final PaymentReminder reminder;
  final VoidCallback? onMarkPaid;
  final VoidCallback? onDelete;

  const ReminderCard({
    super.key,
    required this.reminder,
    this.onMarkPaid,
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
    final statusText = _getStatusText(l10n);
    final dateFormat = DateFormat('dd MMM yyyy');

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Dismissible(
        key: Key(reminder.id),
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
                          reminder.name,
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
                              dateFormat.format(reminder.dueDate),
                              style: TextStyle(fontSize: 12.sp, color: textSecondary),
                            ),
                            if (reminder.isRecurring) ...[
                              SizedBox(width: 8.w),
                              Icon(CupertinoIcons.repeat, size: 12.sp, color: textSecondary),
                              SizedBox(width: 4.w),
                              Text(
                                _getRecurrenceText(l10n),
                                style: TextStyle(fontSize: 12.sp, color: textSecondary),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        CurrencyFormatter.formatShort(reminder.amount),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (reminder.status == PaymentStatus.pending && onMarkPaid != null) ...[
                SizedBox(height: 12.h),
                Row(
                  children: [
                    if (reminder.daysUntilDue >= 0) ...[
                      Text(
                        _getDaysText(l10n),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: reminder.daysUntilDue <= 3 ? AppColors.warning : textSecondary,
                          fontWeight: reminder.daysUntilDue <= 3 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onMarkPaid,
                      icon: Icon(CupertinoIcons.checkmark_circle, size: 16.sp),
                      label: Text(l10n.markPaid),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.success,
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (reminder.status) {
      case PaymentStatus.pending:
        return reminder.isOverdue ? AppColors.danger : AppColors.warning;
      case PaymentStatus.paid:
        return AppColors.success;
      case PaymentStatus.overdue:
        return AppColors.danger;
      case PaymentStatus.skipped:
        return AppColors.info;
    }
  }

  IconData _getStatusIcon() {
    switch (reminder.status) {
      case PaymentStatus.pending:
        return reminder.isOverdue
            ? CupertinoIcons.exclamationmark_circle_fill
            : CupertinoIcons.clock_fill;
      case PaymentStatus.paid:
        return CupertinoIcons.checkmark_circle_fill;
      case PaymentStatus.overdue:
        return CupertinoIcons.exclamationmark_circle_fill;
      case PaymentStatus.skipped:
        return CupertinoIcons.xmark_circle_fill;
    }
  }

  String _getStatusText(AppLocalizations l10n) {
    switch (reminder.status) {
      case PaymentStatus.pending:
        return reminder.isOverdue ? l10n.overdue : l10n.pending;
      case PaymentStatus.paid:
        return l10n.paid;
      case PaymentStatus.overdue:
        return l10n.overdue;
      case PaymentStatus.skipped:
        return l10n.skipped;
    }
  }

  String _getRecurrenceText(AppLocalizations l10n) {
    switch (reminder.recurrence) {
      case RecurrenceType.weekly:
        return l10n.weekly;
      case RecurrenceType.biweekly:
        return l10n.biWeekly;
      case RecurrenceType.monthly:
        return l10n.monthly;
      default:
        return '';
    }
  }

  String _getDaysText(AppLocalizations l10n) {
    final days = reminder.daysUntilDue;
    if (days == 0) return l10n.dueToday;
    if (days == 1) return l10n.dueTomorrow;
    return l10n.dueInDays(days);
  }
}
