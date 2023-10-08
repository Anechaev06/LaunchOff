import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../navigation/navigation.dart';
import '../../project.dart';

class ProjectList extends StatelessWidget {
  final ProjectState state;
  final String? selectedCategory;
  final bool isAuthenticated;
  final bool deletable;

  const ProjectList({
    super.key,
    required this.state,
    this.selectedCategory,
    required this.isAuthenticated,
    required this.deletable,
  });

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      return _centeredMessage(
        context,
        messages: ["Authentication Required"],
        action: TextButton(
          onPressed: () =>
              context.read<NavigationBloc>().add(NavigationEvent.profile),
          child: const Text("Sign In"),
        ),
      );
    }

    if (state is ProjectLoaded) {
      final projects = (selectedCategory == null || selectedCategory == 'All')
          ? (state as ProjectLoaded).projects
          : (state as ProjectLoaded)
              .projects
              .where((p) => p.category == selectedCategory)
              .toList();

      if (projects.isEmpty) {
        return _centeredMessage(context, messages: ['No projects available.']);
      }

      return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return deletable
              ? SlidableProjectTile(project: project)
              : ProjectTile(project: project);
        },
      );
    }

    if (state is ProjectError) {
      return _centeredMessage(context,
          messages: [(state as ProjectError).message]);
    }

    return const Center(child: CircularProgressIndicator());
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
}
