import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/auth/presentation/screens/login_screen.dart';
import 'package:dev_jot/features/auth/presentation/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: ScreenNames.signIn,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      name: ScreenNames.signUp,
      builder: (context, state) => const SignupScreen(),
    ),
  ],
);
