import 'package:uuid/uuid.dart';

enum PaymentStatus { pending, paid, overdue, skipped }

enum RecurrenceType { monthly, biweekly, weekly }

class PaymentReminder {
  final String id;
  final String? loanId;
  final String name;
  final double amount;
  final DateTime dueDate;
  final int reminderDaysBefore;
  final PaymentStatus status;
  final DateTime? paidDate;
  final bool isRecurring;
  final RecurrenceType? recurrence;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;

  PaymentReminder({
    String? id,
    this.loanId,
    required this.name,
    required this.amount,
    required this.dueDate,
    this.reminderDaysBefore = 3,
    this.status = PaymentStatus.pending,
    this.paidDate,
    this.isRecurring = true,
    this.recurrence = RecurrenceType.monthly,
    DateTime? createdAt,
    this.updatedAt,
    this.notes,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  bool get isOverdue =>
      status == PaymentStatus.pending && DateTime.now().isAfter(dueDate);

  int get daysUntilDue => dueDate.difference(DateTime.now()).inDays;

  bool get shouldNotify {
    final daysLeft = daysUntilDue;
    return status == PaymentStatus.pending &&
        daysLeft >= 0 &&
        daysLeft <= reminderDaysBefore;
  }

  DateTime get nextDueDate {
    if (!isRecurring || recurrence == null) return dueDate;

    DateTime next = dueDate;
    while (next.isBefore(DateTime.now())) {
      switch (recurrence!) {
        case RecurrenceType.weekly:
          next = next.add(const Duration(days: 7));
          break;
        case RecurrenceType.biweekly:
          next = next.add(const Duration(days: 14));
          break;
        case RecurrenceType.monthly:
          next = DateTime(next.year, next.month + 1, next.day);
          break;
      }
    }
    return next;
  }

  PaymentReminder copyWith({
    String? loanId,
    String? name,
    double? amount,
    DateTime? dueDate,
    int? reminderDaysBefore,
    PaymentStatus? status,
    DateTime? paidDate,
    bool? isRecurring,
    RecurrenceType? recurrence,
    String? notes,
  }) {
    return PaymentReminder(
      id: id,
      loanId: loanId ?? this.loanId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      status: status ?? this.status,
      paidDate: paidDate ?? this.paidDate,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrence: recurrence ?? this.recurrence,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loanId': loanId,
      'name': name,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'reminderDaysBefore': reminderDaysBefore,
      'status': status.index,
      'paidDate': paidDate?.toIso8601String(),
      'isRecurring': isRecurring,
      'recurrence': recurrence?.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'notes': notes,
    };
  }

  factory PaymentReminder.fromJson(Map<String, dynamic> json) {
    return PaymentReminder(
      id: json['id'] as String,
      loanId: json['loanId'] as String?,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      reminderDaysBefore: json['reminderDaysBefore'] as int? ?? 3,
      status: PaymentStatus.values[json['status'] as int? ?? 0],
      paidDate: json['paidDate'] != null
          ? DateTime.parse(json['paidDate'] as String)
          : null,
      isRecurring: json['isRecurring'] as bool? ?? true,
      recurrence: json['recurrence'] != null
          ? RecurrenceType.values[json['recurrence'] as int]
          : RecurrenceType.monthly,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      notes: json['notes'] as String?,
    );
  }
}

class PaymentHistory {
  final String id;
  final String reminderId;
  final double amountPaid;
  final DateTime paidDate;
  final String? notes;

  PaymentHistory({
    String? id,
    required this.reminderId,
    required this.amountPaid,
    required this.paidDate,
    this.notes,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reminderId': reminderId,
      'amountPaid': amountPaid,
      'paidDate': paidDate.toIso8601String(),
      'notes': notes,
    };
  }

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      id: json['id'] as String,
      reminderId: json['reminderId'] as String,
      amountPaid: (json['amountPaid'] as num).toDouble(),
      paidDate: DateTime.parse(json['paidDate'] as String),
      notes: json['notes'] as String?,
    );
  }
}
