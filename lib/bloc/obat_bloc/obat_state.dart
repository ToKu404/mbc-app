part of 'obat_bloc.dart';

abstract class ObatState extends Equatable {
  const ObatState();

  @override
  List<Object> get props => [];
}

class ObatInitialState extends ObatState {}

class ObatLoadingState extends ObatState {}

class ObatErrorState extends ObatState {
  final String errorMsg;

  ObatErrorState({required this.errorMsg});
}

class ObatLoadedState extends ObatState {
  final ObatModel model;

  ObatLoadedState({required this.model});
}
