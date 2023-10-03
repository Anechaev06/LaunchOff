import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
    on<SignUpEvent>(_onSignUp);
    on<LoadUserEvent>(_onLoadUser);
    add(LoadUserEvent());
  }
  void _onSignIn(SignInEvent event, Emitter<AuthState> emit) => _handleAuth(
        () => authRepository.signIn(event.email, event.password),
        emit,
      );

  void _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) => _handleAuth(
        () => authRepository.signUp(
            event.email, event.password, event.name, event.userName),
        emit,
      );

  void _onLoadUser(LoadUserEvent event, Emitter<AuthState> emit) => _handleAuth(
        authRepository.getCurrentUser,
        emit,
      );

  void _handleAuth(
      Future<UserEntity?> Function() action, Emitter<AuthState> emit) async {
    try {
      final user = await action();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }
}
