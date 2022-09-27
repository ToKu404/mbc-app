import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/firebase/fcm/notification_helper.dart';
import 'package:mbc_mobile/firebase/services/local_notification_services.dart';
import 'package:mbc_mobile/screens/auth/auth_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/home_page.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class Body extends StatefulWidget {
  static String userEmail = "";

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AuthenticationBloc _bloc;

  @override
  void initState() {
    super.initState();

    LocalNotificationServices.initialize(context);
    LocalNotificationServices.requestPermissions();
    NotificationHelper.init(context);

    _bloc = BlocProvider.of<AuthenticationBloc>(context);
    // _bloc.add(CheckLoginEvent());
    internetAvailable();
  }

  internetAvailable() async {
    if (await checkConnection()) {
      _bloc.add(CheckLoginEvent());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pastikan anda terhubung ke Internet')));
    }
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        loginAction(state);
      },
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(26),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.backGroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(Images.logoImage, height: 100),
            SizedBox(
              height: 16,
            ),
            Text(
              'Welcome To Our App',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(8)),
            Text(
              'Manage all your activity in this application',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: Colors.white,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, AuthScreen.routeName);
            //   },
            //   child: DefaultButton(
            //     text: "Get Started",
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void loginAction(AuthenticationState state) async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 2));

    if (state is AuthLoggedOutState) {
      gotoAnotherPage(AuthScreen(
        authenticationBloc: _bloc,
      ));
    } else if (state is AuthLoggedInState) {
      // gotoAnotherPage(HomeScreen(
      //     authenticationBloc: _bloc,
      //     email: state.userEmail.toString(),
      //     id: state.userId));
      gotoAnotherPage(HomePage(
        userId: state.userId.toString(),
        bloc: _bloc,
        hakAkses: state.hakAkses,
      ));
    }
  }

  void gotoAnotherPage(Widget widget) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
