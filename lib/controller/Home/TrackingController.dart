import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class TrackingController extends GetxController {
  StreamSubscription<Position>? positionStream;

  getCurrentLocation() {
    // print("open");
    positionStream =
        Geolocator.getPositionStream().listen((Position? position) {
      // print("===============");
      // print(position!.latitude);
      // print(position!.longitude);
      // print("===============");
    });
  }

  void onInit() {
    getCurrentLocation();

    super.onInit();
  }
}
