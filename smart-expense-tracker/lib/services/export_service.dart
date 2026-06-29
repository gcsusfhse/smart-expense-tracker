// export_service.dart
// Handles exporting the expense list as a CSV file or a PDF report.
// Author: Muthamil P (Backend Logic & Database Integration)
// Reviewed & tested by: Monisha S (Testing & Documentation)

import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/expense.dart';

/// Generates downloadable reports from a list of expenses.
/// Supports two formats:
///   - CSV: lightweight, good for opening in Excel/Sheets.
///   - PDF: formatted report suitable for sharing/printing.
class ExportService {
  /// Exports the given expenses as a CSV file and returns the saved [File].
  Future<File> exportToCSV(List<Expense> expenses) async {
    final rows = <List<String>>[
      ['Title', 'Amount (₹)', 'Category', 'Date', 'Note'],
      ...expenses.map((e) => [
            e.title,
            e.amount.toStringAsFixed(2),
            e.category.label,
            e.date.toIso8601String().split('T').first,
            e.note ?? '',
          ]),
    ];

    final csvData = const ListToCsvConverter().convert(rows);

    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/expense_report_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = File(filePath);
    await file.writeAsString(csvData);
    return file;
  }

  /// Exports the given expenses as a formatted PDF report and returns
  /// the saved [File].
  Future<File> exportToPDF(List<Expense> expenses) async {
    final pdf = pw.Document();
    final total = expenses.fold<double>(0, (sum, e) => sum + e.amount);

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(level: 0, text: 'Smart Expense Tracker — Report'),
          pw.SizedBox(height: 10),
          pw.Text('Generated on: ${DateTime.now().toString().split('.').first}'),
          pw.SizedBox(height: 16),
          pw.Table.fromTextArray(
            headers: ['Title', 'Amount (₹)', 'Category', 'Date'],
            data: expenses
                .map((e) => [
                      e.title,
                      e.amount.toStringAsFixed(2),
                      e.category.label,
                      e.date.toIso8601String().split('T').first,
                    ])
                .toList(),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'Total Spent: ₹${total.toStringAsFixed(2)}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/expense_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
