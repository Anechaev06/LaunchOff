import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../project.dart';

class EditProjectScreen extends StatefulWidget {
  final ProjectEntity project;

  const EditProjectScreen({super.key, required this.project});

  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  void _updateProject() {
    final updatedProject = ProjectEntity(
      id: widget.project.id,
      name: nameController.text,
      description: descriptionController.text,
      problem: problemController.text,
      userId: widget.project.userId,
      images: widget.project.images,
      category: categoryController.text,
    );
    BlocProvider.of<ProjectBloc>(context).add(UpdateProject(updatedProject));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Project'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _updateProject,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: problemController,
              decoration: const InputDecoration(labelText: 'Problem'),
            ),
            DropdownButtonFormField<String>(
              value: categoryController.text.isEmpty
                  ? null
                  : categoryController.text,
              items: categories
                  .where((String value) => value != 'All')
                  .map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                },
              ).toList(),
              onChanged: (newValue) {
                categoryController.text = newValue!;
              },
              decoration: const InputDecoration(labelText: 'Category'),
              validator: (value) =>
                  value!.isEmpty ? 'Category is required' : null,
            ),
          ],
        ),
      ),
    );
  }
}
