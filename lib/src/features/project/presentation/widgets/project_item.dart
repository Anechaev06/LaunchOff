import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final Map<String, dynamic> projectData;

  const ProjectItem({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(projectData['name'] ?? 'Unnamed project'),
      subtitle: Text(projectData['description'] ?? 'No description'),
      onTap: () {
        // Navigate to Project Details Screen or any other appropriate action
      },
    );
  }
}
