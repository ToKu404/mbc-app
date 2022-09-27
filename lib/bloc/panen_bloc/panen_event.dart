part of 'panen_bloc.dart';

abstract class PanenEvent extends Equatable {
  const PanenEvent();

  @override
  List<Object> get props => [];
}

class PanenFetchDataEvent extends PanenEvent {
  final String id;

  PanenFetchDataEvent({required this.id});
  @override
  List<Object> get props => [];
}

class PanenStoreEvent extends PanenEvent {
  final File? file;
  final Panen panen;
  final String notifId;

  PanenStoreEvent({this.file, required this.panen, required this.notifId});

  @override
  List<Object> get props => [];
}
