import '../../auth.dart';

abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;
  final bool wasSignUpSuccessful;

  Authenticated(this.user, {this.wasSignUpSuccessful = false});
}

class AuthenticationError extends AuthState {
  final String message;

  AuthenticationError(this.message);
}
