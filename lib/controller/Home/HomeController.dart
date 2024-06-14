import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:yumyum/controller/Home/TrackingController.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Auth/CaptainData.dart';
import '../../data/datasource/remote/Home/orders.dart';
import 'package:jiffy/jiffy.dart';

import 'CaptainControllerImp.dart';

abstract class HomeController extends GetxController {

}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  CaptainUpData captainUpData = CaptainUpData(Get.find());
  List captains = [];



  @override
  viewcaptains() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await captainUpData.viewcaptains();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        captains = [];
        captains = mapData['data'];
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        captains = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      statusRequest = StatusRequest.success;
      update();
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      statusRequest = StatusRequest.success;
      update();
      return Get.snackbar("فشل", "you are not online please check on it");
    }
  }
  // @override
  // getPending() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.getpending();
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       // Clear the existing items and cartIndices list
  //
  //       pending = mapData['data'];
  //       pending = List.from(pending.reversed);
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //       pending = [];
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }
  //
  // @override
  // getAccepted() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.getaccepted(
  //     '${myServices.sharedPreferences.getInt("delivery_id")!}',
  //   );
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       // Clear the existing items and cartIndices list
  //
  //       accepted = mapData['data'];
  //       accepted = List.from(accepted.reversed);
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //       accepted = [];
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }
  //
  // @override
  // getArchive() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.getarchive(
  //     '${myServices.sharedPreferences.getInt("delivery_id")!}',
  //   );
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       // Clear the existing items and cartIndices list
  //
  //       archive = mapData['data'];
  //       archive = List.from(archive.reversed);
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //       archive = [];
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }
  //
  // @override
  // approve(String ordersid, String usersid) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.approve(
  //     ordersid,
  //     usersid,
  //     '${myServices.sharedPreferences.getInt("delivery_id")!}',
  //   );
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       getPending();
  //       getCurrentLocation();
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }
  //
  // @override
  // done(String ordersid, String usersid) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.done(
  //     ordersid,
  //     usersid,
  //   );
  //   getCurrentLocation();
  //   Get.put(TrackingController());
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       getAccepted();
  //       totalOrders += 1;
  //
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }

  List online_captains = [];

  @override
  viewonlinecaptains() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await captainUpData.viewonlinecaptains();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        online_captains = [];
        online_captains = mapData['data'];
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        online_captains = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      statusRequest = StatusRequest.success;
      update();
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      statusRequest = StatusRequest.success;
      update();
    }
  }

  void onInit() async{


    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print("Firebase Messaging Token: $token");
    myServices.sharedPreferences.setString("token",'admin');
    viewcaptains();
    viewonlinecaptains();
    super.onInit();
  }

  @override
  void dispose() {

    super.dispose();
  }
}
