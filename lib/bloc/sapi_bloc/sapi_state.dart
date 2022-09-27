part of 'sapi_bloc.dart';

abstract class SapiState extends Equatable {}

class SapiInitialState extends SapiState {
  @override
  List<Object> get props => [];
}

class SapiLoadingState extends SapiState {
  @override
  List<Object> get props => [];
}

class SapiSuccessState extends SapiState {
  final String msg;
  SapiSuccessState(this.msg);

  @override
  List<Object> get props => [];
}

class SapiErrorState extends SapiState {
  final String msg;
  SapiErrorState(this.msg);

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SapiLoadedState extends SapiState {
  List<Sapi> datas;
  SapiLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
