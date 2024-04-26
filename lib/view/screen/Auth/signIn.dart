import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import 'package:yumyum/view/screen/Auth/otp.dart';
import 'package:yumyum/view/screen/Home/Terms&Servicescreen.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../controller/Auth/SignUp_Controller.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/CustomTextField.dart';
import '../../widget/Auth/Custom_TextField.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                top: 32.h,
                left: 0.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextField2(
                    valid: (val) {
                      return validInput(val!, 2, 25, "username");
                    },
                    controller: controller.name,
                    keyboardType: TextInputType.name,
                    labelText: 'الاسم ',
                    hintText: 'أكتب اسمك',
                    isPassword: false,
                  ),
                ),
              ),
              Positioned(
                top: 46.h,
                left: 0.w,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextField(
                    valid: (val) {
                      return validInput(val!, 10, 10, "phone");
                    },
                    textfieldcontroller: controller.phone,
                    keyboardType: TextInputType.phone,
                    labelText: 'رقم الموبايل',
                    hintText: ' مثال : 09xxxxxxxxx',
                  ),
                ),
              ),
              // Positioned(
              //   top: 53.h,
              //   left: 0.w,
              //   child: Directionality(
              //     textDirection: TextDirection.rtl,
              //     child: CustomTextField2(
              //       valid: (val) {
              //         return validInput(val!, 8, 25, "password");
              //       },
              //       controller: controller.password,
              //       keyboardType: TextInputType.visiblePassword,
              //       labelText: 'كلمة المرور',
              //       hintText: '***********************',
              //       isPassword: true,
              //     ),
              //   ),
              // ),
              Positioned(
                top: 73.h, // Adjust the position based on your layout
                left: 0.w,
                right: -4.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: 'بمجرد ضغطك زر تسجيل الدخول ، انت توافق على ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'ElMessiri',
                      ),
                      children: [
                        TextSpan(
                          text: 'سياسية الخصوصية والاستخدام',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.orange,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to the desired screen when pressed
                              Get.to(TermsAndService());
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 80.h,
                left: 6.w,
                child: AuthButton(
                  buttonText: 'تسجيل الدخول',
                  onPressed: () async {
                    // await FirebaseAuth.instance.verifyPhoneNumber(
                    //   phoneNumber: '+963958768548',
                    //   verificationCompleted: (PhoneAuthCredential phoneAuthCredential)async{
                    //     await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
                    //   },
                    //   verificationFailed: (error){
                    //     throw Exception(error.message);
                    //   },
                    //   codeSent: (verificationId, forceResendingToken){
                    //     Get.to(MainScreen());
                    //   },
                    //   codeAutoRetrievalTimeout: (verificationId){
                    //
                    //   },
                    // );
                    //loginUser('+963958768548',context);
                    if (controller.form.currentState!.validate()) {
                      Get.to(OtpScreen());
                    }
                  },
                ),
              ),
              Positioned(
                top: 91.h,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => MainScreen());
                      },
                      child: const Text(
                        '  الدخول كزائر',
                        style: TextStyle(
                          color: Colors.orange,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ),
                    Text(
                      ' ليس لديك حساب ؟',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'ElMessiri',
                          fontSize: 12.sp),
                    ),
                  ],
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
