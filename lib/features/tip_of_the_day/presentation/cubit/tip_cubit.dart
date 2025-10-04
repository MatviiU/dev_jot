import 'package:dev_jot/features/tip_of_the_day/domain/exceptions/tip_exception.dart';
import 'package:dev_jot/features/tip_of_the_day/domain/repositories/tip_repository.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/cubit/tip_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipCubit extends Cubit<TipState> {
  TipCubit({required TipRepository tipRepository})
    : _tipRepository = tipRepository,
      super(TipInitial());

  final TipRepository _tipRepository;

  Future<void> fetchTipRequested() async {
    emit(TipLoading());
    try {
      final tip = await _tipRepository.getTipOfTheDay();
      emit(TipLoaded(tip: tip));
    } on TipException catch (e) {
      emit(TipFailure(message: e.message));
    } catch (e) {
      emit(const TipFailure(message: 'Unknown error'));
    }
  }
}
