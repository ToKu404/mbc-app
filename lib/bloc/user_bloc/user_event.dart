part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserFetchSingleData extends UserEvent {
  final String id;
  UserFetchSingleData({required this.id});
}
