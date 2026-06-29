// dashboard_screen.dart
// Main landing screen after login — shows summary, recent expenses, and
// quick navigation to other features.
// Author: Nandhini K (UI/UX Design & Frontend Development)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/summary_card.dart';
import '../widgets/expense_tile.dart';
import '../widgets/app_drawer.dart';
import 'add_edit_expense_screen.dart';
import 'expense_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load expenses as soon as the dashboard mounts.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final recentExpenses = provider.expenses.take(5).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: const AppDrawer(),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: provider.loadExpenses,
              child: ListView(
                children: [
                  SummaryCard(
                    spent: provider.currentMonthTotal,
                    budgetLimit: provider.currentBudget?.limit,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Recent Expenses',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ExpenseListScreen()),
                          ),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                  if (recentExpenses.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          'No expenses yet.\nTap + to add your first expense!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...recentExpenses.map(
                      (expense) => ExpenseTile(
                        expense: expense,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddEditExpenseScreen(expense: expense),
                          ),
                        ),
                        onDelete: () => provider.deleteExpense(expense.id),
                      ),
                    ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddEditExpenseScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
