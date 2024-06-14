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
import 'ItemsController.dart';

abstract class EditItemsController extends GetxController {
  late String items_name;
  late String items_desc;
  late String items_price;
  late String items_discount;
  late String items_subcat;
  late String restaurants_name;
  late String items_image;
  late String restaurants_subcat;
}

class EditItemsControllerImp extends EditItemsController {
  EditItemsControllerImp({
    required String items_name,
    required String items_desc,
    required String items_price,
    required String items_discount,
    required String items_subcat,
    required String restaurants_name,
    required String items_image,
    required String restaurants_subcat,
  }) {
    this.items_name = items_name;
    this.items_desc = items_desc;
    this.items_price = items_price;
    this.items_discount = items_discount;
    this.items_subcat = items_subcat;
    this.restaurants_name = restaurants_name;
    this.items_image = items_image;
    this.restaurants_subcat = restaurants_subcat;
  }


  TextEditingController name = TextEditingController();
  late TextEditingController namerestaurant;
  late TextEditingController subcatrestaurant;
  late TextEditingController subcat;
  late TextEditingController description;
  late TextEditingController price;
  late TextEditingController discount;
  String? imagename;
  ItemsData itemsData = ItemsData(Get.find());
  RestaurantsData restaurantsData = RestaurantsData(Get.find());
  String? updatedCategory;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  File? Imagefiles;
  int? selectedRestaurantIndex;
  List items = [];
  List restaurants = [];
  List restaurantsSubcat = [];
  var isClick = false.obs;
  int index = 0;


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
  void updatedCategories(String value) {
    updatedCategory = value;
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
      Imagefiles = File(image.path);
      // print(Imagefiles);
      update();
    } else {
      Get.defaultDialog(middleText: 'يجب اختيار صورة ');
    }
  }

  @override
  viewItems() async {
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
  void _selectImage() async {
    var imagePicker = ImagePicker();
    var pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      Imagefiles = File(pickedFile.path);
      update();
    }
  }

  @override
  edititems(
      ) async {
    ItemsControllerImp().updateisClick(true);
    update();
    var response = await itemsData.edititems(
  '${myServices.sharedPreferences.getString("items_id")}',
      name.text,
      description.text,
      price.text,
      discount.text,
      selectedRestaurantIndex.toString(),
  '${myServices.sharedPreferences.getString("items_image")}',
      Imagefiles,
    );
    // print("=============================== response $imagename ");
    // print("=============================== response $id ");
    // print("=============================== response $Imagefiles ");
    print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        viewItems();
        Get.offAll(ItemsScreen());
        Get.snackbar("تم التعديل", "تم تعديل الصنف بنجاح");
        statusRequest = StatusRequest.success;
        update();

        return true;
      } else {
        Get.snackbar("فشل التعديل", "فشلت عملية تعديل الصنف يرجى المحاولة مرة أخرى");
        statusRequest = StatusRequest.success;
        update();
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {}
  }

  @override
  deleteitems(
      String id,

      ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await itemsData.deleteitems(
      id,
      imagename!,
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
    name = TextEditingController(text: items_name);
    description = TextEditingController(text: items_desc);
    price = TextEditingController(text: items_price);
    discount = TextEditingController(
      text: items_discount == '0' ? 'لا يوجد' : items_discount,
    );
    namerestaurant = TextEditingController(text: restaurants_name);
    subcat = TextEditingController(text: restaurants_subcat);
    selectedRestaurantIndex = int.parse(items_subcat);
    restaurantsSubcat = restaurants_subcat.split(',');
    imagename = items_image;

    super.onInit();
  }


  @override
  void dispose() {
    viewItems();
    viewrestaurants();
    super.dispose();
  }
}
