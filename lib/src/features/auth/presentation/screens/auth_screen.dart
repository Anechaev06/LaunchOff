import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth.dart';

enum AuthMode { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.signIn;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  void _toggleAuthMode() => setState(() => _authMode =
      _authMode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const ProfileScreen();
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_authMode == AuthMode.signUp)
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name')),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email')),
              TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      if (_authMode == AuthMode.signIn) {
                        BlocProvider.of<AuthBloc>(context)
                            .add(SignInEvent(email, password));
                      } else {
                        final name = nameController.text.trim();
                        BlocProvider.of<AuthBloc>(context)
                            .add(SignUpEvent(email, password, name));
                      }
                    },
                    child: Text(
                        _authMode == AuthMode.signIn ? 'Sign In' : 'Sign Up'),
                  ),
                  OutlinedButton(
                    onPressed: _toggleAuthMode,
                    child: Text(
                      _authMode == AuthMode.signIn ? 'Sign Up' : 'Sign In',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
