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
import '../../data/datasource/remote/Home/ContactUsData.dart';

abstract class ContactUs_Controller extends GetxController {
  contactus(BuildContext context);
}

class ContactUs_ControllerImp extends ContactUs_Controller {
  ContactUsData contactusdata = ContactUsData(Get.find());
  TextEditingController title = TextEditingController();
  TextEditingController subject = TextEditingController();
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  @override
  contactus(BuildContext context) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await contactusdata.postdata(title.text, subject.text,
        '${myServices.sharedPreferences.getInt("users_id")}');
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == true) {
        BuildContext context = Get.context!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "تم إرسال رسالتك بنجاح ! ",
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
        Get.back();
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
    update();
  }

  @override
  void onInit() {
    title = TextEditingController();
    subject = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    title.dispose();
    subject.dispose();
    super.dispose();
  }
}
