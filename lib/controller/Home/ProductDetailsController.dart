import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imgaeasset.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/favorite.dart';
import '../../data/datasource/remote/Home/items.dart';

abstract class ProductDetailsController extends GetxController {
  getDetails();
}

class ProductDetailsControllerImp extends ProductDetailsController {
  FavoriteData favoriteData = FavoriteData(Get.find());
  CartData cartData = CartData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  ItemsData itemsData = ItemsData(Get.find());
  MyServices myServices = Get.find();
  List details = [];
  RxInt selectedRating = 1.obs;
  bool? isFavorite ;

  updatedisfavtrue(bool isfav, String itemsid) {
    isFavorite = true;
    myServices.sharedPreferences.setBool("fav$itemsid", true);
    update();
  }

  updatedisfavfalse(bool isfav, String itemsid) {
    isFavorite = false;
    myServices.sharedPreferences.setBool("fav$itemsid", false);
    update();
  }

  List<String> ratingImages = [
    AppImageAsset.sad,
    AppImageAsset.notgood,
    AppImageAsset.good,
    AppImageAsset.excellent,
    AppImageAsset.outstanding,
  ];

  List data = [];
  int dataindex = 0;
  RxInt quantity = 1.obs;

  @override
  plusquantity() {
    quantity.value = quantity.value + 1;
    update();
  }

  @override
  minesquantity() {
    quantity.value > 1 ? quantity.value = quantity.value - 1 : quantity.value;
    update();
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
  getDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    var items_id = '${myServices.sharedPreferences.getString("items_id")!}';
    var response = await itemsData.getdetails(
      items_id,
    );
    //print(response);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        details = mapData['data'];
        isFavorite = myServices.sharedPreferences.getBool('fav${details[0]['items_id']}') ?? false;
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        details = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  addRate(String items_id) async {
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
        myServices.sharedPreferences.setString("ratingitems_id", "${items_id}");
        BuildContext context = Get.context!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.secondaryColor,
            content: Text(
              "تم تقديم تقييمك بنجاح للمنتج. نقدر مشاركتك وتعليقاتك!",
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
        BuildContext context = Get.context!;
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.secondaryColor,
          content: Text(
            "لقد قمت بتقييم هذا المنتج بالفعل",
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
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  removeFromFav(String itemsId) async {
    var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';

    var response = await favoriteData.removedata(usersId, itemsId);

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
        updatedisfavfalse(false, itemsId);
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
  addToFav(String itemsId) async {
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

      // If the item is not a favorite, add it
      var response = await favoriteData.adddata(usersId, itemsId);

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
                "تمت إضافة العنصر إلى المفضلة  !",
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
          updatedisfavtrue(true, itemsId);
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
    getDetails();
    super.onInit();
  }

  @override
  void dispose() {
    getDetails();
    super.dispose();
  }
}
