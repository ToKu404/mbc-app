import 'package:flutter/material.dart';
import 'package:mbc_mobile/screens/splash/body.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
