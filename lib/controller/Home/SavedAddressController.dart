import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/FavoriteScreen.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Home/address.dart';
import '../../data/datasource/remote/Home/cart.dart';
import '../../data/datasource/remote/Home/favorite.dart';
import '../../data/datasource/remote/Home/items.dart';

abstract class SavedAddressController extends GetxController {
  getAddress();
}

class SavedAddressControllerImp extends SavedAddressController {
  AddressData addressData = AddressData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  List address = [];

  @override
  getAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressData.getdata(
      '${myServices.sharedPreferences.getInt("users_id")!}',
    );
    //print("=============================== response $response ");
    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);
      if (mapData["status"] == true) {
        statusRequest = StatusRequest.success;
        update();

        // Clear the existing items and cartIndices list

        address = mapData['data'];
        address = List.from(address.reversed);
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
  removeAddress(int addressid) async {
    var response = await addressData.removedata('${addressid}');

    if (StatusRequest.success == handlingData(response)) {
      Map mapData = {};
      mapData.addAll(response);

      if (mapData["status"] == true) {
        getAddress();
        statusRequest = StatusRequest.success;
        update();
        BuildContext context = Get.context!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xffFF7A2F),
            content: Text(
              "تمت إزالة الموقع !",
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
      } else {
        getAddress();
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
    getAddress();
    super.onInit();
  }

  @override
  void dispose() {
    getAddress();
    super.dispose();
  }
}
