// expense_model_test.dart
// Unit tests for the Expense model and category mapping.
// Author: Monisha S (Testing, Documentation & Bug Fixing)

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/models/expense.dart';

void main() {
  group('Expense model', () {
    test('toMap and fromMap round-trip correctly', () {
      final original = Expense(
        title: 'Groceries',
        amount: 499.99,
        category: ExpenseCategory.food,
        date: DateTime(2026, 3, 15),
        note: 'Weekly shopping',
      );

      final map = original.toMap();
      final restored = Expense.fromMap(map);

      expect(restored.title, original.title);
      expect(restored.amount, original.amount);
      expect(restored.category, original.category);
      expect(restored.note, original.note);
    });

    test('copyWith overrides only specified fields', () {
      final original = Expense(
        title: 'Bus Ticket',
        amount: 25.0,
        category: ExpenseCategory.travel,
        date: DateTime(2026, 3, 10),
      );

      final updated = original.copyWith(amount: 30.0);

      expect(updated.title, original.title);
      expect(updated.amount, 30.0);
      expect(updated.id, original.id);
    });
  });

  group('ExpenseCategoryX', () {
    test('label returns correct readable string', () {
      expect(ExpenseCategory.food.label, 'Food');
      expect(ExpenseCategory.entertainment.label, 'Entertainment');
    });

    test('fromString correctly parses a known category', () {
      expect(ExpenseCategoryX.fromString('Travel'), ExpenseCategory.travel);
    });

    test('fromString falls back to Others for unknown input', () {
      expect(ExpenseCategoryX.fromString('Unknown'), ExpenseCategory.others);
    });
  });
}
