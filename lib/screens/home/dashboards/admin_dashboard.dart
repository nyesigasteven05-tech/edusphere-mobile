import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/session_provider.dart';
import '../../../widgets/dashboard_header.dart';
import '../../../widgets/module_card.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<SessionProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              name: user?.name ?? 'Admin',
              role: user?.role.displayName ?? 'Administrator',
            ),
            const SizedBox(height: 24),
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: const [
                ModuleCard(
                  icon: Icons.people,
                  title: 'Users',
                  subtitle: 'Manage all users',
                ),
                ModuleCard(
                  icon: Icons.school,
                  title: 'Schools',
                  subtitle: 'School settings',
                ),
                ModuleCard(
                  icon: Icons.receipt,
                  title: 'Reports',
                  subtitle: 'View analytics',
                ),
                ModuleCard(
                  icon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'System config',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
