import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepositoryImpl(this._firebaseAuth, this._firebaseFirestore);

  // Error handling
  String _getErrorMessage(FirebaseAuthException e) {
    const errorMessages = {
      'email-already-in-use': 'Email already in use.',
      'invalid-email': 'Invalid email.',
      'wrong-password': 'Incorrect password.',
    };
    return errorMessages[e.code] ?? 'An unknown error occurred.';
  }

  // User details
  Future<void> _saveUserDetails(
      String uid, String name, String userName) async {
    await _getUserDocRef(uid).set({'userName': userName, 'name': name});
  }

  DocumentReference _getUserDocRef(String uid) =>
      _firebaseFirestore.collection('users').doc(uid);

  // User entity mapping
  UserEntity _mapToUserEntity(User user, DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserEntity(
      id: user.uid,
      email: user.email!,
      userName: data['userName'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Future<UserEntity> _getUserEntity(User? user) async {
    if (user == null) {
      throw AuthException('User is null.');
    }
    final uid = user.uid;
    final doc = await _getUserDocRef(uid).get();
    return _mapToUserEntity(user, doc);
  }

  Future<bool> _isUsernameTaken(String userName) async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  // Public Auth methods
  @override
  Future<UserEntity> signIn(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _getUserEntity(userCredential.user);
    } catch (e) {
      throw AuthException(_getErrorMessage(e as FirebaseAuthException));
    }
  }

  @override
  Future<UserEntity> signUp(
      String email, String password, String name, String userName) async {
    if (await _isUsernameTaken(userName)) {
      throw AuthException('Username already taken.');
    }

    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = userCredential.user!.uid;

      await _saveUserDetails(uid, name, userName);
      return _getUserEntity(userCredential.user);
    } catch (e) {
      throw AuthException(_getErrorMessage(e as FirebaseAuthException));
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async =>
      _getUserEntity(_firebaseAuth.currentUser);

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
