part of 'panen_bloc.dart';

abstract class PanenState extends Equatable {
  const PanenState();

  @override
  List<Object> get props => [];
}

class PanenInitial extends PanenState {}

class PanenLoadingState extends PanenState {}

class PanenSuccessState extends PanenState {
  final String msg;

  PanenSuccessState(this.msg);
}

class PanenErrorState extends PanenState {
  final String msg;

  PanenErrorState(this.msg);
}

class PanenLoadeState extends PanenState {
  final PanenModel model;

  PanenLoadeState(this.model);
}
