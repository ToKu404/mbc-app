part of 'vitamin_bloc.dart';

abstract class VitaminEvent extends Equatable {
  const VitaminEvent();

  @override
  List<Object> get props => [];
}

class VitaminFetchDataEvent extends VitaminEvent {}
