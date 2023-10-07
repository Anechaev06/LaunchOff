import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../navigation/navigation.dart';
import '../../project.dart';

class UserProjectsScreen extends StatelessWidget {
  const UserProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      context.read<ProjectBloc>().add(FetchUserProjects(user.uid));
    }

    return Scaffold(
      body: _buildContent(context, user),
      floatingActionButton:
          user == null ? null : _buildFloatingActionButton(context),
    );
  }

  Widget _buildContent(BuildContext context, User? user) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (user == null) return _buildAuthenticationRequired(context);
        if (state is ProjectLoaded) return _buildProjectList(state, context);
        if (state is ProjectError) return _buildError(context, state.message);
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildAuthenticationRequired(BuildContext context) {
    return _centeredMessage(
      context,
      messages: [
        "Authentication Required",
        "Sign in to create a project.",
      ],
      action: TextButton(
        child: const Text("Sign In"),
        onPressed: () =>
            context.read<NavigationBloc>().add(NavigationEvent.profile),
      ),
    );
  }

  Widget _buildProjectList(ProjectLoaded state, BuildContext context) {
    if (state.projects.isEmpty) {
      return _centeredMessage(context, messages: ['No projects available.']);
    }
    return ListView.builder(
      itemCount: state.projects.length,
      itemBuilder: (context, index) {
        final project = state.projects[index];
        return ListTile(
          title: Text(project.name),
          subtitle: Text(project.description),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ProjectScreen(project: state.projects[index]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return _centeredMessage(
      context,
      messages: [message],
    );
  }

  Widget _centeredMessage(BuildContext context,
      {required List<String> messages, Widget? action}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...messages.map((m) => Text(m)).toList(),
          if (action != null) action,
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProjectAddScreen())),
      child: const Icon(Icons.add),
    );
  }
}
