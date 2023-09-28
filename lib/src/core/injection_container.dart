import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/auth/auth.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Features - Auth
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory(() => AuthBloc(sl()));
}
