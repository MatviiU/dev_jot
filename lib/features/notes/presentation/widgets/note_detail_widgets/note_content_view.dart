import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:dev_jot/features/notes/domain/models/note.dart';
import 'package:dev_jot/features/notes/domain/models/note_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:markdown/markdown.dart' as md;

class NoteContentView extends StatelessWidget {
  const NoteContentView({
    required this.note,
    required this.onItemChanged,
    super.key,
  });

  final Note note;
  final ValueChanged<CheckListItem> onItemChanged;

  Syntax _stringToSyntax(String? language) {
    if (language == null) {
      return Syntax.DART;
    }
    return Syntax.values.firstWhere(
      (e) => e.name.toLowerCase() == language.toLowerCase(),
      orElse: () => Syntax.DART,
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (note.noteType) {
      NoteType.text => HtmlWidget(md.markdownToHtml(note.content)),
      NoteType.code => SyntaxView(
        fontSize: 14,
        syntaxTheme: Theme.of(context).brightness == Brightness.dark
            ? SyntaxTheme.vscodeDark()
            : SyntaxTheme.vscodeLight(),
        code: note.content,
        syntax: _stringToSyntax(note.language),
        withLinesCount: true,
      ),
      NoteType.checkList => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = note.checkListItems[index];
          return CheckboxListTile(
            value: item.isChecked,
            onChanged: (isChecked) {
              onItemChanged(item.copyWith(isChecked: isChecked));
            },
            title: Text(
              item.text,
              style: TextStyle(
                decoration: item.isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(height: 12);
        },
        itemCount: note.checkListItems.length,
      ),
    };
  }
}
