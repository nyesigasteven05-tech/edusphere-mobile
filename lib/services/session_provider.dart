import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';
import 'api_service.dart';

class SessionProvider extends ChangeNotifier {
  AppUser? _user;
  bool _isLoading = false;
  String? _errorMessage;

  AppUser? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  /// Initialize session from persistent storage
  Future<void> initializeSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user_session');

      if (userJson != null) {
        final userData = jsonDecode(userJson);
        _user = AppUser.fromJson(userData, userData['token']);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error initializing session: $e');
      _errorMessage = 'Session restore failed';
      notifyListeners();
    }
  }

  /// Login user
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService.login(username, password);
      final token = response['token'] as String;
      final role = response['role'] as String;

      _user = AppUser(
        id: response['user']?['id'] ?? username,
        email: response['user']?['email'] ?? '$username@edusphere.local',
        name: response['user']?['name'] ?? username,
        role: UserRoleX.fromApiString(role) ?? UserRole.student,
        token: token,
      );

      // Persist session
      await _persistSession();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Login failed: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    if (_user != null) {
      await ApiService.logout(_user!.token);
    }

    _user = null;
    _errorMessage = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_session');
    } catch (e) {
      debugPrint('Error clearing session: $e');
    }

    notifyListeners();
  }

  /// Persist session to device storage
  Future<void> _persistSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(_user?.toJson());
      await prefs.setString('user_session', userJson);
    } catch (e) {
      debugPrint('Error persisting session: $e');
    }
  }
}
