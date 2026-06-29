// user.dart
// Simple demo user model — used only for the local/demo login flow.
// NOTE: This is a college internship demo project, so authentication is
// simulated locally using SharedPreferences rather than a real backend
// (e.g., Firebase Auth). See docs/PROJECT_REPORT.md for justification.
// Author: Muthamil P (Backend Logic & Database Integration)

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  Map<String, dynamic> toMap() => {'name': name, 'email': email};

  factory User.fromMap(Map<String, dynamic> map) =>
      User(name: map['name'] as String, email: map['email'] as String);
}
