import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/repositories/laporan_repo.dart';
import 'package:mbc_mobile/repositories/notifikasi_repo.dart';
import 'package:mbc_mobile/repositories/user_repo.dart';
import 'package:mbc_mobile/screens/splash/splash_screen.dart';
import 'package:mbc_mobile/utils/routes.dart';
import 'package:mbc_mobile/utils/theme.dart';

import 'bloc/laporan_bloc/laporan_bloc.dart';
import 'bloc/notif_bloc/notifikasi_bloc.dart';
import 'bloc/user_bloc/user_bloc.dart';

// receive msg when app in background
Future<void> backGroundHandler(RemoteMessage msg) async {
  print("main");
  print(msg.data.toString());
  print(msg.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backGroundHandler);

  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(UserRepositoryImpl()),
      child: BlocProvider(
        create: (context) => LaporanBloc(LaporanRepositoryImpl()),
        child: BlocProvider(
          create: (context) => NotifikasiBloc(NotifikasiRepositoryImpl()),
          child: BlocProvider(
            create: (BuildContext context) =>
                AuthenticationBloc(UserRepositoryImpl()),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: theme(),
              initialRoute: SplashScreen.routeName,
              routes: routes,
              builder: EasyLoading.init(),
            ),
          ),
        ),
      ),
    );
  }
}
