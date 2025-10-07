import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: PhosphorIcon(
            PhosphorIcons.arrowLeft(),
            color: appTheme.onBackground,
          ),
        ),
        title: Text(
          widget.isEditing ? 'Add Note' : 'Edit Note',
          style: textTheme.titleLarge?.copyWith(color: appTheme.onBackground),
        ),
        actions: [
          IconButton(
            onPressed: _togglePreview,
            icon: PhosphorIcon(
              _isPreviewing
                  ? PhosphorIcons.eyeSlash(PhosphorIconsStyle.regular)
                  : PhosphorIcons.eye(PhosphorIconsStyle.regular),
              color: appTheme.onBackground,
            ),
          ),
          TextButton(
            onPressed: _saveNote,
            child: Text(
              'Save',
              style: textTheme.labelLarge?.copyWith(color: appTheme.primary),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                style: textTheme.headlineMedium,
                maxLines: 1,
              ),
              const Gap(height: 16),
              if (_isPreviewing)
                SizedBox(
                  width: double.infinity,
                  child: HtmlWidget(md.markdownToHtml(_contentController.text)),
                ),
              if (!_isPreviewing)
                TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: 'Write something...',
                    border: InputBorder.none,
                  ),
                  style: textTheme.bodyLarge,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              const Gap(height: 16),
              SwitchListTile(
                title: Text('Code snipped', style: textTheme.bodyLarge),
                activeThumbColor: appTheme.primary,
                secondary: PhosphorIcon(
                  PhosphorIcons.code(PhosphorIconsStyle.regular),
                  color: appTheme.onSurface,
                ),
                value: _isCode,
                onChanged: (newValue) {
                  setState(() {
                    _isCode = newValue;
                  });
                },
              ),
              if (_isCode) ...[
                const Gap(height: 16),
                DropdownButtonFormField<Syntax>(
                  initialValue: _selectedLanguage,
                  items: Syntax.values.map((Syntax syntax) {
                    return DropdownMenuItem<Syntax>(
                      value: syntax,
                      child: Text(syntax.name),
                    );
                  }).toList(),
                  onChanged: (Syntax? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Language',
                    prefixIcon: PhosphorIcon(
                      PhosphorIcons.translate(PhosphorIconsStyle.regular),
                      color: appTheme.hintText,
                    ),
                  ),
                ),
              ],
              const Divider(height: 32),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    labelStyle: textTheme.bodySmall?.copyWith(
                      color: appTheme.primary,
                    ),
                    backgroundColor: appTheme.primary?.withValues(alpha: 0.2),
                    onDeleted: () => _removeTag(tag),
                    deleteIconColor: appTheme.primary,
                    side: BorderSide.none,
                  );
                }).toList(),
              ),
              const Gap(height: 16),
              TextFormField(
                controller: _tagController,
                onFieldSubmitted: _addTag,
                decoration: InputDecoration(
                  hintText: 'Add tag...',
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: PhosphorIcon(
                      PhosphorIcons.tag(PhosphorIconsStyle.regular),
                      color: appTheme.hintText,
                    ),
                  ),
                ),
                style: textTheme.bodyMedium,
                maxLines: 1,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
