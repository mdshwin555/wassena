import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Offers.dart';
import '../../data/datasource/remote/Home/address.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/home.dart';
import '../../data/datasource/remote/Home/restaurants.dart';
import '../../data/datasource/remote/Home/search.dart';
import '../../data/datasource/remote/Home/restaurants.dart';
import 'package:http/http.dart' as http;


abstract class SearchController extends GetxController {

}

class SearchControllerImp extends SearchController {
  SearchData searchData = SearchData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  List searchlistitem = [];
  List searchliststore = [];
  List items = [];
  double? lat;
  double? distance  ;
  double? duration  ;
  double? long;
  Position? position;
  CameraPosition? KGooglePlex;
  String currentLocationName = 'غير معروف';


  RestaurantsData restaurantsData = RestaurantsData(Get.find());
  int type = 0;
  void updateType(int value) {
    type = value;
    update();
  }

  Future<double> calculateDistance(lat, long, destlat, destlong) async {
    var url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs";

    var response = await http.post(Uri.parse(url));

    var responsebody = jsonDecode(response.body);

    var routes = responsebody['routes'];

    if (routes.isNotEmpty) {
      var legs = routes[0]['legs'];

      if (legs.isNotEmpty) {
        var distanceInMeters = legs[0]['distance']['value'];
        var distanceInKM = distanceInMeters / 1000.0;

        var durationInSeconds = legs[0]['duration']['value'];
        var durationInMinutes = durationInSeconds / 60.0;

        distance = distanceInKM;
        duration = durationInMinutes;
        update();
        return distanceInKM;
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }


  getsearch(String query) async {
    var response = await searchData.search(
      query,
        type==0 ?'store':'item'
    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        type==0 ?searchliststore = mapData['data']: searchlistitem = mapData['data'];
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        type==0 ?searchliststore = []: searchlistitem = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  bool isRestaurantOpen(Map<String, dynamic> restaurant) {
    DateTime now = DateTime.now();

    // Get current time
    TimeOfDay currentTime = TimeOfDay(
      hour: now.hour,
      minute: now.minute,
    );

    // Get opening and closing times
    TimeOfDay openTime = TimeOfDay(
      hour: int.parse(restaurant['restaurants_open'].split(':')[0]),
      minute: int.parse(restaurant['restaurants_open'].split(':')[1]),
    );

    TimeOfDay closeTime = TimeOfDay(
      hour: int.parse(restaurant['restaurants_close'].split(':')[0]),
      minute: int.parse(restaurant['restaurants_close'].split(':')[1]),
    );

    // Check if the restaurant is open past midnight
    bool isOpenPastMidnight = closeTime.hour < openTime.hour;

    // Adjust close time if it's before open time
    if (isOpenPastMidnight) {
      closeTime = TimeOfDay(
        hour: closeTime.hour + 24,
        minute: closeTime.minute,
      );
    }

    // Check if current time falls within opening hours
    if ((!isOpenPastMidnight && currentTime.hour > openTime.hour) ||
        (isOpenPastMidnight && (currentTime.hour > openTime.hour || currentTime.hour < closeTime.hour)) ||
        (currentTime.hour == openTime.hour && currentTime.minute >= openTime.minute)) {
      // If current time is after opening time
      if ((!isOpenPastMidnight && currentTime.hour < closeTime.hour) ||
          (isOpenPastMidnight && (currentTime.hour < closeTime.hour || currentTime.hour > openTime.hour)) ||
          (currentTime.hour == closeTime.hour && currentTime.minute < closeTime.minute)) {
        // If current time is before closing time
        return true;
      }
    }

    return false;
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


  viewitemsrestaurants() async {
    var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';
    var restaurantsid =
        '${myServices.sharedPreferences.getInt("restaurants_id")!}';

    statusRequest = StatusRequest.loading;
    update();
    var response = await restaurantsData.getitems(usersId, restaurantsid);
    //print("=============================== response $response ");

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        // Clear the existing items and favoriteIndices list
        items = [];
        items = mapData['data'];

        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        items = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  viewitemsrestaurantsnoauth() async {
    var restaurantsid =
        '${myServices.sharedPreferences.getInt("restaurants_id")!}';

    statusRequest = StatusRequest.loading;
    update();
    var response = await restaurantsData.itemsnoauth(restaurantsid);
    //print("=============================== response $response ");

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        // Clear the existing items and favoriteIndices list
        items = [];
        items = mapData['data'];

        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        items = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }
  @override
  void onInit() async {
    lat = myServices.sharedPreferences.getDouble('lat');
    long = myServices.sharedPreferences.getDouble('long');

    super.onInit();
  }

  @override
  void dispose() {

    super.dispose();
  }
}
