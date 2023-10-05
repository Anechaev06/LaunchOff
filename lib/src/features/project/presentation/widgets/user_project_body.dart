import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../navigation/navigation.dart';
import '../../project.dart';

class UserProjectsBody extends StatelessWidget {
  final User? user;

  const UserProjectsBody(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (user == null) return _buildAuthenticationRequired(context);
        if (state is ProjectLoaded) return _buildProjectList(state);
        if (state is ProjectError) return _buildError(state);
        return const Center(child: CircularProgressIndicator());
      },
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
              onPressed: () =>
                  context.read<NavigationBloc>().add(NavigationEvent.profile))
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

  Widget _buildError(ProjectError state) => Center(child: Text(state.message));
}
