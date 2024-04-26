import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yumyum/core/class/statusrequest.dart';
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
  Color buttonColor = Color(0xffFF7A2F);

  bool isMarkerWithinCircle(LatLng markerPosition) {
    LatLng circleCenter = LatLng(35.955069, 39.011858);
    double distance = Geolocator.distanceBetween(
        markerPosition.latitude,
        markerPosition.longitude,
        circleCenter.latitude,
        circleCenter.longitude);
    return distance <= 2600;
  }

  void setButtonColor(Color color) {
    if (color == Color(0xffFF7A2F)) {
      buttonColor = Color(0xffFF7A2F);
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
    if (isMarkerWithinCircle(latLng)) {
      setButtonColor(Color(0xffFF7A2F));
    } else {
      setButtonColor(Colors.grey);
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
