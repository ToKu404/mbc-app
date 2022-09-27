import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/kabupaten_model.dart';

abstract class KabupatenState extends Equatable {}

class KabupatenInitialState extends KabupatenState {
  @override
  List<Object> get props => [];
}

class KabupatenLoadingState extends KabupatenState {
  @override
  List<Object> get props => [];
}

class KabupatenSuccessState extends KabupatenState {
  final String msg;
  KabupatenSuccessState(this.msg);

  @override
  List<Object> get props => [];
}
class KabupatenErrorState extends KabupatenState {
  final String msg;
  KabupatenErrorState(this.msg);

  @override
  List<Object> get props => [];
}
// ignore: must_be_immutable
class KabupatenLoadedState extends KabupatenState {
  List<Kabupaten> datas;
  KabupatenLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
