import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppearanceSettings extends StatelessWidget {
  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, currentThemeMode) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 16,
                bottom: 8,
                right: 16,
              ),
              child: Text(
                'Appearance',
                style: textTheme.labelLarge?.copyWith(
                  color: appTheme.primary,
                ),
              ),
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              secondary: PhosphorIcon(
                PhosphorIcons.moon(PhosphorIconsStyle.regular),
                color: appTheme.onSurface,
              ),
              title: Text('Dark theme', style: textTheme.bodyLarge),
              value: currentThemeMode == ThemeMode.dark,
              activeThumbColor: appTheme.primary,
              onChanged: (isDark) {
                final newTheme = isDark ? ThemeMode.dark : ThemeMode.light;
                context.read<ThemeCubit>().setTheme(newTheme);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Divider(height: 1, color: appTheme.surface),
            ),
          ],
        );
      },
    );
  }
}
