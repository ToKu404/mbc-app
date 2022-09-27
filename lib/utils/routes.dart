import 'package:flutter/widgets.dart';
import 'package:mbc_mobile/screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  // PeternakScreen.routeName: (context) => PeternakScreen(),
  // PeriksaKebuntinganScreen.routeName: (context) => PeriksaKebuntinganScreen(),
  // PerformaScreen.routeName: (context) => PerformaScreen(),
  // StrowScreen.routeName: (context) => StrowScreen(),
  // InsiminasiBuatanScreen.routeName: (context) => InsiminasiBuatanScreen(),
  // PerlakuanScreen.routeName: (context) => PerlakuanScreen(),
};
