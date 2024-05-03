import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import 'package:yumyum/view/screen/Home/OrdersScreen.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/orders.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

abstract class OrdersController extends GetxController {
  getPinding();

  getOnWay();

  getArchive();
}

class OrdersControllerImp extends OrdersController {
  OrdersData ordersData = OrdersData(Get.find());
  Completer<GoogleMapController>? controllerCompleter;
  CameraPosition? cameraposition;
  String currentLocationName = '';
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController comment = TextEditingController();
  MyServices myServices = Get.find();
  List pinding = [];
  List onway = [];
  List archive = [];
  List details = [];
  Timer? locationUpdateTimer;

  PolylinePoints polylinePoints = PolylinePoints();
  List<Marker> markers = [];
  Set<Polyline> polylineSet = {};
  List<LatLng> polylineco = [];

  double? curlat;
  double? curlong;

  double? restlat;
  double? restlong;

  double? destlat;
  double? destlong;

  String? distance;
  String? duration;

  List<String> ratingImages = [
    AppImageAsset.sad,
    AppImageAsset.notgood,
    AppImageAsset.good,
    AppImageAsset.excellent,
    AppImageAsset.outstanding,
  ];

  RxInt selectedRating = 1.obs;
  RxInt selectedIndex = 0.obs;

  selectTab(int index) {
    selectedIndex.value = index;
    update();
  }


  @override
  getPinding() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getPinding(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    //print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        pinding = mapData['data'];
        pinding = List.from(pinding.reversed);
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        pinding = [];
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
    var response = await ordersData.getOnWay(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    //print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        onway = mapData['data'];
        onway = List.from(onway.reversed);
        statusRequest = StatusRequest.success;
        update();
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
  getArchive() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getArchive(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    //print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        archive = mapData['data'];
        archive = List.from(archive.reversed);
        statusRequest = StatusRequest.success;
        update();
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

  getDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getdetails(
      '${myServices.sharedPreferences.getString("orders_id")!}',
    );
    //print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {

        details = [];
        details = mapData['data'];

        curlat = details[0]['address_lat'];
        curlong = details[0]['address_long'];

        restlat = details[0]['joined_restaurants_lat'];
        restlong = details[0]['joined_restaurants_long'];

        InitialData();
        getPolyline(curlat, curlong, restlat, restlong);
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        details = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  RequestPermissionLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Get.snackbar(
          "تنبيه", "يرجى تشغيل خدمات الموقع لإضافة عنوانك الحالي");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.snackbar(
            "تنبيه", "يرجى تشغيل خدمات الموقع لإضافة عنوانك الحالي");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Get.snackbar("تنبيه",
          "لا يمكن استعمال التطبيق بدون اعطاء صلاحيات الوصول للموقع أثناء استعمال التطبيق");
    }
  }

  getDeliveryLocation() {
    FirebaseFirestore.instance
        .collection("delivery")
        .doc('${details[0]['orders_id']}')
        .snapshots()
        .listen((event) {
      if (event.exists) {
        destlat = event.get("lat");
        destlong = event.get("long");
        duration = event.get("duration");
        distance = event.get("distance");
        updateMarkerDelivery(destlat!, destlong!);
      }
    });
  }

  updateMarkerDelivery(double newlat, double newlong) async {
    Future<Uint8List?> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
          ?.buffer
          .asUint8List();
    }

    final Uint8List? deliverymarker =
        await getBytesFromAsset('assets/images/delvcar2.png', 100);

    markers.removeWhere((element) => element.markerId.value == "dest");
    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(deliverymarker!),
        markerId: MarkerId("dest"),
        position: LatLng(newlat, newlong),
      ),
    );
    /////////////////////////////////////////////
    // getPolyline(curlat, curlong, destlat, destlong);
    //////////////////////////////////////////////////
    update();
  }

  Future<void> getPolyline(lat, long, destlat, destlong) async {
    polylineco.clear(); // Clear previous polyline points

    // Clear previous polylines
    polylineSet.clear();
    var url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$lat,$long&destination=$destlat,$destlong&key=AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs";

    var response = await http.post(Uri.parse(url));

    var responsebody = jsonDecode(response.body);

    var point = responsebody['routes'][0]['overview_polyline']['points'];
    // distance = responsebody['routes'][0]['legs'][0]['distance']
    //     ['text']; // e.g., "1.2 km"
    // duration = responsebody['routes'][0]['legs'][0]['duration']
    //     ['text']; // e.g., "6 mins"
    update();
    List<PointLatLng> result = polylinePoints.decodePolyline(point);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng pointLatLng) {
        polylineco.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
      // distance = responsebody['routes'][0]['legs'][0]['distance']
      //     ['text']; // e.g., "1.2 km"
      // duration = responsebody['routes'][0]['legs'][0]['duration']
      //     ['text']; // e.g., "6 mins"
      update();
    }
    Polyline polyLine = Polyline(
      polylineId: PolylineId("wael"),
      color: AppColor.secondaryColor,
      width: 4,
      points: polylineco,
    );
    polylineSet.add(polyLine);

    getDeliveryLocation();


    update();
  }

  Future<void> InitialData() async {
    Future<Uint8List?> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
          ?.buffer
          .asUint8List();
    }

    final Uint8List? customermarker =
        await getBytesFromAsset('assets/images/homeloc.png', 100);
    final Uint8List? restaurantmarker =
        await getBytesFromAsset('assets/images/restloc.png', 50);
    //final Uint8List? restaurantMarker = await getBytesFromNetworkImage('${AppLink.restaurants_image}/${details[0]['restaurants_logo']}', 1);

    cameraposition = CameraPosition(
      target: LatLng(details[0]['address_lat'], details[0]['address_long']),
      zoom: 15.4746,
    );
    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(customermarker!),
        markerId: MarkerId("current"),
        position: LatLng(details[0]['address_lat'], details[0]['address_long']),
      ),
    );

    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(restaurantmarker!),
        markerId: MarkerId("currentrest"),
        position: LatLng(details[0]['joined_restaurants_lat'],
            details[0]['joined_restaurants_long']),
      ),
    );

  }

  rateorder() async {
    var ordersId = '${details[0]['orders_id']}';

    var response = await ordersData.rateorders(
      ordersId,
      '${selectedRating}',
      '${comment.text}',
    );

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        Get.snackbar("شكراً لتقييمك", "سيتم الرد على حضرتك في أسرع وقت");
        getDetails();
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

  removeorder(String ordersId) async {
    var response = await ordersData.removeorder(
      ordersId,
    );

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        Get.offAll(MainScreen());
        getPinding();
        BuildContext context = Get.context!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.secondaryColor,
            content: Text(
              "تم إلغاء الطلب بنجاح نعتذر على التأخير!",
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

  @override
  void onInit() async {
    getPinding();
    getOnWay();
    getArchive();
    await Jiffy.setLocale('ar');
    locationUpdateTimer;
    super.onInit();
  }

  @override
  void dispose() {
    getPinding();
    getOnWay();
    getArchive();
    locationUpdateTimer?.cancel();
    super.dispose();
  }
}
