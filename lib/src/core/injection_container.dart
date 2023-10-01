import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/auth/auth.dart';
import '../features/navigation/bloc/navigation_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Register repository
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(sl.get<FirebaseAuth>(), sl.get<FirebaseFirestore>()));

  // Register BLoCs
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => NavigationBloc());
}
