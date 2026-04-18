import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:money/core/configs/theme/app_colors.dart';
import 'package:money/core/utils/currency_formatter.dart';
import 'package:money/l10n/app_localizations.dart';
import 'package:money/presentation/calendar/calendar_provider.dart';
import 'package:money/common/widgets/app_card.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProvider);
    final events = ref.watch(calendarEventsProvider);
    final selectedEvents = ref.watch(selectedDayEventsProvider);
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
          l10n.financialCalendar,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: textPrimary),
        ),
        actions: [
          IconButton(
            icon: Icon(
              calendarState.isWeekView ? CupertinoIcons.calendar : CupertinoIcons.calendar_today,
              color: AppColors.primary,
            ),
            onPressed: () => ref.read(calendarProvider.notifier).toggleViewMode(),
            tooltip: calendarState.isWeekView ? l10n.monthView : l10n.weekView,
          ),
          IconButton(
            icon: Icon(CupertinoIcons.calendar_badge_plus, color: AppColors.primary),
            onPressed: () => ref.read(calendarProvider.notifier).goToToday(),
            tooltip: l10n.today,
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar
          _buildCalendar(
            context,
            ref,
            calendarState,
            events,
            isDark,
            textPrimary,
            textSecondary,
          ),

          // Legend
          _buildLegend(l10n, textSecondary),

          // Events List
          Expanded(
            child: selectedEvents.isEmpty
                ? _buildEmptyState(l10n, textSecondary)
                : _buildEventsList(selectedEvents, l10n, textPrimary, textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(
    BuildContext context,
    WidgetRef ref,
    CalendarState calendarState,
    Map<DateTime, List<CalendarEvent>> events,
    bool isDark,
    Color textPrimary,
    Color textSecondary,
  ) {
    return AppCard(
      child: TableCalendar<CalendarEvent>(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
        focusedDay: calendarState.focusedDay,
        selectedDayPredicate: (day) => isSameDay(calendarState.selectedDay, day),
        calendarFormat: calendarState.isWeekView ? CalendarFormat.week : CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        eventLoader: (day) {
          final dateKey = DateTime(day.year, day.month, day.day);
          return events[dateKey] ?? [];
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          leftChevronIcon: Icon(CupertinoIcons.chevron_left, color: textPrimary, size: 20.sp),
          rightChevronIcon: Icon(CupertinoIcons.chevron_right, color: textPrimary, size: 20.sp),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontSize: 12.sp, color: textSecondary, fontWeight: FontWeight.w500),
          weekendStyle: TextStyle(fontSize: 12.sp, color: textSecondary.withValues(alpha: 0.6), fontWeight: FontWeight.w500),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(fontSize: 14.sp, color: textPrimary),
          weekendTextStyle: TextStyle(fontSize: 14.sp, color: textPrimary.withValues(alpha: 0.7)),
          outsideTextStyle: TextStyle(fontSize: 14.sp, color: textSecondary.withValues(alpha: 0.3)),
          todayDecoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(fontSize: 14.sp, color: AppColors.primary, fontWeight: FontWeight.w600),
          selectedDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
          markerDecoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          markersMaxCount: 3,
          markerSize: 6.w,
          markerMargin: EdgeInsets.symmetric(horizontal: 1.w),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, eventsList) {
            if (eventsList.isEmpty) return null;
            return Positioned(
              bottom: 4.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: eventsList.take(3).map((event) {
                  return Container(
                    width: 6.w,
                    height: 6.h,
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    decoration: BoxDecoration(
                      color: event.color,
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          ref.read(calendarProvider.notifier).setSelectedDay(selectedDay);
        },
        onPageChanged: (focusedDay) {
          ref.read(calendarProvider.notifier).setFocusedDay(focusedDay);
        },
      ),
    );
  }

  Widget _buildLegend(AppLocalizations l10n, Color textSecondary) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(AppColors.warning, l10n.pending, textSecondary),
          _buildLegendItem(AppColors.success, l10n.paid, textSecondary),
          _buildLegendItem(AppColors.danger, l10n.overdue, textSecondary),
          _buildLegendItem(AppColors.info, l10n.goals, textSecondary),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, Color textSecondary) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(fontSize: 10.sp, color: textSecondary),
        ),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, Color textSecondary) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.calendar_badge_minus,
            size: 48.sp,
            color: textSecondary.withValues(alpha: 0.3),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.noEventsForDay,
            style: TextStyle(fontSize: 14.sp, color: textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(
    List<CalendarEvent> events,
    AppLocalizations l10n,
    Color textPrimary,
    Color textSecondary,
  ) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _EventCard(event: event, l10n: l10n);
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final CalendarEvent event;
  final AppLocalizations l10n;

  const _EventCard({
    required this.event,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final timeFormat = DateFormat('HH:mm');

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: AppCard(
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: event.color,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: event.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                _getEventIcon(event.type),
                color: event.color,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        _getEventTypeLabel(event.type, l10n),
                        style: TextStyle(fontSize: 12.sp, color: textSecondary),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        timeFormat.format(event.date),
                        style: TextStyle(fontSize: 12.sp, color: textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (event.amount != null)
              Text(
                CurrencyFormatter.formatShort(event.amount!),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: event.color,
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getEventIcon(CalendarEventType type) {
    switch (type) {
      case CalendarEventType.payment:
        return CupertinoIcons.money_dollar_circle;
      case CalendarEventType.goalDeadline:
        return CupertinoIcons.flag_fill;
      case CalendarEventType.goalContribution:
        return CupertinoIcons.plus_circle_fill;
    }
  }

  String _getEventTypeLabel(CalendarEventType type, AppLocalizations l10n) {
    switch (type) {
      case CalendarEventType.payment:
        return l10n.payment;
      case CalendarEventType.goalDeadline:
        return l10n.goalDeadline;
      case CalendarEventType.goalContribution:
        return l10n.contribution;
    }
  }
}
