import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/user_model.dart';
import 'package:mbc_mobile/repositories/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository repository;

  AuthenticationBloc(this.repository) : super(AuthenticationInitialState());
  AuthenticationState get initialState => AuthenticationInitialState();

  late SharedPreferences sharedpref;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      try {
        yield AuthLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.userLogin(
            event.email, event.password, event.token);
        yield AuthGetSuccess(user: data);
      } catch (e) {
        print(e.toString());
        yield AuthGetFailureState(error: e.toString());
      }
    } else if (event is CheckLoginEvent) {
      sharedpref = await SharedPreferences.getInstance();
      var data = sharedpref.get("name");
      var userId = sharedpref.get("id");
      var hakAkses = sharedpref.get("hak_akses");
      print("data $data");
      if (data != null)
        yield AuthLoggedInState(
            userId: int.parse(userId.toString()),
            userEmail: data.toString(),
            hakAkses: hakAkses.toString());
      else
        yield AuthLoggedOutState();
    } else if (event is LogOutEvent) {
      sharedpref = await SharedPreferences.getInstance();
      await sharedpref.clear();
      yield AuthLoggedOutState();
    }
  }
}
