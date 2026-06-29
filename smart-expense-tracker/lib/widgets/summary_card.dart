// summary_card.dart
// Dashboard card showing total spend vs budget with a progress indicator.
// Author: Nandhini K (UI/UX Design & Frontend Development)

import 'package:flutter/material.dart';
import '../utils/formatters.dart';

class SummaryCard extends StatelessWidget {
  final double spent;
  final double? budgetLimit;

  const SummaryCard({super.key, required this.spent, this.budgetLimit});

  @override
  Widget build(BuildContext context) {
    final hasBudget = budgetLimit != null && budgetLimit! > 0;
    final progress = hasBudget ? (spent / budgetLimit!).clamp(0.0, 1.0) : 0.0;
    final isOverBudget = hasBudget && spent > budgetLimit!;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This Month', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(
              Formatters.currency(spent),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            if (hasBudget) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  color: isOverBudget ? Colors.red : const Color(0xFF00897B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isOverBudget
                    ? 'Budget exceeded! Limit: ${Formatters.currency(budgetLimit!)}'
                    : 'Budget limit: ${Formatters.currency(budgetLimit!)}',
                style: TextStyle(
                  fontSize: 12,
                  color: isOverBudget ? Colors.red : Colors.grey,
                  fontWeight: isOverBudget ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ] else
              const Text(
                'No budget set yet. Tap the budget icon to set one.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
