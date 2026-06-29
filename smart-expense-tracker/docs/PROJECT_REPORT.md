# Project Report: Smart Expense Tracker

**Mobile Application Development — Internship Project**

---

## 1. Title of the Project
**Smart Expense Tracker** — A Cross-Platform Mobile Application for Personal Finance Management

## 2. Team Members & Roles

| Name | Role |
|------|------|
| Nandhini K | UI/UX Design and Frontend Development |
| Muthamil P | Backend Logic and Database Integration |
| Monisha S | Testing, Documentation, and Bug Fixing |
| Arbiya K | Project Management, GitHub Repository Maintenance, and Final Integration |

## 3. Introduction

Managing personal finances is a challenge that affects students and working professionals alike. Many people lose track of where their money goes each month simply because tracking expenses manually (in notebooks or scattered notes apps) is tedious and easy to abandon. **Smart Expense Tracker** addresses this everyday problem by giving users a simple, fast, and visual way to log, categorize, and analyze their spending directly from their phone.

This project was undertaken as part of our Mobile Application Development internship, with the objective of applying classroom concepts — UI design, state management, local databases, and data visualization — to a complete, real-world application.

## 4. Problem Statement

College students and early professionals frequently:
- Spend more than planned because they have no real-time visibility into their expenses.
- Forget where small, frequent expenses (food, travel, etc.) go each month.
- Lack a simple tool to set and track a monthly budget.
- Have no easy way to summarize their spending for personal record-keeping.

There is a need for a **lightweight, offline-capable mobile application** that solves these problems without requiring the user to sign up for a complex finance platform or share sensitive bank details.

## 5. Objectives

1. To design an intuitive mobile interface for recording daily expenses.
2. To implement persistent local storage so data is not lost between sessions.
3. To provide visual summaries (charts/graphs) that help users understand spending patterns.
4. To implement a budget alert system that notifies users when they approach or exceed their monthly limit.
5. To allow users to export their financial data for personal record-keeping.
6. To apply good software engineering practices (modular code, version control, documentation) in a team setting.

## 6. Scope of the Project

The application is scoped as a **single-user, offline-first mobile app**. It does not include:
- Real bank account linking or live transaction syncing.
- Multi-user collaboration or shared expense splitting.
- Cloud backup (could be a future enhancement — see Section 12).

This scope was chosen deliberately to keep the project achievable and focused within the internship timeline, while still covering the full breadth of mobile app development: UI, state management, persistence, notifications, and file export.

## 7. Technology Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| State Management | Provider |
| Local Database | SQLite (via `sqflite`) |
| Local Storage | SharedPreferences |
| Charts | fl_chart |
| Notifications | flutter_local_notifications |
| PDF/CSV Export | pdf, csv, share_plus packages |
| Version Control | Git & GitHub |

**Why Flutter?** Flutter allows a single codebase to target both Android and iOS, which suited our team's limited timeline. Its widget-based architecture also made it easy to divide UI work (Nandhini) and logic work (Muthamil) in parallel.

**Why SQLite over Firebase?** Since this is an academic/demo project focused on core mobile development skills rather than backend infrastructure, SQLite keeps the app fully functional offline and avoids the overhead of managing cloud credentials for a classroom submission.

## 8. System Architecture

The app follows a layered architecture to separate concerns:

```
UI Layer (Screens & Widgets)
        ↓
State Management Layer (Providers)
        ↓
Service Layer (DBHelper, AuthService, NotificationService, ExportService)
        ↓
Data Layer (SQLite Database / SharedPreferences)
```

This separation means, for example, that the database implementation could be swapped for a remote API in the future without rewriting any UI code — only the Service Layer would change.

## 9. Modules Implemented

1. **Authentication Module** — Demo login/logout flow.
2. **Dashboard Module** — Monthly summary card, recent expenses.
3. **Expense Management Module** — Add, edit, delete expenses (CRUD).
4. **Category Module** — 8 predefined categories with icons and colors.
5. **Search & Filter Module** — Search by title, filter by category.
6. **Monthly Summary Module** — Month-wise breakdown with navigation.
7. **Charts Module** — Pie chart (category distribution) and bar chart (6-month trend).
8. **Budget Module** — Set monthly limit, receive notification on exceeding it.
9. **Export Module** — Generate CSV and PDF reports, shareable via system share sheet.
10. **Theme Module** — Light/Dark mode toggle, persisted across sessions.

## 10. Individual Contributions (Detailed)

### Nandhini K — UI/UX Design and Frontend Development
- Designed the overall visual language (color palette, spacing, typography) used across the app.
- Built the Login, Splash, Dashboard, and Add/Edit Expense screens.
- Created reusable widgets: `ExpenseTile`, `SummaryCard`, `CategoryChart`, `AppDrawer`.
- Implemented the Dark Mode theme definitions.

### Muthamil P — Backend Logic and Database Integration
- Designed the SQLite schema for expenses and budgets.
- Implemented `DBHelper` with full CRUD operations.
- Built `ExpenseProvider` for centralized state management.
- Implemented the Budget Limit notification logic and `NotificationService`.
- Implemented `ExportService` for PDF/CSV generation.

### Monisha S — Testing, Documentation, and Bug Fixing
- Wrote form validators (`Validators` class) for all input fields.
- Performed manual testing across Add/Edit, Search, and Export flows; logged and tracked bugs (see CHANGELOG.md).
- Authored the README, this Project Report, and in-code documentation comments.
- Built the Monthly Summary and Search & Filter screens.

### Arbiya K — Project Management, GitHub Repository Maintenance, and Final Integration
- Set up the GitHub repository structure, branch strategy, and `.gitignore`.
- Reviewed and merged pull requests from all team members.
- Performed final integration of all modules into `main.dart` and resolved merge conflicts.
- Coordinated weekly stand-ups and maintained the project timeline.

## 11. Testing Summary

| Test Area | Method | Result |
|-----------|--------|--------|
| Add/Edit/Delete Expense | Manual functional testing | Passed |
| Form Validation (empty fields, invalid amount) | Manual testing | Passed |
| Budget Notification Trigger | Manual testing on physical device | Passed |
| CSV/PDF Export | Manual testing, verified file contents | Passed |
| Dark Mode Persistence | Manual testing across app restarts | Passed |
| Search & Filter Accuracy | Manual testing with sample data | Passed |

Unit tests for utility classes (`Validators`, `Formatters`) are included under `test/`.

## 12. Future Enhancements

- Cloud sync and backup (Firebase or REST API) for multi-device access.
- Recurring expense reminders (e.g., monthly subscriptions).
- Multi-currency support.
- Biometric login (fingerprint/Face ID) instead of demo login.
- Expense sharing/splitting for group expenses.
- Voice-based expense entry.

## 13. Conclusion

The Smart Expense Tracker project allowed our team to apply mobile development concepts learned during our internship to build a complete, functioning application that solves a genuine everyday problem. Through this project we gained hands-on experience with Flutter's widget system, state management using Provider, local database integration with SQLite, and collaborative software development using Git and GitHub. We believe this project demonstrates both our individual technical skills and our ability to work effectively as a team.

## 14. References

See `docs/REFERENCES.md` for the full list of documentation and resources consulted during development.
