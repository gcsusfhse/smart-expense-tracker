// notification_service.dart
// Handles local push notifications, primarily for budget-limit alerts.
// Author: Muthamil P (Backend Logic & Database Integration)

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Wraps the flutter_local_notifications plugin to show a single
/// "Budget Limit Exceeded" alert when the user's monthly spend
/// crosses their configured budget.
class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Initializes platform-specific notification settings.
  /// Must be called once during app startup (see main.dart).
  Future<void> init() async {
    if (_initialized) return;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  /// Shows a notification warning the user they have exceeded
  /// (or are close to exceeding) their monthly budget limit.
  Future<void> showBudgetAlert({
    required double spent,
    required double limit,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'budget_channel',
      'Budget Alerts',
      channelDescription: 'Notifies when monthly spending nears or exceeds budget',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    final percentage = (spent / limit * 100).toStringAsFixed(0);

    await _plugin.show(
      0,
      'Budget Limit Alert',
      'You have used $percentage% of your monthly budget (₹${spent.toStringAsFixed(2)} / ₹${limit.toStringAsFixed(2)})',
      details,
    );
  }
}
