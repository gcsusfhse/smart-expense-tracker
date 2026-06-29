// charts_screen.dart
// Visualizes expense distribution and monthly trends using charts.
// Author: Nandhini K (UI/UX Design) with chart data by Muthamil P (Backend)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/expense_provider.dart';
import '../widgets/category_chart.dart';
import '../utils/formatters.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  /// Builds a simple bar chart of total spend for the last 6 months.
  List<BarChartGroupData> _buildMonthlyBars(ExpenseProvider provider) {
    final now = DateTime.now();
    final months = List.generate(6, (i) => DateTime(now.year, now.month - 5 + i));

    return List.generate(months.length, (index) {
      final month = months[index];
      final total = provider.expenses
          .where((e) => e.date.month == month.month && e.date.year == month.year)
          .fold(0.0, (sum, e) => sum + e.amount);

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: total,
            color: const Color(0xFF00897B),
            width: 18,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final now = DateTime.now();
    final months = List.generate(6, (i) => DateTime(now.year, now.month - 5 + i));

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Charts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Spending by Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          CategoryChart(categoryTotals: provider.categoryTotals),
          const SizedBox(height: 32),
          const Text('Last 6 Months Trend', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                barGroups: _buildMonthlyBars(provider),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= months.length) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            Formatters.monthYear(months[index]).split(' ').first.substring(0, 3),
                            style: const TextStyle(fontSize: 11),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
