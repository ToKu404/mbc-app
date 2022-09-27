part of 'metode_bloc.dart';

abstract class MetodeState extends Equatable {
  const MetodeState();

  @override
  List<Object> get props => [];
}

class MetodeInitialState extends MetodeState {}

class MetodeLoadingState extends MetodeState {}

class MetodeErrorState extends MetodeState {
  final String errorMsg;

  MetodeErrorState(this.errorMsg);
}

class MetodeSuccessState extends MetodeState {
  final String successMsg;

  MetodeSuccessState(this.successMsg);
}

class MetodeLoadedState extends MetodeState {
  final MetodeModel metodeModel;

  MetodeLoadedState(this.metodeModel);
}
