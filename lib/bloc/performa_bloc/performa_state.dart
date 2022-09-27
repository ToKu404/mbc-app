part of 'performa_bloc.dart';

abstract class PerformaState extends Equatable {}

class PerformaInitialState extends PerformaState {
  @override
  List<Object> get props => [];
}

class PerformaLoadingState extends PerformaState {
  @override
  List<Object> get props => [];
}

class PerformaSuccessState extends PerformaState {
  final String msg;
  PerformaSuccessState(this.msg);

  @override
  List<Object> get props => [];
}

class PerformaErrorState extends PerformaState {
  final String msg;

  PerformaErrorState(this.msg);

  @override
  List<Object> get props => [];
}

class PerformaLoadedState extends PerformaState {
  final List<Performa> datas;
  PerformaLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
