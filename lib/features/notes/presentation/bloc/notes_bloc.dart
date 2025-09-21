import 'dart:async';

import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/repositories/notes_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_state.dart';

part 'notes_event.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({required NotesRepository notesRepository})
    : _notesRepository = notesRepository,
      super(NotesInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<NotesUpdated>(_onNotesUpdated);
    on<AddNoteRequested>(_onAddNoteRequested);
    on<UpdateNoteRequested>(_onUpdateNoteRequested);
    on<DeleteNoteRequested>(_onDeleteNoteRequested);
  }

  final NotesRepository _notesRepository;
  StreamSubscription<List<Note>>? _notesSubscription;

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    await _notesSubscription?.cancel();
    _notesSubscription = _notesRepository.getNotesStream().listen(
      (notes) => add(NotesUpdated(notes)),
      onError: (Object error) => emit(NotesFailure(error.toString())),
    );
  }

  void _onNotesUpdated(NotesUpdated event, Emitter<NotesState> emit) {
    emit(NotesLoaded(event.notes));
  }

  Future<void> _onAddNoteRequested(
    AddNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      await _notesRepository.addNote(event.note);
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }

  Future<void> _onUpdateNoteRequested(
    UpdateNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      await _notesRepository.updateNote(event.note);
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }

  Future<void> _onDeleteNoteRequested(
    DeleteNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      await _notesRepository.deleteNote(event.noteId);
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
