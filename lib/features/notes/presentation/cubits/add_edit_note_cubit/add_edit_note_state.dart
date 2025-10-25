import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class AddEditNoteState extends Equatable {
  const AddEditNoteState({
    this.title = '',
    this.content = '',
    this.tags = const [],
    this.checkListItems = const [],
    this.noteType = NoteType.text,
    this.selectedLanguage = Syntax.DART,
    this.isEditing = false,
    this.initialNote,
  });

  final String title;
  final String content;
  final List<String> tags;
  final List<CheckListItem> checkListItems;
  final NoteType noteType;
  final Syntax selectedLanguage;
  final bool isEditing;
  final Note? initialNote;

  AddEditNoteState copyWith({
    String? title,
    String? content,
    List<String>? tags,
    List<CheckListItem>? checkListItems,
    NoteType? noteType,
    Syntax? selectedLanguage,
    bool? isEditing,
    Note? initialNote,
  }) {
    return AddEditNoteState(
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      checkListItems: checkListItems ?? this.checkListItems,
      noteType: noteType ?? this.noteType,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isEditing: isEditing ?? this.isEditing,
      initialNote: initialNote ?? this.initialNote,
    );
  }

  @override
  List<Object?> get props => [
    title,
    content,
    tags,
    checkListItems,
    noteType,
    selectedLanguage,
    isEditing,
    initialNote,
  ];
}
