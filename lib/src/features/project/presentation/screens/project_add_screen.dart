import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../project.dart';
import '../../../../core/core.dart';

class ProjectAddScreen extends StatelessWidget {
  const ProjectAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectBloc projectBloc = sl<ProjectBloc>();
    final User? user = FirebaseAuth.instance.currentUser;
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Project")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description')),
            ElevatedButton(
              onPressed: () {
                if (user != null) {
                  final project = ProjectEntity(
                    id: '',
                    name: nameController.text,
                    description: descriptionController.text,
                    userId: user.uid,
                  );
                  projectBloc.add(CreateProject(project));
                }
                Navigator.pop(context);
              },
              child: const Text("Add Project"),
            ),
          ],
        ),
      ),
    );
  }
}
