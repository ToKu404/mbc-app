part of 'strow_bloc.dart';

abstract class StrowState extends Equatable {}

class StrowInitialState extends StrowState {
  @override
  List<Object> get props => [];
}

class StrowLoadingState extends StrowState {
  @override
  List<Object> get props => [];
}

class StrowSuccessState extends StrowState {
  final String msg;
  final List<Strow> datas;

  StrowSuccessState(this.msg, this.datas);

  @override
  List<Object> get props => [];
}
class StrowErrorState extends StrowState {
  final String msg;
  final List<Strow> datas;

  StrowErrorState(this.msg, this.datas);

  @override
  List<Object> get props => [];
}
class StrowLoadedState extends StrowState {
  final List<Strow> datas;
  StrowLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
