import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/domain/entities/savings_goal.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/common/widgets/app_slider.dart';

class AddGoalSheet extends ConsumerStatefulWidget {
  final Function(SavingsGoal) onAdd;
  final SavingsGoal? existingGoal;

  const AddGoalSheet({
    super.key,
    required this.onAdd,
    this.existingGoal,
  });

  @override
  ConsumerState<AddGoalSheet> createState() => _AddGoalSheetState();
}

class _AddGoalSheetState extends ConsumerState<AddGoalSheet> {
  final _nameController = TextEditingController();
  double _targetAmount = 50000000;
  double _initialAmount = 0;
  DateTime _deadline = DateTime.now().add(const Duration(days: 180));

  @override
  void initState() {
    super.initState();
    if (widget.existingGoal != null) {
      final g = widget.existingGoal!;
      _nameController.text = g.name;
      _targetAmount = g.targetAmount;
      _initialAmount = g.currentAmount;
      _deadline = g.deadline;
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

    final monthsRemaining = _deadline.difference(DateTime.now()).inDays / 30;
    final suggestedMonthly = monthsRemaining > 0
        ? (_targetAmount - _initialAmount) / monthsRemaining
        : 0.0;

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
              widget.existingGoal != null ? l10n.editGoal : l10n.addGoal,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: textPrimary),
            ),
            SizedBox(height: 20.h),

            // Name Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: l10n.goalNameHint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),

            // Target Amount Slider
            AppSliderInput(
              label: l10n.targetAmount,
              value: _targetAmount,
              min: 1000000,
              max: 1000000000,
              divisions: 999,
              activeColor: AppColors.primary,
              valueFormatter: (v) => CurrencyFormatter.formatShort(v),
              onChanged: (v) => setState(() => _targetAmount = v),
            ),
            SizedBox(height: 16.h),

            // Initial Amount Slider
            AppSliderInput(
              label: l10n.initialAmount,
              value: _initialAmount,
              min: 0,
              max: _targetAmount,
              divisions: 100,
              activeColor: AppColors.success,
              valueFormatter: (v) => CurrencyFormatter.formatShort(v),
              onChanged: (v) => setState(() => _initialAmount = v),
            ),
            SizedBox(height: 16.h),

            // Deadline Picker
            Text(l10n.deadline, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: textPrimary)),
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
                      dateFormat.format(_deadline),
                      style: TextStyle(fontSize: 16.sp, color: textPrimary),
                    ),
                    const Spacer(),
                    Text(
                      '${_deadline.difference(DateTime.now()).inDays} ${l10n.days}',
                      style: TextStyle(fontSize: 14.sp, color: textSecondary),
                    ),
                    SizedBox(width: 8.w),
                    Icon(CupertinoIcons.chevron_right, color: textSecondary, size: 16.sp),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Suggested Monthly Info
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.lightbulb_fill, color: AppColors.info, size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.suggestedMonthly,
                          style: TextStyle(fontSize: 12.sp, color: textSecondary),
                        ),
                        Text(
                          CurrencyFormatter.format(suggestedMonthly),
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.info),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                  widget.existingGoal != null ? l10n.save : l10n.add,
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
      initialDate: _deadline,
      firstDate: DateTime.now().add(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null) {
      setState(() => _deadline = picked);
    }
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseEnterGoalName)),
      );
      return;
    }

    final goal = SavingsGoal(
      id: widget.existingGoal?.id,
      name: name,
      targetAmount: _targetAmount,
      currentAmount: _initialAmount,
      deadline: _deadline,
      contributions: widget.existingGoal?.contributions ?? [],
    );

    widget.onAdd(goal);
  }
}
