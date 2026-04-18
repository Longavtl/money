import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money/domain/entities/payment_reminder.dart';
import 'package:money/presentation/reminders/reminders_provider.dart';
import 'package:money/presentation/goals/goals_provider.dart';

enum ReportPeriod { week, month, quarter, year, all }

class MonthlyData {
  final int month;
  final int year;
  final double paid;
  final double due;
  final double saved;
  final int paymentCount;

  const MonthlyData({
    required this.month,
    required this.year,
    required this.paid,
    required this.due,
    required this.saved,
    required this.paymentCount,
  });

  String get monthLabel {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

class ReportsState {
  final ReportPeriod selectedPeriod;
  final bool isLoading;

  const ReportsState({
    this.selectedPeriod = ReportPeriod.month,
    this.isLoading = false,
  });

  ReportsState copyWith({
    ReportPeriod? selectedPeriod,
    bool? isLoading,
  }) {
    return ReportsState(
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ReportsNotifier extends StateNotifier<ReportsState> {
  ReportsNotifier() : super(const ReportsState());

  void setPeriod(ReportPeriod period) {
    state = state.copyWith(selectedPeriod: period);
  }
}

final reportsProvider = StateNotifierProvider<ReportsNotifier, ReportsState>((ref) {
  return ReportsNotifier();
});

// Summary statistics
final reportsSummaryProvider = Provider<Map<String, double>>((ref) {
  final remindersState = ref.watch(remindersProvider);
  final goalsState = ref.watch(goalsProvider);

  double totalDebt = 0;
  double totalPaid = 0;
  double totalSaved = 0;
  double totalOverdue = 0;
  int onTimePayments = 0;
  int latePayments = 0;

  for (final reminder in remindersState.reminders) {
    if (reminder.status == PaymentStatus.paid) {
      totalPaid += reminder.amount;
      // Check if was paid on time
      if (reminder.paidDate != null && !reminder.paidDate!.isAfter(reminder.dueDate)) {
        onTimePayments++;
      } else {
        latePayments++;
      }
    } else if (reminder.status == PaymentStatus.pending || reminder.status == PaymentStatus.overdue) {
      totalDebt += reminder.amount;
      if (reminder.isOverdue) {
        totalOverdue += reminder.amount;
      }
    }
  }

  for (final goal in goalsState.goals) {
    totalSaved += goal.currentAmount;
  }

  final totalPayments = onTimePayments + latePayments;
  final onTimeRate = totalPayments > 0 ? onTimePayments / totalPayments * 100 : 0.0;

  return {
    'totalDebt': totalDebt,
    'totalPaid': totalPaid,
    'totalSaved': totalSaved,
    'totalOverdue': totalOverdue,
    'onTimePayments': onTimePayments.toDouble(),
    'latePayments': latePayments.toDouble(),
    'onTimeRate': onTimeRate,
    'netWorth': totalSaved - totalDebt,
  };
});

// Monthly data for charts
final monthlyDataProvider = Provider<List<MonthlyData>>((ref) {
  final remindersState = ref.watch(remindersProvider);
  final goalsState = ref.watch(goalsProvider);
  final reportsState = ref.watch(reportsProvider);

  final Map<String, MonthlyData> monthlyMap = {};

  // Calculate date range based on period
  final now = DateTime.now();
  DateTime startDate;

  switch (reportsState.selectedPeriod) {
    case ReportPeriod.week:
      startDate = now.subtract(const Duration(days: 7));
      break;
    case ReportPeriod.month:
      startDate = DateTime(now.year, now.month - 1, now.day);
      break;
    case ReportPeriod.quarter:
      startDate = DateTime(now.year, now.month - 3, now.day);
      break;
    case ReportPeriod.year:
      startDate = DateTime(now.year - 1, now.month, now.day);
      break;
    case ReportPeriod.all:
      startDate = DateTime(2020);
      break;
  }

  // Generate months in range
  DateTime current = DateTime(startDate.year, startDate.month);
  while (current.isBefore(DateTime(now.year, now.month + 1))) {
    final key = '${current.year}-${current.month}';
    monthlyMap[key] = MonthlyData(
      month: current.month,
      year: current.year,
      paid: 0,
      due: 0,
      saved: 0,
      paymentCount: 0,
    );
    current = DateTime(current.year, current.month + 1);
  }

  // Aggregate payment data
  for (final reminder in remindersState.reminders) {
    final date = reminder.status == PaymentStatus.paid && reminder.paidDate != null
        ? reminder.paidDate!
        : reminder.dueDate;

    if (date.isBefore(startDate)) continue;

    final key = '${date.year}-${date.month}';
    if (monthlyMap.containsKey(key)) {
      final existing = monthlyMap[key]!;
      if (reminder.status == PaymentStatus.paid) {
        monthlyMap[key] = MonthlyData(
          month: existing.month,
          year: existing.year,
          paid: existing.paid + reminder.amount,
          due: existing.due,
          saved: existing.saved,
          paymentCount: existing.paymentCount + 1,
        );
      } else {
        monthlyMap[key] = MonthlyData(
          month: existing.month,
          year: existing.year,
          paid: existing.paid,
          due: existing.due + reminder.amount,
          saved: existing.saved,
          paymentCount: existing.paymentCount,
        );
      }
    }
  }

  // Aggregate savings data
  for (final goal in goalsState.goals) {
    for (final contribution in goal.contributions) {
      if (contribution.date.isBefore(startDate)) continue;
      if (contribution.amount <= 0) continue;

      final key = '${contribution.date.year}-${contribution.date.month}';
      if (monthlyMap.containsKey(key)) {
        final existing = monthlyMap[key]!;
        monthlyMap[key] = MonthlyData(
          month: existing.month,
          year: existing.year,
          paid: existing.paid,
          due: existing.due,
          saved: existing.saved + contribution.amount,
          paymentCount: existing.paymentCount,
        );
      }
    }
  }

  return monthlyMap.values.toList()..sort((a, b) {
    final yearCompare = a.year.compareTo(b.year);
    if (yearCompare != 0) return yearCompare;
    return a.month.compareTo(b.month);
  });
});

// Debt vs Paid pie chart data
final debtPaidRatioProvider = Provider<Map<String, double>>((ref) {
  final summary = ref.watch(reportsSummaryProvider);

  final totalDebt = summary['totalDebt'] ?? 0;
  final totalPaid = summary['totalPaid'] ?? 0;
  final total = totalDebt + totalPaid;

  if (total == 0) {
    return {'debt': 0, 'paid': 0};
  }

  return {
    'debt': totalDebt / total * 100,
    'paid': totalPaid / total * 100,
    'debtAmount': totalDebt,
    'paidAmount': totalPaid,
  };
});
