import 'package:flutter/material.dart';
import 'package:launchoff/src/core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      routes: AppRoutes.routes,
      theme: AppTheme.theme,
    );
  }
}
