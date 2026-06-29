// formatters.dart
// Reusable formatting helpers for currency and dates.
// Author: Monisha S (Testing, Documentation & Bug Fixing)

import 'package:intl/intl.dart';

class Formatters {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static String currency(double amount) => _currencyFormat.format(amount);

  static String shortDate(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  static String monthYear(DateTime date) => DateFormat('MMMM yyyy').format(date);
}
