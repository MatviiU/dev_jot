part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  const NotesLoaded(this.notes);

  final List<Note> notes;

  @override
  List<Object?> get props => [notes];
}

final class NotesFailure extends NotesState {
  const NotesFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
