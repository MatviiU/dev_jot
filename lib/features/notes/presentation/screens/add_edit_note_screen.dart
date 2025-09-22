import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  @override
  void initState() {
    super.initState();
    final note = widget.note;
    if (note != null) {
      _titleController = TextEditingController(text: note.title);
      _contentController = TextEditingController(text: note.content);
    } else {
      _titleController = TextEditingController();
      _contentController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (widget.isEditing) {
      final updateNote = widget.note!.copyWith(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
      );
      context.read<NotesBloc>().add(UpdateNoteRequested(updateNote));
    } else {
      context.read<NotesBloc>().add(
        AddNoteRequested(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
        ),
      );
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final note = widget.note;
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
          note == null ? 'Add Note' : 'Edit Note',
          style: textTheme.titleLarge?.copyWith(color: appTheme.onBackground),
        ),
        actions: [
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
              const Gap(height: 16,),
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
            ],
          ),
        ),
      ),
    );
  }
}
