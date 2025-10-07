import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:markdown/markdown.dart' as md;

class NoteContentView extends StatelessWidget {
  const NoteContentView({required this.note, super.key});

  final Note note;

  Syntax _stringToSyntax(String language) {
    return Syntax.values.firstWhere(
      (e) => e.name.toLowerCase() == language.toLowerCase(),
      orElse: () => Syntax.DART,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (note.isCode) {
      return SyntaxView(
        fontSize: 14,
        syntaxTheme: Theme.of(context).brightness == Brightness.dark
            ? SyntaxTheme.vscodeDark()
            : SyntaxTheme.vscodeLight(),
        code: note.content,
        syntax: _stringToSyntax(note.language),
        withLinesCount: true,
      );
    } else {
      final htmlContent = md.markdownToHtml(note.content);
      return HtmlWidget(htmlContent);
    }
  }
}
