import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhosphorIcon(
            PhosphorIcons.exclamationMark(),
            size: 48,
            color: appTheme.hintText,
          ),
          Text(
            'Something went wrong!',
            style: textTheme.bodyLarge?.copyWith(color: appTheme.hintText),
          ),
        ],
      ),
    );
  }
}
