import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money/domain/entities/payment_reminder.dart';
import 'package:money/domain/entities/savings_goal.dart';
import 'package:money/presentation/reminders/reminders_provider.dart';
import 'package:money/presentation/goals/goals_provider.dart';

enum CalendarEventType { payment, goalDeadline, goalContribution }

class CalendarEvent {
  final String id;
  final String title;
  final DateTime date;
  final CalendarEventType type;
  final double? amount;
  final Color color;
  final dynamic sourceData;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.type,
    this.amount,
    required this.color,
    this.sourceData,
  });
}

class CalendarState {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final bool isWeekView;
  final bool isLoading;

  const CalendarState({
    required this.focusedDay,
    this.selectedDay,
    this.isWeekView = false,
    this.isLoading = false,
  });

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    bool? isWeekView,
    bool? isLoading,
  }) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      isWeekView: isWeekView ?? this.isWeekView,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CalendarNotifier extends StateNotifier<CalendarState> {
  CalendarNotifier()
      : super(CalendarState(
          focusedDay: DateTime.now(),
          selectedDay: DateTime.now(),
        ));

  void setFocusedDay(DateTime day) {
    state = state.copyWith(focusedDay: day);
  }

  void setSelectedDay(DateTime day) {
    state = state.copyWith(selectedDay: day, focusedDay: day);
  }

  void toggleViewMode() {
    state = state.copyWith(isWeekView: !state.isWeekView);
  }

  void goToToday() {
    final today = DateTime.now();
    state = state.copyWith(focusedDay: today, selectedDay: today);
  }
}

final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>((ref) {
  return CalendarNotifier();
});

// Combined events provider
final calendarEventsProvider = Provider<Map<DateTime, List<CalendarEvent>>>((ref) {
  final remindersState = ref.watch(remindersProvider);
  final goalsState = ref.watch(goalsProvider);

  final Map<DateTime, List<CalendarEvent>> events = {};

  // Add payment reminders
  for (final reminder in remindersState.reminders) {
    final dateKey = DateTime(reminder.dueDate.year, reminder.dueDate.month, reminder.dueDate.day);
    final event = CalendarEvent(
      id: reminder.id,
      title: reminder.name,
      date: reminder.dueDate,
      type: CalendarEventType.payment,
      amount: reminder.amount,
      color: _getPaymentColor(reminder.status),
      sourceData: reminder,
    );

    events.putIfAbsent(dateKey, () => []);
    events[dateKey]!.add(event);
  }

  // Add goal deadlines
  for (final goal in goalsState.goals) {
    if (goal.status == GoalStatus.active) {
      final dateKey = DateTime(goal.deadline.year, goal.deadline.month, goal.deadline.day);
      final event = CalendarEvent(
        id: goal.id,
        title: goal.name,
        date: goal.deadline,
        type: CalendarEventType.goalDeadline,
        amount: goal.targetAmount,
        color: const Color(0xFF2196F3), // Blue
        sourceData: goal,
      );

      events.putIfAbsent(dateKey, () => []);
      events[dateKey]!.add(event);
    }

    // Add goal contributions
    for (final contribution in goal.contributions) {
      if (contribution.amount > 0) {
        final dateKey = DateTime(contribution.date.year, contribution.date.month, contribution.date.day);
        final event = CalendarEvent(
          id: '${goal.id}_${contribution.date.millisecondsSinceEpoch}',
          title: '${goal.name} contribution',
          date: contribution.date,
          type: CalendarEventType.goalContribution,
          amount: contribution.amount,
          color: const Color(0xFF4CAF50), // Green
          sourceData: contribution,
        );

        events.putIfAbsent(dateKey, () => []);
        events[dateKey]!.add(event);
      }
    }
  }

  return events;
});

// Events for selected day
final selectedDayEventsProvider = Provider<List<CalendarEvent>>((ref) {
  final calendarState = ref.watch(calendarProvider);
  final events = ref.watch(calendarEventsProvider);

  if (calendarState.selectedDay == null) return [];

  final dateKey = DateTime(
    calendarState.selectedDay!.year,
    calendarState.selectedDay!.month,
    calendarState.selectedDay!.day,
  );

  return events[dateKey] ?? [];
});

Color _getPaymentColor(PaymentStatus status) {
  switch (status) {
    case PaymentStatus.pending:
      return const Color(0xFFFFC107); // Amber
    case PaymentStatus.paid:
      return const Color(0xFF4CAF50); // Green
    case PaymentStatus.overdue:
      return const Color(0xFFF44336); // Red
    case PaymentStatus.skipped:
      return const Color(0xFF9E9E9E); // Grey
  }
}
