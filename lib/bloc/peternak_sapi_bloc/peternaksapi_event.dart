part of 'peternaksapi_bloc.dart';

abstract class PeternaksapiEvent extends Equatable {}

class PeternakSapiFetchDataEvent extends PeternaksapiEvent {
  final String id;
  PeternakSapiFetchDataEvent(this.id);

  @override
  List<Object> get props => [];
}
