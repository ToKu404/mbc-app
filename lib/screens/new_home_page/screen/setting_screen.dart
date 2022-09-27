import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:mbc_mobile/screens/auth/auth_screen.dart';
import 'package:mbc_mobile/utils/AppColor.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class SettingScreen extends StatefulWidget {
  final String userId;
  final AuthenticationBloc bloc;

  const SettingScreen({Key? key, required this.userId, required this.bloc})
      : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print(state);
        if (state is AuthLoggedOutState) {
          gotoAnotherPage(AuthScreen(authenticationBloc: widget.bloc), context);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserErrorState) {
            return buildError(state.errorMsg);
          } else if (state is UserSingleLoadedState) {
            return Container(
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.user.email,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text(
                              state.user.hakAkses == "3"
                                  ? 'Pendamping'
                                  : state.user.hakAkses == "4"
                                      ? 'Dokter'
                                      : 'TSR',
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: getProportionateScreenHeight(16)),
                          Text("No Hp", style: titleDarkStyle),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: AppColor.primaryExtraSoft,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(state.user.noHp),
                          ),
                          SizedBox(height: getProportionateScreenHeight(16)),
                          Text("Alamat Lengkap", style: titleDarkStyle),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: AppColor.primaryExtraSoft,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(state.user.alamat),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        alertConfirm();
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        width: size.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                            child: Text("Log Out",
                                style: TextStyle(color: Colors.white))),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(80)),
                  ])),
            );
          } else {
            return buildLoading();
          }
        },
      ),
    );
  }

  void gotoAnotherPage(Widget widget, BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  void alertConfirm() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, Logout",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      widget.bloc.add(LogOutEvent());
      return;
    }
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError(String msg) {
    return Center(
      child: Text(msg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }
}
