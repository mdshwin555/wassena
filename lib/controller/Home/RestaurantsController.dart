import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/favorite.dart';
import '../../data/datasource/remote/Home/restaurants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

abstract class RestaurantsController extends GetxController {
  viewrestaurants();
}

class RestaurantsControllerImp extends RestaurantsController {
  FavoriteData favoriteData = FavoriteData(Get.find());
  CartData cartData = CartData(Get.find());
  RestaurantsData restaurantsData = RestaurantsData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  RxInt selectedIndex = 0.obs;
  Position? position;
  CameraPosition? KGooglePlex;
  List<Marker> markers = [];
  double? lat;
  double? distance  ;
  double? duration  ;
  double? long;
  String currentLocationName = 'غير معروف';
  Set<Polyline> polylineSet = {};
  List<LatLng> polylineco = [];
  PolylinePoints polylinePoints = PolylinePoints();


  selectTab(int index) {
    selectedIndex.value = index;
    update();
  }

  List<int> cartIndices = [];
  List restaurants = [];
  List categories = [];
  List items = [];


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


  String formatTime(String timeStr) {
    TimeOfDay time = TimeOfDay(
      hour: int.parse(timeStr.split(':')[0]),
      minute: int.parse(timeStr.split(':')[1]),
    );

    String formattedHour = '';
    String formattedMinute = '';

    if (time.hour < 12) {
      formattedHour = '${time.hour}';
    } else if (time.hour == 12) {
      formattedHour = '${time.hour}';
    } else {
      formattedHour = '${time.hour - 12}';
    }

    formattedMinute = time.minute.toString().padLeft(2, '0');

    String period = time.hour < 12 ? 'ص' : 'م';

    return '$formattedHour:$formattedMinute $period';
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


  int _compareTimeOfDay(TimeOfDay a, TimeOfDay b) {
    if (a.hour < b.hour) {
      return -1;
    } else if (a.hour > b.hour) {
      return 1;
    } else {
      // Hours are equal, compare minutes
      if (a.minute < b.minute) {
        return -1;
      } else if (a.minute > b.minute) {
        return 1;
      } else {
        // Both hours and minutes are equal
        return 0;
      }
    }
  }

  @override
  viewrestaurants() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await restaurantsData.getdata(
      myServices.sharedPreferences.getInt("categoryid")==null?'4':'${myServices.sharedPreferences.getInt("categoryid")!}',
    );
    //print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        // restaurants = [];
        restaurants = mapData['data'];
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        restaurants = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
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

  addToCart(int index, String items_id,String count) async {
    if (myServices.sharedPreferences.getString("token") == null) {
      BuildContext context = Get.context!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                " ! يجب تسجيل الدخول أولا ",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';
      // var itemsId = '${items[index]['items_id']}';

      // Always add the item to the cart
      var response = await cartData.adddata(usersId, items_id);

      if (StatusRequest.success == handlingData(response)) {
        Map mapData = {};
        mapData.addAll(response);

        if (mapData["status"] == true) {
          statusRequest = StatusRequest.success;
          update();

          BuildContext context = Get.context!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.secondaryColor,
              content: Text(
                "تمت الإضافة للسلة !",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                ),
              ),
              duration: Duration(seconds: 2),
            ),
          );
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
  }

  getcategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await restaurantsData.getcatigories();
    //print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        categories = [];
        categories = mapData['data'];
        return true;
      } else {
        categories = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
    KGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );

    var address = await GeoCode().reverseGeocoding(
      latitude: position!.latitude,
      longitude: position!.longitude,
    );
    lat = position?.latitude;
    long = position?.longitude;
    currentLocationName = address.streetAddress!;
    statusRequest = StatusRequest.success;
    update();
  }

  Future<double> calculateDistance(lat, long, destlat, destlong) async {
    var url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=AIzaSyBZoCY93kss7zkXAN9LW2N5__AhcI02GNw";

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


  @override
  void onInit() async {
    getCurrentLocation();
    viewrestaurants();
    getcategories();
    super.onInit();
  }

  @override
  void dispose() {
    viewrestaurants();
    getcategories();
    getCurrentLocation();
    super.dispose();
  }
}
