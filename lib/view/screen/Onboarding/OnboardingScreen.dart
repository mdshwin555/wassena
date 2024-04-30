import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import 'package:yumyum/view/screen/Auth/signIn.dart';

import '../../../core/constant/color.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -30.h,
            left: -32.w,
            child: CircleAvatar(
              backgroundColor: AppColor.primaryColor,
              radius: 250.sp,
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildPage(
                Positioned(
                  top: 5.h,
                  child: Lottie.asset(
                    AppImageAsset.shopping,
                    height: 35.h,
                  ),
                ),
                "الآن أسهل من أي وقت مضى ! ",
                "استمتع بتجربة تسوق مريحة وممتعة و اكتشف العروض الرائعة اليوم",
              ),
              _buildPage(
                Positioned(
                  top: 3.h,
                  left: 15.w,
                  child: Lottie.asset(
                    AppImageAsset.deliverybike,
                    height: 35.h,
                  ),
                ),
                "وين ما كنت، رح نوصلك ! ",
                "مع خدمة التوصيل السريع، احصل على طلباتك في أسرع وقت ممكن !",
              ),
              _buildPage(
                Positioned(
                  top: 5.h,
                  child: Lottie.asset(
                    AppImageAsset.offers,
                    height: 35.h,
                  ),
                ),
                "لا تفوّت عروضنا الرائعة !",
                "ابق على اطلاع دائم على عروضنا الحصرية وخصوماتنا الرائعة !",
              ),
            ],
          ),
          Positioned(
            bottom: 3.5.h,
            child: GestureDetector(
              onTap: (){
                Get.to(SignInScreen());
              },
              child: Text(
                'skip',
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  letterSpacing: 2
                ),
              ),
            ),
          ),
          _buildDotsIndicator(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildPage(
      Widget image, String title, String description) {
    return Stack(
      alignment: Alignment.center,
      children: [
        image,
        Positioned(
          top: 55.h,
          left: 10.w,
          child: Container(
            width: 80.w,
            child: Text(
              title,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
        Positioned(
          top: 63.h,
          left: 10.w,
          child: Container(
            width: 80.w,
            child: Text(
              description,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'ElMessiri',
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Positioned(
      bottom: 22.h,
      left: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
            width: _currentPage == index ? 20 : 10,
            height: 10.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // Change shape to rectangle
              borderRadius: BorderRadius.circular(5.0),
              // Optional: Add border radius for a rounded rectangle
              color: _currentPage == index ? AppColor.secondaryColor : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildButtons() {
    return Positioned(
      bottom: 10.h,
      left: 12.w,
      child: GestureDetector(
        onTap: () {
          if (_currentPage < 2) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            Get.to(SignInScreen());
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 7.5.h,
          width: 75.w,
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _currentPage < 2 ? "التالي" : "تسجيل الدخول",
            style: TextStyle(
              color: Colors.white,
              height: 0.2.h,
              fontSize: 13.sp,
              fontFamily: 'ElMessiri',
            ),
          ),
        ),
      ),
    );
  }
}
