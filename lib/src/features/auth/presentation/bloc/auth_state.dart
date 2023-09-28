abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {}

class AuthenticationError extends AuthState {
  final String message;

  AuthenticationError(this.message);
}
