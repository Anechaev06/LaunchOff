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
  Future<List<ProjectEntity>> getUserProjects() async {
    final snapshot = await firestore
        .collection('projects')
        .where('userId', isEqualTo: 'some_user_id')
        .get();
    return _mapSnapshotToProjects(snapshot);
  }

  List<ProjectEntity> _mapSnapshotToProjects(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => ProjectEntity(
              id: doc.id,
              name: doc['name'],
              description: doc['description'],
            ))
        .toList();
  }

  @override
  Future<void> createProject(ProjectEntity project) async {
    await firestore.collection('projects').add({
      'name': project.name,
      'description': project.description,
    });
  }
}
