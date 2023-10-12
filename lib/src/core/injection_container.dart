import 'package:firebase_core/firebase_core.dart';
import 'package:launchoff/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/auth/auth.dart';
import '../features/navigation/navigation.dart';
import '../features/project/project.dart';
import '../features/search/search.dart';

final sl = GetIt.instance;

Future<void> initializeFirebase() async => await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

void initializeDependencies() {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(sl.get<FirebaseAuth>(), sl.get<FirebaseFirestore>()));
  sl.registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(sl.get<FirebaseFirestore>()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(sl.get<FirebaseFirestore>()));

  // Blocs
  sl.registerFactory(() => NavigationBloc());
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => ProjectBloc(projectRepository: sl()));
  sl.registerFactory(() => SearchBloc(searchRepository: sl()));
}
