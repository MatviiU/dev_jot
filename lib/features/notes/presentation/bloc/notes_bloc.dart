import 'dart:async';

import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
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
    on<NotesFailureEvent>(_onNotesFailure);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<TagSelected>(_onTagSelected);
  }

  final NotesRepository _notesRepository;
  StreamSubscription<List<Note>>? _notesSubscription;

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    await _notesSubscription?.cancel();
    _notesSubscription = _notesRepository.getNotesStream().listen(
      (notes) => add(NotesUpdated(notes: notes)),
      onError: (Object error) {
        add(NotesFailureEvent(error.toString()));
      },
    );
  }

  void _onNotesUpdated(NotesUpdated event, Emitter<NotesState> emit) {
    final currentQuery = state is NotesLoaded
        ? (state as NotesLoaded).searchQuery
        : '';
    final currentTag = state is NotesLoaded
        ? (state as NotesLoaded).selectedTag
        : null;
    final filteredNotes = _filterNotes(
      notes: event.notes,
      query: currentQuery,
      tag: currentTag,
    );
    emit(
      NotesLoaded(
        notes: event.notes,
        filteredNotes: filteredNotes,
        searchQuery: currentQuery,
        selectedTag: currentTag,
      ),
    );
  }

  Future<void> _onAddNoteRequested(
    AddNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await _notesRepository.addNote(
        title: event.title,
        content: event.content,
        tags: event.tags,
        language: event.language ?? '',
        noteType: event.noteType,
        checkListItems: event.checkListItems,
      );
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }

  Future<void> _onUpdateNoteRequested(
    UpdateNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await _notesRepository.updateNote(event.note);
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }

  Future<void> _onTagSelected(
    TagSelected event,
    Emitter<NotesState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      final filteredNotes = _filterNotes(
        notes: currentState.notes,
        query: currentState.searchQuery,
        tag: event.tag,
      );
      emit(
        currentState.copyWith(
          selectedTag: event.tag,
          filteredNotes: filteredNotes,
          clearSelectedTag: event.tag == null,
        ),
      );
    }
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<NotesState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      final filteredNotes = _filterNotes(
        notes: currentState.notes,
        query: event.query,
        tag: currentState.selectedTag,
      );
      emit(
        currentState.copyWith(
          searchQuery: event.query,
          filteredNotes: filteredNotes,
        ),
      );
    }
  }

  Future<void> _onDeleteNoteRequested(
    DeleteNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await _notesRepository.deleteNote(event.noteId);
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }

  void _onNotesFailure(NotesFailureEvent event, Emitter<NotesState> emit) {
    emit(NotesFailure(event.error));
  }

  List<Note> _filterNotes({
    required List<Note> notes,
    required String query,
    String? tag,
  }) {
    var filteredNotes = List<Note>.from(notes);
    if (tag != null) {
      filteredNotes = filteredNotes
          .where((note) => note.tags.contains(tag))
          .toList();
    }

    if (query.isNotEmpty) {
      final lowerCaseQuery = query.toLowerCase();
      filteredNotes = filteredNotes.where((note) {
        final titleMatch = note.title.toLowerCase().contains(lowerCaseQuery);
        final contentMatch = note.content.toLowerCase().contains(
          lowerCaseQuery,
        );
        final tagsMatch = note.tags.any(
          (tag) => tag.toLowerCase().contains(lowerCaseQuery),
        );
        final checklistMatch = note.checkListItems.any(
          (item) => item.text.toLowerCase().contains(lowerCaseQuery),
        );
        return titleMatch || contentMatch || tagsMatch || checklistMatch;
      }).toList();
    }
    return filteredNotes;
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
