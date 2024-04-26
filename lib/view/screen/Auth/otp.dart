import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import 'package:yumyum/view/screen/Home/Terms&Servicescreen.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../controller/Auth/SignUp_Controller.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/CustomPinInput.dart';
import '../../widget/Auth/CustomTextField.dart';
import '../../widget/Auth/Custom_TextField.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());

    return Scaffold(
      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) => Form(
          key: controller.form,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -40.h,
                left: -10.w,
                child: Container(
                  width: 140.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: const Color(0xffFF7A2F).withOpacity(0.90),
                      borderRadius: BorderRadius.circular(300.sp)),
                ),
              ),
              Positioned(
                top: 5.h,
                right: 11.w,
                child: Row(
                  children: [
                    Text(
                      'أطلب الآن',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ElMessiri',
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 1.3.h),
                      child:
                      Lottie.asset(AppImageAsset.splashlogo, height: 13.h),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 35.h,
                left: 5.w,
                child: Form(
                  key: controller.codeformstate,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: CustomPinInput(
                      otpController: controller.code,
                      valid: (val) {
                        return validInput(val!, 5, 5, "code");
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70.h,
                left: 6.w,
                child: AuthButton(
                  buttonText: 'تحقق من الكود ',
                  onPressed: () async {
                    controller.signUp(context);
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

//  loginUser(String phone, BuildContext context) async {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   print(['phone=>', phone]);
//   _auth.verifyPhoneNumber(
//       phoneNumber: phone,
//       timeout: Duration(seconds: 5),
//       verificationCompleted: (AuthCredential credential) async {
//         Navigator.of(context).pop();
//
//         var result = await _auth.signInWithCredential(credential);
//
//         var user = result.user;
//
//         if (user != null) {
//           Get.to(MainScreen());
//         } else {
//           print("Error");
//         }
//
//         //This callback would gets called when verification is done auto maticlly
//       },
//       verificationFailed: (error){
//         throw Exception(error.message);
//       },
//       codeSent: (verificationId, forceResendingToken) {
//         showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text("Give the code?"),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                   ],
//                 ),
//                 actions: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {  },
//                     child: Text("Confirm"),
//                     // onPressed: () async {
//                     //   final code = _codeController.text.trim();
//                     //   AuthCredential credential =
//                     //   PhoneAuthProvider.getCredential(
//                     //       verificationId: verificationId, smsCode: code);
//                     //
//                     //   AuthResult result =
//                     //   await _auth.signInWithCredential(credential);
//                     //
//                     //   FirebaseUser user = result.user;
//                     //
//                     //   if (user != null) {
//                     //     Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //             builder: (context) => HomeScreen(
//                     //               user: user,
//                     //             )));
//                     //   } else {
//                     //     print("Error");
//                     //   }
//                     // },
//                   )
//                 ],
//               );
//             });
//       },
//       codeAutoRetrievalTimeout: (verificationId){
//
//       });
// }
