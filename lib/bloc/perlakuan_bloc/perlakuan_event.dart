part of 'perlakuan_bloc.dart';

abstract class PerlakuanEvent extends Equatable {}

class PerlakuanFetchDataEvent extends PerlakuanEvent {
  final String userId;

  PerlakuanFetchDataEvent(this.userId);
  @override
  List<Object> get props => [];
}

class PerlakuanStoreEvent extends PerlakuanEvent {
  final File? file;
  final Perlakuan perlakuan;
  final String notifikasiId;

  PerlakuanStoreEvent(
      {this.file, required this.perlakuan, required this.notifikasiId});

  @override
  List<Object> get props => [];
}

class PerlakuanDeleteEvent extends PerlakuanEvent {
  final Perlakuan perlakuan;

  PerlakuanDeleteEvent({required this.perlakuan});

  @override
  List<Object> get props => [];
}
