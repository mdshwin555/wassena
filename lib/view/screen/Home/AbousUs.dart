import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constant/imgaeasset.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -42.h,
            left: -10.w,
            child: Container(
              width: 140.w,
              height: 60.h,
              decoration: BoxDecoration(
                  color: const Color(0xffFF7A2F),
                  borderRadius: BorderRadius.circular(300.sp)),
            ),
          ),
          Positioned(
            top: 45.h,
            child: Text(
              'Order Now',
              style: TextStyle(
                color: Color(0xffFF7A2F),
                fontFamily: 'ProtestRiot',
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
          ),
          Positioned(
            top: 51.h,
            child: Text(
              'Developed by Eng.AL Mouayad Shwin ©',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 6.sp,
              ),
            ),
          ),
          Positioned(
            top: 5.h,
            right: 5.w,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_forward_ios_outlined),
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 23.h,
            child: Container(
              height: 20.h,
              width: 20.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.sp),
                image: DecorationImage(
                  image: AssetImage(AppImageAsset.appicon),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 57.h,
            child: Container(
              width: 87.w,
              child: Text(
                ' يوفر التطبيق قائمة شاملة من المتاجر والمطاعم والسلع من مختلف الفئات مثل المأكولات، الملابس، الإلكترونيات، الأدوات المنزلية، وغيرها الكثير يمكن للمستخدمين العثور بسرعة على المنتجات التي يبحثون عنها ومقارنة الأسعار والعروض بالإضافة إلى ذلك، يتيح التطبيق للمستخدمين تتبع الطلبات والديلفري على الخريطة مباشرةً، مما يضمن لهم متابعة الطلبات بكل سهولة ومعرفة موعد وصولها المتوقع إلى باب منازلهم ',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.black,
                  height: 0.2.h,
                  fontSize: 11.sp,
                  fontFamily: 'ElMessiri',
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 1.5.h,
            child: Container(
              width: 90.w,
              child: Text(
                'version 1.0.0',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 9.sp,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
