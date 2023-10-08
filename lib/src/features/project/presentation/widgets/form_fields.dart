import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class FormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController problemController;
  final TextEditingController categoryController;

  const FormFields({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.problemController,
    required this.categoryController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
          validator: (value) => value!.isEmpty ? 'Name is required' : null,
        ),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
          validator: (value) =>
              value!.isEmpty ? 'Description is required' : null,
        ),
        TextFormField(
          controller: problemController,
          decoration: const InputDecoration(labelText: 'Problem'),
          validator: (value) => value!.isEmpty ? 'Problem is required' : null,
        ),
        DropdownButtonFormField<String>(
          value:
              categoryController.text.isEmpty ? null : categoryController.text,
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
          validator: (value) => value!.isEmpty ? 'Category is required' : null,
        ),
      ],
    );
  }
}
