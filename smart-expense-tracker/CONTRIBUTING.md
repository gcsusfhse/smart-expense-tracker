# Contributing to Smart Expense Tracker

Thank you for your interest in contributing! This document outlines the workflow our team followed during development and the guidelines for anyone extending this project.

## Team Workflow

This project was built collaboratively by a 4-member team as part of a Mobile Application Development internship. We followed a simplified **feature-branch workflow**:

1. `main` branch always contains stable, working code.
2. Each feature was developed on its own branch, e.g. `feature/add-expense-screen`, `feature/charts`, `bugfix/budget-notification`.
3. Once a feature was complete and tested locally, a Pull Request was opened and reviewed by at least one other team member before merging.
4. Merge conflicts were resolved collaboratively during weekly sync-up calls.

## Branch Naming Convention

| Type        | Format                        | Example                          |
|-------------|--------------------------------|-----------------------------------|
| Feature     | `feature/short-description`    | `feature/expense-search`          |
| Bug fix     | `bugfix/short-description`     | `bugfix/dashboard-null-crash`     |
| Documentation | `docs/short-description`     | `docs/update-readme`              |

## Commit Message Guidelines

We follow a conventional, readable commit message style:

```
<type>: <short description>

Examples:
feat: add monthly summary screen
fix: resolve crash when deleting last expense
docs: update README with installation steps
style: format expense_tile widget
refactor: simplify category filter logic
test: add unit tests for Validators class
```

## How to Contribute (for future extensions)

1. Fork the repository.
2. Clone your fork: `git clone https://github.com/gcsusfhse/smart-expense-tracker.git`
3. Create a new branch: `git checkout -b feature/your-feature-name`
4. Make your changes, following the existing code style (see below).
5. Run `flutter analyze` and `flutter test` before committing.
6. Commit your changes with a clear message.
7. Push to your fork and open a Pull Request against `main`.

## Code Style Guidelines

- Follow standard [Dart style conventions](https://dart.dev/effective-dart/style).
- Keep widgets small and focused — extract reusable UI into `lib/widgets/`.
- Add a short comment header to every new file explaining its purpose and listing the responsible author, consistent with the rest of the codebase.
- All public classes and non-trivial methods should have doc comments (`///`).
- Run `flutter format .` before committing.

## Reporting Issues

If you find a bug or want to suggest an enhancement, please open an issue using the templates in `.github/ISSUE_TEMPLATE/` and include:
- Steps to reproduce (for bugs)
- Expected vs actual behavior
- Screenshots, if relevant
- Flutter/Dart version (`flutter --version`)

## Code of Conduct

Be respectful and constructive in code reviews and discussions. This project was built by students learning together — feedback should always be educational, not discouraging.
