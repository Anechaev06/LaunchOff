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
  final userNameController = TextEditingController();

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
              _buildTextField(nameController, 'Name'),
              _buildTextField(userNameController, 'Username (@)')
            ],
            _buildTextField(emailController, 'Email'),
            _buildPasswordField(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _handleAuthAction(),
          child: Text(_authMode == AuthMode.signIn ? 'Sign In' : 'Sign Up'),
        ),
        TextButton(
          onPressed: _toggleAuthMode,
          child: Text(_authMode == AuthMode.signIn ? 'Sign Up' : 'Sign In'),
        ),
      ],
    );
  }

  void _handleAuthAction() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    final userName = userNameController.text.trim();

    if (_authMode == AuthMode.signIn) {
      BlocProvider.of<AuthBloc>(context).add(SignInEvent(email, password));
    } else {
      BlocProvider.of<AuthBloc>(context)
          .add(SignUpEvent(email, password, name, userName));
    }
  }

  void _toggleAuthMode() {
    setState(() => _authMode =
        _authMode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn);
  }

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
