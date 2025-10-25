import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:dev_jot/features/notes/presentation/cubits/add_edit_note_cubit/add_edit_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:uuid/uuid.dart';

class AddEditNoteCubit extends Cubit<AddEditNoteState> {
  AddEditNoteCubit() : super(const AddEditNoteState());

  final _uuid = const Uuid();

  void initialize(Note? note) {
    if (note != null) {
      emit(
        state.copyWith(
          initialNote: note,
          isEditing: true,
          title: note.title,
          content: note.content,
          tags: note.tags,
          checkListItems: note.checkListItems
              .map((item) => item.copyWith())
              .toList(),
          noteType: note.noteType,
          selectedLanguage: _stringToSyntax(note.language ?? 'dart'),
        ),
      );
    } else {
      emit(const AddEditNoteState());
    }
  }

  void titleChanged(String title) => emit(state.copyWith(title: title));

  void contentChanged(String content) => emit(state.copyWith(content: content));

  void addTag(String submittedTag) {
    final tag = submittedTag.trim();
    if (tag.isNotEmpty && !state.tags.contains(tag)) {
      emit(state.copyWith(tags: [...state.tags, tag]));
    }
  }

  void removeTag(String tag) {
    emit(state.copyWith(tags: state.tags.where((t) => t != tag).toList()));
  }

  void noteTypeChanged(NoteType newType) {
    emit(state.copyWith(noteType: newType));
  }

  void languageChanged(Syntax language) {
    emit(state.copyWith(selectedLanguage: language));
  }

  void addCheckListItem() {
    final newCheckListItem = CheckListItem(
      id: _uuid.v4(),
      text: '',
      isChecked: false,
    );
    emit(
      state.copyWith(
        checkListItems: [...state.checkListItems, newCheckListItem],
      ),
    );
  }

  void updateChecklistItem(CheckListItem updatedItem) {
    final index = state.checkListItems.indexWhere(
      (item) => item.id == updatedItem.id,
    );
    if (index != -1) {
      final updatedList = [...state.checkListItems];
      updatedList[index] = updatedItem;
      emit(state.copyWith(checkListItems: updatedList));
    }
  }

  void removeCheckListItem(String id) {
    emit(
      state.copyWith(
        checkListItems: state.checkListItems
            .where((item) => item.id != id)
            .toList(),
      ),
    );
  }

  Syntax _stringToSyntax(String language) {
    return Syntax.values.firstWhere(
      (e) => e.name.toLowerCase() == language.toLowerCase(),
      orElse: () => Syntax.DART,
    );
  }
}
