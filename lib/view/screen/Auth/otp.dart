import 'dart:async';
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
import '../../../core/constant/color.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/CustomPinInput.dart';
import '../../widget/Auth/CustomTextField.dart';
import '../../widget/Auth/Custom_TextField.dart';

class OtpScreen extends StatefulWidget {
  String? number;
   OtpScreen({super.key, this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isResendAgain = false;

  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }
  verify() {


    const oneSec = Duration(milliseconds: 2000);
    _timer = new Timer.periodic(oneSec, (timer) {

    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3)
          _currentIndex = 0;
      });
    });

    super.initState();
  }

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
                      color:  AppColor.primaryColor.withOpacity(0.90),
                      borderRadius: BorderRadius.circular(300.sp)),
                ),
              ),
              Positioned(
                bottom: 1.h,
                top: 8.h,
                left: 9.h,

                child: Text(
                  'أدخل رمز التحقق',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ElMessiri',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
              ),
              Positioned(
                top: 23.h, // Adjust the position based on your layout
                left: 0.w,
                right: 0.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: 'لقد أرسلنا رمز التحقق المكون من 5 أرقام الى الرقم ${widget.number}',
                      style:  TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontFamily: 'ElMessiri',
                      ),

                    ),
                  ),
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
              Positioned(
                top: 79.h, // Adjust the position based on your layout
                left: 0.w,
                right: 0.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: 'لم تتلقى الكود بعد؟',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'ElMessiri',
                      ),
                      children: [
                        TextSpan(
                          text: _isResendAgain ? " إعادة المحاولة بعد " + _start.toString() : " إعادة الإرسال ",
                          style:  TextStyle(
                            //decoration: TextDecoration.underline,
                            fontSize: 12.sp,
                            color: AppColor.secondaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (_isResendAgain) return;
                              resend();
                            },
                        ),
                      ],
                    ),
                  ),
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
