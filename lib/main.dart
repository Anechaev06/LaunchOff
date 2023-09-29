import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:launchoff/src/app.dart';
import 'package:launchoff/src/core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependencies();
  runApp(const App());
}
