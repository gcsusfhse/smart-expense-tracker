# GitHub Repository Setup Guide

This file is a setup companion — **not part of the app itself** — containing everything you need to configure the repository on GitHub after uploading the project.

---

## 1. Repository Name

```
smart-expense-tracker
```

## 2. Professional Repository Description

> A cross-platform Smart Expense Tracker built with Flutter — track daily expenses, visualize spending with charts, set budget limits with alerts, and export PDF/CSV reports. Built as a team Mobile Application Development internship project.

## 3. Suggested GitHub Topics (tags)

Add these under "About → Topics" on your GitHub repo page:

```
flutter
dart
mobile-app
expense-tracker
android
ios
sqlite
provider
mobile-application-development
student-project
internship-project
finance-app
budget-tracker
flutter-app
cross-platform
fl-chart
material-design
open-source
```

## 4. Suggested 20 Git Commit Messages

These represent a realistic commit history for this project, in chronological order. Use them as you make actual commits, or as a reference for `git log` storytelling:

1. `chore: initialize Flutter project and repository structure`
2. `docs: add initial README with project overview`
3. `feat: add app theming and color palette setup`
4. `feat: implement demo login screen with form validation`
5. `feat: add splash screen with auth status routing`
6. `feat: create Expense and Budget data models`
7. `feat: implement SQLite DBHelper for expense CRUD operations`
8. `feat: add ExpenseProvider for centralized state management`
9. `feat: build Dashboard screen with monthly summary card`
10. `feat: implement Add/Edit Expense screen with category picker`
11. `feat: add swipe-to-delete on expense list tiles`
12. `feat: build All Expenses list screen`
13. `feat: implement Monthly Summary screen with month navigation`
14. `feat: add Search & Filter screen with category chips`
15. `feat: integrate fl_chart for category pie chart`
16. `feat: add 6-month spending trend bar chart`
17. `feat: implement Budget screen and local notification alerts`
18. `feat: add PDF and CSV export with share_plus integration`
19. `feat: implement Dark Mode toggle with persisted preference`
20. `test: add unit tests for Validators and Expense model`

### Bonus commits (for ongoing maintenance realism)
- `fix: resolve crash when exporting an empty expense list`
- `fix: correct budget notification firing multiple times`
- `refactor: extract CategoryStyle into shared utility`
- `docs: add Project Report and Architecture documentation`
- `chore: add GitHub Actions CI workflow for analyze and test`
- `docs: finalize README with screenshots and usage guide`

## 5. Suggested README Badges (already included in README.md)

The main README already includes badges for: Flutter version, Dart version, MIT License, Platform support, Project status, PRs welcome, and CI build status. Update the CI badge URL once GitHub Actions runs are public:

```markdown
[![Build](https://github.com/<your-username>/smart-expense-tracker/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/<your-username>/smart-expense-tracker/actions)
```

## 6. Suggested Branch Protection (for realism)

On GitHub → Settings → Branches, consider protecting `main` with:
- Require pull request before merging
- Require status checks to pass (the CI workflow) before merging

## 7. Suggested GitHub Releases

Tag releases matching the CHANGELOG.md milestones, e.g.:
- `v0.1.0` — Initial scaffolding
- `v0.4.0` — Search, filter, monthly summary
- `v0.6.0` — Charts and budget alerts
- `v0.8.0` — Export and dark mode
- `v1.0.0` — Final submission release

## 8. Suggested LinkedIn/Resume Project Summary

> Built **Smart Expense Tracker**, a Flutter mobile app for personal finance management, as part of a 4-member team during a Mobile Application Development internship. Implemented [your specific module] using [relevant tech], contributing to a project that ships full CRUD functionality, SQLite persistence, data visualization with fl_chart, local budget-limit notifications, and PDF/CSV export — all version-controlled and CI-tested on GitHub.
