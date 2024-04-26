import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Offers.dart';
import '../../data/datasource/remote/Home/address.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/home.dart';


abstract class HomeController extends GetxController {
  getData();
}

class HomeControllerImp extends HomeController {
  HomeData homeData = HomeData(Get.find());
  OffersData offersData = OffersData(Get.find());
  AddressData addressData = AddressData(Get.find());
  CartData cartData = CartData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  RxInt bottomNavIndex = 4.obs;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  bool _locationSettingsOpened = false;
  RxInt notificationlength = 0.obs;
  var home = true.obs;
  Position? position;
  CameraPosition? KGooglePlex;
  List<Marker> markers = [];
  double? lat;
  double? long;
  String currentLocationName = 'غير معروف';

  List categories = [];
  List items = [];
  List itemstopselling = [];
  List address = [];
  List notifications = [];
  List notificationslength = [];
  List offers = [];
  List searchlist = [];
  List cartitems = [];
  RxInt currentIndex = 0.obs;


  updatecurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }


  void updateisHome(bool value) {
    home.value = value;
    getData();
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



  addToCart(int index, String items_id, String count) async {
    if (myServices.sharedPreferences.getString("token") == null) {
      BuildContext context = Get.context!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
              backgroundColor: Color(0xffFF7A2F),
              content: Text(
                "تمت إضافة المنتجات للسلة !",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
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


  getNotification() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getnotifications(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        notifications = mapData['data'];
        notifications = List.from(notifications.reversed);
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        notifications = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  getsearch(String query) async {
    var response = await homeData.search(
      query,
    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        searchlist = mapData['data'];
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        searchlist = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getdata();
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        categories = mapData['categories']['data'];
        items = mapData['items']['data'];
        getCurrentLocation();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        items =[];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }

  getOffers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await offersData.getoffers();
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        offers = [];
        offers = mapData['data'];
        getData();
        return true;
      } else {
        offers = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }

  @override
  void onInit() async {
    getData();
    getOffers();
    getCurrentLocation();
    getNotification();
    RequestPermissionLocation();
    await Jiffy.setLocale('ar');
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    getOffers();
    getData();
    getCurrentLocation();
    getNotification();
    getCurrentLocation();
    RequestPermissionLocation();
    super.dispose();
  }
}
