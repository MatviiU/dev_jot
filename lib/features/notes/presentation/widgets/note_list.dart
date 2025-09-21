import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/presentation/widgets/note_list_item.dart';
import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {
  const NoteList({required this.notes, super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => NoteListItem(note: notes[index]),
      separatorBuilder: (context, index) => const Gap(height: 12),
      itemCount: notes.length,
    );
  }
}
