import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/code_settings.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/note_content_editor.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/note_title_field.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/tag_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class AddEditNoteForm extends StatelessWidget {
  const AddEditNoteForm({
    required this.titleController,
    required this.contentController,
    required this.tagController,
    required this.isPreviewing,
    required this.isCode,
    required this.selectedLanguage,
    required this.tags,
    required this.onIsCodeChanged,
    required this.onLanguageChanged,
    required this.onTagAdded,
    required this.onTagRemoved,
    super.key,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final TextEditingController tagController;
  final bool isPreviewing;
  final bool isCode;
  final Syntax selectedLanguage;
  final List<String> tags;
  final ValueChanged<bool> onIsCodeChanged;
  final ValueChanged<Syntax?> onLanguageChanged;
  final ValueChanged<String> onTagAdded;
  final ValueChanged<String> onTagRemoved;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoteTitleField(controller: titleController),
            const Gap(height: 16),
            NoteContentEditor(
              isPreviewing: isPreviewing,
              controller: contentController,
            ),
            const Gap(height: 16),
            CodeSettings(
              isCode: isCode,
              selectedLanguage: selectedLanguage,
              onIsCodeChanged: onIsCodeChanged,
              onSelectedLanguageChanged: onLanguageChanged,
            ),
            const Divider(height: 32),
            TagManager(
              tags: tags,
              controller: tagController,
              onTagAdded: onTagAdded,
              onTagRemoved: onTagRemoved,
            ),
          ],
        ),
      ),
    );
  }
}
