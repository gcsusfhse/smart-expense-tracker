# System Architecture

This document explains the architectural layers used in the Smart Expense Tracker app in more detail than the README, intended for developers who want to extend the project.

## Layered Architecture Overview

```
┌──────────────────────────────────────────────┐
│                  UI Layer                     │
│   screens/  (Login, Dashboard, Charts, etc.)  │
│   widgets/  (ExpenseTile, SummaryCard, etc.)  │
└────────────────────┬───────────────────────────┘
                      │ watches / reads
┌────────────────────▼───────────────────────────┐
│            State Management Layer              │
│   providers/ExpenseProvider                     │
│   providers/ThemeProvider                       │
└────────────────────┬───────────────────────────┘
                      │ calls
┌────────────────────▼───────────────────────────┐
│                Service Layer                    │
│   services/DBHelper                             │
│   services/AuthService                          │
│   services/NotificationService                  │
│   services/ExportService                        │
└────────────────────┬───────────────────────────┘
                      │ persists to
┌────────────────────▼───────────────────────────┐
│                  Data Layer                     │
│   SQLite (expenses, budgets tables)             │
│   SharedPreferences (session, theme)            │
└──────────────────────────────────────────────────┘
```

## Why This Structure?

- **Separation of concerns**: UI code never talks to the database directly. This makes it possible to write unit tests for business logic (in `providers/` and `services/`) without needing a UI test harness.
- **Single source of truth**: `ExpenseProvider` holds the in-memory list of expenses that all screens read from, so the UI is always consistent after any add/edit/delete operation.
- **Testability**: Utility classes (`Validators`, `Formatters`) are pure functions with no dependencies, making them trivial to unit test (see `test/`).

## Data Flow Example: Adding an Expense

1. User fills the form on `AddEditExpenseScreen` and taps **Save**.
2. The screen calls `context.read<ExpenseProvider>().addExpense(expense)`.
3. `ExpenseProvider.addExpense()` calls `DBHelper.insertExpense()` to persist the record.
4. `ExpenseProvider` reloads its in-memory list via `loadExpenses()` and calls `notifyListeners()`.
5. Every widget watching `ExpenseProvider` (Dashboard, Expense List, Charts) automatically rebuilds with the new data.
6. `ExpenseProvider` checks the new monthly total against the budget limit and triggers a notification if exceeded.

## Folder-to-Layer Mapping

| Folder | Layer | Responsibility |
|--------|-------|-----------------|
| `lib/screens/` | UI | Full-page views |
| `lib/widgets/` | UI | Reusable, smaller UI components |
| `lib/providers/` | State Management | App-wide reactive state |
| `lib/services/` | Service | Business logic, database, notifications, export |
| `lib/models/` | Data | Plain data classes shared across all layers |
| `lib/utils/` | Cross-cutting | Constants, formatters, validators used everywhere |
