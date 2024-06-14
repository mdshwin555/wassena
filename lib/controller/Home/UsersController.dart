import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumyum/view/screen/Home/UsersScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Categories.dart';
import '../../data/datasource/remote/Home/Users.dart';
import '../../view/screen/Home/CategoriesScreen.dart';

abstract class UsersController extends GetxController {}

class UsersControllerImp extends UsersController {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  UsersData usersData = UsersData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  bool isblock=true;
  List users = [];

  void updatenameblock() {
    isblock = !isblock;
    update();
  }

  @override
  viewusers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await usersData.viewusers();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        users = [];
        users = mapData['data'];
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        users = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  blockusers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await usersData.blockusers(
      myServices.sharedPreferences.getString("users_id")!,
      isblock==true ? '1' : '0',
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        // Get.offAll(UsersScreen());
        isblock==false ? Get.snackbar("حظر المستخدم", "تم حظر المستخدم بنجاح"):
        Get.snackbar("رفع القيود عن المستخدم", "تم فك حظر المستخدم بنجاح");
        viewusers();
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل الإرسال", "فشل إرسال الرسالة يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  singleotification() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await usersData.singleotification(
      title.text,
      body.text,
      myServices.sharedPreferences.getString("users_id")!,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        Get.offAll(UsersScreen());
        Get.snackbar("تمت الإرسال", "تم إرسال الرسالة بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل الإرسال", "فشل إرسال الرسالة يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }


  @override
  allotifications() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await usersData.allotifications(
      title.text,
      body.text,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        Get.offAll(UsersScreen());
        Get.snackbar("تمت الإرسال", "تم إرسال الرسالة بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل الإرسال", "فشل إرسال الرسالة يرجى المحاولة مرة أخرى");
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
    viewusers();
    super.onInit();
  }

  @override
  void dispose() {
    viewusers();
    super.dispose();
  }
}
