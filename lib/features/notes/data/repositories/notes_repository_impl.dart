import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_jot/features/notes/domain/exceptions/notes_exception.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/repositories/notes_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotesRepositoryImpl implements NotesRepository {
  NotesRepositoryImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
       _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Note> _getNotesCollection() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw UserNotFoundExceptionWithUid();
    }
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .withConverter<Note>(
          fromFirestore: (snapshot, _) =>
              Note.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (note, _) => note.toJson(),
        );
  }

  @override
  Future<void> addNote(Note note) {
    return _getNotesCollection().add(note);
  }

  @override
  Future<void> deleteNote(String noteId) {
    if (noteId.isEmpty) {
      throw NoteNotFoundForDeleteException();
    }
    return _getNotesCollection().doc(noteId).delete();
  }

  @override
  Stream<List<Note>> getNotesStream() {
    return _getNotesCollection().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Future<void> updateNote(Note note) {
    if (note.id.isEmpty) {
      throw NoteNotFoundForUpdateException();
    }
    return _getNotesCollection().doc(note.id).update(note.toJson());
  }
}
