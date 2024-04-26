import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/OrdersDetailsScreen.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/imgaeasset.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/address.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/coupon.dart';
import '../../data/datasource/remote/Home/orders.dart';
import 'HomeController.dart';

abstract class CartController extends GetxController {
  getItems();

  checkcoupon();
}

class CartControllerImp extends CartController {
  AddressData addressData = AddressData(Get.find());
  HomeControllerImp homeController = Get.put(HomeControllerImp());
  CartData cartData = CartData(Get.find());
  OrdersData ordersData = OrdersData(Get.find());
  CouponData couponData = CouponData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  TextEditingController coupon = TextEditingController();
  TextEditingController description = TextEditingController();
  String currentLocationName = 'غير معروف';

  List items = [];
  List details = [];
  List address = [];
  double totalprice = 0;
  double deliveryprice = 0;
  List coupondata = [];
  List checkoutdata = [];
  Position? position;
  CameraPosition? KGooglePlex;

  @override
  getItems() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartData.getdata(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData['datacart']["status"] == true) {
        items = [];
        items = mapData['datacart']['data'];
        totalprice = 0;
        deliveryprice = 0;
        for (var item in items) {
          var discountedPrice = item['itemsprice'] -
              (item['itemsprice'] * item['items_discount'] / 100);
          item['totalItemPrice'] = discountedPrice;

          totalprice += discountedPrice;
        }
        totalprice =
            myServices.sharedPreferences.getString("coupon_discount") == null
                ? totalprice
                : totalprice -
                    (totalprice *
                        int.parse(myServices.sharedPreferences
                            .getString("coupon_discount")!) /
                        100);

        double degreesToRadians(double degrees) {
          return degrees * pi / 180;
        }

        // in km
        double calculateDistance(
            double startLat, double startLng, double endLat, double endLng) {
          const radius = 6371; // Earth's radius in kilometers

          // Convert degrees to radians
          final startLatRad = degreesToRadians(startLat);
          final endLatRad = degreesToRadians(endLat);
          final deltaLatRad = degreesToRadians(endLat - startLat);
          final deltaLngRad = degreesToRadians(endLng - startLng);

          // Calculate the Haversine formula
          final a = pow(sin(deltaLatRad / 2), 2) +
              cos(startLatRad) * cos(endLatRad) * pow(sin(deltaLngRad / 2), 2);
          final c = 2 * atan2(sqrt(a), sqrt(1 - a));
          final distance = radius * c;

          return distance;
        }

        double distance = calculateDistance(
            homeController.lat == null ? 33.555555 : homeController.lat!,
            homeController.long == null ? 33.55555 : homeController.long!,
            items[0]['restaurants_lat'],
            items[0]['restaurants_long']);

        deliveryprice =double.parse((((distance * 2000) / 500).round() * 500).toStringAsFixed(0));
        //     double.parse('${items[0]['restaurants_deliveryprice']}');
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
  checkcoupon() async {
    statusRequest = StatusRequest.loading;
    update();

    String? appliedCoupon =
        myServices.sharedPreferences.getString("coupon_name");

    if (appliedCoupon != null && appliedCoupon == coupon.text) {
      statusRequest = StatusRequest.success;
      update();
      Get.snackbar('فشل', 'الكوبون مستخدم بالفعل');
      return;
    } else {
      var response = await couponData.checkcoupon(coupon.text);
      if (StatusRequest.success == handlingData(response)) {
        Map mapData = {};
        mapData.addAll(response);

        if (mapData["status"] == true) {
          statusRequest = StatusRequest.success;
          update();
          coupondata = mapData['data'][0];
          totalprice =
              totalprice - totalprice * coupondata[0]['coupon_discount'] / 100;
          myServices.sharedPreferences
              .setString("coupon_name", "${coupondata[0]['coupon_name']}");
          myServices.sharedPreferences
              .setString("coupon_id", "${coupondata[0]['coupon_id']}");
          myServices.sharedPreferences.setString(
              "coupon_discount", "${coupondata[0]['coupon_discount']}");
          update();
          Get.snackbar('تهانينا',
              ' % لقد حصلت على خصم ${coupondata[0]['coupon_discount']}');
        } else {
          Get.snackbar("لللأسف", "لقد انتهت صلاحية هذا الكوبون");
          statusRequest = StatusRequest.success;
          update();
        }
      } else if (statusRequest == StatusRequest.offlinefailure) {
        Get.snackbar("فشل", "you are not online please check on it");
      } else if (statusRequest == StatusRequest.serverfailure) {}
    }
  }

  getDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ordersData.getdetails(
      '${myServices.sharedPreferences.getString("orders_id")!}',
    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
        details = mapData['data'];
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

  checkout(BuildContext context) async {
    statusRequest = StatusRequest.loading;
    update();
    var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';
    var addressid = '${myServices.sharedPreferences.getInt("addressid")!}';
    var coupon_id =
        '${myServices.sharedPreferences.getString("coupon_id") ?? "0"}';
    var coupon_discount =
        '${myServices.sharedPreferences.getString("coupon_discount") ?? "0"}';

    var response = await ordersData.checkout(
        usersId,
        addressid,
        '0',
        "${deliveryprice}",
        "${totalprice}",
        "${coupon_id}",
        '0',
        "${coupon_discount}",
        "0",
        "none",
        description.text,
        '${DateTime.now()}');

    if (StatusRequest.success == handlingData(response)) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(response);

      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        var data = mapData['data'];
        if (data is Map<String, dynamic> && data.containsKey('cart_orders')) {
          //checkoutdata = data['cart_orders'];
          description.text = '';
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                width: 90.w,
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        AppImageAsset.ordersuccssecful,
                        height: 25.h,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'تم الطلب بنجاح',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'رقم طلبكم هو : ${data['cart_orders']}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black26,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 6.h,
                        width: 75.w,
                        child: ElevatedButton(
                          onPressed: () {
                            myServices.sharedPreferences.setString(
                                "orders_id", "${data['cart_orders']}");
                            getDetails();
                            Get.off(OrdersDetails());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFF7A2F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'تتبع الطلب',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () {
                          Get.offAll(MainScreen());
                          getItems();
                        },
                        child: Text(
                          'الرجوع',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.orange,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          myServices.sharedPreferences.remove("addressid");
          myServices.sharedPreferences.remove("activeAddress");

          myServices.sharedPreferences.remove("coupon_discount");
        } else {
          statusRequest = StatusRequest.loading;
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
  addToCart(String itemsId, String count) async {
    var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';

    var response = await cartData.adddata(usersId, itemsId);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;

        update();
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

  @override
  removeFromCart(String itemsId) async {
    var usersId = '${myServices.sharedPreferences.getInt("users_id")!}';

    // Remove the item from the cart
    var response = await cartData.removedata(usersId, itemsId);

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();
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

  @override
  getAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressData.getdata(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        address = mapData['data'];
        address = List.from(address.reversed);
        statusRequest = StatusRequest.success;
        update();
        return true;
      } else {
        statusRequest = StatusRequest.success;
        update();
        address = [];
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      return Get.snackbar("فشل", "you are not online please check on it");
    } else if (statusRequest == StatusRequest.serverfailure) {
      // Handle server failure
    }
  }

  @override
  void onInit() async {
    getAddress();
    getItems();
    super.onInit();
  }

  @override
  void dispose() {
    getAddress();
    getItems();
    super.dispose();
  }
}
