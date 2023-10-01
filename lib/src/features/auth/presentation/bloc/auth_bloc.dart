import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    _initEventHandlers();
    add(LoadUserEvent());
  }

  void _initEventHandlers() {
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
    on<SignUpEvent>(_signUp);
    on<LoadUserEvent>(_loadUser);
  }

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

  void _signIn(SignInEvent event, Emitter<AuthState> emit) => _handleAuth(
        () => authRepository.signIn(event.email, event.password),
        emit,
      );

  void _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  void _signUp(SignUpEvent event, Emitter<AuthState> emit) => _handleAuth(
        () => authRepository.signUp(event.email, event.password, event.name),
        emit,
      );

  void _loadUser(LoadUserEvent event, Emitter<AuthState> emit) => _handleAuth(
        authRepository.getCurrentUser,
        emit,
      );
}
