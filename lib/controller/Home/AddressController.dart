import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yumyum/core/class/statusrequest.dart';
import '../../core/services/services.dart';

class AddressController extends GetxController {

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;





  @override
  void onInit() {

    super.onInit();
  }
}
