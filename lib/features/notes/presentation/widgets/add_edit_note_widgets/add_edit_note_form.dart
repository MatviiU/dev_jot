import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/checklist_editor.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/code_settings.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/note_content_editor.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/note_title_field.dart';
import 'package:dev_jot/features/notes/presentation/widgets/add_edit_note_widgets/tag_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddEditNoteForm extends StatelessWidget {
  const AddEditNoteForm({
    required this.titleController,
    required this.contentController,
    required this.tagController,
    required this.isPreviewing,
    //required this.isCode,
    required this.selectedLanguage,
    required this.tags,
    //required this.onIsCodeChanged,
    required this.onLanguageChanged,
    required this.onTagAdded,
    required this.onTagRemoved,
    required this.onNoteTypeChanged,
    required this.noteType,
    required this.checklistItems,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onItemChanged,
    super.key,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final TextEditingController tagController;
  final bool isPreviewing;

  //final bool isCode;
  final Syntax selectedLanguage;
  final List<String> tags;

  //final ValueChanged<bool> onIsCodeChanged;
  final ValueChanged<Syntax?> onLanguageChanged;
  final ValueChanged<String> onTagAdded;
  final ValueChanged<String> onTagRemoved;
  final ValueChanged<NoteType?> onNoteTypeChanged;
  final NoteType noteType;
  final List<CheckListItem> checklistItems;
  final VoidCallback onAddItem;
  final ValueChanged<String> onRemoveItem;
  final ValueChanged<CheckListItem> onItemChanged;

  Widget _buildEditor() {
    return switch (noteType) {
      NoteType.text => NoteContentEditor(
        isPreviewing: isPreviewing,
        controller: contentController,
        codeSyntax: selectedLanguage,
        isCode: false,
      ),
      NoteType.code => Column(
        children: [
          CodeSettings(
            selectedLanguage: selectedLanguage,
            //onIsCodeChanged: onIsCodeChanged,
            onSelectedLanguageChanged: onLanguageChanged,
          ),
          const Gap(height: 16),
          NoteContentEditor(
            isPreviewing: isPreviewing,
            controller: contentController,
            codeSyntax: selectedLanguage,
            isCode: true,
          ),
        ],
      ),
      NoteType.checkList => ChecklistEditor(
        items: checklistItems,
        onAddItem: onAddItem,
        onRemoveItem: onRemoveItem,
        onItemChanged: onItemChanged,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoteTitleField(controller: titleController),
            const Gap(height: 24),
            SegmentedButton<NoteType>(
              segments: <ButtonSegment<NoteType>>[
                ButtonSegment<NoteType>(
                  value: NoteType.text,
                  label: const Text('Text'),
                  icon: PhosphorIcon(PhosphorIcons.textT()),
                ),
                ButtonSegment<NoteType>(
                  value: NoteType.code,
                  label: const Text('Code'),
                  icon: PhosphorIcon(PhosphorIcons.code()),
                ),
                ButtonSegment<NoteType>(
                  value: NoteType.checkList,
                  label: const Text('Check List'),
                  icon: PhosphorIcon(PhosphorIcons.listChecks()),
                ),
              ],
              selected: {noteType},
              onSelectionChanged: (Set<NoteType> newSelection) =>
                  onNoteTypeChanged(newSelection.first),
              multiSelectionEnabled: false,
            ),
            const Gap(height: 16),
            _buildEditor(),
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
