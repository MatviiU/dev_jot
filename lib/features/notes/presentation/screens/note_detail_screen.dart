import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/widgets/note_detail_widgets/note_content_view.dart';
import 'package:dev_jot/features/notes/presentation/widgets/note_detail_widgets/note_detail_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        final currentNote = (state as NotesLoaded).notes.firstWhere(
          (n) => n.id == note.id,
          orElse: () => note,
        );
        return Scaffold(
          appBar: NoteDetailAppBar(note: currentNote),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: NoteContentView(note: currentNote),
            ),
          ),
        );
      },
    );
  }
}
