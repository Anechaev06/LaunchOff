abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final String id;
  final String email;

  Authenticated(this.id, this.email);
}

class AuthenticationError extends AuthState {
  final String error;

  AuthenticationError(this.error);
}
