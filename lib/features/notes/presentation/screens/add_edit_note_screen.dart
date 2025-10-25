import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/cubits/add_edit_note_cubit/add_edit_note_cubit.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/add_edit_note_app_bar.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/add_edit_note_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({super.key, this.note});

  final Note? note;

  bool get isEditing => note != null;

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final TextEditingController _tagController;

  @override
  void initState() {
    super.initState();
    context.read<AddEditNoteCubit>().initialize(widget.note);

    final initialState = context.read<AddEditNoteCubit>().state;
    _titleController = TextEditingController(text: initialState.title);
    _contentController = TextEditingController(text: initialState.content);
    _tagController = TextEditingController();

    _titleController.addListener(() {
      context.read<AddEditNoteCubit>().titleChanged(_titleController.text);
    });
    _contentController.addListener(() {
      context.read<AddEditNoteCubit>().contentChanged(_contentController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final state = context.read<AddEditNoteCubit>().state;
    final language = state.noteType == NoteType.code
        ? state.selectedLanguage.name.toLowerCase()
        : null;
    if (widget.isEditing) {
      final updateNote = state.initialNote!.copyWith(
        title: state.title.trim(),
        content: state.content.trim(),
        tags: state.tags,
        language: language,
        noteType: state.noteType,
        checkListItems: state.checkListItems,
      );
      context.read<NotesBloc>().add(UpdateNoteRequested(updateNote));
    } else {
      context.read<NotesBloc>().add(
        AddNoteRequested(
          title: state.title.trim(),
          content: state.content.trim(),
          tags: state.tags,
          language: language,
          noteType: state.noteType,
          checkListItems: state.checkListItems,
        ),
      );
    }
    context.pop();
  }

  void _addTag(String submittedTag) {
    context.read<AddEditNoteCubit>().addTag(submittedTag);
    _tagController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddEditNoteCubit>().state;
    return Scaffold(
      appBar: AddEditNoteAppBar(isEditing: widget.isEditing, onSave: _saveNote),
      body: AddEditNoteForm(
        titleController: _titleController,
        contentController: _contentController,
        tagController: _tagController,
        selectedLanguage: state.selectedLanguage,
        tags: state.tags,
        onLanguageChanged: (language) =>
            context.read<AddEditNoteCubit>().languageChanged(language!),
        onTagAdded: _addTag,
        onTagRemoved: (tag) => context.read<AddEditNoteCubit>().removeTag(tag),
        onNoteTypeChanged: (noteType) =>
            context.read<AddEditNoteCubit>().noteTypeChanged(noteType!),
        noteType: state.noteType,
        checklistItems: state.checkListItems,
        onAddItem: context.read<AddEditNoteCubit>().addCheckListItem,
        onRemoveItem: context.read<AddEditNoteCubit>().removeCheckListItem,
        onItemChanged: context.read<AddEditNoteCubit>().updateChecklistItem,
      ),
    );
  }
}
