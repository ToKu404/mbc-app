part of 'sapi_master_bloc.dart';

abstract class SapiMasterState extends Equatable {
  const SapiMasterState();

  @override
  List<Object> get props => [];
}

class SapiMasterInitial extends SapiMasterState {}

class SapiMasterLoadingState extends SapiMasterState {}

class SapiMasterLoadedState extends SapiMasterState {
  final MasterSapiModel model;
  SapiMasterLoadedState({required this.model});
}

class SapiMasterErrorState extends SapiMasterState {
  final String errorMsg;

  SapiMasterErrorState({required this.errorMsg});
}

class SapiMasterSuccessState extends SapiMasterState {
  final String successMsg;
  SapiMasterSuccessState({required this.successMsg});
}
