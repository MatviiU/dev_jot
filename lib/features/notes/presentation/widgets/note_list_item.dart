import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Dismissible(
      key: Key(note.id),
      onDismissed: (direction) =>
          context.read<NotesBloc>().add(DeleteNoteRequested(note.id)),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PhosphorIcon(PhosphorIcons.trash()),
            const Gap(width: 16),
            const Text('Delete'),
          ],
        ),
      ),
      child: InkWell(
        onTap: () => context.pushNamed(ScreenNames.addEditNote, extra: note),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appTheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: textTheme.titleLarge?.copyWith(
                  color: appTheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(height: 8),
              Text(
                note.content,
                style: textTheme.bodyMedium?.copyWith(
                  color: appTheme.onSurface,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
