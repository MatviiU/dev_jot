import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/add_edit_note_app_bar.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/add_edit_note_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

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
  final _tags = <String>[];
  final _uuid = const Uuid();

  //var _isCode = false;
  var _isPreviewing = false;
  var _selectedLanguage = Syntax.DART;
  late NoteType _noteType;
  var _checkListItems = <CheckListItem>[];

  @override
  void initState() {
    super.initState();
    final note = widget.note;
    _titleController = TextEditingController(text: note?.title);
    _contentController = TextEditingController(text: note?.content);
    _tagController = TextEditingController();

    if (widget.isEditing && note != null) {
      _tags.addAll(note.tags);
      if (note.noteType == NoteType.code) {
        _selectedLanguage = _stringToSyntax(note.language!);
      }
      _noteType = note.noteType;
      _checkListItems = note.checkListItems
          .map((item) => item.copyWith())
          .toList();
    } else {
      _noteType = NoteType.text;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final language = _noteType == NoteType.code
        ? _selectedLanguage.name.toLowerCase()
        : null;

    if (widget.isEditing) {
      final updateNote = widget.note!.copyWith(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        tags: _tags,
        language: _selectedLanguage.name.toLowerCase(),
        noteType: _noteType,
        checkListItems: _checkListItems,
      );
      context.read<NotesBloc>().add(UpdateNoteRequested(updateNote));
    } else {
      context.read<NotesBloc>().add(
        AddNoteRequested(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          tags: _tags,
          language: language,
          noteType: _noteType,
          checkListItems: _checkListItems,
        ),
      );
    }
    context.pop();
  }

  void _addTag(String submittedTag) {
    final tag = submittedTag.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
      _tagController.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _togglePreview() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isPreviewing = !_isPreviewing;
    });
  }

  Syntax _stringToSyntax(String language) {
    return Syntax.values.firstWhere(
      (e) => e.name.toLowerCase() == language.toLowerCase(),
      orElse: () => Syntax.DART,
    );
  }

  void _onLanguageChanged(Syntax? newValue) {
    if (newValue != null) {
      setState(() => _selectedLanguage = newValue);
    }
  }

  void _onNoteTypeChanged(NoteType? newValue) {
    if (newValue != null) {
      setState(() {
        _noteType = newValue;
        _isPreviewing = false;
      });
    }
  }

  void _addCheckListItem() {
    setState(() {
      _checkListItems.add(
        CheckListItem(id: _uuid.v4(), text: '', isChecked: false),
      );
    });
  }

  void _removeChecklistItem(String id) {
    setState(() {
      _checkListItems.removeWhere((item) => item.id == id);
    });
  }

  void _updateChecklistItem(CheckListItem updatedItem) {
    setState(() {
      final index = _checkListItems.indexWhere(
        (item) => item.id == updatedItem.id,
      );
      if (index != -1) {
        _checkListItems[index] = updatedItem;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddEditNoteAppBar(
        isEditing: widget.isEditing,
        isPreviewing: _isPreviewing,
        onTogglePreview: _togglePreview,
        onSave: _saveNote,
      ),
      body: AddEditNoteForm(
        titleController: _titleController,
        contentController: _contentController,
        tagController: _tagController,
        isPreviewing: _isPreviewing,
        selectedLanguage: _selectedLanguage,
        tags: _tags,
        //onIsCodeChanged: _onIsCodeChanged,
        onLanguageChanged: _onLanguageChanged,
        onTagAdded: _addTag,
        onTagRemoved: _removeTag,
        onNoteTypeChanged: _onNoteTypeChanged,
        noteType: _noteType,
        checklistItems: _checkListItems,
        onAddItem: _addCheckListItem,
        onRemoveItem: _removeChecklistItem,
        onItemChanged: _updateChecklistItem,
      ),
    );
  }
}
