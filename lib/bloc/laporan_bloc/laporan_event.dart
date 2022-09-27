part of 'laporan_bloc.dart';

abstract class LaporanEvent extends Equatable {
  const LaporanEvent();

  @override
  List<Object> get props => [];
}

class LaporanFetchDataEvent extends LaporanEvent {
  final String userId;
  LaporanFetchDataEvent(this.userId);
}
