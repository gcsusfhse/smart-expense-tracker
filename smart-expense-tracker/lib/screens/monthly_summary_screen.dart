// monthly_summary_screen.dart
// Shows a breakdown of expenses for a selected month/year.
// Author: Monisha S (Testing, Documentation & Bug Fixing)
// Data logic: Muthamil P (Backend Logic & Database Integration)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_tile.dart';
import '../utils/formatters.dart';
import 'add_edit_expense_screen.dart';

class MonthlySummaryScreen extends StatefulWidget {
  const MonthlySummaryScreen({super.key});

  @override
  State<MonthlySummaryScreen> createState() => _MonthlySummaryScreenState();
}

class _MonthlySummaryScreenState extends State<MonthlySummaryScreen> {
  DateTime _selectedMonth = DateTime.now();

  void _changeMonth(int offset) {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final monthExpenses = provider.expenses
        .where((e) =>
            e.date.month == _selectedMonth.month && e.date.year == _selectedMonth.year)
        .toList();

    final total = monthExpenses.fold(0.0, (sum, e) => sum + e.amount);

    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Summary')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  Formatters.monthYear(_selectedMonth),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Total Spent: ${Formatters.currency(total)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: monthExpenses.isEmpty
                ? const Center(child: Text('No expenses for this month.'))
                : ListView.builder(
                    itemCount: monthExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = monthExpenses[index];
                      return ExpenseTile(
                        expense: expense,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddEditExpenseScreen(expense: expense),
                          ),
                        ),
                        onDelete: () => provider.deleteExpense(expense.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
