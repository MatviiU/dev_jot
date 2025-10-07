import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: appTheme.background,
      elevation: 0,
      title: Text(
        'DevJot',
        style: textTheme.headlineMedium?.copyWith(color: appTheme.onBackground),
      ),
      actions: [
        IconButton(
          onPressed: () => context.pushNamed(ScreenNames.settings),
          icon: PhosphorIcon(PhosphorIcons.gear(PhosphorIconsStyle.regular)),
        ),
        IconButton(
          color: appTheme.onBackground,
          icon: PhosphorIcon(PhosphorIcons.signOut(PhosphorIconsStyle.regular)),
          onPressed: () {
            context.read<AuthBloc>().add(SignOutRequested());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
