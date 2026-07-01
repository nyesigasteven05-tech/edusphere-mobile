import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/session_provider.dart';
import '../../../widgets/dashboard_header.dart';
import '../../../widgets/module_card.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<SessionProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              name: user?.name ?? 'Student',
              role: user?.role.displayName ?? 'Learner',
            ),
            const SizedBox(height: 24),
            const Text(
              'My Portal',
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
                  icon: Icons.book,
                  title: 'Classes',
                  subtitle: 'My enrolled classes',
                ),
                ModuleCard(
                  icon: Icons.assignment,
                  title: 'Assignments',
                  subtitle: 'View & submit',
                ),
                ModuleCard(
                  icon: Icons.grade,
                  title: 'Grades',
                  subtitle: 'My scores',
                ),
                ModuleCard(
                  icon: Icons.receipt,
                  title: 'Fees',
                  subtitle: 'Fee status',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
