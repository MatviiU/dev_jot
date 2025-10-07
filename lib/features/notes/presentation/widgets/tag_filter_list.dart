import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagFilterList extends StatelessWidget {
  const TagFilterList({required this.uniqueTags, super.key, this.selectedTag});

  final List<String> uniqueTags;
  final String? selectedTag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                selected: selectedTag == null,
                onSelected: (value) {
                  context.read<NotesBloc>().add(const TagSelected(null));
                },
              ),
            );
          }
          final tag = uniqueTags[index - 1];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(tag),
              selected: selectedTag == tag,
              onSelected: (isSelected) {
                context.read<NotesBloc>().add(
                  TagSelected(isSelected ? tag : null),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
