import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/color.dart';
import 'package:yumyum/view/screen/Auth/otp.dart';
import 'package:yumyum/view/screen/Home/Terms&Servicescreen.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../controller/Auth/SignUp_Controller.dart';
import '../../../core/functions/validinput.dart';
import '../../../core/services/services.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/CustomTextField.dart';
import '../../widget/Auth/Custom_TextField.dart';

class InfoUserScreen extends StatefulWidget {
  InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    MyServices myServices = Get.find();

    return Scaffold(
      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) => Form(
          key: controller.form,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -40.h,
                left: -10.w,
                child: Container(
                  width: 140.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.90),
                      borderRadius: BorderRadius.circular(300.sp)),
                ),
              ),
              Positioned(
                top: 7.h,
                right: 11.w,
                child: Row(
                  children: [
                    Text(
                      myServices.sharedPreferences.getBool("isExist") == true
                          ? 'معلوماتك الشخصية'
                          : 'أدخل معلوماتك الشخصية ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ElMessiri',
                        fontSize:
                            myServices.sharedPreferences.getBool("isExist") ==
                                    true
                                ? 17.sp
                                : 15.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    // Transform.translate(
                    //   offset: Offset(0, 1.3.h),
                    //   child:
                    //   Image.asset(AppImageAsset.appicon, height: 9.h),
                    // ),
                  ],
                ),
              ),
              Positioned(
                top: 32.h,
                left: 0.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextField2(
                    valid: (val) {
                      // return validInput(val!, 2, 25, "username");
                    },
                    controller: controller.name,
                    keyboardType: TextInputType.name,
                    labelText: 'الاسم ',
                    hintText: 'أكتب اسمك',
                    isPassword: false,
                  ),
                ),
              ),
              Positioned(
                top: 44.h,
                left: 0.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 6.w),
                        child: Text('الجنس',style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 13.sp,
                          fontFamily: 'ElMessiri',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                      SizedBox(
                        height: 8.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 0),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 3.w),
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.red),
                              ),
                              hintText: controller.gender.text,
                              hintStyle: TextStyle(
                                height: 0.2.h,
                                fontSize: 11.sp,
                                fontFamily: 'ElMessiri',
                                letterSpacing: 1,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    position:
                                    RelativeRect.fromLTRB(0, 50.h, 10.w, 0),
                                    items: [
                                      "ذكر",
                                      "أنثى",
                                    ].map((String gender) {
                                      return PopupMenuItem(
                                        value: gender,
                                        onTap: (){
                                          controller.updategender(gender);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              gender,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColor.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 56.h,
                left: 0.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 6.w),
                        child: Text('المنطقة',style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 13.sp,
                          fontFamily: 'ElMessiri',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                      SizedBox(
                        height: 8.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 0),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 3.w),
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.red),
                              ),
                              hintText: controller.city.text,
                              hintStyle: TextStyle(
                                height: 0.2.h,
                                fontSize: 11.sp,
                                fontFamily: 'ElMessiri',
                                letterSpacing: 1,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    position:
                                    RelativeRect.fromLTRB(0, 67.h, 10.w, 0),
                                    items: [
                                      "دمشق",
                                      "الزبداني",
                                    ].map((String city) {
                                      return PopupMenuItem(
                                        value: city,
                                        onTap: (){
                                          controller.updatecity(city);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              city,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColor.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 75.h,
                left: 6.w,
                child: AuthButton(
                  buttonText: 'إكمال',
                  color: AppColor.secondaryColor,
                  onPressed: () async {
                    if (controller.form.currentState!.validate()) {
                      myServices.sharedPreferences.getBool("isExist") == false
                          ?
                      controller.gender.text == 'اختر الجنس' || controller.city.text == 'اختر المنطقة' || controller.name.text == ''
                          ?
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColor.primaryColor,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.name.text == '' ? " الرجاء إختيار إسمك " :
                                controller.gender.text == 'اختر الجنس' ? " الرجاء تحديد الجنس ":
                                controller.city.text == 'اختر المنطقة' ? " الرجاء إختيار منطقتك ":'',
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
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      )
                          :
                      (  controller.signUp(context)
                    )
                          :
                      controller.update_profile(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
