// budget.dart
// Model representing the user's monthly budget limit.
// Author: Muthamil P (Backend Logic & Database Integration)

/// Stores the monthly budget limit set by the user.
/// Used by [NotificationService] to trigger a "Budget Limit Exceeded"
/// alert once total monthly expenses cross this value.
class Budget {
  final int month; // 1-12
  final int year;
  final double limit;

  Budget({
    required this.month,
    required this.year,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'year': year,
      'limit_amount': limit,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      month: map['month'] as int,
      year: map['year'] as int,
      limit: (map['limit_amount'] as num).toDouble(),
    );
  }
}
