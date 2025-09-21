import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_jot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_jot/features/auth/domain/repositories/auth_repository.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_jot/features/notes/data/repositories/notes_repository_impl.dart';
import 'package:dev_jot/features/notes/domain/repositories/notes_repository.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: getIt<FirebaseAuth>()),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(authRepository: getIt<AuthRepository>()),
    )
    ..registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(
        firestore: getIt<FirebaseFirestore>(),
        auth: getIt<FirebaseAuth>(),
      ),
    )
    ..registerFactory<NotesBloc>(
      () => NotesBloc(notesRepository: getIt<NotesRepository>()),
    );
}
