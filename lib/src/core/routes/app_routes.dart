import 'package:flutter/material.dart';
import '../../features/project/project.dart';
import '../../features/auth/auth.dart';
import '../../features/navigation/navigation.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = {
    '/': (_) => const NavigationScreen(),
    '/auth': (_) => const AuthScreen(),
    '/profile': (_) => const ProfileScreen(),
    '/userProjects': (_) => const UserProjectsScreen(),
    '/allProjects': (_) => const UserProjectsScreen(),
    '/projectAdd': (_) => const ProjectAddScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: routes[settings.name] ?? (_) => const NavigationScreen(),
    );
  }
}
