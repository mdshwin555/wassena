import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/FavoriteScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imgaeasset.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/favorite.dart';
import '../../data/datasource/remote/Home/items.dart';

abstract class ItemsController extends GetxController {
  getItems();
}

class ItemsControllerImp extends ItemsController {
  ItemsData itemsData = ItemsData(Get.find());
  CartData cartData = CartData(Get.find());
  FavoriteData favoriteData = FavoriteData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  TextEditingController rate = TextEditingController();

  RxInt selectedRating = 1.obs;

  List<String> ratingImages = [
    AppImageAsset.sad,
    AppImageAsset.notgood,
    AppImageAsset.good,
    AppImageAsset.excellent,
    AppImageAsset.outstanding,
  ];

  int itemsid = 0;
  List items = [];
  List favorite = [];

  @override
  getItems() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await itemsData.getdata(
      '${myServices.sharedPreferences.getInt("categoryid")!}',
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );

    //print(response);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        items = [];
        items = mapData['data'];
        statusRequest = StatusRequest.success;
        update();
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

  @override
  getItemsnoauth() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await itemsData.itemsnoauth(
      '${myServices.sharedPreferences.getInt("categoryid")!}',
    );

    //print(response);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        items = [];
        items = mapData['data'];
        statusRequest = StatusRequest.success;
        update();
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

  @override
  addToCart(String items_id, String count) async {
    if (myServices.sharedPreferences.getString("token") == null) {
      BuildContext context = Get.context!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                " ! يجب تسجيل الدخول أولا ",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      statusRequest = StatusRequest.loading;
      update();

      var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';

      for (var i = 0; i < int.parse(count); i++) {
        var response = await cartData.adddata(usersId, items_id);

        if (StatusRequest.success == handlingData(response)) {
          Map mapData = {};
          mapData.addAll(response);
          if (mapData["status"] == true) {
          } else {

          }
        } else if (statusRequest == StatusRequest.offlinefailure) {
          Get.snackbar("فشل", "you are not online please check on it");
        } else if (statusRequest == StatusRequest.serverfailure) {
          // Handle server failure
        }
      }

      // Show Snackbar after the loop completes
      BuildContext context = Get.context!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.secondaryColor,
          content: Text(
            "تمت إضافة المنتجات للسلة !",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'ElMessiri',
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      statusRequest = StatusRequest.success;
      update();
    }
  }

  @override
  addRate(String items_id) async {
    if (myServices.sharedPreferences.getString("token") == null) {
      BuildContext context = Get.context!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                " ! يجب تسجيل الدخول أولا ",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Icon(Icons.logout),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';
      // var itemsId = '${items[index]['items_id']}';

      // Always add the item to the cart
      var response =
          await itemsData.addrate(usersId, items_id, selectedRating.toString());

      if (StatusRequest.success == handlingData(response)) {
        Map mapData = {};
        mapData.addAll(response);

        if (mapData["status"] == true) {
          statusRequest = StatusRequest.success;
          update();
          BuildContext context = Get.context!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.secondaryColor,
              content: Text(
                "تم تقديم تقييمك بنجاح للمنتج. نقدر مشاركتك وتعليقاتك!",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                ),
              ),
              duration: Duration(seconds: 2),
            ),
          );
          getItems();
        } else {
          statusRequest = StatusRequest.success;
          update();
        }
      } else if (statusRequest == StatusRequest.offlinefailure) {
        Get.snackbar("فشل", "you are not online please check on it");
      } else if (statusRequest == StatusRequest.serverfailure) {
        // Handle server failure
      }
    }
  }

  @override
  void onInit() async {
    // myServices.sharedPreferences.getString("users_phone") == null
    //     ? getItemsnoauth()
    //     : getItems();
    super.onInit();
  }

  @override
  void dispose() {
    // myServices.sharedPreferences.getString("users_phone") == null
    //     ? getItemsnoauth()
    //     : getItems();
    super.dispose();
  }
}
