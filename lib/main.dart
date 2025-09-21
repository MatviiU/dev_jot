import 'package:dev_jot/core/di/get_it.dart' as di;
import 'package:dev_jot/core/navigation/app_router.dart';
import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  di.setupDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.getIt<AuthBloc>()),
        BlocProvider(create: (context) => di.getIt<NotesBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(authBloc: context.read<AuthBloc>());
    return MaterialApp.router(
      title: 'DevJot',
      routerConfig: appRouter.router,
      theme: darkTheme,
    );
  }
}
