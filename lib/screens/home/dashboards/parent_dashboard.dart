import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/session_provider.dart';
import '../../../widgets/dashboard_header.dart';
import '../../../widgets/module_card.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<SessionProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Portal'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              name: user?.name ?? 'Parent',
              role: user?.role.displayName ?? 'Guardian',
            ),
            const SizedBox(height: 24),
            const Text(
              'Children\'s Progress',
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
                  icon: Icons.grade,
                  title: 'Grades',
                  subtitle: 'Academic progress',
                ),
                ModuleCard(
                  icon: Icons.checklist,
                  title: 'Attendance',
                  subtitle: 'Attendance records',
                ),
                ModuleCard(
                  icon: Icons.receipt,
                  title: 'Fees',
                  subtitle: 'Fee information',
                ),
                ModuleCard(
                  icon: Icons.message,
                  title: 'Messages',
                  subtitle: 'Communicate',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
