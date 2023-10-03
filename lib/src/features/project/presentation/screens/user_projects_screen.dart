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
          if (user == null) {
            return _buildAuthenticationRequired(context);
          } else if (state is ProjectLoaded) {
            return _buildProjectList(state);
          } else if (state is ProjectError) {
            return _buildError(state);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: user != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/projectAdd");
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildAuthenticationRequired(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Authentication Required"),
          const Text("Sign in to create a project."),
          TextButton(
            child: const Text("Sign In"),
            onPressed: () {
              Navigator.pushNamed(context, "/auth");
            },
          ),
        ],
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
}
