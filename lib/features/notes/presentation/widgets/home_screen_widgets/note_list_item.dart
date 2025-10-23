import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({required this.note, super.key});

  final Note note;

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: appTheme.surface,
          title: Text(
            'Confirm Deletion',
            style: textTheme.titleLarge?.copyWith(color: appTheme.onSurface),
          ),
          content: Text(
            'Are you sure you want to delete this note?',
            style: textTheme.bodyMedium?.copyWith(color: appTheme.hintText),
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () => context.pop(false),
                  child: Text(
                    'Cancel',
                    style: textTheme.labelLarge?.copyWith(
                      color: appTheme.onSurface,
                    ),
                  ),
                ),
                const Gap(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTheme.error,
                    foregroundColor: appTheme.onError,
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    context.read<NotesBloc>().add(DeleteNoteRequested(note.id));
                    context.pop(true);
                  },
                  child: Text(
                    'Delete',
                    style: textTheme.labelLarge?.copyWith(
                      color: appTheme.background,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildNoteIcon(AppColorsExtension appTheme) {
    return switch (note.noteType) {
      NoteType.code => PhosphorIcon(
        PhosphorIcons.code(),
        color: appTheme.onSurface,
      ),
      NoteType.checkList => PhosphorIcon(
        PhosphorIcons.listChecks(),
        color: appTheme.onSurface,
      ),
      NoteType.text => const SizedBox.shrink(),
    };
  }

  Widget _buildNoteContentPreview(
    BuildContext context,
    AppColorsExtension appTheme,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return switch (note.noteType) {
      NoteType.text || NoteType.code => Text(
        note.content,
        style: textTheme.bodyMedium?.copyWith(color: appTheme.onSurface),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      NoteType.checkList => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: note.checkListItems.take(3).map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                PhosphorIcon(
                  item.isChecked
                      ? PhosphorIcons.checkSquare(PhosphorIconsStyle.fill)
                      : PhosphorIcons.square(PhosphorIconsStyle.light),
                  color: appTheme.hintText,
                  size: 18,
                ),
                const Gap(width: 8),
                Expanded(
                  child: Text(
                    item.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: appTheme.onSurface,
                      decoration: item.isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: appTheme.hintText,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Dismissible(
      key: Key(note.id),
      confirmDismiss: (direction) => _showConfirmationDialog(context),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: appTheme.error!,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PhosphorIcon(
                PhosphorIcons.trash(PhosphorIconsStyle.bold),
                color: appTheme.onError,
              ),
              const Gap(width: 16),
              Text(
                'Delete',
                style: textTheme.labelLarge?.copyWith(color: appTheme.onError),
              ),
            ],
          ),
        ),
      ),
      child: InkWell(
        onTap: () => context.pushNamed(ScreenNames.noteDetails, extra: note),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appTheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNoteIcon(appTheme),
                  if (note.noteType != NoteType.text) const Gap(width: 8),
                  Text(
                    note.title,
                    style: textTheme.titleLarge?.copyWith(
                      color: appTheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Gap(height: 8),
              _buildNoteContentPreview(context, appTheme),
              if (note.content.isNotEmpty || note.checkListItems.isNotEmpty)
                const Gap(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: note.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    backgroundColor: appTheme.primary?.withValues(alpha: 0.1),
                    labelStyle: textTheme.labelMedium?.copyWith(
                      color: appTheme.primary,
                    ),
                    side: BorderSide.none,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
