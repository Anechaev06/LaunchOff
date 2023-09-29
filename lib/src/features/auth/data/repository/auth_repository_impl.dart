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

  @override
  Future<bool> isAuthenticated() async {
    return firebaseAuth.currentUser != null;
  }
}
