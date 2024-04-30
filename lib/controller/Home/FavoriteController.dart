import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/favorite.dart';
import 'ProductDetailsController.dart';

abstract class FavoriteController extends GetxController {
  getData();
}

class FavoriteControllerImp extends FavoriteController {
  FavoriteData favoriteData = FavoriteData(Get.find());
  ProductDetailsControllerImp productDetailsController =
      Get.put(ProductDetailsControllerImp());
  CartData cartData = CartData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  List items = [];

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await favoriteData.getdata(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    //print("=============================== response $response ");
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
    } else if (statusRequest == StatusRequest.serverfailure) {}
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
      var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';

      var response = await cartData.adddata(usersId, items_id);

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

  void removeFromFavorites(String itemsId) async {
    var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';

    var response = await favoriteData.removedata(usersId, itemsId);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        BuildContext context = Get.context!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.secondaryColor,
            content: Text(
              "تمت إزالة العنصر من المفضلة  !",
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
        productDetailsController.updatedisfavfalse(false, itemsId);
        getData();
        update();
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

  @override
  void onInit() async {
    myServices.sharedPreferences.getString("users_phone") == null
        ? null
        : getData();
    super.onInit();
  }

  @override
  void dispose() {
    myServices.sharedPreferences.getString("users_phone") == null
        ? null
        : getData();
    super.dispose();
  }
}
