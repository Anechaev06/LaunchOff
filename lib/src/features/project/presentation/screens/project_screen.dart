import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../project.dart';

class ProjectScreen extends StatelessWidget {
  final ProjectEntity project;

  const ProjectScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${project.name}'),
            const SizedBox(height: 16),
            Text('Description: ${project.description}'),
            const SizedBox(height: 16),
            const Text('Images:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: project.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(imageUrl: project.images[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
