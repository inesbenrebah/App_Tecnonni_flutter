import 'package:go_router/go_router.dart';
import 'package:app_tecnonni_flutter/features/auth/login_screen.dart';
import 'package:app_tecnonni_flutter/features/auth/setup_screen.dart';
import 'package:app_tecnonni_flutter/features/auth/signup_screen.dart';
import 'package:app_tecnonni_flutter/features/help/help_screen.dart';
import 'package:app_tecnonni_flutter/features/home/home_screen.dart';
import 'package:app_tecnonni_flutter/features/lessons/phone_path_screen.dart';
import 'package:app_tecnonni_flutter/features/onboarding/onboarding_screen.dart';
import 'package:app_tecnonni_flutter/features/onboarding/welcome_screen.dart';
import 'package:app_tecnonni_flutter/features/profile/profile_screen.dart';
import 'package:app_tecnonni_flutter/features/settings/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (c, s) => const WelcomeScreen()),
    GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingScreen()),
    GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (c, s) => const SignupScreen()),
    GoRoute(path: '/setup', builder: (c, s) => const SetupScreen()),
    GoRoute(
      path: '/home',
      builder: (c, s) => HomeScreen(initialTab: (s.extra as int?) ?? 0),
    ),
    GoRoute(path: '/phone', builder: (c, s) => const PhonePathScreen()),
    GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
    GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
    GoRoute(path: '/help', builder: (c, s) => const HelpScreen()),
  ],
);