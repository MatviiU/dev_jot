import 'package:dev_jot/features/notes/domain/models/note.dart';

abstract interface class NotesRepository {
  Stream<List<Note>> getNotesStream();

  Future<void> addNote({
    required String title,
    required String content,
    List<String> tags = const [],
    bool isCode = false,
  });

  Future<void> updateNote(Note note);

  Future<void> deleteNote(String noteId);
}
