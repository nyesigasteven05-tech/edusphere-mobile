import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/session_provider.dart';
import '../../theme/app_theme.dart';
import 'login_screen.dart';
import '../home/home_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Wait for session provider to initialize
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final sessionProvider = context.read<SessionProvider>();
    final isLoggedIn = sessionProvider.isLoggedIn;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.school,
              size: 80,
              color: AppTheme.white,
            ),
            const SizedBox(height: 24),
            const Text(
              'EduSphere',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppTheme.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'School Management System',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.white,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
            ),
          ],
        ),
      ),
    );
  }
}
