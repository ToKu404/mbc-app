import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:mbc_mobile/firebase/services/local_notification_services.dart';

class NotificationHelper {
  static const TAG = "NotificationHelper";
  static void init(BuildContext context) {
    // opened app from terminated state
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.instance
        .getToken()
        .then((value) => print('$TAG, TOKEN $value'));
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    // foreground work

    FirebaseMessaging.onMessage.listen((message) {
      print("$TAG : Message Title ${message.notification!.title}");
      print("$TAG : Message Body ${message.notification!.body}");

      LocalNotificationServices.display(message);
    });

    // on background but user still opened app
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      final routeFromNotif = msg.data['event'];

      print("$TAG : routeFromNotif $routeFromNotif");
      // Navigator.of(context).pushNamed(SplashScreen.routeName);
    });
  }
}
