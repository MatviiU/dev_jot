import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:markdown/markdown.dart' as md;

class NoteContentEditor extends StatelessWidget {
  const NoteContentEditor({
    required this.isPreviewing,
    required this.controller,
    super.key,
  });

  final bool isPreviewing;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    if (isPreviewing) {
      SizedBox(
        width: double.infinity,
        child: HtmlWidget(md.markdownToHtml(controller.text)),
      );
    }
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Write something...',
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }
}
