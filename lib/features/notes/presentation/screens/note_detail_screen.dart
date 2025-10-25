import 'package:dev_jot/features/app/widgets/failure_screen.dart';
import 'package:dev_jot/features/app/widgets/splash_screen.dart';
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
        return switch (state) {
          NotesInitial() || NotesLoading() => const SplashScreen(),
          NotesLoaded(notes: final notes) => _buildNoteLoadedState(
            context,
            notes,
          ),
          NotesFailure() => const FailureScreen(),
        };
      },
    );
  }

  Widget _buildNoteLoadedState(BuildContext context, List<Note> notes) {
    final currentNote = notes.firstWhere(
      (n) => n.id == note.id,
      orElse: () => note,
    );
    return Scaffold(
      appBar: NoteDetailAppBar(note: currentNote),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NoteContentView(
            note: currentNote,
            onItemChanged: (updatedItem) {
              final index = currentNote.checkListItems.indexWhere(
                (item) => item.id == updatedItem.id,
              );
              if (index == -1) return;
              final newItems = [...currentNote.checkListItems];
              newItems[index] = updatedItem;
              final updatedNote = currentNote.copyWith(
                checkListItems: newItems,
              );
              context.read<NotesBloc>().add(UpdateNoteRequested(updatedNote));
            },
          ),
        ),
      ),
    );
  }
}
