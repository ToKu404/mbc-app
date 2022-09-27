part of 'notifikasi_bloc.dart';

abstract class NotifikasiState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotifikasiInitialState extends NotifikasiState {}

class NotifikasiErrorState extends NotifikasiState {
  final String error;
  NotifikasiErrorState({required this.error});
}

class NotifikasiSuccessState extends NotifikasiState {
  final NotifikasiModel datas;
  NotifikasiSuccessState({required this.datas});
}

class NotifikasiLoadingState extends NotifikasiState {}
