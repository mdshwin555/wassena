import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
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

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  MyServices myServices = Get.find();
  late AnimationController _controller;

  _google_play() async {
    final uri = Uri.parse('https://play.google.com/store/apps/details?id=com.wasena.app');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }


  @override
  void initState() {
    super.initState();
    SplashControllerImp().getVersion();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    _controller.forward();
  }

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
            Positioned(
              bottom: 26.h,
              right: -6.0.w,
              child:ColorFiltered(
                colorFilter: ColorFilter.mode(
                  AppColor.secondaryColor,
                  BlendMode.srcIn,
                ),
                child: Transform.scale(
                  scale:  0.74,
                  child: Image.asset(
                    AppImageAsset.logoIntro,
                    height: 50.h,
                  ),
                ),
              ),
            ),


           controller.current_version!=controller.version? Positioned(
              bottom: 22.h,
              child: Column(
                children: [
                  Text(
                    'Critical App Update Available: \nEnsure Seamless Experience by Updating Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,

                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 1.4.h,),
                  InkWell(
                    onTap: (){_google_play();},
                    child: Text(
                      'click here for update!',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
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
              bottom: 48.h,
              left: 36.5.w,
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
                          scale:  0.75,
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
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  bottom: 42.h,
                  left: 38.w,
                  child: Transform.scale(
                    scale:  4* _controller.value,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'ElMessiri',
                        color: AppColor.secondaryColor,
                      ),
                      child: Text('صينا'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

  }


}
