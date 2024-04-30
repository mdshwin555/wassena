import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/MainScreen.dart';

import '../../../controller/Auth/SignUp_Controller.dart';
import '../../../core/constant/color.dart';

class CustomPinInput extends StatelessWidget {
  final TextEditingController otpController;

  CustomPinInput({
    required this.otpController, required Function(dynamic val) valid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 90.w,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Transform.scale(
          scale: 1,
          child: Pinput(
            onChanged: (pin) {
              if (pin.length == 5) {
                SignUpControllerImp().signUp(context);
                print("finish");
              }
            },
            length: 5,
            controller: otpController,
            animationCurve: Curves.easeInOutExpo,
            focusedPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: AppColor.secondaryColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
