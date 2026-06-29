// constants.dart
// App-wide constants: colors, strings, and spacing values.
// Author: Nandhini K (UI/UX Design & Frontend Development)

import 'package:flutter/material.dart';
import '../models/expense.dart';

class AppConstants {
  static const String appName = 'Smart Expense Tracker';
  static const String appTagline = 'Track. Save. Grow.';

  // Default budget suggestion shown on first launch
  static const double defaultBudgetSuggestion = 10000.0;
}

/// Maps each [ExpenseCategory] to a representative color and icon,
/// used consistently across charts, list tiles, and category chips.
class CategoryStyle {
  static Color colorFor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return const Color(0xFFEF6C00);
      case ExpenseCategory.travel:
        return const Color(0xFF1E88E5);
      case ExpenseCategory.shopping:
        return const Color(0xFFD81B60);
      case ExpenseCategory.bills:
        return const Color(0xFF6D4C41);
      case ExpenseCategory.health:
        return const Color(0xFFC62828);
      case ExpenseCategory.entertainment:
        return const Color(0xFF8E24AA);
      case ExpenseCategory.education:
        return const Color(0xFF00897B);
      case ExpenseCategory.others:
        return const Color(0xFF607D8B);
    }
  }

  static IconData iconFor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Icons.restaurant;
      case ExpenseCategory.travel:
        return Icons.directions_car;
      case ExpenseCategory.shopping:
        return Icons.shopping_bag;
      case ExpenseCategory.bills:
        return Icons.receipt_long;
      case ExpenseCategory.health:
        return Icons.local_hospital;
      case ExpenseCategory.entertainment:
        return Icons.movie;
      case ExpenseCategory.education:
        return Icons.school;
      case ExpenseCategory.others:
        return Icons.category;
    }
  }
}
