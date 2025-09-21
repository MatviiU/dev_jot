import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_jot/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _signIn(BuildContext context) {
    context.read<AuthBloc>().add(
      SignInRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PhosphorIcon(
                      PhosphorIcons.code(PhosphorIconsStyle.regular),
                      size: 48,
                      color: appTheme.primary,
                    ),
                    const Gap(height: 60),
                    Text('Welcome Back', style: textTheme.displayLarge),
                    const Gap(height: 8),
                    Text(
                      'Log in to your account',
                      style: textTheme.titleMedium?.copyWith(
                        color: appTheme.hintText,
                      ),
                    ),
                    const Gap(height: 48),
                    CustomTextFormField(
                      hintText: 'Email',
                      controller: _emailController,
                      prefixIcon: PhosphorIcon(
                        PhosphorIcons.at(PhosphorIconsStyle.regular),
                        color: appTheme.hintText,
                      ),
                    ),
                    const Gap(height: 20),
                    CustomTextFormField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      prefixIcon: PhosphorIcon(
                        PhosphorIcons.lock(PhosphorIconsStyle.regular),
                        color: appTheme.hintText,
                      ),
                    ),
                    const Gap(height: 32),
                    ElevatedButton(
                      onPressed: isLoading ? null : () => _signIn(context),
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Log In'),
                    ),
                    const Gap(height: 24),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account?",
                              style: textTheme.bodyMedium?.copyWith(
                                color: appTheme.hintText,
                              ),
                            ),
                            TextSpan(
                              text: ' Sign Up',
                              style: textTheme.bodyMedium?.copyWith(
                                color: appTheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    context.pushNamed(ScreenNames.signUp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
