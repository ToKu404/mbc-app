part of 'peternaksapi_bloc.dart';

abstract class PeternaksapiState extends Equatable {
  const PeternaksapiState();

  @override
  List<Object> get props => [];
}

class PeternaksapiInitialState extends PeternaksapiState {}

class PeternaksapiLoadingState extends PeternaksapiState {}

class PeternaksapiSuccessState extends PeternaksapiState {
  final String successMsg;

  PeternaksapiSuccessState({required this.successMsg});
}

class PeternaksapiErrorState extends PeternaksapiState {
  final String errorMsg;

  PeternaksapiErrorState({required this.errorMsg});
}

class PeternaksapiLoadedState extends PeternaksapiState {
  final PeternakSapiModel model;

  PeternaksapiLoadedState({required this.model});
}
