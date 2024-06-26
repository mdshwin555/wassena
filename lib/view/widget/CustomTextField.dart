import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constant/color.dart';
import '../../controller/Auth/SignIn_Controller.dart';

class CustomTextField2 extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?) valid;
  final bool isPassword;
  final bool isEnable;

  const CustomTextField2({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.valid,
    this.isPassword = false,
    this.isEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInControllerImp signInController = Get.put(SignInControllerImp());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelText,
                style: TextStyle(
                  color: Colors.black,
                  height: 0.2.h,
                  fontSize: 13.sp,
                  fontFamily: 'Cairo',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                child: TextFormField(
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11.sp,
                    color: isEnable ? Colors.black :Colors.grey,
                  ),
                  enabled: isEnable,

                  validator: valid,
                  controller: controller,
                  keyboardType: keyboardType,
                  cursorColor: AppColor.secondaryColor,
                  obscureText: isPassword
                      ? signInController.isPasswordVisible == true.obs
                      ? false
                      : true
                      : false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.5.w),
                    isDense: true,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColor.grey),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColor.grey),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColor.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color:AppColor.secondaryColor,),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColor.red),
                    ),
                    hintText: hintText,
                    errorStyle: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 8.sp
                    ),
                    hintStyle: TextStyle(
                      height: 0.2.h,
                      fontSize: 11.sp,
                      fontFamily: 'Cairo',
                      letterSpacing: 1,
                    ),
                    suffixIcon: isPassword
                        ? GestureDetector(
                      onTap: () {
                        signInController.togglePasswordVisibility();
                      },
                      child: Icon(
                        signInController.isPasswordVisible == true.obs
                            ? EneftyIcons.eye_outline
                            : EneftyIcons.eye_slash_outline,
                        color:
                        signInController.isPasswordVisible == true.obs
                            ? AppColor.secondaryColor
                            : AppColor.grey.withOpacity(0.70),
                      ),
                    )
                        : null,
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
