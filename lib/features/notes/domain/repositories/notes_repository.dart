import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';

abstract interface class NotesRepository {
  Stream<List<Note>> getNotesStream();

  Future<void> addNote({
    required String title,
    required String content,
    required NoteType noteType,
    List<String> tags = const [],
    bool isCode = false,
    String language = 'dart',
    List<CheckListItem> checkListItems = const [],
  });

  Future<void> updateNote(Note note);

  Future<void> deleteNote(String noteId);
}
