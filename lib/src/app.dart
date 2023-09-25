import 'package:flutter/material.dart';
import 'package:launchoff/src/core/core.dart';
import 'package:launchoff/src/navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const Navigation(),
    );
  }
}
