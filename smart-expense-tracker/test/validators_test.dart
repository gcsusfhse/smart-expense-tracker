// validators_test.dart
// Unit tests for the Validators utility class.
// Author: Monisha S (Testing, Documentation & Bug Fixing)

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/utils/validators.dart';

void main() {
  group('Validators.validateTitle', () {
    test('returns error when title is empty', () {
      expect(Validators.validateTitle(''), isNotNull);
    });

    test('returns error when title is only whitespace', () {
      expect(Validators.validateTitle('   '), isNotNull);
    });

    test('returns null for a valid title', () {
      expect(Validators.validateTitle('Lunch'), isNull);
    });
  });

  group('Validators.validateAmount', () {
    test('returns error when amount is empty', () {
      expect(Validators.validateAmount(''), isNotNull);
    });

    test('returns error when amount is not a number', () {
      expect(Validators.validateAmount('abc'), isNotNull);
    });

    test('returns error when amount is zero or negative', () {
      expect(Validators.validateAmount('0'), isNotNull);
      expect(Validators.validateAmount('-5'), isNotNull);
    });

    test('returns null for a valid positive amount', () {
      expect(Validators.validateAmount('150.50'), isNull);
    });
  });

  group('Validators.validateEmail', () {
    test('returns error for missing @ symbol', () {
      expect(Validators.validateEmail('invalidemail.com'), isNotNull);
    });

    test('returns null for a valid email', () {
      expect(Validators.validateEmail('student@college.edu'), isNull);
    });
  });

  group('Validators.validatePassword', () {
    test('returns error when password is too short', () {
      expect(Validators.validatePassword('abc'), isNotNull);
    });

    test('returns null when password meets minimum length', () {
      expect(Validators.validatePassword('abcd'), isNull);
    });
  });
}
