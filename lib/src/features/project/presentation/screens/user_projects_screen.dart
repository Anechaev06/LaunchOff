import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../project.dart';
import '../../../../core/core.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectBloc projectBloc = sl<ProjectBloc>();
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      projectBloc.add(FetchUserProjects(user.uid));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Your Projects")),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        bloc: projectBloc,
        builder: (context, state) {
          if (state is ProjectLoaded) {
            return _buildProjectList(state);
          } else if (state is ProjectError) {
            return _buildError(state);
          }
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (user == null) {
            _showAuthDialog(context);
          } else {
            Navigator.pushNamed(context, "/projectAdd");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProjectList(ProjectLoaded state) {
    return state.projects.isEmpty
        ? const Center(child: Text('No projects available.'))
        : ListView.builder(
            itemCount: state.projects.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(state.projects[index].name),
              subtitle: Text(state.projects[index].description),
            ),
          );
  }

  Widget _buildError(ProjectError state) {
    return Center(child: Text(state.message));
  }

  void _showAuthDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Authentication Required"),
        content: const Text("Sign in to create a project."),
        actions: [
          TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context)),
          TextButton(
              child: const Text("Sign In"),
              onPressed: () => Navigator.pushNamed(context, "/auth")),
        ],
      ),
    );
  }
}
