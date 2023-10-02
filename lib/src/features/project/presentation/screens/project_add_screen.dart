import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../project.dart';

class ProjectAddScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  ProjectAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectBloc = BlocProvider.of<ProjectBloc>(context);
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
                projectBloc.add(CreateProject(ProjectEntity(
                  id: '',
                  name: nameController.text,
                  description: descriptionController.text,
                )));
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
