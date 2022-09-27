part of 'strow_bloc.dart';

abstract class StrowEvent extends Equatable {}

class StrowFetchDataEvent extends StrowEvent {
  @override
  List<Object> get props => [];
}

class StrowStoreEvent extends StrowEvent {
  final Strow strow;

  StrowStoreEvent({required this.strow});

  @override
  List<Object> get props => [];
}
class StrowUpdateEvent extends StrowEvent {
  final Strow strow;

  StrowUpdateEvent({required this.strow});

  @override
  List<Object> get props => [];
}
class StrowDeleteEvent extends StrowEvent {
  final Strow strow;

  StrowDeleteEvent({required this.strow});

  @override
  List<Object> get props => [];
}
