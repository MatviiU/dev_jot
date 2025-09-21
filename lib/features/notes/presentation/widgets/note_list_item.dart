import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:flutter/material.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
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
              style: textTheme.titleLarge?.copyWith(color: appTheme.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(height: 8),
            Text(
              note.content,
              style: textTheme.bodyMedium?.copyWith(color: appTheme.onSurface),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
