import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NoteDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NoteDetailAppBar({required this.note, super.key});

  final Note note;

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
        note.title,
        style: textTheme.titleLarge?.copyWith(color: appTheme.onBackground),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              context.pushNamed(ScreenNames.addEditNote, extra: note),
          icon: PhosphorIcon(PhosphorIcons.pencil()),
        ),
        if (note.isCode)
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: note.content));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: appTheme.surface,
                  content: Text(
                    'Copied to clipboard',
                    style: textTheme.bodyMedium?.copyWith(
                      color: appTheme.onSurface,
                    ),
                  ),
                ),
              );
            },
            icon: PhosphorIcon(PhosphorIcons.copy()),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
