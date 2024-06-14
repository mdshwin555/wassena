import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumyum/view/screen/Home/RestaurantsScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Categories.dart';
import '../../data/datasource/remote/Home/Restaurants.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;
import 'package:geocode/geocode.dart';

import '../../view/screen/Home/HomeScreen.dart';


abstract class RestaurantsController extends GetxController {}

class RestaurantsControllerImp extends RestaurantsController {
  late TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController open = TextEditingController();
  TextEditingController close = TextEditingController();
  TextEditingController subcat = TextEditingController();
  late  TextEditingController city;
  late  TextEditingController typeRes;
  late  TextEditingController rate;
  RestaurantsData restaurantsData = RestaurantsData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? updatedCategory;
  File? logo;
  File? background;
  List searchlist = [];
  List restaurants = [];
  List categories = [];
  bool is24Hours = false;
  var isClick = false.obs;

  Completer<GoogleMapController>? controllerCompleter;
  List<Marker> markers = [];
  String? currentLocationName;
  double? lat;
  double? long;
  Position? position;
  CameraPosition? KGooglePlex;
  bool _locationSettingsOpened = false;


  void updatecity(String value) {
    city.text = value;
    update();
  }
  void updatedCategories(String value) {
    updatedCategory = value;
    update();
  }
  void updatetypeRes(String value) {
    typeRes.text = value;
    update();
  }
  void updateisClick(bool value) {
    isClick.value = value;
    update();
  }

  addMarkers(LatLng latlng) async {
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"), position: latlng));
    lat = latlng.latitude;
    long = latlng.longitude;
    update();
  }

  void moveCameraTo(LatLng latLng) async {
    final GoogleMapController controller = await controllerCompleter!.future;
    if (controller != null) {
      final newCameraPosition = CameraPosition(target: latLng, zoom: 15.0);
      controller
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }

  @override
  getsearch(String query) async {
    // print('////////////////////////');
    var url = "https://photon.komoot.io/api/?q=$query&limit=5";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      List features = responsebody['features'];

      if (features != null && features.isNotEmpty) {
        statusRequest = StatusRequest.success;
        searchlist = features;
      } else {
        //statusRequest = StatusRequest.error;
        searchlist = [];
      }
    } else {
      //statusRequest = StatusRequest.error;
      searchlist = [];
    }

    update();
  }

  Future<void> RequestPermissionLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && !_locationSettingsOpened) {
      // Location services are not enabled, show dialog to enable location services
      return _showLocationServiceDialog(
          "تنبيه", "يرجى تشغيل خدمات الموقع لإضافة عنوانك الحالي");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permission denied, show dialog to enable location services
        return _showLocationServiceDialog(
            "تنبيه", "يرجى تشغيل خدمات الموقع لإضافة عنوانك الحالي");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, show dialog accordingly
      return _showLocationServiceDialog("تنبيه",
          "لا يمكن استعمال التطبيق بدون اعطاء صلاحيات الوصول للموقع أثناء استعمال التطبيق");
    }
  }

  Future<void> _showLocationServiceDialog(String title, String message) async {
    _locationSettingsOpened = true;
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      // Dialog is not dismissible with a tap on the outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: Text('تشغيل'),
                  onPressed: () {
                    // Open location settings
                    openLocationSettings();
                  },
                ),
                TextButton(
                  child: Text('إلغاء'),
                  onPressed: () {
                    // Open location settings
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
    _locationSettingsOpened = false;
  }

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
    KGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    addMarkers(LatLng(position!.latitude, position!.longitude));

    var address = await GeoCode().reverseGeocoding(
      latitude: position!.latitude,
      longitude: position!.longitude,
    );
    currentLocationName = address.streetAddress;
    update();

    statusRequest = StatusRequest.none;
    update();
  }


  void pickLogo(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      logo = File(image.path);
      // print(logo);
      update();
    } else {
      Get.defaultDialog(middleText: 'يجب اختيار صورة ');
    }
  }

  void pickBackGroundImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      background = File(image.path);
      // print(background);
      update();
    } else {
      Get.defaultDialog(middleText: 'يجب اختيار صورة ');
    }
  }

  @override
  viewcategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.viewcategories();
    // print("=============================== response $response ");
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        // Clear the existing items and cartIndices list

        categories = mapData['data'];
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        categories = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  viewrestaurants() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await restaurantsData.viewrestaurants(
      myServices.sharedPreferences.getString("categoryid")!,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        restaurants = [];
        restaurants = mapData['data'];
        return true;
      } else {
        restaurants = [];
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }

  @override
  addrestaurants() async {
    updateisClick(true);
    update();


    // print( name.text);
    // print(  type.text,);
    // print(  open.text,);
    // print(  close.text,);
    // print(  is24Hours,);
    // print(  price.text,);
    // print(  lat,);
    // print(  long,);
    // print(   updatedCategory.toString(),);
    // print(  city.text,);


    // print(  logo,);
    // print(  background,);

    var response = await restaurantsData.addrestaurants(
      name.text,
      type.text,
      open.text,
      close.text,
      is24Hours?'1':'0',
      price.text,
      '${DateTime.now()}',
      '${myServices.sharedPreferences.getString("categories_id")}',
      rate.text,
      '$lat',
      '$long',
      logo!,
      background!,
      city.text,
      updatedCategory.toString(),
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        updateisClick(false);
        viewrestaurants();
        Get.offAll(RestaurantsScreen());
        Get.snackbar("تمت الإضافة", "تمت إضافة المطعم بنجاح");
        statusRequest = StatusRequest.success;
        update();

        return true;
      } else {
        updateisClick(false);
        Get.snackbar("فشلت الإضافة", "فشلت إضافة الصنف يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      updateisClick(false);
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }

  @override
  deleteresturant(
      String id,
      String logo,
      String background,
      ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.deleteresturant(
      id,
      logo,
      background,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        viewrestaurants();
        Get.offAll(HomeScreen());
        Get.snackbar("تم الحذف", "تم حذف المطعم بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل الحذف", "فشلت عملية حذف المطعم يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }


  void onInit() {
    RequestPermissionLocation();
    viewcategories();
    viewrestaurants();
    getCurrentLocation();
    controllerCompleter = Completer<GoogleMapController>();
    city = TextEditingController(text: 'الزبداني');
    typeRes = TextEditingController(text: 'تصنيف المطعم');
    rate = TextEditingController(text: '4.5');
    super.onInit();
  }

  @override
  void dispose() {
    RequestPermissionLocation();
    getCurrentLocation();
    viewcategories();
    viewrestaurants();
    super.dispose();
  }
}
