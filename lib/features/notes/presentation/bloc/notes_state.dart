part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  const NotesLoaded({
    this.notes = const [],
    this.filteredNotes = const [],
    this.searchQuery = '',
    this.selectedTag,
  });

  final List<Note> notes;
  final List<Note> filteredNotes;
  final String searchQuery;
  final String? selectedTag;

  NotesLoaded copyWith({
    List<Note>? notes,
    List<Note>? filteredNotes,
    String? searchQuery,
    String? selectedTag,
    bool clearSelectedTag = false,
  }) {
    return NotesLoaded(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTag: clearSelectedTag ? null : selectedTag ?? this.selectedTag,
    );
  }

  @override
  List<Object?> get props => [notes, searchQuery, filteredNotes, selectedTag];
}

final class NotesFailure extends NotesState {
  const NotesFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
