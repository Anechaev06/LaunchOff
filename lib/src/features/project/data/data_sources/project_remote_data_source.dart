import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectRemoteDataSource {
  final FirebaseFirestore firestore;

  ProjectRemoteDataSource(this.firestore);

  Future<QuerySnapshot> getCollectionSnapshot(String collectionPath) {
    return firestore.collection(collectionPath).get();
  }

  Future<QuerySnapshot> getFilteredCollectionSnapshot(
    String collectionPath,
    String field,
    dynamic isEqualTo,
  ) {
    return firestore
        .collection(collectionPath)
        .where(field, isEqualTo: isEqualTo)
        .get();
  }

  Future<void> addDocument(String collectionPath, Map<String, dynamic> data) {
    return firestore.collection(collectionPath).add(data);
  }

  Future<void> deleteDocument(String collectionPath, String docId) {
    return firestore.collection(collectionPath).doc(docId).delete();
  }

  Future<void> updateDocument(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  ) {
    return firestore.collection(collectionPath).doc(docId).update(data);
  }
}
