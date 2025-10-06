import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({required this.note, super.key});

  final Note note;

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
          note.title,
          style: textTheme.titleLarge?.copyWith(color: appTheme.onBackground),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.pushNamed(ScreenNames.addEditNote, extra: note),
            icon: PhosphorIcon(PhosphorIcons.pencil()),
          ),
        ],
      ),
      body: note.isCode
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SyntaxView(
                  syntaxTheme: SyntaxTheme.vscodeDark(),
                  code: note.content,
                  syntax: Syntax.DART,
                  withLinesCount: true,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(note.content, style: textTheme.bodyLarge),
              ),
            ),
    );
  }
}
