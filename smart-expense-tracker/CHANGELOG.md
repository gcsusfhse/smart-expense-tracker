# Changelog

All notable changes to the **Smart Expense Tracker** project are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project uses date-based versioning suited to an academic project timeline.

---

## [1.0.0] - 2026-04-18
### Added
- Final integration of all modules for internship submission.
- Polished UI across all screens with consistent theming.
- Project Report and complete documentation finalized.
- App icon and splash screen branding.

### Fixed
- Budget notification firing multiple times for the same threshold (#21).
- Incorrect total in Monthly Summary when switching months quickly (#19).

### Changed
- Refactored `ExpenseProvider` to reduce redundant database calls.

---

## [0.8.0] - 2026-04-05
### Added
- PDF and CSV export functionality with share sheet integration.
- Dark Mode toggle with persisted preference.

### Fixed
- Crash when exporting an empty expense list (#17).
- Date picker allowing future dates beyond today (#15).

---

## [0.6.0] - 2026-03-22
### Added
- Charts screen: category-wise pie chart and 6-month trend bar chart.
- Budget Limit screen with local notification alert when limit is crossed.

### Changed
- Migrated category color/icon logic into a shared `CategoryStyle` utility to avoid duplication across widgets.

---

## [0.4.0] - 2026-03-08
### Added
- Search & Filter screen (search by title, filter by category).
- Monthly Summary screen with month navigation.
- Swipe-to-delete gesture on expense list tiles.

### Fixed
- Form validation not clearing error text after correction (#9).

---

## [0.2.0] - 2026-02-20
### Added
- SQLite database integration via `sqflite` for persistent expense storage.
- Add/Edit Expense screen with category dropdown and date picker.
- Dashboard screen with monthly total summary card.

---

## [0.1.0] - 2026-02-08
### Added
- Initial project scaffolding with Flutter.
- Demo login screen and splash screen.
- Basic app navigation structure and theming setup.
- Repository structure: README, LICENSE, .gitignore, CONTRIBUTING guide.

---

**Legend:** `Added` = new feature · `Changed` = modification to existing feature · `Fixed` = bug fix
