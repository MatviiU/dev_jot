import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: PhosphorIcon(
            PhosphorIcons.arrowLeft(),
            color: appTheme.onBackground,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(height: 24),
              Text(
                'Create Account',
                style: textTheme.displayLarge?.copyWith(
                  color: appTheme.onBackground,
                ),
              ),
              const Gap(height: 8),
              Text(
                'Start your journey with DevJot',
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
              const Gap(height: 20),
              CustomTextFormField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _confirmPasswordController,
                prefixIcon: PhosphorIcon(
                  PhosphorIcons.lockKey(PhosphorIconsStyle.regular),
                  color: appTheme.hintText,
                ),
              ),
              const Gap(height: 32),
              ElevatedButton(onPressed: () {}, child: const Text('Sign Up')),
              const Gap(height: 24),
              TextButton(
                onPressed: () {},
                child: RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium?.copyWith(
                      color: appTheme.hintText,
                    ),
                    children: [
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                          color: appTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.pop(),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
