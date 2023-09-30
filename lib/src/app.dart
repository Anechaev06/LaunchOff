import 'package:flutter/material.dart';
import 'package:launchoff/src/core/core.dart';
import 'package:launchoff/src/features/navigation/navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.theme,
      home: const NavigationScreen(),
    );
  }
}
