import 'package:firebase_auth/firebase_auth.dart';
import '../../auth.dart';

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
}
