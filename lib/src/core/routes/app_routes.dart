import 'package:flutter/material.dart';
import '../../features/home/home.dart';
import '../../features/project/project.dart';
import '../../features/auth/auth.dart';
import '../../features/navigation/navigation.dart';

class AppRoutes {
  AppRoutes._();

  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const NavigationScreen(),
    '/home': (_) => const HomeScreen(),
    '/auth': (_) => const AuthScreen(),
    '/project': (_) => const UserProjectsScreen(),
    '/projectAdd': (_) => const ProjectAddScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeBuilder = routes[settings.name];
    if (routeBuilder != null) {
      return MaterialPageRoute(builder: routeBuilder);
    }
    return MaterialPageRoute(builder: (_) => const NavigationScreen());
  }
}
