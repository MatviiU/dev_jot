part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

final class LoadNotes extends NotesEvent {}

final class NotesUpdated extends NotesEvent {
  const NotesUpdated({required this.notes});

  final List<Note> notes;

  @override
  List<Object?> get props => [notes];
}

final class AddNoteRequested extends NotesEvent {
  const AddNoteRequested({
    required this.title,
    required this.content,
    this.tags = const [],
    this.isCode = false,
  });

  final String title;
  final String content;
  final List<String> tags;
  final bool isCode;

  @override
  List<Object?> get props => [title, content, tags, isCode];
}

final class UpdateNoteRequested extends NotesEvent {
  const UpdateNoteRequested(this.note);

  final Note note;

  @override
  List<Object?> get props => [note];
}

final class TagSelected extends NotesEvent {
  const TagSelected(this.tag);

  final String? tag;

  @override
  List<Object?> get props => [tag];
}

final class SearchQueryChanged extends NotesEvent {
  const SearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
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
