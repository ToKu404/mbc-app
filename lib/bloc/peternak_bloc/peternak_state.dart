import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/peternak_model.dart';

abstract class PeternakState extends Equatable {}

class PeternakInitialState extends PeternakState {
  @override
  List<Object> get props => [];
}

class PeternakLoadingState extends PeternakState {
  @override
  List<Object> get props => [];
}

class PeternakSuccessState extends PeternakState {
  final String msg;
  PeternakSuccessState(this.msg);

  @override
  List<Object> get props => [];
}

class PeternakErrorState extends PeternakState {
  final String msg;
  PeternakErrorState(this.msg);

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class PeternakLoadedState extends PeternakState {
  List<Peternak> datas;
  PeternakLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
