import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hintText,
    this.obscureText = false,
    super.key,
    this.prefixIcon,
    this.controller,
    this.validator,
  });

  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: appTheme.onBackground),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: prefixIcon,
              )
            : null,
      ),
    );
  }
}
