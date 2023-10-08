import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CategoryPopupMenu extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryPopupMenu({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: selectedCategory,
      onSelected: onCategorySelected,
      itemBuilder: (BuildContext context) {
        return categories.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      },
    );
  }
}
