import 'package:flutter/material.dart';
import '../../auth.dart';

class ActionButtons extends StatelessWidget {
  final AuthMode authMode;
  final VoidCallback toggleAuthMode;
  final VoidCallback handleAuthAction;

  const ActionButtons({
    super.key,
    required this.authMode,
    required this.toggleAuthMode,
    required this.handleAuthAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: handleAuthAction,
          child: Text(authMode == AuthMode.signIn ? 'Sign In' : 'Sign Up'),
        ),
        TextButton(
          onPressed: toggleAuthMode,
          child: Text(authMode == AuthMode.signIn ? 'Sign Up' : 'Sign In'),
        ),
      ],
    );
  }
}
