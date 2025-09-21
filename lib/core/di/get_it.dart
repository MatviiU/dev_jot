import 'package:dev_jot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_jot/features/auth/domain/repositories/auth_repository.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: getIt<FirebaseAuth>()),
    )
    ..registerFactory<AuthBloc>(
      () => AuthBloc(authRepository: getIt<AuthRepository>()),
    );
}
