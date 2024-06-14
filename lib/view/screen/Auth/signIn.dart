import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import 'package:yumyum/view/widget/CustomTextField.dart';
import '../../../controller/Auth/SignIn_Controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/CustomTextField.dart';
import '../Home/HomeScreen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignInControllerImp());

    return Scaffold(
      body: GetBuilder<SignInControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.form,
            child: Stack(
              children: [
                Positioned(
                  top: -40.h,
                  left: -10.w,
                  child: Container(
                    width: 140.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(300.sp)),
                  ),
                ),
                Positioned(
                  top: 3.h,
                  left: 52.w,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(1),
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(
                      AppImageAsset.logo,
                      height: 17.h,
                    ),
                  ),
                ),
                Positioned(
                  top: 7.7.h,
                  left: 27.w,
                  child: Text('W',style:TextStyle(
                    color: AppColor.secondaryColor,
                    fontFamily: 'Cairo',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ) ,),
                ),
                Positioned(
                  top: 7.7.h,
                  left: 36.w,
                  child: Text('asena',style:TextStyle(
                    color: AppColor.white,
                    fontFamily: 'Cairo',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ) ,),
                ),
                Positioned(
                  top: 12.h,
                  left: 42.w,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(1),
                      BlendMode.srcATop,
                    ),
                    child: Text('admin',style:TextStyle(
                      color: AppColor.white,
                      fontFamily: 'Cairo',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ) ,),
                  ),
                ),

                Positioned(
                  top: 32.h,
                  left: 0.w,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomTextField(
                      valid: (val) {
                        return validInput(val!, 5, 100, "name");
                      },
                      textfieldcontroller: controller.name,
                      keyboardType: TextInputType.text,
                      labelText: 'إسم الآدمن',
                      hintText: ' Admin name',
                    ),
                  ),
                ),
                Positioned(
                  top: 46.h,
                  left: 0.w,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomTextField2(
                      valid: (val) {
                        return validInput(val!, 10, 100, "password");
                      },
                      isPassword: true,
                      isEnable: true,
                      controller: controller.password,
                      keyboardType: TextInputType.text,
                      labelText: 'كلمة المرور',
                      hintText: '*************',
                    ),
                  ),
                ),
                Positioned(
                  top: 60.h, // Adjust the position based on your layout
                  left: 0.w,
                  right: -4.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        text:
                            'بمجرد ضغطك زر تسجيل الدخول أو الدخول كزائر، انت توافق على',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                        ),
                        children: [
                          TextSpan(
                            text: ' الشروط والأحكام ',
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                          TextSpan(
                            text: 'و ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'سياسية الخصوصية والاستخدام',
                            style: TextStyle(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 72.h,
                  left: 6.w,
                  child: AuthButton(
                    buttonText: 'تسجيل الدخول',
                    onPressed: () {
                      if (controller.form.currentState!.validate()) {
                        if (controller.name.text == 'Wasena.hon' && controller.password.text == '0933800100@') {
                          Get.offAll(() => HomeScreen());
                          FirebaseMessaging.instance.subscribeToTopic("admin");
                        } else {
                          Get.snackbar(
                              "خطأ في إسم المستخدم أو كلمة المرور",
                              "يرجى التأكد من معلومات الآدمن ثم المحاولة لاحقاً"
                          );
                        }
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 83.h,
                  left: 14.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' ! لديك الكثير من العمل للقيام به',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      Text(
                        ' مرحبا كابتن',
                        style: TextStyle(
                            color: AppColor.black,
                            fontFamily: 'Cairo',
                            fontSize: 12.sp),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
