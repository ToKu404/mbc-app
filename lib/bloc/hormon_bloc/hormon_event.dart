part of 'hormon_bloc.dart';

abstract class HormonEvent extends Equatable {
  const HormonEvent();

  @override
  List<Object> get props => [];
}

class HormonFetchDataEvent extends HormonEvent {}
