import 'package:flutter/material.dart';
import '../../features/auth/auth.dart';
import '../../features/navigation/navigation.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const NavigationScreen(),
    '/signIn': (_) => SignInScreen(),
    '/signUp': (_) => const SignUpScreen(),
    '/profile': (_) => const ProfileScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeBuilder = routes[settings.name];
    if (routeBuilder != null) {
      return MaterialPageRoute(builder: routeBuilder);
    }
    return MaterialPageRoute(builder: (_) => const NavigationScreen());
  }
}
