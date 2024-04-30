import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/Auth/SignInData.dart';
import '../../data/datasource/remote/Auth/SignUpData.dart';

abstract class SignUpController extends GetxController {
  signUp(BuildContext context);

  signIn(BuildContext context);
}

class SignUpControllerImp extends SignUpController {
  SignUpData signUpData = SignUpData(Get.find());
  SignInData signInData = SignInData(Get.find());
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  MyServices myServices = Get.find();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController code = TextEditingController();
  GlobalKey<FormState> codeformstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  var isClick = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    update();
  }

  void updateisClick(bool value) {
    isClick.value = value;
    update();
  }

  @override
  signUp(BuildContext context) async {
    //print('create account ');
    if (form.currentState!.validate()) {
      updateisClick(true);
      update();
      var response = await signUpData.postdata(
        name.text,
        phone.text,
        '12345678',
        phone.text,
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == true) {
          //print('create account successfully');
          signIn(context);
        } else if (response['status'] == false) {

          signIn(context);
          statusRequest = StatusRequest.none;
          update();
        }
      } else if (statusRequest != StatusRequest.success) {
        statusRequest = handlingData(response);
        if (StatusRequest.failure == statusRequest) {
          if (response['status'] == false) {
            signIn(context);
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
  signIn(BuildContext context) async {
    //print('signin ');
    if (form.currentState!.validate()) {
      updateisClick(true);
      update();
      var response = await signInData.postdata(
        phone.text,
        '12345678',
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == true) {

          BuildContext context = Get.context!;
          AudioPlayer().play(AssetSource('audios/system.mp3'));

          myServices.sharedPreferences
              .setString("token", response['data']['users_password']);
          myServices.sharedPreferences
              .setInt("users_id", response['data']['users_id']);
          myServices.sharedPreferences
              .setString("users_phone", response['data']['users_phone']);
          myServices.sharedPreferences
              .setString("users_name", response['data']['users_name']);

          FirebaseMessaging.instance.subscribeToTopic("users");
          FirebaseMessaging.instance
              .subscribeToTopic("users${response['data']['users_id']}");

          response['data']['users_blocked']==0?Get.offAll(() => MainScreen()):ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " لقد تم حظر حسابك من الوصول الى التطبيق ! ",
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ],
              ),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (response['status'] == false) {
          BuildContext context = Get.context!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " رقم الموبايل أو كلمة المرور خاطئة ! ",
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ],
              ),
              duration: Duration(seconds: 2),
            ),
          );
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
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }
}
