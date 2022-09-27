part of 'insiminasi_buatan_bloc.dart';

abstract class InsiminasiBuatanState extends Equatable {}

class InsiminasiBuatanInitialState extends InsiminasiBuatanState {
  @override
  List<Object> get props => [];
}

class InsiminasiBuatanLoadingState extends InsiminasiBuatanState {
  @override
  List<Object> get props => [];
}

class InsiminasiBuatanSuccessState extends InsiminasiBuatanState {
  final String msg;

  InsiminasiBuatanSuccessState(this.msg);

  @override
  List<Object> get props => [];
}

class InsiminasiBuatanErrorState extends InsiminasiBuatanState {
  final String msg;

  InsiminasiBuatanErrorState(this.msg);

  @override
  List<Object> get props => [];
}

class InsiminasiBuatanLoadedState extends InsiminasiBuatanState {
  final List<InsiminasiBuatan> datas;
  InsiminasiBuatanLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
