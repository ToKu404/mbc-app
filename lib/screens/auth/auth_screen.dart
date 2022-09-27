import 'package:flutter/material.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/screens/auth/body.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = "auth";
  final AuthenticationBloc authenticationBloc;

  const AuthScreen({Key? key, required this.authenticationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Sign In", style: TextStyle(color: Colors.white))),
      body: Container(child: Body(authenticationBloc: authenticationBloc)),
    );
  }
}
