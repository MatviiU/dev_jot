import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/widgets/home_screen_widgets/empty_notes.dart';
import 'package:dev_jot/features/notes/presentation/widgets/home_screen_widgets/note_list.dart';
import 'package:dev_jot/features/notes/presentation/widgets/home_screen_widgets/notes_search_bar.dart';
import 'package:dev_jot/features/notes/presentation/widgets/home_screen_widgets/tag_filter_list.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/widgets/tip_card.dart';
import 'package:flutter/material.dart';

class NotesLoadedView extends StatelessWidget {
  const NotesLoadedView({
    required this.state,
    required this.searchController,
    super.key,
  });

  final NotesLoaded state;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final uniqueTags = state.notes.expand((note) => note.tags).toSet().toList();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: TipCard(),
        ),
        NotesSearchBar(controller: searchController),
        TagFilterList(uniqueTags: uniqueTags, selectedTag: state.selectedTag),
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
  }
}
