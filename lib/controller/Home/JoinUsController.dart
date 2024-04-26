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
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/orders.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

abstract class JoinUsController extends GetxController {

}

class JoinUsControllerImp extends JoinUsController {
  //JoinUsData joinUsData = JoinUsData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  MyServices myServices = Get.find();


  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
