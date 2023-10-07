import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/core.dart';
import '../../project.dart';

class ProjectAddScreen extends StatefulWidget {
  const ProjectAddScreen({super.key});

  @override
  State<ProjectAddScreen> createState() => _ProjectAddScreenState();
}

class _ProjectAddScreenState extends State<ProjectAddScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final picker = ImagePicker();
  List<File> pickedImages = [];
  String? selectedCategory;

  Future<void> pickImages() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImages.add(File(pickedFile.path));
      });
    }
  }

  Widget buildImagesList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pickedImages.length,
      itemBuilder: (context, index) {
        return Image.file(pickedImages[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProjectBloc projectBloc = sl<ProjectBloc>();
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            DropdownButton<String>(
              value: selectedCategory,
              items: <String>['Tech', 'Health', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: pickImages,
              child: const Text('Pick Images'),
            ),
            SizedBox(
              height: 100,
              child: buildImagesList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final imageUrls = await projectBloc.uploadImages(pickedImages);
                final project = ProjectEntity(
                  id: '',
                  name: nameController.text,
                  description: descriptionController.text,
                  problem: problemController.text,
                  userId: user!.uid,
                  images: imageUrls,
                  category: selectedCategory!,
                );
                projectBloc.add(CreateProject(project));
                Navigator.of(context).pop();
              },
              child: const Text('Create Project'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    problemController.dispose();
    super.dispose();
  }
}
