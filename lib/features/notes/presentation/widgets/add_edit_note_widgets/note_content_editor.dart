import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class NoteContentEditor extends StatelessWidget {
  const NoteContentEditor({
    required this.controller,
    required this.isCode,
    super.key,
    this.codeSyntax,
  });

  final TextEditingController controller;
  final bool isCode;
  final Syntax? codeSyntax;

  @override
  Widget build(BuildContext context) {
    // if (isCode) {
    //   return SyntaxView(
    //     code: controller.text,
    //     syntax: codeSyntax ?? Syntax.DART,
    //     syntaxTheme: Theme.of(context).brightness == Brightness.dark
    //         ? SyntaxTheme.vscodeDark()
    //         : SyntaxTheme.vscodeLight(),
    //     withLinesCount: true,
    //     fontSize: 14,
    //   );
    // }

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
