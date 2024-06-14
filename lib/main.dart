import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Auth/signIn.dart';
import 'package:yumyum/view/screen/Home/HomeScreen.dart';
import 'bindings/intialbindings.dart';
import 'core/services/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialServices();
  //await DevToolsServer.serve(address: InternetAddress.anyIPv4);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Sizer(builder: (context, orientation, deviceType) {
      return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        home:myServices.sharedPreferences.getString("token")==null?SignInScreen():HomeScreen(),
      );
    });
  }
}
