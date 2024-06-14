import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/Auth/SignIn_Controller.dart';
import '../../../controller/Home/CaptainControllerImp.dart';
import '../../../controller/Home/ItemsController.dart';
import '../../../controller/Home/OffersController.dart';
import '../../../controller/Home/RestaurantsController.dart';
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
    final SignInControllerImp signUpController = Get.put(SignInControllerImp());
    final OffersControllerImp OffersController = Get.put(OffersControllerImp());
    final RestaurantsControllerImp RestaurantsController = Get.put(RestaurantsControllerImp());
    final ItemsControllerImp ItemsController = Get.put(ItemsControllerImp());

    return signUpController.isClick == true.obs || OffersController.isClick == true.obs || RestaurantsController.isClick == true.obs || ItemsController.isClick == true.obs || CaptainControllerImp().isClick == true.obs
        ? Padding(
            padding: EdgeInsets.only(left: 0.w),
            child: CircleAvatar(
              backgroundColor: AppColor.secondaryColor,
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
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  height: 0.2.h,
                  fontSize: 15.sp,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          );
  }
}
