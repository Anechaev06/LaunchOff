abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}

class LoadUserEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String userName;

  SignUpEvent(this.email, this.password, this.name, this.userName);
}

class SignUpSuccessful extends AuthEvent {}
