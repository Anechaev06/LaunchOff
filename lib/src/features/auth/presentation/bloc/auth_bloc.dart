import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(Unauthenticated()) {
    on<SignInEvent>(_onSignInEvent);
  }

  void _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      await authRepository.signIn(event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }
}
