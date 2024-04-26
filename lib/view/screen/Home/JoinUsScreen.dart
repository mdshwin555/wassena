import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/JoinUsController.dart';

import '../../../core/constant/color.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/CustomTextField.dart';
import '../../widget/Auth/Custom_TextField.dart';

class JoinUsScreen extends StatelessWidget {
  const JoinUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(JoinUsControllerImp());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'انضم لنا',
              style: TextStyle(
                color: AppColor.black,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Color(0xffFF7A2F),
              labelColor: Color(0xffFF7A2F),
              labelStyle: TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 9.sp,
              ),
              tabs: const [
                Tab(text: ' كمتجر'),
                Tab(text: ' كعامل توصيل'),
              ],
            ),
          ),
          body: GetBuilder<JoinUsControllerImp>(
            builder: (controller) => TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextField2(
                        valid: (val) {
                          return validInput(val!, 2, 25, "username");
                        },
                        controller: controller.name,
                        keyboardType: TextInputType.name,
                        labelText: 'اسم المتجر ',
                        hintText: 'أكتب اسم متجرك',
                        isPassword: false,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextField(
                        valid: (val) {
                          return validInput(val!, 10, 10, "phone");
                        },
                        textfieldcontroller: controller.phone,
                        keyboardType: TextInputType.phone,
                        labelText: 'رقم الموبايل',
                        hintText: ' مثال : 09xxxxxxxxx',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 7.w),
                      child: Text(
                        'نوع المتجر ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 12.sp,
                          fontFamily: 'ElMessiri',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                            hintText: 'ما هو نوع متجرك',
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
                                  RelativeRect.fromLTRB(0, 60.h, 0, 0),
                                  items: [
                                    "مطعم",
                                    "مقهى",
                                    "ملابس",
                                    "موبايلات",
                                    "سوبرماركت",
                                    "العناية الشخصية",
                                    "صيدلية",
                                    "هدايا",
                                  ].map((String vehicle) {
                                    return PopupMenuItem(
                                      value: vehicle,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            vehicle,
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: AuthButton(
                        buttonText: 'إرسال طلب ',
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xffFF7A2F),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    " تم تقديم طلبك بنجاح, سوف يتم التواصل معك",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 10.sp,
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
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Directionality(
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
                    SizedBox(
                      height: 4.h,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CustomTextField(
                        valid: (val) {
                          return validInput(val!, 10, 10, "phone");
                        },
                        textfieldcontroller: controller.phone,
                        keyboardType: TextInputType.phone,
                        labelText: 'رقم الموبايل',
                        hintText: ' مثال : 09xxxxxxxxx',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 7.w),
                      child: Text(
                        'نوع المركبة ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 12.sp,
                          fontFamily: 'ElMessiri',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                            hintText: 'اختر مركبتك ',
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
                                      RelativeRect.fromLTRB(0, 60.h, 0, 0),
                                  items: [
                                    "سيارة",
                                    "دراجة نارية",
                                    "دراجة هوائية",
                                  ].map((String vehicle) {
                                    return PopupMenuItem(
                                      value: vehicle,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            vehicle,
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: AuthButton(
                        buttonText: 'إرسال طلب ',
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xffFF7A2F),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    " تم تقديم طلبك بنجاح, سوف يتم التواصل معك",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 10.sp,
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
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JoinAsStoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Join as a Store', // Add your content for joining as a store
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
