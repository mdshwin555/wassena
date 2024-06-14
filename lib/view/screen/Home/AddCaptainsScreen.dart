import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/ItemsController.dart';
import 'package:yumyum/controller/Home/RestaurantsController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import 'package:yumyum/view/screen/Home/HomeScreen.dart';
import '../../../controller/Home/CaptainControllerImp.dart';
import '../../../controller/Home/CategoriesController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/functions/validinput.dart';
import '../../../core/services/services.dart';
import '../../widget/Auth/AuthButton.dart';
import '../../widget/Auth/CustomTextField.dart';
import '../../widget/CustomTextField.dart';
import 'AddAddressScreen.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class AddCaptainsScreen extends StatefulWidget {
  const AddCaptainsScreen({super.key});

  @override
  State<AddCaptainsScreen> createState() => _AddRestaurantsScreenState();
}

class _AddRestaurantsScreenState extends State<AddCaptainsScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(CaptainControllerImp());


    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () {
                Get.back();
              }),
        ],
        leading: SizedBox(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Captain',
          style: TextStyle(
              color: AppColor.black,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              fontSize: 15.sp),
        ),
      ),
      body: GetBuilder<CaptainControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: SingleChildScrollView(
            child: Form(
              key: controller.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w,bottom: 1.h),
                    child: Text(
                      'اسم الكابتن',
                      style: TextStyle(
                        color: Colors.black,
                        height: 0.2.h,
                        fontSize: 11.sp,
                        fontFamily: 'Cairo',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                    width: 100.w,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        controller: controller.name,
                        validator:  (val) {
                          return validInput(val!, 2, 100, "username");
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.red),
                          ),
                          hintText: 'اسم الكابتن',
                          hintStyle: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Directionality(
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
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomTextField2(
                      valid: (val) {
                        return validInput(val!, 8, 100, "password");
                      },
                      isPassword: true,
                      isEnable: true,
                      controller: controller.password,
                      keyboardType: TextInputType.text,
                      labelText: 'كلمة مرور الحساب',
                      hintText: '*************',
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: AuthButton(
                      buttonText: 'Create Captain',
                      onPressed: () {
                         controller.addCaptain(context);

                      },
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
