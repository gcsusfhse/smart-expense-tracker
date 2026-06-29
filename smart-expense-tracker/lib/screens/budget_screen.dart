// budget_screen.dart
// Lets the user set their monthly budget limit and view current usage.
// Author: Muthamil P (Backend Logic & Database Integration)
// UI styling: Nandhini K (UI/UX Design & Frontend Development)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../utils/formatters.dart';
import '../utils/validators.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentBudget = context.read<ExpenseProvider>().currentBudget;
    if (currentBudget != null) {
      _budgetController.text = currentBudget.limit.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _saveBudget() async {
    if (!_formKey.currentState!.validate()) return;
    final limit = double.parse(_budgetController.text);
    await context.read<ExpenseProvider>().setBudget(limit);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Budget limit updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final spent = provider.currentMonthTotal;

    return Scaffold(
      appBar: AppBar(title: const Text('Set Budget Limit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Current Month Spending', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(Formatters.currency(spent),
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _budgetController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Monthly Budget Limit (₹)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                ),
                validator: Validators.validateAmount,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBudget,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Save Budget'),
              ),
              const SizedBox(height: 12),
              const Text(
                'You will receive a notification once your spending reaches this limit.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
