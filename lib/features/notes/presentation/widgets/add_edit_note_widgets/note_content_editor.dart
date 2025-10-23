import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:markdown/markdown.dart' as md;

class NoteContentEditor extends StatelessWidget {
  const NoteContentEditor({
    required this.isPreviewing,
    required this.controller,
    required this.isCode,
    super.key,
    this.codeSyntax,
  });

  final bool isPreviewing;
  final TextEditingController controller;
  final bool isCode;
  final Syntax? codeSyntax;

  @override
  Widget build(BuildContext context) {
    if (isPreviewing) {
      if (isCode) {
        return SyntaxView(
          code: controller.text,
          syntax: codeSyntax ?? Syntax.DART,
          syntaxTheme: Theme.of(context).brightness == Brightness.dark
              ? SyntaxTheme.vscodeDark()
              : SyntaxTheme.vscodeLight(),
          withLinesCount: true,
          fontSize: 14,
        );
      }
      return SizedBox(
        width: double.infinity,
        child: HtmlWidget(md.markdownToHtml(controller.text)),
      );
    }

    final textStyle = isCode
        ? const TextStyle(fontFamily: 'monospace', fontSize: 16)
        : Theme.of(context).textTheme.bodyLarge;
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Write something...',
        border: InputBorder.none,
      ),
      style: textStyle,
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }
}
