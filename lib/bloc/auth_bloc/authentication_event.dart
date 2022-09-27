part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String token;

  LoginEvent({required this.email, required this.password, required this.token});
}

class LogOutEvent extends AuthenticationEvent {}

class CheckLoginEvent extends AuthenticationEvent {}
