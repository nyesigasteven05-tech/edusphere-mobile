enum UserRole {
  superAdmin,
  schoolAdmin,
  accountant,
  teacher,
  student,
  parent,
}

extension UserRoleX on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.superAdmin:
        return 'Super Admin';
      case UserRole.schoolAdmin:
        return 'School Admin';
      case UserRole.accountant:
        return 'Accountant';
      case UserRole.teacher:
        return 'Teacher';
      case UserRole.student:
        return 'Student';
      case UserRole.parent:
        return 'Parent';
    }
  }

  static UserRole? fromApiString(String roleString) {
    switch (roleString.toLowerCase().replaceAll(' ', '')) {
      case 'superadmin':
        return UserRole.superAdmin;
      case 'schooladmin':
        return UserRole.schoolAdmin;
      case 'accountant':
        return UserRole.accountant;
      case 'teacher':
        return UserRole.teacher;
      case 'student':
        return UserRole.student;
      case 'parent':
        return UserRole.parent;
      default:
        return null;
    }
  }
}

class AppUser {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final String token;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.token,
  });

  factory AppUser.fromJson(Map<String, dynamic> json, String token) {
    return AppUser(
      id: json['id'] as String? ?? 'unknown',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: UserRoleX.fromApiString(json['role'] as String? ?? 'Student') ??
          UserRole.student,
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.displayName,
      'token': token,
    };
  }
}
