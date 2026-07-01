# EduSphere Mobile — Flutter Skeleton

This is the mobile client skeleton for **EduSphere**, the multi-tenant School Management SaaS. It matches the architecture in your Software Design Document: **Flutter app → REST API → JWT auth → MySQL**.

## ✨ What's Included

- **🔐 Login Screen** wired to `POST /auth/login` (per your API Architecture Design)
- **💾 Session Handling**: JWT token + role persisted on-device with `shared_preferences`, restored automatically on app launch (splash screen)
- **🎯 Role-Based Navigation**: After login, the app reads the `role` field from the login response and shows the matching dashboard:
  - Super Admin / School Admin / Accountant → `AdminDashboard`
  - Teacher → `TeacherDashboard`
  - Student → `StudentDashboard`
  - Parent → `ParentDashboard`
- **📱 Bottom Navigation**: Dashboard / Announcements / Profile (with logout)
- **🧪 Mock API Mode** — The whole app runs right now with **no backend**, using a fake login that assigns a role based on the username you type (try `admin`, `teacher`, `student`, `parent`, `accountant`, or `super`).

## 📂 Project Structure

```
lib/
  main.dart                        # App entry point
  main_router.dart                 # Named route configuration
  theme/
    app_theme.dart                 # EduSphere colors, buttons, inputs
  models/
    user_model.dart                # AppUser + UserRole (mirrors `roles` table)
  services/
    api_service.dart               # REST calls — mock/live switch lives here
    session_provider.dart          # Holds + persists logged-in session
  screens/
    auth/
      splash_screen.dart           # App initialization & session check
      login_screen.dart            # Login form with mock demo
    home/
      home_shell.dart              # Bottom nav + role-based routing
      announcements_screen.dart    # System announcements feed
      profile_screen.dart          # User profile & logout
      dashboards/
        admin_dashboard.dart       # Admin/Super Admin/Accountant dashboard
        teacher_dashboard.dart     # Teacher dashboard
        student_dashboard.dart     # Student dashboard
        parent_dashboard.dart      # Parent portal
  widgets/
    dashboard_header.dart          # Personalized greeting widget
    module_card.dart               # Reusable module card for dashboard actions
```

## 🚀 How to Run It

You'll need Flutter installed ([flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)). Since your laptop has limited RAM/storage (per your notes), running this in **GitHub Codespaces** or **Gitpod** is a good option — both give you a cloud Linux box with Flutter pre-installable in seconds.

```bash
# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Or run in browser (no emulator needed)
flutter run -d chrome
```

## 🔌 Connecting to Your Real Node.js/Express API

Everything routes through one file: `lib/services/api_service.dart`.

1. Set `ApiConfig.useMock = false`
2. Set `ApiConfig.baseUrl` to your deployed API, e.g. `https://api.edusphere.com/api/v1`
3. Make sure your `/auth/login` endpoint returns exactly:
   ```json
   {
     "token": "JWT_TOKEN",
     "role": "School Admin",
     "user": {
       "id": "user_id",
       "email": "user@school.com",
       "name": "User Name"
     }
   }
   ```
   (role string must be one of: `Super Admin`, `School Admin`, `Teacher`, `Accountant`, `Student`, `Parent` — matches `UserRoleX.fromApiString`)

No other file needs to change — every screen reads the session through `SessionProvider`, not directly from the API.

## 🎯 Suggested Next Steps

1. **Wire up module cards** (Attendance, Fees, Exams, etc.) to their real endpoints as you build them out:
   - `GET /students` → StudentDashboard
   - `GET /attendance` → Attendance module
   - `GET /fees` → Fees module
   - Each `ModuleCard` currently shows a snackbar placeholder.

2. **Add forgot password flow** using `POST /auth/refresh-token` or a dedicated reset endpoint.

3. **Add pull-to-refresh + loading/error states** once dashboards call real data.

4. **Consider `flutter_secure_storage`** instead of `shared_preferences` for the JWT token before production — plain shared_preferences isn't encrypted.

5. **Add app icons/splash branding** once you have your EduSphere logo finalized.

## 🔑 Demo Mode Credentials

The app runs in **mock mode by default**. Try these usernames to test different roles:

| Username | Role |
|----------|------|
| `super` | Super Admin |
| `admin` | School Admin |
| `accountant` | Accountant |
| `teacher` | Teacher |
| `student` | Student |
| `parent` | Parent |

**Password**: Any value (mock mode ignores it)

## 📋 API Integration Checklist

- [ ] Connect to `/auth/login` endpoint
- [ ] Replace mock data with real API calls
- [ ] Implement `/students` endpoint for Student Dashboard
- [ ] Implement `/attendance` endpoint for Attendance module
- [ ] Implement `/fees` endpoint for Fee module
- [ ] Add error handling and retry logic
- [ ] Implement token refresh logic
- [ ] Add loading states and skeleton screens
- [ ] Test with all 6 roles

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Local Storage**: shared_preferences
- **HTTP**: http package
- **Navigation**: Named routes

## 📄 License

This project is part of the EduSphere School Management SaaS.

---

You've already done the hard part — the planning and architecture are solid. This skeleton just gives you a real, running app shell to build the rest of EduSphere into, screen by screen. Happy coding! 🎓
