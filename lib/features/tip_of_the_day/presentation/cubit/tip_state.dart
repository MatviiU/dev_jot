import 'package:dev_jot/features/tip_of_the_day/domain/models/tip.dart';
import 'package:equatable/equatable.dart';

sealed class TipState extends Equatable {
  const TipState();

  @override
  List<Object> get props => [];
}

final class TipInitial extends TipState {}

final class TipLoading extends TipState {}

final class TipLoaded extends TipState {
  const TipLoaded({required this.tip});

  final Tip tip;

  @override
  List<Object> get props => [tip];
}

final class TipFailure extends TipState {
  const TipFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
