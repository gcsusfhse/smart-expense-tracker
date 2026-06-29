// db_helper.dart
// Handles all local persistence using SQLite (sqflite package).
// Author: Muthamil P (Backend Logic & Database Integration)

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense.dart';
import '../models/budget.dart';

/// Singleton wrapper around the sqflite database.
///
/// Why SQLite instead of Firebase/Firestore?
/// This is a 2nd-year academic project focused on core mobile-app
/// concepts (state management, UI, local persistence) rather than
/// cloud infrastructure. SQLite keeps the app fully offline-capable,
/// which is also friendlier for demoing without an internet connection.
class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expense_tracker.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Table for individual expense records.
    await db.execute('''
      CREATE TABLE expenses (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        note TEXT
      )
    ''');

    // Table for storing the monthly budget limit.
    await db.execute('''
      CREATE TABLE budgets (
        month INTEGER NOT NULL,
        year INTEGER NOT NULL,
        limit_amount REAL NOT NULL,
        PRIMARY KEY (month, year)
      )
    ''');
  }

  // ---------------------- EXPENSE CRUD OPERATIONS ----------------------

  /// Inserts a new expense record into the database.
  Future<void> insertExpense(Expense expense) async {
    final db = await database;
    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Returns all expenses sorted by most recent date first.
  Future<List<Expense>> getAllExpenses() async {
    final db = await database;
    final result = await db.query('expenses', orderBy: 'date DESC');
    return result.map((row) => Expense.fromMap(row)).toList();
  }

  /// Updates an existing expense identified by its [id].
  Future<void> updateExpense(Expense expense) async {
    final db = await database;
    await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  /// Deletes an expense by [id].
  Future<void> deleteExpense(String id) async {
    final db = await database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  /// Returns expenses that fall within the given month/year.
  /// Used for the Monthly Summary screen and budget calculations.
  Future<List<Expense>> getExpensesForMonth(int month, int year) async {
    final all = await getAllExpenses();
    return all
        .where((e) => e.date.month == month && e.date.year == year)
        .toList();
  }

  /// Searches expenses by title (case-insensitive) and/or category.
  Future<List<Expense>> searchExpenses({
    String? query,
    ExpenseCategory? category,
  }) async {
    final all = await getAllExpenses();
    return all.where((e) {
      final matchesQuery = query == null ||
          query.isEmpty ||
          e.title.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == null || e.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  // ---------------------- BUDGET OPERATIONS ----------------------

  /// Saves or updates the budget limit for a given month/year.
  Future<void> setBudget(Budget budget) async {
    final db = await database;
    await db.insert(
      'budgets',
      budget.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves the budget limit for a given month/year, if set.
  Future<Budget?> getBudget(int month, int year) async {
    final db = await database;
    final result = await db.query(
      'budgets',
      where: 'month = ? AND year = ?',
      whereArgs: [month, year],
    );
    if (result.isEmpty) return null;
    return Budget.fromMap(result.first);
  }
}
