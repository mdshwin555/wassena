import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../controller/Home/SplashController.dart';
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
  Widget build(BuildContext context) {
    SplashControllerImp controller= Get.put(SplashControllerImp());

    return GetBuilder<SplashControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColor.primaryColor),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
                alignment: Alignment.center,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    AppColor.secondaryColor,
                    BlendMode.srcIn,
                  ),
                  child: Transform.scale(
                    scale:  0.7,
                    child: Image.asset(
                      AppImageAsset.logoIntro,
                      height: 50.h,
                    ),
                  ),
                )
            ),


           controller.current_version!=controller.version? Positioned(
              bottom: 22.h,
              child: Text(
                'Please update for new version',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ):Text(''),
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
            Positioned(
              bottom: 46.h,
              left: 35.5.w,
              child: Container(
                  alignment: Alignment.center,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      AppColor.secondaryColor,
                      BlendMode.srcIn,
                    ),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14159), // Rotate 180 degrees around Y-axis (flip)
                      child: Transform.rotate(
                        angle: -0.3,
                        child: Transform.scale(
                          scale:  0.57,
                          child: Lottie.asset(
                            AppImageAsset.motor,
                            height: 15.h,
                          ),
                        ),
                      ),
                    ),
                  )
              ),
            ),
            Positioned(
              bottom: 38.h,
              left: 24.w,
              child:DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 70.0,
                    fontFamily: 'ElMessiri',
                    color: AppColor.secondaryColor
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,

                  animatedTexts: [
                    ScaleAnimatedText('صينا'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  @override
  void initState() {
    super.initState();
    SplashControllerImp().getVersion();
  }
}
