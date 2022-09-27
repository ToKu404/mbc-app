part of 'periksa_kebuntingan_bloc.dart';

abstract class PeriksaKebuntinganEvent extends Equatable {}

class PeriksaKebuntinganFetchDataEvent extends PeriksaKebuntinganEvent {
  final String id;
  PeriksaKebuntinganFetchDataEvent(this.id);
  @override
  List<Object> get props => [];
}

class PeriksaKebuntinganStoreEvent extends PeriksaKebuntinganEvent {
  final File? file;
  final PeriksaKebuntingan periksaKebuntingan;
  final String notifId;

  PeriksaKebuntinganStoreEvent(
      {this.file, required this.periksaKebuntingan, required this.notifId});

  @override
  List<Object> get props => [];
}

class PeriksaKebuntinganDeleteEvent extends PeriksaKebuntinganEvent {
  final PeriksaKebuntingan periksaKebuntingan;
  final String userId;

  PeriksaKebuntinganDeleteEvent(
      {required this.periksaKebuntingan, required this.userId});

  @override
  List<Object> get props => [];
}
