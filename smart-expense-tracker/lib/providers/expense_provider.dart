// expense_provider.dart
// Central state management class using the Provider package.
// Author: Muthamil P (Backend Logic) with UI hooks by Nandhini K (Frontend)

import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../models/budget.dart';
import '../services/db_helper.dart';
import '../services/notification_service.dart';

/// [ExpenseProvider] is the single source of truth for expense data
/// across the app. Screens listen to this provider via [Consumer] or
/// [context.watch] so the UI automatically rebuilds whenever expenses
/// are added, edited, or deleted.
///
/// We chose the `provider` package (over setState or BLoC) because it
/// offers a good balance of simplicity and scalability for a project
/// of this size — ideal for a 2nd-year academic submission.
class ExpenseProvider extends ChangeNotifier {
  final DBHelper _dbHelper = DBHelper.instance;

  List<Expense> _expenses = [];
  Budget? _currentBudget;
  bool _isLoading = false;

  List<Expense> get expenses => _expenses;
  Budget? get currentBudget => _currentBudget;
  bool get isLoading => _isLoading;

  /// Loads all expenses from the local database into memory.
  /// Called once on app startup and after any CRUD operation.
  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();

    _expenses = await _dbHelper.getAllExpenses();

    final now = DateTime.now();
    _currentBudget = await _dbHelper.getBudget(now.month, now.year);

    _isLoading = false;
    notifyListeners();
  }

  /// Adds a new expense and refreshes the in-memory list.
  Future<void> addExpense(Expense expense) async {
    await _dbHelper.insertExpense(expense);
    await loadExpenses();
    await _checkBudgetThreshold();
  }

  /// Updates an existing expense and refreshes the in-memory list.
  Future<void> updateExpense(Expense expense) async {
    await _dbHelper.updateExpense(expense);
    await loadExpenses();
    await _checkBudgetThreshold();
  }

  /// Deletes an expense by id and refreshes the in-memory list.
  Future<void> deleteExpense(String id) async {
    await _dbHelper.deleteExpense(id);
    await loadExpenses();
  }

  /// Sets/updates the monthly budget limit.
  Future<void> setBudget(double limit) async {
    final now = DateTime.now();
    final budget = Budget(month: now.month, year: now.year, limit: limit);
    await _dbHelper.setBudget(budget);
    _currentBudget = budget;
    notifyListeners();
    await _checkBudgetThreshold();
  }

  /// Returns the total amount spent in the current month.
  double get currentMonthTotal {
    final now = DateTime.now();
    return _expenses
        .where((e) => e.date.month == now.month && e.date.year == now.year)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  /// Returns a map of category -> total spent, used for pie/bar charts.
  Map<ExpenseCategory, double> get categoryTotals {
    final Map<ExpenseCategory, double> totals = {};
    for (final expense in _expenses) {
      totals[expense.category] = (totals[expense.category] ?? 0) + expense.amount;
    }
    return totals;
  }

  /// Checks whether current spending has crossed the budget limit and,
  /// if so, triggers a local notification.
  Future<void> _checkBudgetThreshold() async {
    if (_currentBudget == null) return;
    final spent = currentMonthTotal;
    if (spent >= _currentBudget!.limit) {
      await NotificationService.instance.showBudgetAlert(
        spent: spent,
        limit: _currentBudget!.limit,
      );
    }
  }

  /// Returns expenses filtered by search query and/or category.
  /// Used by the Search & Filter screen.
  List<Expense> filterExpenses({String? query, ExpenseCategory? category}) {
    return _expenses.where((e) {
      final matchesQuery = query == null ||
          query.isEmpty ||
          e.title.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == null || e.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }
}
