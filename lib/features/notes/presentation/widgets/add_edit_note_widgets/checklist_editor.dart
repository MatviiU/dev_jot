import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/domain/models/checklist_item.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChecklistEditor extends StatefulWidget {
  const ChecklistEditor({
    required this.items,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onItemChanged,
    super.key,
  });

  final List<CheckListItem> items;
  final VoidCallback onAddItem;
  final ValueChanged<String> onRemoveItem;
  final ValueChanged<CheckListItem> onItemChanged;

  @override
  State<ChecklistEditor> createState() => _ChecklistEditorState();
}

class _ChecklistEditorState extends State<ChecklistEditor> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();

    for (final item in widget.items) {
      _controllers[item.id] = TextEditingController(text: item.text);
    }
  }

  @override
  void didUpdateWidget(covariant ChecklistEditor oldWidget) {
    super.didUpdateWidget(oldWidget);

    for (final item in widget.items) {
      if (!_controllers.containsKey(item.id)) {
        _controllers[item.id] = TextEditingController(text: item.text);
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: widget.items.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(height: 12);
          },
          itemBuilder: (context, state) {
            final item = widget.items[state];
            final controller = _controllers[item.id]!;

            return Row(
              children: [
                Checkbox(
                  value: item.isChecked,
                  onChanged: (isChecked) {
                    widget.onItemChanged(item.copyWith(isChecked: isChecked));
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'New item...',
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      widget.onItemChanged(item.copyWith(text: text));
                    },
                  ),
                ),
                IconButton(
                  onPressed: () => widget.onRemoveItem(item.id),
                  icon: PhosphorIcon(PhosphorIcons.x()),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: widget.onAddItem,
          label: const Text('Add item'),
          icon: PhosphorIcon(PhosphorIcons.plus()),
        ),
      ],
    );
  }
}
