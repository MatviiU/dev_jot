part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

final class LoadNotes extends NotesEvent {}

final class NotesUpdated extends NotesEvent {
  const NotesUpdated(this.notes);

  final List<Note> notes;

  @override
  List<Object?> get props => [notes];
}

final class AddNoteRequested extends NotesEvent {
  const AddNoteRequested({
    required this.title,
    required this.content,
    this.tags = const [],
  });

  final String title;
  final String content;
  final List<String> tags;

  @override
  List<Object?> get props => [title, content, tags];
}

final class UpdateNoteRequested extends NotesEvent {
  const UpdateNoteRequested(this.note);

  final Note note;

  @override
  List<Object?> get props => [note];
}

final class DeleteNoteRequested extends NotesEvent {
  const DeleteNoteRequested(this.noteId);

  final String noteId;

  @override
  List<Object?> get props => [noteId];
}

final class NotesFailureEvent extends NotesEvent {
  const NotesFailureEvent(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
