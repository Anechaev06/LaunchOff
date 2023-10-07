import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ProjectAddScreen extends StatefulWidget {
  const ProjectAddScreen({super.key});

  @override
  State<ProjectAddScreen> createState() => _ProjectAddScreenState();
}

class _ProjectAddScreenState extends State<ProjectAddScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _problemController = TextEditingController();
  String? _selectedCategory;
  final _imagesUrls = <String>[];
  final _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _problemController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final Reference ref = FirebaseStorage.instance
            .ref()
            .child('projects')
            .child('${DateTime.now().toIso8601String()}.jpg');
        final TaskSnapshot uploadTask =
            await ref.putFile(File(pickedFile.path));

        if (uploadTask.state == TaskState.success) {
          final String downloadUrl = await uploadTask.ref.getDownloadURL();
          setState(() => _imagesUrls.add(downloadUrl));
        } else {
          _showErrorSnackbar('Error uploading image. Please try again later.');
        }
      }
    } catch (error) {
      _showErrorSnackbar('Error uploading image: $error');
    }
  }

  Future<void> _addProject() async {
    if (!_validateFields()) {
      _showErrorSnackbar(
          'Please complete all fields and upload at least one image.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('projects').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'problem': _problemController.text,
        'category': _selectedCategory,
        'images': _imagesUrls,
      });
      Navigator.of(context).pop();
    } catch (error) {
      _showErrorSnackbar('Error adding project. Please try again later.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _validateFields() {
    return _nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _problemController.text.isNotEmpty &&
        _selectedCategory != null &&
        _imagesUrls.isNotEmpty;
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: controller.text.isEmpty ? 'This field is required' : null,
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField(
      value: _selectedCategory,
      hint: const Text('Select Category'),
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      items: ['IT', 'Biology', 'Physics', 'Chemistry']
          .map<DropdownMenuItem<String>>(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
    );
  }

  Widget _buildImagesListView() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imagesUrls.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageUrl: _imagesUrls[index],
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Project")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  _buildTextField(_nameController, 'Name'),
                  _buildTextField(_descriptionController, 'Description'),
                  _buildTextField(_problemController, 'Problem'),
                  _buildCategoryDropdown(),
                  ElevatedButton(
                    onPressed: _pickAndUploadImage,
                    child: const Text("Add Image"),
                  ),
                  _buildImagesListView(),
                  ElevatedButton(
                    onPressed: _addProject,
                    child: const Text("Add Project"),
                  ),
                ],
              ),
            ),
    );
  }
}
