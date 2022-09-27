part of 'insiminasi_buatan_bloc.dart';

abstract class InsiminasiBuatanEvent extends Equatable {}

class InsiminasiBuatanFetchDataEvent extends InsiminasiBuatanEvent {
  final String userId;
  InsiminasiBuatanFetchDataEvent({required this.userId});

  @override
  List<Object> get props => [];
}

class InsiminasiBuatanStoreEvent extends InsiminasiBuatanEvent {
  final File? file;
  final InsiminasiBuatan insiminasiBuatan;
  final String notifId;

  InsiminasiBuatanStoreEvent(
      {this.file, required this.insiminasiBuatan, required this.notifId});

  @override
  List<Object> get props => [];
}

class InsiminasiBuatanUpdateEvent extends InsiminasiBuatanEvent {
  final InsiminasiBuatan insiminasiBuatan;

  InsiminasiBuatanUpdateEvent({required this.insiminasiBuatan});

  @override
  List<Object> get props => [];
}

class InsiminasiBuatanDeleteEvent extends InsiminasiBuatanEvent {
  final InsiminasiBuatan insiminasiBuatan;

  InsiminasiBuatanDeleteEvent({required this.insiminasiBuatan});

  @override
  List<Object> get props => [];
}
