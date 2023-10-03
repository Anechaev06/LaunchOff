import '../../auth.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signUp(
      String email, String password, String name, String userName);
}
