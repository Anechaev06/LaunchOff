import 'package:launchoff/src/features/auth/auth.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, String password);
  Future<bool> isAuthenticated();
  Future<void> signOut();
}
