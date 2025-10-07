import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NotesSearchBar extends StatelessWidget {
  const NotesSearchBar({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: PhosphorIcon(
            PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
            color: appTheme.hintText,
          ),
        ),
        onChanged: (query) {
          context.read<NotesBloc>().add(SearchQueryChanged(query));
        },
      ),
    );
  }
}
