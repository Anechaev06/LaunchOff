import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/auth.dart';

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

  Future<bool> _isUsernameTaken(String userName) async {
    final snapshot = await firebaseFirestore
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _getUserEntity(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    }
  }

  @override
  Future<UserEntity> signUp(
      String email, String password, String name, String userName) async {
    if (await _isUsernameTaken(userName)) {
      throw AuthException('The username is already taken.');
    }
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      await firebaseFirestore.collection('users').doc(uid).set(
        {
          'userName': userName,
          'name': name,
        },
      );

      return _getUserEntity(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _getUserEntity(firebaseAuth.currentUser);
  }

  @override
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'wrong-password':
        return 'The password is not correct.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
