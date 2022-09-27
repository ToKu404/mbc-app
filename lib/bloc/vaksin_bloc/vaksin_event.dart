part of 'vaksin_bloc.dart';

abstract class VaksinEvent extends Equatable {
  const VaksinEvent();

  @override
  List<Object> get props => [];
}

class VaksinFetchDataEvent extends VaksinEvent {}
