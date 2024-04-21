import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
import '../../project.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    final snapshot = await remoteDataSource.getCollectionSnapshot('projects');
    return snapshot.docs.map(ProjectModel.fromFirestore).toList();
  }

  @override
  Future<List<ProjectEntity>> getUserProjects(String userId) async {
    final snapshot = await remoteDataSource.getFilteredCollectionSnapshot(
      'projects',
      'userId',
      userId,
    );
    return snapshot.docs.map(ProjectModel.fromFirestore).toList();
  }

  @override
  Future<void> createProject(ProjectEntity project) async {
    final projectModel = ProjectModel.fromEntity(project);
    await remoteDataSource.addDocument('projects', projectModel.toFirestore());
  }

  @override
  Future<List<ProjectEntity>> getProjectsByCategory(String category) async {
    final snapshot = await remoteDataSource.getFilteredCollectionSnapshot(
      'projects',
      'category',
      category,
    );
    return snapshot.docs.map(ProjectModel.fromFirestore).toList();
  }

  @override
  Future<void> deleteProject(String projectId) async {
    await remoteDataSource.deleteDocument('projects', projectId);
  }

  @override
  Future<void> updateProject(ProjectEntity project) async {
    final projectModel = ProjectModel.fromEntity(project);
    await remoteDataSource.updateDocument(
      'projects',
      project.id,
      projectModel.toFirestore(),
    );
  }

  @override
  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    // for (var image in images) {
    //   var snapshot = await FirebaseStorage.instance
    //       .ref(
    //           'projects/${DateTime.now().toIso8601String()}_${image.path.split('/').last}')
    //       .putFile(image);

    //   var downloadUrl = await snapshot.ref.getDownloadURL();
    //   imageUrls.add(downloadUrl);
    // }
    return imageUrls;
  }
}
