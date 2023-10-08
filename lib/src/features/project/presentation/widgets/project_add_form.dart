import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../project.dart';

class ProjectAddForm extends StatefulWidget {
  const ProjectAddForm({super.key});

  @override
  State<ProjectAddForm> createState() => _ProjectAddFormState();
}

class _ProjectAddFormState extends State<ProjectAddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final picker = ImagePicker();
  List<File> pickedImages = [];

  Future<void> pickImages() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImages.add(File(pickedFile.path));
      });
    }
  }

  void _createProject(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final projectBloc = BlocProvider.of<ProjectBloc>(context);
      final User? user = FirebaseAuth.instance.currentUser;
      final imageUrls = await projectBloc.uploadImages(pickedImages);
      final project = ProjectEntity(
        id: '',
        name: nameController.text,
        description: descriptionController.text,
        problem: problemController.text,
        userId: user!.uid,
        images: imageUrls,
        category: categoryController.text,
      );
      projectBloc.add(CreateProject(project));
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              FormFields(
                nameController: nameController,
                descriptionController: descriptionController,
                problemController: problemController,
                categoryController: categoryController,
              ),
              ElevatedButton(
                onPressed: pickImages,
                child: const Text('Pick Images'),
              ),
              SizedBox(
                height: 100,
                child: ImageList(pickedImages: pickedImages),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _createProject(context),
                child: const Text('Create Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
