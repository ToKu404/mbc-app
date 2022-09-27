part of 'birahi_bloc.dart';

abstract class BirahiState extends Equatable {
  const BirahiState();

  @override
  List<Object> get props => [];
}

class BirahiInitial extends BirahiState {}

class BirahiLoadingState extends BirahiState {}

class BirahiErrorState extends BirahiState {
  final String msg;

  BirahiErrorState(this.msg);
}

class BirahiSuccessState extends BirahiState {
  final String msg;

  BirahiSuccessState(this.msg);
}
