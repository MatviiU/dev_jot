import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/app/widgets/failure_screen.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/app/widgets/splash_screen.dart';
import 'package:dev_jot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/widgets/empty_notes.dart';
import 'package:dev_jot/features/notes/presentation/widgets/note_list.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/cubit/tip_cubit.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/widgets/tip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    context.read<NotesBloc>().add(LoadNotes());
    context.read<TipCubit>().fetchTipRequested();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return switch (state) {
            NotesInitial() || NotesLoading() => const SplashScreen(),
            NotesLoaded() => Builder(
              builder: (context) {
                final uniqueTags = state.notes
                    .expand((note) => note.tags)
                    .toSet()
                    .toList();
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: TipCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: PhosphorIcon(
                            PhosphorIcons.magnifyingGlass(
                              PhosphorIconsStyle.regular,
                            ),
                            color: appTheme.hintText,
                          ),
                        ),
                        onChanged: (query) {
                          context.read<NotesBloc>().add(
                            SearchQueryChanged(query),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: uniqueTags.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: const Text('All'),
                                selected: state.selectedTag == null,
                                onSelected: (value) {
                                  context.read<NotesBloc>().add(
                                    const TagSelected(null),
                                  );
                                },
                              ),
                            );
                          }
                          final tag = uniqueTags[index - 1];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: FilterChip(
                              label: Text(tag),
                              selected: state.selectedTag == tag,
                              onSelected: (isSelected) {
                                context.read<NotesBloc>().add(
                                  TagSelected(isSelected ? tag : null),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(height: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: state.filteredNotes.isEmpty
                            ? const EmptyNotes()
                            : NoteList(notes: state.filteredNotes),
                      ),
                    ),
                  ],
                );
              },
            ),
            NotesFailure() => const FailureScreen(),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(ScreenNames.addEditNote),
        child: PhosphorIcon(PhosphorIcons.plus(PhosphorIconsStyle.regular)),
      ),
    );
  }
}
