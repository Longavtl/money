import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'package:money_mate/core/configs/theme/app_colors.dart';
import 'package:money_mate/core/utils/currency_formatter.dart';
import 'package:money_mate/domain/entities/calculation_results.dart';

/// A scrollable table showing detailed amortization schedule
class AmortizationTable extends StatelessWidget {
  final List<AmortizationEntry> schedule;
  final int maxRows;

  const AmortizationTable({
    super.key,
    required this.schedule,
    this.maxRows = 12, // Default to showing 1 year
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displaySchedule =
        maxRows > 0 ? schedule.take(maxRows).toList() : schedule;

    if (schedule.isEmpty) {
      return const SizedBox();
    }

    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bảng trả nợ chi tiết',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                if (maxRows > 0 && schedule.length > maxRows)
                  Text(
                    '${displaySchedule.length}/${schedule.length} tháng',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.6)
                          : AppColors.lightTextSecondary,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),

            // Table header
            _buildTableHeader(isDark),

            // Divider
            Divider(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1),
              height: 1,
            ),

            // Table rows
            ...displaySchedule.map((entry) => _buildTableRow(entry, isDark)),

            // Show more indicator
            if (maxRows > 0 && schedule.length > maxRows) ...[
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  '+ ${schedule.length - maxRows} tháng nữa',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(bool isDark) {
    final headerStyle = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.w600,
      color: isDark
          ? Colors.white.withValues(alpha: 0.7)
          : AppColors.lightTextSecondary,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 35.w,
            child: Text('T', style: headerStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child:
                Text('Trả/tháng', style: headerStyle, textAlign: TextAlign.end),
          ),
          Expanded(
            flex: 2,
            child: Text('Gốc', style: headerStyle, textAlign: TextAlign.end),
          ),
          Expanded(
            flex: 2,
            child: Text('Lãi', style: headerStyle, textAlign: TextAlign.end),
          ),
          Expanded(
            flex: 2,
            child: Text('Dư nợ', style: headerStyle, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(AmortizationEntry entry, bool isDark) {
    final textStyle = TextStyle(
      fontSize: 11.sp,
      color: isDark ? Colors.white : AppColors.lightTextPrimary,
    );

    final highlightMonth = entry.month == 1 ||
        entry.month == 12 ||
        entry.month == schedule.length;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: highlightMonth
            ? (isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.02))
            : null,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.05),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 35.w,
            child: Text(
              '${entry.month}',
              style: textStyle.copyWith(
                fontWeight: highlightMonth ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              CurrencyFormatter.formatCompact(entry.payment),
              style: textStyle.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              CurrencyFormatter.formatCompact(entry.principalPaid),
              style: textStyle.copyWith(
                color: AppColors.chartPrincipal,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              CurrencyFormatter.formatCompact(entry.interestPaid),
              style: textStyle.copyWith(
                color: AppColors.chartInterest,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              CurrencyFormatter.formatCompact(entry.balance),
              style: textStyle,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
