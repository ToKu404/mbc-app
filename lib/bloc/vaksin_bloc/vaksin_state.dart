part of 'vaksin_bloc.dart';

abstract class VaksinState extends Equatable {
  const VaksinState();

  @override
  List<Object> get props => [];
}

class VaksinInitialState extends VaksinState {}

class VaksinLoadingState extends VaksinState {}

class VaksinErrorState extends VaksinState {
  final String errorMsg;

  VaksinErrorState({required this.errorMsg});
}

class VaksinLoadedState extends VaksinState {
  final VaksinModel model;

  VaksinLoadedState({required this.model});
}
