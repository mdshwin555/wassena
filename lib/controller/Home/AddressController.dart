import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yumyum/core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/address.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class AddressController extends GetxController {
  AddressData addressData = AddressData(Get.find());

  MyServices myServices = Get.find();
  TextEditingController nameaddress = TextEditingController();
  TextEditingController phone = TextEditingController();
  List searchlist = [];

  StatusRequest statusRequest = StatusRequest.loading;

  Completer<GoogleMapController>? controllerCompleter;
  CameraPosition? KGooglePlex;
  List<Marker> markers = [];
  String? currentLocationName;
  double? lat;
  double? long;
  Position? position;
  Color buttonColor = AppColor.secondaryColor;


///////Al Zabadani////////////
  List<LatLng> getZabadaniPolygonPoints() {
    return [
      LatLng(33.757386, 36.161074),
      LatLng(33.736760, 36.144079),
      LatLng(33.722127, 36.139444),
      LatLng(33.713417, 36.122707),
      LatLng(33.698027, 36.110175),
      LatLng(33.688431, 36.106909),
      LatLng(33.662948, 36.090782),
      LatLng(33.641291, 36.067796),
      LatLng(33.634428, 36.027866),
      LatLng(33.635390, 36.010905),

      LatLng(33.642540, 36.005131),
      LatLng(33.652763, 36.012648),

      LatLng(33.660436, 36.024096),
      LatLng(33.706110, 36.058771),
      LatLng(33.718104, 36.075508),
      LatLng(33.725814, 36.077482 ),
      LatLng(33.730883, 36.083147),
      LatLng(33.737093, 36.089499),
      LatLng(33.739305, 36.102717),
      LatLng(33.748583, 36.111042),
      LatLng(33.772631, 36.124518),
      LatLng(33.800237, 36.145031),
      LatLng(33.810436, 36.147692),
      LatLng(33.815856, 36.154215),
      LatLng(33.820847, 36.157648),
      LatLng(33.816426, 36.164515),
      LatLng(33.811292, 36.165030),
      LatLng(33.807940, 36.159451),
      LatLng(33.800166, 36.154558),
      LatLng(33.779480, 36.148207),
      LatLng(33.765781, 36.138594),
      LatLng(33.741090, 36.122372),
      LatLng(33.735237, 36.116020),
    ];
  }
  bool isMarkerInsidePolygon(LatLng markerPosition, List<LatLng> polygonPoints) {
    bool isInside = false;
    int count = 0;
    for (int i = 0; i < polygonPoints.length; i++) {
      LatLng vertex1 = polygonPoints[i];
      LatLng vertex2 = polygonPoints[(i + 1) % polygonPoints.length];
      if (_isIntersect(markerPosition, vertex1, vertex2)) {
        count++;
      }
    }
    if (count % 2 == 1) {
      isInside = true;
    }
    return isInside;
  }
  bool _isIntersect(LatLng markerPosition, LatLng vertex1, LatLng vertex2) {
    if (markerPosition.longitude < min(vertex1.longitude, vertex2.longitude) ||
        markerPosition.longitude >= max(vertex1.longitude, vertex2.longitude) ||
        markerPosition.latitude <= min(vertex1.latitude, vertex2.latitude) ||
        vertex1.latitude == vertex2.latitude) {
      return false;
    }
    double slope = (vertex2.longitude - vertex1.longitude) / (vertex2.latitude - vertex1.latitude);
    double intersectionLongitude = vertex1.longitude + (markerPosition.latitude - vertex1.latitude) * slope;
    return intersectionLongitude >= markerPosition.longitude;
  }
  bool isMarkerRawda(LatLng markerPosition) {

    LatLng circleCenter = LatLng(33.652484, 36.021059);

    double distance = Geolocator.distanceBetween(
        markerPosition.latitude,
        markerPosition.longitude,
        circleCenter.latitude,
        circleCenter.longitude);

    return distance <= 2400;
  }
  ///////Damascus////////////
  List<LatLng> getDamascusPolygonPoints() {
    return [
      LatLng(33.522333, 36.196382),
      LatLng(33.502868, 36.219728),
      LatLng(33.502868, 36.219728),
      LatLng(33.482813, 36.240933),
      LatLng(33.467222, 36.255428),
      LatLng(33.468808, 36.270264),
      LatLng(33.451084, 36.300257),
      LatLng(33.464430, 36.322502),
      LatLng(33.487154, 36.324001),
      LatLng(33.473812, 36.360243),

      LatLng(33.495075, 36.363742),
      LatLng(33.546126, 36.348996),

      LatLng(33.563622, 36.319253),
      LatLng(33.547376, 36.299007),
      LatLng(33.540501, 36.279012),
      LatLng(33.544251, 36.260017),
      LatLng(33.562165, 36.234523),
      LatLng(33.560290, 36.232523),
      LatLng(33.550084, 36.221776),
      LatLng(33.542168, 36.226525),
      LatLng(33.530085, 36.201780),
      LatLng(33.522333, 36.196382),
    ];
  }
////////////////************

  void setButtonColor(Color color) {
    if (color == AppColor.secondaryColor) {
      buttonColor = AppColor.secondaryColor;
      update();
    } else {
      buttonColor = Colors.grey;
      update();
    }
    update();
  }

  addAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';

    // Always add the item to the cart
    var response = await addressData.adddata(
      usersId,
      '${nameaddress.text}',
      '${phone.text}',
      '${currentLocationName}',
      '${lat}',
      '${long}',
    );

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        Get.snackbar("تمت الإضافة", "تمت إضافة العنوان بنجاح");
        statusRequest = StatusRequest.success;
        update();
      } else {
        statusRequest = StatusRequest.loading;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  getsearch(String query) async {
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
      searchlist = [];
    }

    update();
  }

  Future<void> addMarkers(LatLng latlng) async {
    statusRequest = StatusRequest.loading;
    update();

    Future<Uint8List?> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      Uint8List bytes = data.buffer.asUint8List();
      ui.Codec codec =
          await ui.instantiateImageCodec(bytes, targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
          ?.buffer
          .asUint8List();
    }

    try {
      final Uint8List? customermarker =
          await getBytesFromAsset('assets/images/marker3.png', 150);

      markers.clear();
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(customermarker!),
        markerId: MarkerId("1"),
        position: LatLng(latlng.latitude - 0.0010, latlng.longitude),
      ));

      lat = latlng.latitude;
      long = latlng.longitude;

      var address = await GeoCode().reverseGeocoding(
        latitude: latlng.latitude,
        longitude: latlng.longitude,
      );
      currentLocationName = '';
      currentLocationName = address.streetAddress;
      statusRequest = StatusRequest.success;
      update();
    } catch (e) {
      print('Error adding markers: $e');
      // Handle error here, e.g., show a dialog to the user
    }
  }

  void moveCameraTo(LatLng latLng) async {
    final GoogleMapController controller = await controllerCompleter!.future;
    if (controller != null) {
      final newCameraPosition = CameraPosition(target: latLng, zoom: 15.0);
      controller
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
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
    lat = position!.latitude;
    long = position!.longitude;
    LatLng latLng = LatLng(lat!, long!);
    addMarkers(latLng);
    moveCameraTo(latLng);
     if(myServices.sharedPreferences.getString('users_city')=='الزبداني'){
       if (isMarkerInsidePolygon(latLng, getZabadaniPolygonPoints()) || isMarkerRawda(latLng)==true) {
         setButtonColor(AppColor.secondaryColor);
       } else {
         setButtonColor(Colors.grey);
       }
     }else{
       if (isMarkerInsidePolygon(latLng, getDamascusPolygonPoints())) {
         setButtonColor(AppColor.secondaryColor);
       } else {
         setButtonColor(Colors.grey);
       }
     }
    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void onInit() {
    getCurrentLocation();
    controllerCompleter = Completer<GoogleMapController>();
    super.onInit();
  }
}
