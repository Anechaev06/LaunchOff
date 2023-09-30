import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
    on<LoadUserEvent>(_loadUser);
    on<SignUpEvent>(_signUp);
    add(LoadUserEvent());
  }

  void _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.signIn(event.email, event.password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }

  void _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  void _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      UserEntity user =
          await authRepository.signUp(event.email, event.password, event.name);

      emit(Authenticated(user));
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }

  void _loadUser(LoadUserEvent event, Emitter<AuthState> emit) async {
    final user = await authRepository.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }
}
