import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddEditNoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddEditNoteAppBar({
    required this.isEditing,
    required this.onSave,
    super.key,
  });

  final bool isEditing;

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: appTheme.background,
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: PhosphorIcon(
          PhosphorIcons.arrowLeft(),
          color: appTheme.onBackground,
        ),
      ),
      title: Text(
        isEditing ? 'Add Note' : 'Edit Note',
        style: textTheme.titleLarge?.copyWith(color: appTheme.onBackground),
      ),
      actions: [
        TextButton(
          onPressed: onSave,
          child: Text(
            'Save',
            style: textTheme.labelLarge?.copyWith(color: appTheme.primary),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
