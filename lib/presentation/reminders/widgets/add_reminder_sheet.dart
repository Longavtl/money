import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/payment_reminder.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/common/widgets/app_slider.dart';

class AddReminderSheet extends ConsumerStatefulWidget {
  final Function(PaymentReminder) onAdd;
  final PaymentReminder? existingReminder;

  const AddReminderSheet({
    super.key,
    required this.onAdd,
    this.existingReminder,
  });

  @override
  ConsumerState<AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends ConsumerState<AddReminderSheet> {
  final _nameController = TextEditingController();
  double _amount = 5000000;
  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));
  int _reminderDays = 3;
  bool _isRecurring = true;
  RecurrenceType _recurrence = RecurrenceType.monthly;

  @override
  void initState() {
    super.initState();
    if (widget.existingReminder != null) {
      final r = widget.existingReminder!;
      _nameController.text = r.name;
      _amount = r.amount;
      _dueDate = r.dueDate;
      _reminderDays = r.reminderDaysBefore;
      _isRecurring = r.isRecurring;
      _recurrence = r.recurrence ?? RecurrenceType.monthly;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final dateFormat = DateFormat('dd MMM yyyy');

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
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
              widget.existingReminder != null ? l10n.editReminder : l10n.addReminder,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary),
            ),
            SizedBox(height: 20.h),

            // Name Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: l10n.reminderNameHint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),

            // Amount Slider
            AppSliderInput(
              label: l10n.amount,
              value: _amount,
              min: 100000,
              max: 100000000,
              divisions: 999,
              activeColor: AppColors.primary,
              valueFormatter: (v) => CurrencyFormatter.formatShort(v),
              onChanged: (v) => setState(() => _amount = v),
            ),
            SizedBox(height: 16.h),

            // Due Date Picker
            Text(l10n.dueDate, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: textPrimary)),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.calendar, color: textSecondary, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      dateFormat.format(_dueDate),
                      style: TextStyle(fontSize: 16.sp, color: textPrimary),
                    ),
                    const Spacer(),
                    Icon(CupertinoIcons.chevron_right, color: textSecondary, size: 16.sp),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Reminder Days
            AppSliderInput(
              label: l10n.remindBefore,
              value: _reminderDays.toDouble(),
              min: 1,
              max: 14,
              divisions: 13,
              activeColor: AppColors.info,
              valueFormatter: (v) => '${v.toInt()} ${l10n.days}',
              onChanged: (v) => setState(() => _reminderDays = v.toInt()),
            ),
            SizedBox(height: 16.h),

            // Recurring Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.recurring, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: textPrimary)),
                CupertinoSwitch(
                  value: _isRecurring,
                  activeColor: AppColors.primary,
                  onChanged: (v) => setState(() => _isRecurring = v),
                ),
              ],
            ),

            // Recurrence Type
            if (_isRecurring) ...[
              SizedBox(height: 12.h),
              Row(
                children: RecurrenceType.values.map((type) {
                  final isSelected = _recurrence == type;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: GestureDetector(
                        onTap: () => setState(() => _recurrence = type),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : borderColor,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              _getRecurrenceLabel(type),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? AppColors.primary : textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            SizedBox(height: 24.h),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  widget.existingReminder != null ? l10n.save : l10n.add,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20.h),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  String _getRecurrenceLabel(RecurrenceType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case RecurrenceType.weekly:
        return l10n.weekly;
      case RecurrenceType.biweekly:
        return l10n.biWeekly;
      case RecurrenceType.monthly:
        return l10n.monthly;
    }
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseEnterName)),
      );
      return;
    }

    final reminder = PaymentReminder(
      id: widget.existingReminder?.id,
      name: name,
      amount: _amount,
      dueDate: _dueDate,
      reminderDaysBefore: _reminderDays,
      isRecurring: _isRecurring,
      recurrence: _isRecurring ? _recurrence : null,
    );

    widget.onAdd(reminder);
  }
}
