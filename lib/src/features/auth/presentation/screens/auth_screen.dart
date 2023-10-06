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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => _handleAuthState(state),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => _buildAuthForm(state),
      ),
    );
  }

  void _handleAuthState(AuthState state) {
    if (state is AuthenticationError) {
      _showErrorDialog(state.message);
    }
  }

  Widget _buildAuthForm(AuthState state) {
    if (state is Authenticated) return const ProfileScreen();

    return Scaffold(
      appBar: AppBar(
          title: Text(_authMode == AuthMode.signIn ? 'Sign In' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_authMode == AuthMode.signUp) ...[
              CustomTextField(controller: _nameController, labelText: 'Name'),
              CustomTextField(
                  controller: _userNameController, labelText: 'Username (@)'),
            ],
            CustomTextField(controller: _emailController, labelText: 'Email'),
            PasswordField(controller: _passwordController),
            ActionButtons(
              authMode: _authMode,
              toggleAuthMode: _toggleAuthMode,
              handleAuthAction: _handleAuthAction,
            ),
          ],
        ),
      ),
    );
  }

  void _handleAuthAction() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final userName = _userNameController.text.trim();

    if (_authMode == AuthMode.signIn) {
      BlocProvider.of<AuthBloc>(context).add(SignInEvent(email, password));
    } else {
      BlocProvider.of<AuthBloc>(context)
          .add(SignUpEvent(email, password, name, userName));
    }
  }

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
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }
}
