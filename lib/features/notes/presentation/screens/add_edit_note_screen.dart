import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/add_edit_note_app_bar.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/add_edit_note_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
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
  final _tags = <String>[];
  var _isCode = false;
  var _isPreviewing = false;
  var _selectedLanguage = Syntax.DART;

  @override
  void initState() {
    super.initState();
    final note = widget.note;
    _titleController = TextEditingController(text: note?.title);
    _contentController = TextEditingController(text: note?.content);
    _tagController = TextEditingController();

    if (widget.isEditing) {
      _tags.addAll(note!.tags);
      _isCode = note.isCode;
      _selectedLanguage = _stringToSyntax(note.language);
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
    if (widget.isEditing) {
      final updateNote = widget.note!.copyWith(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        tags: _tags,
        isCode: _isCode,
        language: _selectedLanguage.name.toLowerCase(),
      );
      context.read<NotesBloc>().add(UpdateNoteRequested(updateNote));
    } else {
      context.read<NotesBloc>().add(
        AddNoteRequested(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          tags: _tags,
          isCode: _isCode,
          language: _selectedLanguage.name.toLowerCase(),
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

  void _onIsCodeChanged(bool newValue) {
    setState(() => _isCode = newValue);
  }

  void _onLanguageChanged(Syntax? newValue) {
    if (newValue != null) {
      setState(() => _selectedLanguage = newValue);
    }
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
        isCode: _isCode,
        selectedLanguage: _selectedLanguage,
        tags: _tags,
        onIsCodeChanged: _onIsCodeChanged,
        onLanguageChanged: _onLanguageChanged,
        onTagAdded: _addTag,
        onTagRemoved: _removeTag,
      ),
    );
  }
}
