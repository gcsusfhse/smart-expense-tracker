// app_drawer.dart
// Side navigation drawer used across main app screens.
// Author: Nandhini K (UI/UX Design & Frontend Development)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/auth_service.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/expense_list_screen.dart';
import '../screens/monthly_summary_screen.dart';
import '../screens/search_screen.dart';
import '../screens/charts_screen.dart';
import '../screens/budget_screen.dart';
import '../screens/export_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).appBarTheme.backgroundColor),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 40),
                  SizedBox(height: 8),
                  Text(
                    'Smart Expense Tracker',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            _drawerItem(context, Icons.dashboard, 'Dashboard', const DashboardScreen()),
            _drawerItem(context, Icons.list_alt, 'All Expenses', const ExpenseListScreen()),
            _drawerItem(context, Icons.calendar_month, 'Monthly Summary', const MonthlySummaryScreen()),
            _drawerItem(context, Icons.search, 'Search & Filter', const SearchScreen()),
            _drawerItem(context, Icons.pie_chart, 'Charts', const ChartsScreen()),
            _drawerItem(context, Icons.account_balance, 'Budget Limit', const BudgetScreen()),
            _drawerItem(context, Icons.ios_share, 'Export Report', const ExportScreen()),
            const Divider(),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('Dark Mode'),
              value: themeProvider.isDarkMode,
              onChanged: (_) => themeProvider.toggleTheme(),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {
                await AuthService().logout();
                if (!context.mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, Widget screen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
      },
    );
  }
}
