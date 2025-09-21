import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/app/widgets/splash_screen.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_jot/features/auth/presentation/screens/login_screen.dart';
import 'package:dev_jot/features/auth/presentation/screens/signup_screen.dart';
import 'package:dev_jot/features/notes/presentation/screens/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required this.authBloc});

  final AuthBloc authBloc;

  late final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: ScreenNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: ScreenNames.signIn,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        name: ScreenNames.signUp,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/notes',
        name: ScreenNames.notes,
        builder: (context, state) => const NotesScreen(),
      ),
    ],
    redirect: (context, state) {
      final authState = authBloc.state;
      final currentLocation = state.uri.toString();

      final isAuthRoute = ['/login', '/sign-up'].contains(currentLocation);

      if (authState is AuthUnknown) {
        return '/splash';
      }
      if (authState is Authenticated) {
        if (isAuthRoute || currentLocation == '/splash') {
          return '/notes';
        }
      }
      if (authState is Unauthenticated) {
        if (!isAuthRoute) {
          return '/login';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    stream.asBroadcastStream().listen((_) => notifyListeners());
  }
}
