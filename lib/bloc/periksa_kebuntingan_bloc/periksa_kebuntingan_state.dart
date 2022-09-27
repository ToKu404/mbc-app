part of 'periksa_kebuntingan_bloc.dart';

abstract class PeriksaKebuntinganState extends Equatable {}

class PeriksaKebuntinganInitialState extends PeriksaKebuntinganState {
  @override
  List<Object> get props => [];
}

class PeriksaKebuntinganLoadingState extends PeriksaKebuntinganState {
  @override
  List<Object> get props => [];
}

class PeriksaKebuntinganSuccessState extends PeriksaKebuntinganState {
  final String msg;

  PeriksaKebuntinganSuccessState(this.msg);

  @override
  List<Object> get props => [];
}

class PeriksaKebuntinganErrorState extends PeriksaKebuntinganState {
  final String msg;

  PeriksaKebuntinganErrorState(this.msg);

  @override
  List<Object> get props => [];
}

class PeriksaKebuntinganLoadedState extends PeriksaKebuntinganState {
  final List<PeriksaKebuntingan> datas;
  PeriksaKebuntinganLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
