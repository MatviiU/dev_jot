import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/failure_screen.dart';
import 'package:dev_jot/features/app/widgets/splash_screen.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/widgets/empty_notes.dart';
import 'package:dev_jot/features/notes/presentation/widgets/note_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<NotesBloc>().add(LoadNotes());
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.background,
        elevation: 0,
        title: Text(
          'DevJot',
          style: textTheme.headlineMedium?.copyWith(
            color: appTheme.onBackground,
          ),
        ),
        actions: [
          IconButton(
            color: appTheme.onBackground,
            icon: PhosphorIcon(
              PhosphorIcons.signOut(PhosphorIconsStyle.regular),
            ),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            return switch (state) {
              NotesInitial() || NotesLoading() => const SplashScreen(),
              NotesLoaded(notes: final notes) =>
                notes.isEmpty ? const EmptyNotes() : NoteList(notes: notes),
              NotesFailure() => const FailureScreen(),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: PhosphorIcon(PhosphorIcons.plus(PhosphorIconsStyle.regular)),
      ),
    );
  }
}
