import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../project.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final FirebaseFirestore firestore;

  ProjectRepositoryImpl(this.firestore);

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    try {
      final snapshot = await firestore.collection('projects').get();
      return _mapSnapshotToProjects(snapshot);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProjectEntity>> getProjectsByCategory(String category) async {
    try {
      final snapshot = await firestore
          .collection('projects')
          .where('category', isEqualTo: category)
          .get();
      return _mapSnapshotToProjects(snapshot);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProjectEntity>> getUserProjects(String userId) async {
    try {
      final snapshot = await firestore
          .collection('projects')
          .where('userId', isEqualTo: userId)
          .get();
      return _mapSnapshotToProjects(snapshot);
    } catch (e) {
      rethrow; // rethrow to be caught by upper layers (BLoC)
    }
  }

  @override
  Future<void> createProject(ProjectEntity project) async {
    try {
      final projectData = {
        'name': project.name,
        'description': project.description,
        'problem': project.problem,
        'userId': project.userId,
        'images': project.images,
        'category': project.category,
      };
      await firestore.collection('projects').add(projectData);
    } catch (e) {
      rethrow;
    }
  }

  List<ProjectEntity> _mapSnapshotToProjects(QuerySnapshot snapshot) =>
      snapshot.docs.map((doc) => _mapDocToProject(doc)).toList();

  ProjectEntity _mapDocToProject(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final images = data['images'] ?? [];
    return ProjectEntity(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      problem: data['problem'] ?? '',
      userId: data['userId'] ?? '',
      images: images.cast<String>(),
      category: data['category'] ?? '',
    );
  }

  @override
  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    for (var image in images) {
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child('projects/${DateTime.now().toIso8601String()}')
          .putFile(image);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }
}
