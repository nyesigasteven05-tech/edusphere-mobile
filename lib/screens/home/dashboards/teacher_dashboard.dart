import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/session_provider.dart';
import '../../../widgets/dashboard_header.dart';
import '../../../widgets/module_card.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<SessionProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              name: user?.name ?? 'Teacher',
              role: user?.role.displayName ?? 'Educator',
            ),
            const SizedBox(height: 24),
            const Text(
              'My Classes',
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
                  icon: Icons.class_,
                  title: 'Classes',
                  subtitle: 'My classes',
                ),
                ModuleCard(
                  icon: Icons.assignment,
                  title: 'Assignments',
                  subtitle: 'Create & grade',
                ),
                ModuleCard(
                  icon: Icons.checklist,
                  title: 'Attendance',
                  subtitle: 'Mark attendance',
                ),
                ModuleCard(
                  icon: Icons.grade,
                  title: 'Grades',
                  subtitle: 'Record scores',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
