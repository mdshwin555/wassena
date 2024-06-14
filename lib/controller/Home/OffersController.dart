import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumyum/view/screen/Home/OffersScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Offers.dart';

abstract class OffersController extends GetxController {}

class OffersControllerImp extends OffersController {
  OffersData offersData = OffersData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  File? Imagefile;
  late  TextEditingController city;
  List offers = [];
  var isClick = false.obs;

  void updatecity(String value) {
    city.text = value;
    update();
  }

  void pickImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Imagefile = File(image.path);
      update();
    } else {
      Get.defaultDialog(middleText: 'يجب اختيار صورة ');
    }
  }

  viewoffers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await offersData.viewoffers();
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        offers = mapData['data'];
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        offers = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  void updateisClick(bool value) {
    isClick.value = value;
    update();
  }

  addoffers() async {
    updateisClick(true);
    update();
    var response = await offersData.addoffers(
      Imagefile!,
       city.text
    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {

        viewoffers();
        Get.offAll(OffersScreen());
        Get.snackbar("تمت الإضافة", "تمت إضافة الإعلان بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشلت الإضافة", "فشلت إضافة الإعلان يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }


  deleteoffers(
    String offers_id,
    String offers_image,
  ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await offersData.deleteoffers(
      offers_id,
      offers_image,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        viewoffers();
        Get.offAll(OffersScreen());
        Get.snackbar("تم الحذف", "تم حذف الإعلان بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل الحذف", "فشلت عملية حذف الإعلان يرجى المحاولة مرة أخرى");
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
    viewoffers();
    city = TextEditingController(text: 'الزبداني');
    super.onInit();
  }

  @override
  void dispose() {
    viewoffers();
    super.dispose();
  }
}
