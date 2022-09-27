part of 'metode_bloc.dart';

abstract class MetodeEvent extends Equatable {
  const MetodeEvent();

  @override
  List<Object> get props => [];
}

class MetodeFetchDataEvent extends MetodeEvent {}
