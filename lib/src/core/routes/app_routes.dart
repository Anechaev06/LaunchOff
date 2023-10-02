import 'package:flutter/material.dart';
import 'package:launchoff/src/features/home/home.dart';
import 'package:launchoff/src/features/project/project.dart';
import '../../features/auth/auth.dart';
import '../../features/navigation/navigation.dart';

class AppRoutes {
  AppRoutes._();

  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const NavigationScreen(),
    '/home': (_) => const HomeScreen(),
    '/auth': (_) => const AuthScreen(),
    '/profile': (_) => const ProfileScreen(),
    '/project': (_) => const UserProjectListScreen(),
    '/projectAdd': (_) => ProjectAddScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeBuilder = routes[settings.name];
    if (routeBuilder != null) {
      return MaterialPageRoute(builder: routeBuilder);
    }
    return MaterialPageRoute(builder: (_) => const NavigationScreen());
  }
}
