import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../services/session_provider.dart';
import 'dashboards/admin_dashboard.dart';
import 'dashboards/teacher_dashboard.dart';
import 'dashboards/student_dashboard.dart';
import 'dashboards/parent_dashboard.dart';
import 'announcements_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({Key? key}) : super(key: key);

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
      builder: (context, sessionProvider, _) {
        if (sessionProvider.user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = sessionProvider.user!;

        // Select dashboard based on role
        final dashboardWidgets = <Widget>[
          _buildDashboard(user.role),
          const AnnouncementsScreen(),
          const ProfileScreen(),
        ];

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: dashboardWidgets[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Announcements',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard(UserRole role) {
    switch (role) {
      case UserRole.superAdmin:
      case UserRole.schoolAdmin:
      case UserRole.accountant:
        return const AdminDashboard();
      case UserRole.teacher:
        return const TeacherDashboard();
      case UserRole.student:
        return const StudentDashboard();
      case UserRole.parent:
        return const ParentDashboard();
    }
  }
}
