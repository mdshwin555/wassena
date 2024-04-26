import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/Auth/SignUp_Controller.dart';
import '../../../core/constant/color.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final SignUpControllerImp signUpController = Get.put(SignUpControllerImp());

    return signUpController.isClick == true.obs ||
            signUpController.isClick == true.obs
        ? Padding(
            padding: EdgeInsets.only(left: 39.w),
            child: CircleAvatar(
              backgroundColor: Color(0xffFF7A2F),
              radius: 20.sp,
              child: const CircularProgressIndicator(color: AppColor.white),
            ),
          )
        : GestureDetector(
            onTap: onPressed,
            child: Container(
              alignment: Alignment.center,
              height: 7.5.h,
              width: 88.w,
              decoration: BoxDecoration(
                color: Color(0xffFF7A2F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  height: 0.2.h,
                  fontSize: 15.sp,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
          );
  }
}
