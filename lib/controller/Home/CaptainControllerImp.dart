import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumyum/view/screen/Home/RestaurantsScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Auth/CaptainData.dart';
import '../../data/datasource/remote/Home/Categories.dart';
import '../../data/datasource/remote/Home/Restaurants.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;
import 'package:geocode/geocode.dart';

import '../../view/screen/Home/HomeScreen.dart';


abstract class CaptainController extends GetxController {}

class CaptainControllerImp extends CaptainController {
  TextEditingController  name= TextEditingController();
  TextEditingController  phone= TextEditingController();
  TextEditingController password = TextEditingController();

  CaptainUpData captainUpData = CaptainUpData(Get.find());
  GlobalKey<FormState> form = GlobalKey<FormState>();
  RestaurantsData restaurantsData = RestaurantsData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  var isClick = false.obs;
  List captains = [];
  List online_captains = [];

  void updateisClick(bool value) {
    isClick.value = value;
    update();
  }

  @override
  viewcaptains() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await captainUpData.viewcaptains();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        captains = [];
        captains = mapData['data'];
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        captains = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  viewonlinecaptains() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await captainUpData.viewonlinecaptains();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        online_captains = [];
        online_captains = mapData['data'];
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        online_captains = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  addCaptain(BuildContext context) async {
    //// print('create account ');
    if (form.currentState!.validate()) {
      updateisClick(true);
      update();
      var response = await captainUpData.postdata(
        name.text,
        phone.text,
        password.text,
        phone.text,
      );
      // print(response);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == true) {
          updateisClick(false);
          Get.offAll(HomeScreen());
          Get.snackbar("تمت إضافة الكابتن  ${name.text}", "تمت العملية بنجاح 👌🛵");
        } else if (response['status'] == false) {
          updateisClick(false);
          Get.snackbar("فشل", "you are not online please check on it");
          statusRequest = StatusRequest.none;
          update();
        }
      } else if (statusRequest != StatusRequest.success) {
        updateisClick(false);
        statusRequest = handlingData(response);
        if (StatusRequest.failure == statusRequest) {
          if (response['status'] == false) {
            Get.snackbar("فشل", "you are not online please check on it");
            statusRequest = StatusRequest.none;
            update();
          }
        }
      }
      updateisClick(false);
      update();
    } else {
      Get.snackbar("فشل", "you are not online please check on it");
      statusRequest = StatusRequest.none;
      update();
      updateisClick(false);}
  }

  makeCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunch('$uri')) {
      await launch('$uri');
    } else {
      throw 'Could not launch $uri';
    }
  }

  void onInit() {
    viewcaptains();
    viewonlinecaptains();
    super.onInit();
  }

  @override
  void dispose() {

    super.dispose();
  }
}
