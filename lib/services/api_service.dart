import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class ApiConfig {
  /// Toggle between mock and live API
  static bool useMock = true;

  /// Base URL for your deployed API (e.g., https://api.edusphere.com/api/v1)
  static String baseUrl = 'https://api.edusphere.com/api/v1';
}

class ApiService {
  /// Mock login for testing (no backend required)
  static Future<Map<String, dynamic>> mockLogin(String username, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Assign role based on username
    final roleMap = {
      'super': 'Super Admin',
      'admin': 'School Admin',
      'accountant': 'Accountant',
      'teacher': 'Teacher',
      'student': 'Student',
      'parent': 'Parent',
    };

    final role = roleMap[username.toLowerCase()] ?? 'Student';
    final mockToken = 'mock_jwt_${username}_${DateTime.now().millisecondsSinceEpoch}';

    return {
      'token': mockToken,
      'role': role,
      'user': {
        'id': '${username}_id',
        'email': '$username@edusphere.local',
        'name': username.replaceFirst(username[0], username[0].toUpperCase()),
      },
    };
  }

  /// Login with backend API
  static Future<Map<String, dynamic>> liveLogin(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'token': data['token'] as String,
          'role': data['role'] as String,
          'user': data['user'] ?? {},
        };
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Unified login endpoint
  static Future<Map<String, dynamic>> login(String username, String password) async {
    if (ApiConfig.useMock) {
      return mockLogin(username, password);
    } else {
      return liveLogin(username, password);
    }
  }

  /// Logout (if backend supports token revocation)
  static Future<void> logout(String token) async {
    if (!ApiConfig.useMock) {
      try {
        await http.post(
          Uri.parse('${ApiConfig.baseUrl}/auth/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
      } catch (e) {
        // Logout locally anyway
      }
    }
  }
}
