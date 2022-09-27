part of 'sapi_master_bloc.dart';

abstract class SapiMasterEvent extends Equatable {
  const SapiMasterEvent();

  @override
  List<Object> get props => [];
}

class SapiMasterFetchDataEvent extends SapiMasterEvent {}
