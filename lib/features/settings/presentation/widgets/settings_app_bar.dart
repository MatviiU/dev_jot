import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      elevation: 0,
      backgroundColor: appTheme.background,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: PhosphorIcon(
          PhosphorIcons.arrowLeft(),
          color: appTheme.onBackground,
        ),
      ),
      title: Text('Settings', style: textTheme.headlineMedium),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
