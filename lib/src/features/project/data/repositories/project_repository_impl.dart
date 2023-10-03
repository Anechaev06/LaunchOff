import 'package:cloud_firestore/cloud_firestore.dart';
import '../../project.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final FirebaseFirestore firestore;

  ProjectRepositoryImpl(this.firestore);

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    final snapshot = await firestore.collection('projects').get();
    return _mapSnapshotToProjects(snapshot);
  }

  @override
  Future<List<ProjectEntity>> getUserProjects(String userId) async {
    final snapshot = await firestore
        .collection('projects')
        .where('userId', isEqualTo: userId)
        .get();
    return _mapSnapshotToProjects(snapshot);
  }

  @override
  Future<void> createProject(ProjectEntity project) async {
    final projectData = {
      'name': project.name,
      'description': project.description,
      'userId': project.userId,
    };
    await firestore.collection('projects').add(projectData);
  }

  List<ProjectEntity> _mapSnapshotToProjects(QuerySnapshot snapshot) =>
      snapshot.docs
          .map((doc) => ProjectEntity(
                id: doc.id,
                name: doc['name'],
                description: doc['description'],
                userId: doc['userId'],
              ))
          .toList();
}
