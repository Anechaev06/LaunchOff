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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  void _toggleAuthMode() => setState(() => _authMode =
      _authMode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn);

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An error occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          _showErrorDialog(state.message);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
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
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                if (_authMode == AuthMode.signUp)
                  TextField(
                    controller: userNameController,
                    decoration:
                        const InputDecoration(labelText: 'Username (@)'),
                  ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        final name = nameController.text.trim();
                        final userName = userNameController.text.trim();
                        if (_authMode == AuthMode.signIn) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignInEvent(email, password));
                        } else {
                          BlocProvider.of<AuthBloc>(context).add(
                              SignUpEvent(email, password, name, userName));
                        }
                      },
                      child: Text(
                          _authMode == AuthMode.signIn ? 'Sign In' : 'Sign Up'),
                    ),
                    OutlinedButton(
                      onPressed: _toggleAuthMode,
                      child: Text(
                          _authMode == AuthMode.signIn ? 'Sign Up' : 'Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
