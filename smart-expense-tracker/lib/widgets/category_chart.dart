// category_chart.dart
// Pie chart visualizing expense distribution across categories.
// Author: Nandhini K (UI/UX Design & Frontend Development)
// Chart logic reviewed by: Muthamil P (Backend Logic & Database Integration)

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class CategoryChart extends StatelessWidget {
  final Map<ExpenseCategory, double> categoryTotals;

  const CategoryChart({super.key, required this.categoryTotals});

  @override
  Widget build(BuildContext context) {
    if (categoryTotals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: Text('No expenses yet to chart.')),
      );
    }

    final total = categoryTotals.values.fold(0.0, (a, b) => a + b);

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: categoryTotals.entries.map((entry) {
                final percentage = (entry.value / total * 100);
                return PieChartSectionData(
                  value: entry.value,
                  color: CategoryStyle.colorFor(entry.key),
                  title: '${percentage.toStringAsFixed(0)}%',
                  radius: 70,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: categoryTotals.entries.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: CategoryStyle.colorFor(entry.key),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${entry.key.label} (${Formatters.currency(entry.value)})',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
