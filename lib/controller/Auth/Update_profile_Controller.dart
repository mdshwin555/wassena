import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/color.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Auth/SignInData.dart';
import '../../data/datasource/remote/Auth/SignUpData.dart';
import '../../data/datasource/remote/Auth/UpdateProfileData.dart';
import '../../view/screen/Auth/user_info.dart';

abstract class UpdateProfileController extends GetxController {

}

class UpdateProfileControllerImp extends UpdateProfileController {
  UpdateProfileData updateProfileData = UpdateProfileData(Get.find());
  MyServices myServices = Get.find();

   late  TextEditingController phone;
   late  TextEditingController name;
   late  TextEditingController gender;
   late  TextEditingController city;
  var isClick = false.obs;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  void updateisClick(bool value) {
    isClick.value = value;
    update();
  }

  void updategender(String value) {
    gender.text = value;
    update();
  }
  void updatecity(String value) {
    city.text = value;
    update();
  }

  @override
  update_profile(BuildContext context) async {
    statusRequest=StatusRequest.loading;
    if (form.currentState!.validate()) {
      updateisClick(true);
      update();
      var response = await updateProfileData.updatedata(
        myServices.sharedPreferences.getInt("users_id").toString(),
        name.text,
        city.text,
        gender.text,
      );
      print(response);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == true) {

          AudioPlayer().play(AssetSource('audios/system.mp3'));


          myServices.sharedPreferences
              .setString("users_name", name.text);
          myServices.sharedPreferences
              .setString("users_city", city.text);
          myServices.sharedPreferences
              .setString("users_gender", gender.text);
          Get.offAll(MainScreen());

        } else if (response['status'] == false) {
          myServices.sharedPreferences
              .setString("users_name", name.text);
          myServices.sharedPreferences
              .setString("users_city", city.text);
          myServices.sharedPreferences
              .setString("users_gender", gender.text);
          Get.offAll(MainScreen());
          statusRequest = StatusRequest.none;
          update();
        }
      } else if (statusRequest != StatusRequest.success) {
        statusRequest = handlingData(response);
        if (StatusRequest.failure == statusRequest) {
          if (response['status'] == false) {

            statusRequest = StatusRequest.none;
            update();
          }
        }
      }
      updateisClick(false);
      update();
    } else {}
  }

  @override
  void onInit() {
    phone = TextEditingController(text:  myServices.sharedPreferences
        .getString("users_phone")!);
    name = TextEditingController(text:  myServices.sharedPreferences.getString('users_name'));
    gender = TextEditingController(text:  myServices.sharedPreferences.getString('users_gender'));
    city = TextEditingController(text: myServices.sharedPreferences.getString('users_city'));
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }
}
