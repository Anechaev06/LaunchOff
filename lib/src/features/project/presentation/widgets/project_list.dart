import 'package:flutter/material.dart';
import '../../project.dart';

class ProjectList extends StatelessWidget {
  final ProjectState state;
  final String? selectedCategory;

  const ProjectList({super.key, required this.state, this.selectedCategory});

  @override
  Widget build(BuildContext context) {
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
          return ProjectTile(project: project);
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
      {required List<String> messages}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: messages.map((m) => Text(m)).toList(),
      ),
    );
  }
}
