import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Splash/SplashScreen.dart';
import 'bindings/intialbindings.dart';
import 'core/services/services.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(
      'resource://drawable/ic_stat_icon',
      [
        NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.green,
            ledColor: Colors.green)
      ],
      debug: true);
  await initialServices();
  // await FirebaseAppCheck.instance.activate(
  //     webProvider: ReCaptchaEnterpriseProvider(
  //         '6LeZOnApAAAAAM8w9sf1JoZzSLtalv74rlIo9PeI'),
  //     androidProvider: AndroidProvider.playIntegrity,
  //     appleProvider: AppleProvider.appAttest);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'alerts',
        title: message.notification!.title!,
        body:  message.notification!.body!,
      ),
    );
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        theme: ThemeData(
          primaryColor: Color(0xff133032),
          canvasColor: Color(0xff133032),
          cardColor: Color(0xff133032),
          focusColor: Color(0xff133032),
          splashColor: Color(0xffbbd469),
          bottomAppBarColor: Color(0xff133032),
          backgroundColor: Color(0xff133032),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xff133032),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      );
    });
  }
}
