import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumyum/view/screen/Home/ItemsScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/Categories.dart';
import '../../data/datasource/remote/Home/Items.dart';
import '../../data/datasource/remote/Home/Restaurants.dart';
import '../../view/screen/Home/CategoriesScreen.dart';

abstract class ItemsController extends GetxController {}

class ItemsControllerImp extends ItemsController {
  TextEditingController name = TextEditingController();
  late TextEditingController namerestaurant;
  late TextEditingController subcatrestaurant;
  late TextEditingController discount;
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  ItemsData itemsData = ItemsData(Get.find());
  RestaurantsData restaurantsData = RestaurantsData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  File? Imagefile;
  int? selectedRestaurantIndex;
  List items = [];
  List restaurants = [];
  List restaurantsSubcat = [];
  var isClick = false.obs;
  int index = 0;

  void updateisClick(bool value) {
    isClick.value = value;
    update();
  }
  void updatenamerestaurant(String value) {
    namerestaurant.text = value;
    update();
  }
  void updatesubcatrestaurant(String value) {
    subcatrestaurant.text = value;
    update();
  }

  void updateindex(int value) {
    selectedRestaurantIndex = value;
    update();
  }

  void updateindexProduct(int value , String subcatrestaurants) {
    index = value;
    subcatrestaurant.text =subcatrestaurants;
    update();
  }

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
  viewItems() async {
    statusRequest=StatusRequest.loading;
    update();
    var response = await itemsData.viewitems(
      myServices.sharedPreferences.getString("categories_id")!,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        // Clear the existing items and cartIndices list

        items = mapData['data'];
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        items = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  // Assuming 'selectedRestaurantIndex' is already defined and updated elsewhere in your code.

  @override
  viewrestaurants() async {

    var response = await restaurantsData.viewrestaurants(
      myServices.sharedPreferences.getString("categories_id")!,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map<String, dynamic> mapData = response as Map<String, dynamic>; // Ensuring the type is correct.
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

         restaurants = mapData['data']; // Ensure this is treated as a list of dynamic objects.

        if (selectedRestaurantIndex != null && selectedRestaurantIndex! < restaurants.length) {
          String subcategoriesString = restaurants[selectedRestaurantIndex!]['restaurants_subcat'];
          restaurantsSubcat = subcategoriesString.split(',');
          // print(restaurantsSubcat);
        }

        return true;
      } else {
        restaurants = [];
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      Get.snackbar("فشل", "You are not online please check your connection.");
    } else if (statusRequest == StatusRequest.serverfailure) {
      Get.snackbar("فشل", "Server error, please try again later.");
    }
  }

  // @override
  // viewrestaurants() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await restaurantsData.viewrestaurants(
  //     myServices.sharedPreferences.getString("categories_id")!,
  //   );
  //   // print("=============================== response $response ");
  //   if (StatusRequest.success == handlingData(response)) {
  //     Map mapData = {};
  //     mapData.addAll(response);
  //     if (mapData["status"] == true) {
  //       statusRequest = StatusRequest.success;
  //       update();
  //
  //       restaurants = [];
  //       restaurants = mapData['data'];
  //       restaurantsSubcat.addAll(mapData['data']
  //           .where((item) => item["restaurants_subcat"]));
  //       return true;
  //     } else {
  //       restaurants = [];
  //       statusRequest = StatusRequest.success;
  //       update();
  //     }
  //   } else if (statusRequest == StatusRequest.offlinefailure) {
  //     return Get.snackbar("فشل", "you are not online please check on it");
  //   } else if (statusRequest == StatusRequest.serverfailure) {}
  // }

  @override
  additems() async {
    updateisClick(true);
    update();
    var response = await itemsData.additems(
      name.text,
      name.text,
      description.text,
      description.text,
      "100",
      price.text,
      discount.text,
      myServices.sharedPreferences.getString("categories_id")!,
      index.toString(),//////////////
      // selectedRestaurantIndex.
      '${DateTime.now()}',
      myServices.sharedPreferences.getString("restaurants_id")!,
      "0.0",
      "45",
      Imagefile!,


    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        updateisClick(false);
        viewItems();
        Get.offAll(ItemsScreen());
        Get.snackbar("تمت الإضافة", "تمت إضافة الصنف بنجاح");
        statusRequest = StatusRequest.success;
        update();

        return true;
      } else {
        updateisClick(false);
        Get.snackbar("فشلت الإضافة", "فشلت إضافة الصنف يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      updateisClick(false);
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }



  @override
  deleteitems(
      String id,
      String imagename,
      ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await itemsData.deleteitems(
      id,
      imagename,
    );
    // print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        viewItems();
        Get.offAll(ItemsScreen());
        Get.snackbar("تم الحذف", "تم حذف الصنف بنجاح");
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        Get.snackbar("فشل الحذف", "فشلت عملية حذف الصنف يرجى المحاولة مرة أخرى");
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
    viewItems();
    viewrestaurants();
    namerestaurant = TextEditingController(text: 'يرجى إختيار إسم المطعم');
    subcatrestaurant = TextEditingController(text:  'يرجى إختيار القسم');
    discount = TextEditingController(text:  '0');
    updateisClick(false);
    super.onInit();
  }

  @override
  void dispose() {
    viewItems();
    viewrestaurants();
    super.dispose();
  }
}
