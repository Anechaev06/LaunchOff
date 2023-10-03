import 'package:flutter/material.dart';
import 'package:launchoff/src/app.dart';
import 'package:launchoff/src/core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  initializeDependencies();
  runApp(const App());
}
