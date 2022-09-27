part of 'laporan_bloc.dart';

abstract class LaporanState extends Equatable {
  const LaporanState();

  @override
  List<Object> get props => [];
}

class LaporanInitialState extends LaporanState {}

class LaporanLoadingState extends LaporanState {}

class LaporanLoadedState extends LaporanState {
  final LaporanModel model;

  LaporanLoadedState(this.model);
}

class LaporanSuccessState extends LaporanState {
  final String successMsg;

  LaporanSuccessState(this.successMsg);
}

class LaporanErrorState extends LaporanState {
  final String errorMsg;

  LaporanErrorState(this.errorMsg);
}
