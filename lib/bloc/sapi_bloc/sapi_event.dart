part of 'sapi_bloc.dart';

abstract class SapiEvent extends Equatable {}

class SapiFetchDataEvent extends SapiEvent {
  final String userId;
  SapiFetchDataEvent(this.userId);
  @override
  List<Object> get props => [];
}

class SapiStoreEvent extends SapiEvent {
  final File? fotoDepan;
  final File? fotoSamping;
  final File? fotoPeternak;
  final File? fotoRumah;
  final Sapi sapi;
  final File? fotoPerforma;
  final Performa performa;

  SapiStoreEvent(
      {required this.fotoDepan,
      required this.fotoSamping,
      required this.fotoPeternak,
      required this.fotoRumah,
      required this.sapi,
      required this.fotoPerforma,
      required this.performa});
  @override
  List<Object?> get props => [];
}
