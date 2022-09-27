part of 'notifikasi_bloc.dart';

abstract class NotifikasiEvent extends Equatable {
  const NotifikasiEvent();

  @override
  List<Object> get props => [];
}

class NotifFetchByUserId extends NotifikasiEvent {
  final int id;

  NotifFetchByUserId({required this.id});

  @override
  List<Object> get props => [];
}
