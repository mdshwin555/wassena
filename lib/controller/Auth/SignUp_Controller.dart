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

abstract class SignUpController extends GetxController {
  signUp(BuildContext context);

  signIn(BuildContext context);
}

class SignUpControllerImp extends SignUpController {
  SignUpData signUpData = SignUpData(Get.find());
  SignInData signInData = SignInData(Get.find());
  UpdateProfileData updateProfileData = UpdateProfileData(Get.find());
  MyServices myServices = Get.find();

   late  TextEditingController phone;
   late  TextEditingController name;
   late  TextEditingController gender;
   late  TextEditingController city;
  TextEditingController password = TextEditingController();
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

  void updategender(String value) {
    gender.text = value;
    update();
  }
  void updatecity(String value) {
    city.text = value;
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
        myServices.sharedPreferences
            .getString("phone").toString(),
        '12345678',
        myServices.sharedPreferences
            .getString("phone").toString(),
        gender.text,
        city.text,
      );
      print(response);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == true) {

         signInAfterSignUp(context);

        } else if (response['status'] == false) {


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

          myServices.sharedPreferences
              .setString("token", response['data']['users_password']);
          myServices.sharedPreferences
              .setInt("users_id", response['data']['users_id']);
          myServices.sharedPreferences
              .setString("users_phone", response['data']['users_phone']);
          myServices.sharedPreferences
              .setString("users_name", response['data']['users_name']);
          myServices.sharedPreferences
              .setString("users_city", response['data']['users_city']);
          myServices.sharedPreferences
              .setString("users_gender", response['data']['users_gender']);
          myServices.sharedPreferences
              .setBool("isExist", true);

          FirebaseMessaging.instance.subscribeToTopic("users");
          FirebaseMessaging.instance
              .subscribeToTopic("users${response['data']['users_id']}");

          response['data']['users_blocked']==0? Get.offAll(() => InfoUserScreen(

          )):ScaffoldMessenger.of(context).showSnackBar(
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

          myServices.sharedPreferences
              .setBool("isExist", false);
          myServices.sharedPreferences
              .setString("phone", phone.text);
          Get.offAll(() => InfoUserScreen(
          
          ));
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
  signInAfterSignUp(BuildContext context) async {


      var response = await signInData.postdata(
        myServices.sharedPreferences.getString('phone').toString(),
        '12345678',
      );
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == true) {

          AudioPlayer().play(AssetSource('audios/system.mp3'));
          myServices.sharedPreferences
              .setString("token", response['data']['users_password']);
          myServices.sharedPreferences
              .setInt("users_id", response['data']['users_id']);
          myServices.sharedPreferences
              .setString("users_phone", response['data']['users_phone']);
          myServices.sharedPreferences
              .setString("users_name", response['data']['users_name']);
          myServices.sharedPreferences
              .setString("users_city", response['data']['users_city']);
          myServices.sharedPreferences
              .setString("users_gender", response['data']['users_gender']);

          FirebaseMessaging.instance.subscribeToTopic("users");
          FirebaseMessaging.instance
              .subscribeToTopic("users${response['data']['users_id']}");

          Get.offAll(() => MainScreen(

          ));
        } else if (response['status'] == false) {

          Get.to(() => InfoUserScreen(

          ));
          statusRequest = StatusRequest.none;
          update();
        }
      }
      updateisClick(false);
      update();

  }

  @override
  update_profile(BuildContext context) async {
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
  void onInit() {
    phone = TextEditingController(text:  myServices.sharedPreferences.getBool("isExist")==true ?myServices.sharedPreferences.getString('users_phone'):'');
    name = TextEditingController(text:  myServices.sharedPreferences.getBool("isExist")==true ?myServices.sharedPreferences.getString('users_name'):'');
    gender = TextEditingController(text:  myServices.sharedPreferences.getBool("isExist")==true ?myServices.sharedPreferences.getString('users_gender'):'اختر الجنس');
    city = TextEditingController(text:  myServices.sharedPreferences.getBool("isExist")==true ?myServices.sharedPreferences.getString('users_city'):'اختر المنطقة');
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }
}
