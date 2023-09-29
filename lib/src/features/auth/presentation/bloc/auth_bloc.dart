import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
  }

  void _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.signIn(event.email, event.password);
      emit(Authenticated(user.id, user.email));
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }

  void _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }
}
