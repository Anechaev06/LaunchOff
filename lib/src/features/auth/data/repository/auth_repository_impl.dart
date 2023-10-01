import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepositoryImpl(this.firebaseAuth, this.firebaseFirestore);

  Future<UserEntity> _getUserEntity(User? user) async {
    final uid = user!.uid;
    final doc = await firebaseFirestore.collection('users').doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    return UserEntity(
      id: uid,
      email: user.email!,
      userName: data['userName'] ?? '',
      name: data['name'] ?? '',
    );
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _getUserEntity(userCredential.user);
  }

  @override
  Future<UserEntity> signUp(
      String email, String password, String name, String userName) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await firebaseFirestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'userName': userName,
      'name': name,
    });
    return _getUserEntity(userCredential.user);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _getUserEntity(firebaseAuth.currentUser);
  }

  @override
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
