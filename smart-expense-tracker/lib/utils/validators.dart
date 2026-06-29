// validators.dart
// Form input validation helpers used across Login and Add/Edit Expense forms.
// Author: Monisha S (Testing, Documentation & Bug Fixing)

class Validators {
  /// Validates the expense title field — must not be empty.
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  /// Validates the expense amount field — must be a positive number.
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an amount';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return 'Enter a valid number';
    }
    if (parsed <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }

  /// Validates email format for the demo login screen.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Validates password length for the demo login screen.
  static String? validatePassword(String? value) {
    if (value == null || value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}
