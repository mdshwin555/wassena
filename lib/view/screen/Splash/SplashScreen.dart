import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../core/constant/color.dart';
import '../../../core/services/services.dart';
import '../MainScreen.dart';
import '../Onboarding/OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MyServices myServices = Get.find();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      myServices.sharedPreferences.getString("token") == null
          ? Get.to(OnboardingScreen())
          : Get.offAll(MainScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   height: 100.h,
          //   width: 100.w,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(AppImageAsset.splashfastmart),
          //       fit: BoxFit.cover,
          //       colorFilter: ColorFilter.mode(
          //               Colors.black.withOpacity(0.5),
          //               BlendMode.srcATop,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   child: Lottie.asset(
          //     AppImageAsset.splashlogo,
          //     height: 50.h,
          //   ),
          // ),
          Container(
            alignment: Alignment.center,
         decoration: BoxDecoration(color: AppColor.primaryColor),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            bottom: 43.h,
            child: DefaultTextStyle(
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontFamily: 'ProtestRiot',
                fontSize: 70.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText(
                    'Wasena',
                    speed: Duration(milliseconds: 350),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 2.h,
            child: Text(
              'Developed by Wasena ©',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 10.sp,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 30.h,
          //   child: DefaultTextStyle(
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontFamily: 'ElMessiri',
          //       fontSize: 20.sp,
          //       letterSpacing: 1,
          //     ),
          //     child: AnimatedTextKit(
          //       pause: Duration(milliseconds: 5),
          //       animatedTexts: [
          //         RotateAnimatedText('وفر'),
          //         RotateAnimatedText('وقتك'),
          //         RotateAnimatedText('وتعبك'),
          //         RotateAnimatedText('ومصرياتك'),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
