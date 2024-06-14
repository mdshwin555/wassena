import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import 'package:yumyum/view/screen/Home/OrdersScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/orders.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;

import '../../view/screen/Home/OrdersDetailsScreen.dart';
import 'TrackingController.dart';

abstract class OrdersController extends GetxController {}

class OrdersControllerImp extends OrdersController {
  OrdersData ordersData = OrdersData(Get.find());
  CameraPosition? cameraposition;
  Completer<GoogleMapController>? controllerCompleter;
  String currentLocationName = '';
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  StreamSubscription<Position>? positionStream;
  RxInt totalOrders = 0.obs;
  List details = [];
  List pending = [];
  List preparing = [];
  List onway = [];
  List archive = [];
  List<Marker> markers = [];
  RxInt selectedIndex = 0.obs;
  CameraPosition? KGooglePlex;
  late TextEditingController  new_delivery_price = TextEditingController(text: '');
  String? old_delivery_price;

  selectTab(int index) {
    selectedIndex.value = index;
    update();
  }
  String addCommasToNumber(int number) {
    String numberStr = number.toString();
    String result = '';
    int count = 0;

    for (int i = numberStr.length - 1; i >= 0; i--) {
      result = numberStr[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) {
        result = ',' + result;
      }
    }

    return result;
  }

  makeCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunch('$uri')) {
      await launch('$uri');
    } else {
      throw 'Could not launch $uri';
    }
  }
  // InitialData() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   if (details.isNotEmpty) {
  //     final placemarks = await placemarkFromCoordinates(
  //       details[0]['address_lat'],
  //       details[0]['address_long'],
  //       localeIdentifier: 'ar', // Set the locale for Arabic
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       geocoding.Placemark placemark = placemarks.first;
  //
  //       // Extract detailed location information
  //       String name = placemark.name ?? '';
  //       String locality = placemark.locality ?? '';
  //       String subLocality = placemark.subLocality ?? '';
  //       String thoroughfare = placemark.thoroughfare ?? '';
  //       String subThoroughfare = placemark.subThoroughfare ?? '';
  //
  //       currentLocationName =
  //       '$subThoroughfare $thoroughfare, $subLocality, $locality, ';
  //
  //       // Update cameraposition after extracting details
  //
  //       statusRequest = StatusRequest.success;
  //       update();
  //     }
  //   }
  // }

  @override
  getDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getdetails(
      '${myServices.sharedPreferences.getString("orders_id")!}',
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        // print("=============================== response 200 ");
        statusRequest = StatusRequest.success;
        update();
        details = [];
        details = mapData['data'];
        old_delivery_price = details[0]['orders_pricedelivery'];

        // InitialData();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        details = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      // print("=============================== response 404 ");
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // print("=============================== response 500 ");
      // Handle server failure
    }
  }

  @override
  additem(
    String usersId,
    String itemsId,
    String orderid,
  ) async {
    statusRequest = StatusRequest.loading;
    update();
    // Always add the item to the cart
    var response = await ordersData.additem(usersId, itemsId,orderid);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        getDetails();
        statusRequest = StatusRequest.success;
        update();
      } else {
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  updateDeliveryPriceOrder(
      String order_id,
      String new_delivery_price,
      ) async {
    statusRequest = StatusRequest.loading;
    update();
    // Always add the item to the cart
    var response = await ordersData.updateDeliveryPriceOrder(order_id, new_delivery_price);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        Get.snackbar("تمت التعديل", "لقد قمت بتعديل سعر التوصيل لهذا الطلب");
        Get.to(OrdersDetails());
        statusRequest = StatusRequest.success;
        update();
      } else {
        Get.snackbar("فشل", "you are not online please check on it");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      Get.snackbar("فشل", "you are not online please check on it");
      // Handle server failure
    }
  }


  @override
  removeitem(String usersId, String itemsId,  String orderid,) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.removeitem(usersId, itemsId,orderid);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        getDetails();
        statusRequest = StatusRequest.success;
        update();
      } else {
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  getPending() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getpending();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        // Clear the existing items and cartIndices list

        pending = mapData['data'];
        pending = List.from(pending.reversed);
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        pending = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }


  getPreparing() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getpreparing();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        preparing = [];
        preparing = mapData['data'];
        preparing = List.from(preparing.reversed);
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        preparing = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  getOnWay() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getonway();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        onway = [];
        onway = mapData['data'];
        onway = List.from(onway.reversed);
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        onway = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  getarchive() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getarchive();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        archive = [];
        archive = mapData['data'];
        archive = List.from(archive.reversed);
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        archive = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

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
  @override
  approve(String ordersid, String usersid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.approve(
      ordersid,
      usersid,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        Get.snackbar("تم القبول", "تم قبول الأوردر بنجاح");
        getDetails();
        Get.offAll(OrdersDetails());
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل", "فشلت عملية قبول الأوردر يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  prepare(String ordersid, String usersid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.prepare(
      ordersid,
      usersid,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        Get.snackbar("تم تعديل الحالة", "يتم تحضير الأوردر الآن");
        getDetails();
        Get.offAll(OrdersDetails());
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل", "فشلت عملية تحضير الأوردر يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  reject(String ordersid, String usersid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.reject(
      ordersid,
      usersid,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        Get.snackbar("تم الرفض", "تم رفض الأوردر بنجاح");
       Get.offAll(OrdersScreen());
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل", "فشلت عملية رفض الأوردر يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  //
  // @override
  // done(String ordersid, String usersid) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.done(
  //     ordersid,
  //     usersid,
  //   );
  //
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

  @override
  void onInit() async {
    getPending();
    getDetails();
    getPreparing();
    getOnWay();
    getarchive();
    new_delivery_price = TextEditingController(text: old_delivery_price);

    // print('=============================================================================================================&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&======================================');
    // print(details[0]['address_long'],);
    // print(details[0]['address_lat'],);
    await Jiffy.setLocale('ar');
    super.onInit();
  }

  @override
  void dispose() {
    getDetails();
    getPending();
    getPreparing();
    getOnWay();
    getarchive();
    new_delivery_price = TextEditingController(text: old_delivery_price);
    super.dispose();
  }
}
