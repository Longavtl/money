import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money/core/providers/dependency_providers.dart';
import 'package:money/core/storage/local_storage_service.dart';
import 'package:money/domain/entities/payment_reminder.dart';

class RemindersState {
  final List<PaymentReminder> reminders;
  final List<PaymentHistory> history;
  final bool isLoading;
  final String? error;

  const RemindersState({
    this.reminders = const [],
    this.history = const [],
    this.isLoading = false,
    this.error,
  });

  List<PaymentReminder> get pendingReminders =>
      reminders.where((r) => r.status == PaymentStatus.pending).toList();

  List<PaymentReminder> get overdueReminders =>
      reminders.where((r) => r.isOverdue).toList();

  List<PaymentReminder> get upcomingReminders {
    final now = DateTime.now();
    final upcoming = now.add(const Duration(days: 7));
    return pendingReminders
        .where((r) => r.dueDate.isAfter(now) && r.dueDate.isBefore(upcoming))
        .toList();
  }

  int get upcomingCount => upcomingReminders.length;

  RemindersState copyWith({
    List<PaymentReminder>? reminders,
    List<PaymentHistory>? history,
    bool? isLoading,
    String? error,
  }) {
    return RemindersState(
      reminders: reminders ?? this.reminders,
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RemindersNotifier extends StateNotifier<RemindersState> {
  final LocalStorageService _storage;

  RemindersNotifier(this._storage) : super(const RemindersState()) {
    loadReminders();
  }

  Future<void> loadReminders() async {
    state = state.copyWith(isLoading: true);
    try {
      final reminders = _storage.getAllReminders();
      final history = _storage.getPaymentHistory();

      // Update overdue status
      final updatedReminders = reminders.map((r) {
        if (r.status == PaymentStatus.pending && r.isOverdue) {
          return r.copyWith(status: PaymentStatus.overdue);
        }
        return r;
      }).toList();

      state = state.copyWith(
        reminders: updatedReminders,
        history: history,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addReminder(PaymentReminder reminder) async {
    await _storage.saveReminder(reminder);
    await loadReminders();
  }

  Future<void> updateReminder(PaymentReminder reminder) async {
    await _storage.saveReminder(reminder);
    await loadReminders();
  }

  Future<void> deleteReminder(String id) async {
    await _storage.deleteReminder(id);
    await loadReminders();
  }

  Future<void> markAsPaid(String reminderId, {double? amount, String? notes}) async {
    final reminder = state.reminders.firstWhere((r) => r.id == reminderId);

    // Create payment history
    final history = PaymentHistory(
      reminderId: reminderId,
      amountPaid: amount ?? reminder.amount,
      paidDate: DateTime.now(),
      notes: notes,
    );
    await _storage.addPaymentHistory(history);

    // Update reminder status
    final updatedReminder = reminder.copyWith(
      status: PaymentStatus.paid,
      paidDate: DateTime.now(),
    );

    // If recurring, create next reminder
    if (reminder.isRecurring && reminder.recurrence != null) {
      final nextReminder = PaymentReminder(
        loanId: reminder.loanId,
        name: reminder.name,
        amount: reminder.amount,
        dueDate: reminder.nextDueDate,
        reminderDaysBefore: reminder.reminderDaysBefore,
        isRecurring: true,
        recurrence: reminder.recurrence,
        notes: reminder.notes,
      );
      await _storage.saveReminder(nextReminder);
    }

    await _storage.saveReminder(updatedReminder);
    await loadReminders();
  }

  Future<void> skipPayment(String reminderId) async {
    final reminder = state.reminders.firstWhere((r) => r.id == reminderId);
    final updatedReminder = reminder.copyWith(status: PaymentStatus.skipped);
    await _storage.saveReminder(updatedReminder);
    await loadReminders();
  }
}

final remindersProvider =
    StateNotifierProvider<RemindersNotifier, RemindersState>((ref) {
  final storage = ref.watch(localStorageProvider);
  return RemindersNotifier(storage);
});

// Convenience providers
final upcomingRemindersProvider = Provider<List<PaymentReminder>>((ref) {
  return ref.watch(remindersProvider).upcomingReminders;
});

final overdueRemindersProvider = Provider<List<PaymentReminder>>((ref) {
  return ref.watch(remindersProvider).overdueReminders;
});

final upcomingCountProvider = Provider<int>((ref) {
  return ref.watch(remindersProvider).upcomingCount;
});
