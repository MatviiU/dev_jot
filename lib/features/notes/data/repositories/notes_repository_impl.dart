import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_jot/features/notes/domain/exceptions/notes_exception.dart';
import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
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

  CollectionReference<Map<String, dynamic>> _getNotesCollection() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw UserNotFoundExceptionWithUid();
    }
    return _firestore.collection('users').doc(userId).collection('notes');
  }

  @override
  Future<void> addNote({
    required String title,
    required String content,
    required NoteType noteType,
    List<String> tags = const [],
    String? language,
    List<CheckListItem> checkListItems = const [],
  }) {
    final data = {
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
      'tags': tags,
      'noteType': noteType.name,
      'checkListItems': checkListItems.map((item) => item.toJson()).toList(),
    };
    if (noteType == NoteType.code && language != null) {
      data['language'] = language;
    }
    return _getNotesCollection().add(data);
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
    return _getNotesCollection()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            return snapshot.docs.map((doc) {
              final data = doc.data();
              return Note.fromJson(data).copyWith(id: doc.id);
            }).toList();
          } catch (e) {
            return [];
          }
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
