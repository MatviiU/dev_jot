import 'package:dev_jot/features/app/screen_names.dart';
import 'package:dev_jot/features/app/widgets/failure_screen.dart';
import 'package:dev_jot/features/app/widgets/splash_screen.dart';
import 'package:dev_jot/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:dev_jot/features/notes/presentation/widgets/home_screen_widgets/home_app_bar.dart';
import 'package:dev_jot/features/notes/presentation/widgets/home_screen_widgets/notes_loaded_view.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/cubit/tip_cubit.dart';
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
    return Scaffold(
      appBar: const HomeAppBar(),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return switch (state) {
            NotesInitial() || NotesLoading() => const SplashScreen(),
            NotesLoaded() => NotesLoadedView(
              state: state,
              searchController: _searchController,
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
