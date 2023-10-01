import 'package:firebase_auth/firebase_auth.dart';
import 'package:launchoff/src/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<UserEntity> signIn(String email, String password) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserEntity(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
  }

  @override
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

  Future<bool> isAuthenticated() async {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    User? currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      return UserEntity(
          id: currentUser.uid,
          email: currentUser.email!,
          name: currentUser.displayName ?? '');
    }
    return null;
  }

  @override
  Future<UserEntity> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? newUser = userCredential.user;

      await newUser!.updateDisplayName(name);
      await newUser.reload();
      newUser = firebaseAuth.currentUser;

      return UserEntity(
        id: newUser!.uid,
        email: newUser.email!,
        name: newUser.displayName!,
      );
    } catch (e) {
      rethrow;
    }
  }
}
