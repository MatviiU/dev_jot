import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CodeSettings extends StatelessWidget {
  const CodeSettings({
    required this.isCode,
    required this.selectedLanguage,
    required this.onIsCodeChanged,
    required this.onSelectedLanguageChanged,
    super.key,
  });

  final bool isCode;
  final Syntax selectedLanguage;
  final ValueChanged<bool> onIsCodeChanged;
  final ValueChanged<Syntax?> onSelectedLanguageChanged;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SwitchListTile(
          title: Text('Code snipped', style: textTheme.bodyLarge),
          activeThumbColor: appTheme.primary,
          secondary: PhosphorIcon(
            PhosphorIcons.code(PhosphorIconsStyle.regular),
            color: appTheme.onSurface,
          ),
          value: isCode,
          onChanged: onIsCodeChanged,
        ),
        if (isCode) ...[
          const Gap(height: 16),
          DropdownButtonFormField<Syntax>(
            initialValue: selectedLanguage,
            items: Syntax.values.map((Syntax syntax) {
              return DropdownMenuItem<Syntax>(
                value: syntax,
                child: Text(syntax.name),
              );
            }).toList(),
            onChanged: onSelectedLanguageChanged,
            decoration: InputDecoration(
              labelText: 'Language',
              prefixIcon: PhosphorIcon(
                PhosphorIcons.translate(PhosphorIconsStyle.regular),
                color: appTheme.hintText,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
