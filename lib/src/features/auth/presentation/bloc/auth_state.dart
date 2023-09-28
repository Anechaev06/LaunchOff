abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final String userId;
  final String userEmail;

  Authenticated(this.userId, this.userEmail);
}

class AuthenticationError extends AuthState {
  final String error;

  AuthenticationError(this.error);
}
