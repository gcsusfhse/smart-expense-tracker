// expense.dart
// Data model representing a single expense entry.
// Author: Muthamil P (Backend Logic & Database Integration)

import 'package:uuid/uuid.dart';

/// Enum representing the predefined expense categories.
/// Keeping this centralized avoids typos and makes filtering consistent
/// across the Dashboard, Reports, and Charts screens.
enum ExpenseCategory {
  food,
  travel,
  shopping,
  bills,
  health,
  entertainment,
  education,
  others,
}

/// Helper extension to convert [ExpenseCategory] to a readable label
/// and to/from the string value stored in the local database.
extension ExpenseCategoryX on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.travel:
        return 'Travel';
      case ExpenseCategory.shopping:
        return 'Shopping';
      case ExpenseCategory.bills:
        return 'Bills';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.entertainment:
        return 'Entertainment';
      case ExpenseCategory.education:
        return 'Education';
      case ExpenseCategory.others:
        return 'Others';
    }
  }

  static ExpenseCategory fromString(String value) {
    return ExpenseCategory.values.firstWhere(
      (e) => e.label.toLowerCase() == value.toLowerCase(),
      orElse: () => ExpenseCategory.others,
    );
  }
}

/// Core model class for an Expense record.
///
/// This class is intentionally kept free of any UI or database-specific
/// code (separation of concerns) so it can be reused across:
///   - SQLite persistence (DBHelper)
///   - Charts (fl_chart data points)
///   - PDF / CSV export
class Expense {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final String? note;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  }) : id = id ?? const Uuid().v4();

  /// Creates a copy of this expense with optional field overrides.
  /// Used by the Edit Expense screen so we don't mutate the original object.
  Expense copyWith({
    String? title,
    double? amount,
    ExpenseCategory? category,
    DateTime? date,
    String? note,
  }) {
    return Expense(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  /// Converts this object into a Map for SQLite insertion.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.label,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  /// Builds an [Expense] instance from a SQLite row.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: ExpenseCategoryX.fromString(map['category'] as String),
      date: DateTime.parse(map['date'] as String),
      note: map['note'] as String?,
    );
  }

  @override
  String toString() =>
      'Expense(id: $id, title: $title, amount: $amount, category: ${category.label}, date: $date)';
}
