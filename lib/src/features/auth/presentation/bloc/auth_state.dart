import '../../auth.dart';

abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;
  Authenticated(this.user);
}

class AuthenticationError extends AuthState {
  final String error;
  AuthenticationError(this.error);
}
