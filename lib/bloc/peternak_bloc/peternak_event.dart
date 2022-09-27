import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/peternak_model.dart';

abstract class PeternakEvent extends Equatable {}

class PeternakFetchDataEvent extends PeternakEvent {
  final String userId;

  PeternakFetchDataEvent({required this.userId});

  @override
  List<Object> get props => [];
}

class PeternakStoreEvent extends PeternakEvent {
  final Peternak peternak;

  PeternakStoreEvent({required this.peternak});

  @override
  List<Object> get props => [];
}

class PeternakUpdateEvent extends PeternakEvent {
  final Peternak peternak;

  PeternakUpdateEvent({required this.peternak});

  @override
  List<Object> get props => [];
}

class PeternakDeleteEvent extends PeternakEvent {
  final Peternak peternak;

  PeternakDeleteEvent({required this.peternak});

  @override
  List<Object> get props => [];
}
