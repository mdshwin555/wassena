import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumyum/view/screen/Home/HomeScreen.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Auth/SignInData.dart';

abstract class SignInController extends GetxController {

  signIn(BuildContext context);
}

class SignInControllerImp extends SignInController {
  SignInData signInData = SignInData(Get.find());
  late TextEditingController name;
  late TextEditingController password;
  MyServices myServices = Get.find();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  var isClick = false.obs;
  var isPasswordVisible = false.obs;

  void updateisClick(bool value) {
    isClick.value = value;
    update();
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    update();
  }

  @override
  signIn(BuildContext context) async {
    if (form.currentState!.validate()) {
      updateisClick(true);
      update();
      var response = await signInData.postdata(
        name.text,
        '123456787654321',
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == true) {
          // print('Login successfully');

          myServices.sharedPreferences.setString("token", response['data']['admin_password']);
          myServices.sharedPreferences.setInt("delivery_id", response['data']['admin_id']);
          myServices.sharedPreferences.setString("delivery_phone",response['data']['admin_phone']);


          // FirebaseMessaging.instance.subscribeToTopic("delivery");
          // FirebaseMessaging.instance
          //     .subscribeToTopic("delivery${response['data']['delivery_id']}");

          Get.offAll(() => HomeScreen());
        } else if (response['status'] == false) {
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
    name = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    super.dispose();
  }
}
