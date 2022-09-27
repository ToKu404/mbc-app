part of 'vitamin_bloc.dart';

abstract class VitaminState extends Equatable {
  const VitaminState();

  @override
  List<Object> get props => [];
}

class VitaminInitialState extends VitaminState {}

class VitaminLoadingState extends VitaminState {}

class VitaminErrorState extends VitaminState {
  final String errorMsg;

  VitaminErrorState({required this.errorMsg});
}

class VitaminLoadedState extends VitaminState {
  final VitaminModel model;

  VitaminLoadedState({required this.model});
}
