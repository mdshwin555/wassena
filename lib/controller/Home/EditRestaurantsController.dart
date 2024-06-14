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


abstract class EditRestaurantsController extends GetxController {
  late String res_id;
  late String res_name;
  late String res_type;
  late String res_city;
  late String res_open;
  late String res_close;
  late String res_deliveryprice;
  late String res_isfulltime;
  late String res_subcat;
  late String res_lat;
  late String res_lng;
  late String res_logo;
  late String background_image;
  late String categories_id;
  late String categories_name;
}

class EditRestaurantsControllerImp extends EditRestaurantsController {
  EditRestaurantsControllerImp({
    required String res_id,
    required String res_name,
    required String res_type,
    required String res_city,
    required String res_open,
    required String res_close,
    required String res_deliveryprice,
    required String res_isfulltime,
    required String res_subcat,
    required String res_lat,
    required String res_lng,
    required String res_logo,
    required String background_image,
    required String categories_name,
  }) {
    this.res_name = res_id;
    this.res_name = res_name;
    this.res_type = res_type;
    this.res_city = res_city;
    this.res_open = res_open;
    this.res_close = res_close;
    this.res_deliveryprice = res_deliveryprice;
    this.res_isfulltime = res_isfulltime;
    this.res_subcat = res_subcat;
    this.res_lat = res_lat;
    this.res_lng = res_lng;
    this.res_logo = res_logo;
    this.background_image = background_image;
    this.categories_name = categories_name;

  }

  late TextEditingController name;
  late TextEditingController price;
  late TextEditingController open ;
  late TextEditingController close ;
  late TextEditingController subcat;
  late  TextEditingController city;
  late  TextEditingController typeRes;
  late  TextEditingController rate;
  late  TextEditingController cat;
  RestaurantsData restaurantsData = RestaurantsData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? updatedCategory ;
  File? logo;
  File? background;
  List searchlist = [];
  List restaurants = [];
  List<String> newSubcategories = [];
  List<String> subcategories = [];
  List categories = [];
  bool is24Hours = false ;
  var isClick = false.obs;

  Completer<GoogleMapController>? controllerCompleter;
  List<Marker> markers = [];
  String? currentLocationName;

  double? lat;
  double? long;
  Position? position;
  CameraPosition? KGooglePlex;
  bool _locationSettingsOpened = false;
  String? imageoldlogo;
  String? imageoldbackground;

  void updatecity(String value) {
    city.text = value;
    update();
  }
  void updatedCategories(String value) {
    cat.text = value;
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

  // getCurrentLocation() async {
  //   position = await Geolocator.getCurrentPosition();
  //   KGooglePlex = CameraPosition(
  //     target: LatLng(position!.latitude, position!.longitude),
  //     zoom: 14.4746,
  //   );
  //   addMarkers(LatLng(position!.latitude, position!.longitude));
  //
  //   var address = await GeoCode().reverseGeocoding(
  //     latitude: position!.latitude,
  //     longitude: position!.longitude,
  //   );
  //   currentLocationName = address.streetAddress;
  //   update();
  //
  //   statusRequest = StatusRequest.none;
  //   update();
  // }

  @override
  viewcategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.viewcategories();
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

  void picklogo(ImageSource source) async {
    XFile? logo_pick = await ImagePicker().pickImage(source: source);
    if (logo_pick != null) {
      logo = File(logo_pick.path);
      update();
    } else {
      Get.defaultDialog(middleText: 'يجب اختيار صورة ');
    }
  }
  void pickImage(ImageSource source) async {
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
  editrestaurants(
      String id,
      String imageoldlogo,
      String imageoldbackground,
      ) async {
    updateisClick(true);
    update();
    // print(id);
    // print( name.text);
    // print(  typeRes.text,);
    // print(  open.text,);
    // print(  close.text,);
    // print(  price.text,);
    // print(  lat,);
    // print(  long,);
    // print(  subcategories.toString(),);
    // print(  city.text,);
    // print(  is24Hours,);
    // print(  ',,,,,,,,,,,,,,,,,,,,,,',);
    // print(  res_logo,);
    // print(  background_image,);
    // print(  logo,);
    // print(  background,);
    var response = await restaurantsData.editrestaurants(
      id.toString(),
      name.text,
      typeRes.text,
      is24Hours?'09:00':open.text,
      is24Hours?'12:00':close.text,
      price.text,
      '$lat',
      '$long',
      // subcategories[0].replaceAll('-', ',').toString(),
      subcat.text,
      city.text,
      is24Hours?'1':'0',
      '1',
      res_logo,
      background_image,
      logo,
      background,
    );
    // print("=============================== response $response ");
    // print("=============================== response ${subcat.text} ");
    // print("=============================== response ${subcat.text} ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        updateisClick(false);
        viewrestaurants();
        Get.offAll(RestaurantsScreen());
        Get.snackbar("تمت التعديل", "تمت تعديل المطعم بنجاح");
        statusRequest = StatusRequest.success;
        update();

        return true;
      } else {
        updateisClick(false);
        Get.snackbar("فشلت عملية التعديل", "فشلت  تعديل المطعم يرجى المحاولة مرة أخرى");
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
    // getCurrentLocation();
    controllerCompleter = Completer<GoogleMapController>();
    name = TextEditingController(text: res_name);
    typeRes = TextEditingController(text: res_type);
    rate = TextEditingController(text: '4.5');
    price = TextEditingController(text: res_deliveryprice);
    open = TextEditingController(text: res_open);
    close = TextEditingController(text: res_close);
    subcat = TextEditingController(text: res_subcat.replaceAll(',', '-'));
    city = TextEditingController(text: myServices.sharedPreferences.getString('city'));
    cat = TextEditingController(text: categories_name);
     is24Hours = res_isfulltime =='1'? true: false;
     lat=double.parse(res_lat);
     long=double.parse(res_lng);

    super.onInit();
  }

  @override
  void dispose() {
    RequestPermissionLocation();
    // getCurrentLocation();
    viewcategories();
    viewrestaurants();
    super.dispose();
  }
}
