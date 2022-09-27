part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String errorMsg;

  UserErrorState({required this.errorMsg});
}

class UserSingleLoadedState extends UserState {
  final User user;

  UserSingleLoadedState({required this.user});
}
