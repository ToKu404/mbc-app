part of 'obat_bloc.dart';

abstract class ObatEvent extends Equatable {
  const ObatEvent();

  @override
  List<Object> get props => [];
}

class ObatFetchDataEvent extends ObatEvent {}
