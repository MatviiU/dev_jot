import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TagManager extends StatelessWidget {
  const TagManager({
    required this.tags,
    required this.controller,
    required this.onTagAdded,
    required this.onTagRemoved,
    super.key,
  });

  final List<String> tags;
  final TextEditingController controller;
  final ValueChanged<String> onTagAdded;
  final ValueChanged<String> onTagRemoved;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return Chip(
              label: Text(tag),
              labelStyle: textTheme.bodySmall?.copyWith(
                color: appTheme.primary,
              ),
              backgroundColor: appTheme.primary?.withValues(alpha: 0.2),
              onDeleted: () => onTagRemoved(tag),
              deleteIconColor: appTheme.primary,
              side: BorderSide.none,
            );
          }).toList(),
        ),
        const Gap(height: 16),
        TextFormField(
          controller: controller,
          onFieldSubmitted: onTagAdded,
          decoration: InputDecoration(
            hintText: 'Add tag...',
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: PhosphorIcon(
                PhosphorIcons.tag(PhosphorIconsStyle.regular),
                color: appTheme.hintText,
              ),
            ),
          ),
          style: textTheme.bodyMedium,
          maxLines: 1,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
