import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../project.dart';
import '../../../../core/core.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectBloc = sl<ProjectBloc>();
    final user = sl<FirebaseAuth>().currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Your Projects")),
      body: BlocProvider(
        create: (_) => projectBloc..add(FetchUserProjects(user?.uid ?? '')),
        child: UserProjectsBody(user),
      ),
      floatingActionButton: _buildButton(user, context),
    );
  }

  FloatingActionButton? _buildButton(User? user, BuildContext context) {
    if (user == null) return null;
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, "/projectAdd"),
      child: const Icon(Icons.add),
    );
  }
}
