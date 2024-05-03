import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/linkapi.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Offers.dart';
import '../../data/datasource/remote/Home/address.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/home.dart';
import 'package:http/http.dart' as http;

import '../../view/screen/MainScreen.dart';
import '../../view/screen/Onboarding/OnboardingScreen.dart';


abstract class SplashController extends GetxController {
}

class SplashControllerImp extends SplashController {
  HomeData homeData = HomeData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  int? version=1;
  int current_version=1;

  ///check version
  _google_play() async {
    final uri = Uri.parse('https://play.google.com/store/apps/details?id=com.wasena.app');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
  @override
  getVersion() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getversion();
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        version = mapData['data'][0]['version_number'];

        if(current_version!=version){
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.update_sharp,size: 14,),

                  const Text('Check update  '),
                ],
              ),
              content: Text(' أحدث الميزات والتحسينات عن طريق تحديث تطبيق وصينا إلى الإصدار الأحدث '),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => _google_play(),
                  child: const Text('تحديث الآن', style: TextStyle(color: Colors.blueGrey)),
                ),
              ],
            ),
          );
        }else{
          Timer(Duration(seconds: 3), () {

            myServices.sharedPreferences.getString("token") == null
                ? Get.to(OnboardingScreen())
                : Get.offAll(MainScreen());
          });
        }
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {

        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {

      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }




  @override
  void onInit() async {
    getVersion();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
