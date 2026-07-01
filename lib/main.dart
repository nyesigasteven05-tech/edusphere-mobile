import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/session_provider.dart';
import 'theme/app_theme.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SessionProvider()..initializeSession(),
      child: const EduSphereApp(),
    ),
  );
}

class EduSphereApp extends StatelessWidget {
  const EduSphereApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduSphere',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
