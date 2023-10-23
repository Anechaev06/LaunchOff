import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/auth.dart';
import '../../../project/project.dart';
import '../../search.dart';

class SearchRepositoryImpl implements SearchRepository {
  final FirebaseFirestore _firebaseFirestore;

  SearchRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<SearchEntity>> search(String query) async {
    final userResults = await _searchUsers(query);
    final projectResults = await _searchProjects(query);

    return [
      ...userResults.map((user) => SearchEntity(user: user, project: null)),
      ...projectResults
          .map((project) => SearchEntity(user: null, project: project)),
    ];
  }

  Future<List<UserEntity>> _searchUsers(String query) async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: query)
        .where('userName', isLessThan: '${query}z')
        .get();

    return snapshot.docs.map((doc) => _mapToUserEntity(doc)).toList();
  }

  Future<List<ProjectEntity>> _searchProjects(String query) async {
    final snapshot = await _firebaseFirestore
        .collection('projects')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: '${query}z')
        .get();

    return snapshot.docs.map((doc) => _mapToProjectEntity(doc)).toList();
  }

  UserEntity _mapToUserEntity(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserEntity(
      id: doc.id,
      email: data['email'],
      userName: data['userName'],
      name: data['name'],
    );
  }

  ProjectEntity _mapToProjectEntity(DocumentSnapshot doc) {
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
}
