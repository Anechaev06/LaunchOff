import 'package:flutter/material.dart';
import '../../project.dart';

class ProjectListTile extends StatelessWidget {
  final ProjectEntity project;

  const ProjectListTile({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(project.name),
      subtitle: Text(project.description),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProjectScreen(project: project)),
      ),
    );
  }
}
