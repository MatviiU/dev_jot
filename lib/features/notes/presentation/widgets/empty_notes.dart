import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PhosphorIcon(
          PhosphorIcons.noteBlank(PhosphorIconsStyle.regular),
          size: 48,
          color: appTheme.hintText,
        ),
        Text(
          textAlign: TextAlign.center,
          "You don't have any notes yet. Create your first one!",
          style: textTheme.bodyLarge?.copyWith(color: appTheme.hintText),
        ),
      ],
    );
  }
}
