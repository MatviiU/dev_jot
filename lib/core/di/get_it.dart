import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_jot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_jot/features/auth/domain/repositories/auth_repository.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_jot/features/notes/data/repositories/notes_repository_impl.dart';
import 'package:dev_jot/features/notes/domain/repositories/notes_repository.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/cubits/add_edit_note_cubit/add_edit_note_cubit.dart';
import 'package:dev_jot/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:dev_jot/features/settings/domain/repositories/settings_repository.dart';
import 'package:dev_jot/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:dev_jot/features/tip_of_the_day/data/datasource/tip_api_service.dart';
import 'package:dev_jot/features/tip_of_the_day/data/repository/tip_repository_impl.dart';
import 'package:dev_jot/features/tip_of_the_day/domain/repositories/tip_repository.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/cubit/tip_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    )
    ..registerLazySingleton<Dio>(
      () => Dio(BaseOptions(contentType: 'application/json')),
    )
    ..registerLazySingleton<TipApiService>(() => TipApiService(getIt<Dio>()))
    ..registerLazySingleton<TipRepository>(
      () => TipRepositoryImpl(tipApiService: getIt<TipApiService>()),
    )
    ..registerFactory<TipCubit>(
      () => TipCubit(tipRepository: getIt<TipRepository>()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () =>
          SettingsRepositoryImpl(sharedPreferences: getIt<SharedPreferences>()),
    )
    ..registerLazySingleton<ThemeCubit>(
      () => ThemeCubit(settingsRepository: getIt<SettingsRepository>()),
    )
    ..registerFactory<AddEditNoteCubit>(AddEditNoteCubit.new);
}
