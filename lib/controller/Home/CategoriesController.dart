import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Categories.dart';
import '../../view/screen/Home/CategoriesScreen.dart';

abstract class CategoriesController extends GetxController {
}

class CategoriesControllerImp extends CategoriesController {

  late TextEditingController name = TextEditingController();
  CategoriesData categoriesData = CategoriesData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  File? Imagefile;

  List categories = [];

  void pickImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Imagefile = File(image.path);
      // print(Imagefile);
      update();
    } else {
      Get.defaultDialog(middleText: 'يجب اختيار صورة ');
    }
  }

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

  @override
  addcategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.addcategories(
      name.text,
      name.text,
      Imagefile!,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        viewcategories();
        Get.offAll(CategoriesScreen());
        Get.snackbar("تمت الإضافة", "تمت إضافة النوع بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشلت الإضافة", "فشلت إضافة النوع يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }


  void updatename(String value) {
    name.text = value;
    update();
  }

  @override
  editcategories(
    String id,
    String imagename,
  ) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await categoriesData.editcategories(
      id,
      name.text,
      name.text,
      imagename,
      Imagefile,
    );

    // print("=============================== response $response ");

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        viewcategories();
        Get.offAll(CategoriesScreen());
        Get.snackbar("تم التعديل", "تم تعديل النوع بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar(
            "فشل التعديل", "فشلت عملية تعديل النوع يرجى المحاولة مرة أخرى");
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
  deletecategories(
    String id,
    String imagename,
  ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.deletecategories(
      id,
      imagename,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        viewcategories();
        Get.offAll(CategoriesScreen());
        Get.snackbar("تم الحذف", "تم حذف النوع بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل الذف", "فشلت عملية حذف النوع يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  // @override
  // getAccepted() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.getaccepted(
  //     '${myServices.sharedPreferences.getInt("delivery_id")!}',
  //   );
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       // Clear the existing items and cartIndices list
  //
  //       accepted = mapData['data'];
  //       accepted = List.from(accepted.reversed);
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //       accepted = [];
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }
  //
  // @override
  // getArchive() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.getarchive(
  //     '${myServices.sharedPreferences.getInt("delivery_id")!}',
  //   );
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       // Clear the existing items and cartIndices list
  //
  //       archive = mapData['data'];
  //       archive = List.from(archive.reversed);
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //       archive = [];
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }
  //

  // @override
  // done(String ordersid, String usersid) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await ordersData.done(
  //     ordersid,
  //     usersid,
  //   );
  //   getCurrentLocation();
  //   Get.put(TrackingController());
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       getAccepted();
  //       totalOrders += 1;
  //
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       return true;
  //     } else {
  //       statusRequest = StatusRequest.success;
  //       update();
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {
  //     // Handle server failure
  //   }
  // }

  void onInit() {
    viewcategories();
    super.onInit();
  }

  @override
  void dispose() {
    viewcategories();
    super.dispose();
  }
}
