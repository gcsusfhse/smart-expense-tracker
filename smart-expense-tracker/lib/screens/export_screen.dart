// export_screen.dart
// Lets the user export their expense data as a CSV or PDF report and share it.
// Author: Muthamil P (Backend Logic & Database Integration)
// Testing & edge cases: Monisha S (Testing, Documentation & Bug Fixing)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/expense_provider.dart';
import '../services/export_service.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final ExportService _exportService = ExportService();
  bool _isExporting = false;

  Future<void> _export(String format) async {
    final expenses = context.read<ExpenseProvider>().expenses;

    if (expenses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No expenses to export yet.')),
      );
      return;
    }

    setState(() => _isExporting = true);

    try {
      final file = format == 'csv'
          ? await _exportService.exportToCSV(expenses)
          : await _exportService.exportToPDF(expenses);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'My Expense Report (${format.toUpperCase()})',
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export Report')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Export all your recorded expenses as a CSV or PDF file to share or back up.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              icon: const Icon(Icons.table_chart_outlined),
              label: const Text('Export as CSV'),
              onPressed: _isExporting ? null : () => _export('csv'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('Export as PDF'),
              onPressed: _isExporting ? null : () => _export('pdf'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
            if (_isExporting) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}
