part of 'hormon_bloc.dart';

abstract class HormonState extends Equatable {
  const HormonState();

  @override
  List<Object> get props => [];
}

class HormonInitialState extends HormonState {}

class HormonLoadingState extends HormonState {}

class HormonErrorState extends HormonState {
  final String errorMsg;

  HormonErrorState({required this.errorMsg});
}

class HormonLoadedState extends HormonState {
  final HormonModel model;

  HormonLoadedState({required this.model});
}
