// auth_service.dart
// Simulated authentication service for the demo login flow.
// Author: Muthamil P (Backend Logic & Database Integration)

import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

/// Handles "login" and "logout" for the demo authentication flow.
///
/// This project does not use a real backend/auth provider — login is
/// simulated locally so the focus stays on core Flutter/mobile-dev
/// concepts. Credentials are not validated against a server; any
/// non-empty name + valid-looking email is accepted, mirroring how many
/// classroom demo apps illustrate an auth flow without external services.
class AuthService {
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyUserName = 'user_name';
  static const _keyUserEmail = 'user_email';

  /// Simulates a login request. In a production app this would call a
  /// REST API or Firebase Auth and handle real credential verification.
  Future<bool> login(String name, String email, String password) async {
    if (name.trim().isEmpty || !email.contains('@') || password.length < 4) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserName, name.trim());
    await prefs.setString(_keyUserEmail, email.trim());
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
    if (!isLoggedIn) return null;

    final name = prefs.getString(_keyUserName) ?? 'Guest';
    final email = prefs.getString(_keyUserEmail) ?? '';
    return User(name: name, email: email);
  }
}
