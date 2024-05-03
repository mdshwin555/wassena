import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Auth/Update_profile_Controller.dart';
import 'package:yumyum/core/constant/color.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/Custom_TextField.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    Get.put(UpdateProfileControllerImp());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('معلوماتي الشخصية',style: TextStyle(
          color: Colors.black,
          height: 0.2.h,
          fontSize: 13.sp,
          fontFamily: 'ElMessiri',
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          Padding(padding: EdgeInsets.only(right: 10.sp),
          child: IconButton(onPressed: ()=>Get.back(), icon:Icon(Icons.arrow_forward_ios_rounded)),)
        ],
      ),
      body: GetBuilder<UpdateProfileControllerImp>(
        builder: (controller) => Form(
          key: controller.form,
          child: Stack(
            alignment: Alignment.center,
            children: [


              Positioned(
                top: 10.h,
                left: 0.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextField2(
                    valid: (val) {
                      return validInput(val!, 2, 25, "username");
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
                top: 22.h,
                left: 0.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextField2(
                    valid: (val) {
                      return validInput(val!, 2, 25, "phone");
                    },
                    controller: controller.phone,
                    isEnable: false,
                    keyboardType: TextInputType.phone,
                    labelText: 'رقم الجوال ',
                    hintText: 'أكتب رقمك',
                    isPassword: false,
                  ),
                ),
              ),
              Positioned(
                top: 34.h,
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
                top: 46.h,
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
                top: 70.h,
                left: 6.w,
                child:AuthButton(
                  buttonText:  controller.statusRequest ==
                      StatusRequest.loading
                      ?
                      'جار الحفظ..'
                      : 'حفظ',
                  color: AppColor.secondaryColor,
                  onPressed: () async {
                    controller.update_profile(context);
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
