import 'dart:ui';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumyum/view/screen/Auth/signIn.dart';
import '../../../core/services/services.dart';
import 'AbousUs.dart';
import 'ContactUs.dart';
import 'SavedAddress.dart';
import 'Terms&Servicescreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 100.w,
            child: FractionallySizedBox(
              widthFactor: 0.92,
              // Adjust the width factor based on your layout
              child: Container(
                height: 13.h,
                padding: EdgeInsets.fromLTRB(5.w, 0, 4.w, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(width: 0.4.w, color: Colors.black26),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    myServices.sharedPreferences.getString("users_phone") ==
                            null
                        ? TextButton(
                            child: Text(
                              'تسجيل دخول',
                              style: TextStyle(
                                color: Color(0xffFF7A2F),
                                height: 0.2.h,
                                fontSize: 9.sp,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Get.offAll(SignInScreen());
                            },
                          )
                        : TextButton(
                            child: Text(
                              'تسجيل خروج',
                              style: TextStyle(
                                color: Color(0xffFF7A2F),
                                height: 0.2.h,
                                fontSize: 9.sp,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: 95.w,
                                    child: AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 10.0),
                                          Text(
                                            'هل أنت متأكد أنك تريد تسجيل الخروج ؟',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ElMessiri',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 6.h,
                                                  width: 20.w,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      FirebaseMessaging.instance
                                                          .unsubscribeFromTopic(
                                                              "users");
                                                      FirebaseMessaging.instance
                                                          .unsubscribeFromTopic(
                                                              "users${myServices.sharedPreferences.getInt("users_id")}");
                                                      myServices
                                                          .sharedPreferences
                                                          .clear();
                                                      Get.to(SignInScreen());
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Color(0xffFF7A2F),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'نعم',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'ElMessiri',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 6.h,
                                                    width: 20.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xffFF7A2F),
                                                          width: 0.3.h,
                                                        )),
                                                    child: Text(
                                                      'لا',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffFF7A2F),
                                                        height: 0.2.h,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'ElMessiri',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          myServices.sharedPreferences
                                      .getString("users_phone") ==
                                  null
                              ? Text(
                                  'مرحباً بك !',
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ElMessiri',
                                  ),
                                )
                              : FittedBox(
                                  child: Text(
                                    myServices.sharedPreferences
                                        .getString("users_name")!,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ElMessiri',
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 1.h,
                          ),
                          myServices.sharedPreferences
                                      .getString("users_phone") ==
                                  null
                              ? SizedBox()
                              : Text(
                                  myServices.sharedPreferences
                                      .getString("users_phone")!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black54,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xffFF7A2F),
                      radius: 30.sp,
                      child: Icon(
                        EneftyIcons.profile_bold,
                        color: Colors.white,
                        size: 35.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 55.h,
                    width: 92.w,
                    padding: EdgeInsets.fromLTRB(5.w, 2.h, 4.w, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border:
                            Border.all(width: 0.4.w, color: Colors.black26)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(SavedAddress());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      EneftyIcons.location_bold,
                                      color: Color(0xffFF7A2F),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'عناوينك',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.navigate_next_sharp)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Divider(
                            color: Colors.black26,
                            thickness: 0.2.h,
                            indent: 1.w,
                            endIndent: 1.w,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(AboutUs());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      EneftyIcons.info_circle_bold,
                                      color: Color(0xffFF7A2F),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'حول التطبيق',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.navigate_next_sharp)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Divider(
                            color: Colors.black26,
                            thickness: 0.2.h,
                            indent: 1.w,
                            endIndent: 1.w,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(TermsAndService());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      EneftyIcons.note_2_bold,
                                      color: Color(0xffFF7A2F),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'سياسية الخصوصية و الإستخدام',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   width: 8.w,
                                // ),
                                Icon(Icons.navigate_next_sharp)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Divider(
                            color: Colors.black26,
                            thickness: 0.2.h,
                            indent: 1.w,
                            endIndent: 1.w,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(ContactUs());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      EneftyIcons.call_calling_bold,
                                      color: Color(0xffFF7A2F),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'تواصل معنا',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.navigate_next_sharp)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          // Divider(
                          //   color: Colors.black26,
                          //   thickness: 0.2.h,
                          //   indent: 1.w,
                          //   endIndent: 1.w,
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.to(JoinUsScreen());
                          //   },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Transform.scale(
                          //             scale: 1.5,
                          //             child: Image.asset(
                          //               AppImageAsset.joinus,
                          //               height: 3.h,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: 2.w,
                          //           ),
                          //           Text(
                          //             'انضم لنا',
                          //             style: TextStyle(
                          //               fontSize: 12.sp,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold,
                          //               fontFamily: 'ElMessiri',
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Icon(Icons.navigate_next_sharp)
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          Divider(
                            color: Colors.black26,
                            thickness: 0.2.h,
                            indent: 1.w,
                            endIndent: 1.w,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Share.share(
                                  'اكتشف التجربة الجديدة مع تطبيق أوردر الآن! احصل على أشهى الوجبات وأجود المنتجات بنقرة واحدة. حمّل التطبيق الآن واستمتع بتجربة تسوق فريدة! https://play.google.com/store/apps/details?id=com.ordernow.app');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      EneftyIcons.share_bold,
                                      color: Color(0xffFF7A2F),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'دعوة الأصدقاء ',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.navigate_next_sharp)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Divider(
                            color: Colors.black26,
                            thickness: 0.2.h,
                            indent: 1.w,
                            endIndent: 1.w,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              openAppReview();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    openAppReview();
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        EneftyIcons.star_bold,
                                        color: Color(0xffFF7A2F),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        'تقييم التطبيق  ',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ElMessiri',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.navigate_next_sharp),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }
}

void openAppReview() async {
  final InAppReview inAppReview = InAppReview.instance;

  if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  } else {}
}
