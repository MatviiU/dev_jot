import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        final currentNote = (state as NotesLoaded).notes.firstWhere(
          (n) => n.id == note.id,
          orElse: () => note,
        );
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
              currentNote.title,
              style: textTheme.titleLarge?.copyWith(
                color: appTheme.onBackground,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () =>
                    context.pushNamed(ScreenNames.addEditNote, extra: note),
                icon: PhosphorIcon(PhosphorIcons.pencil()),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildNoteContent(currentNote, Theme.of(context)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoteContent(Note currentNote, ThemeData theme) {
    if (currentNote.isCode) {
      return SyntaxView(
        fontSize: 14,
        syntaxTheme: theme.brightness == Brightness.dark
            ? SyntaxTheme.vscodeDark()
            : SyntaxTheme.vscodeLight(),
        code: currentNote.content,
        syntax: Syntax.DART,
        withLinesCount: true,
        expanded: true,
      );
    } else {
      final htmlContent = md.markdownToHtml(currentNote.content);
      return HtmlWidget(htmlContent);
    }
  }
}
