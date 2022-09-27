part of 'hasil_bloc.dart';

abstract class HasilEvent extends Equatable {
  const HasilEvent();

  @override
  List<Object> get props => [];
}

class HasilFetchDataEvent extends HasilEvent {}
