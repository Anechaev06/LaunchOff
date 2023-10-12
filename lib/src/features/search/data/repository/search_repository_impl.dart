import 'package:cloud_firestore/cloud_firestore.dart';
import '../../search.dart';

class SearchRepositoryImpl implements SearchRepository {
  final FirebaseFirestore _firebaseFirestore;

  SearchRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<SearchEntity>> search(String query) async {
    throw Exception('Search');
  }
}
