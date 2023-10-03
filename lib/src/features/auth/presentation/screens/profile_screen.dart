import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(title: const Text("Profile")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Name: ${user.name}"),
                  Text("Username: ${user.userName}"),
                  Text("Email: ${user.email}"),
                  OutlinedButton(
                    onPressed: () =>
                        BlocProvider.of<AuthBloc>(context).add(SignOutEvent()),
                    child: const Text("Sign Out"),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text("Not Authenticated"));
      },
    );
  }
}
