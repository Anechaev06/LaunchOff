import 'package:cloud_firestore/cloud_firestore.dart';
import '../../project.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required String id,
    required String name,
    required String description,
    required String problem,
    required String userId,
    required List<String> images,
    required String category,
  }) : super(
          id: id,
          name: name,
          description: description,
          problem: problem,
          userId: userId,
          images: images,
          category: category,
        );

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProjectModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      problem: data['problem'] ?? '',
      userId: data['userId'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'problem': problem,
      'userId': userId,
      'images': images,
      'category': category,
    };
  }
}
