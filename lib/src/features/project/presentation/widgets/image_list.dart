import 'package:flutter/material.dart';
import 'dart:io';

class ImageList extends StatelessWidget {
  final List<File> pickedImages;

  const ImageList({super.key, required this.pickedImages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pickedImages.length,
      itemBuilder: (context, index) {
        return Image.file(pickedImages[index]);
      },
    );
  }
}
