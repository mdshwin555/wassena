import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/UsersController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import '../../../controller/Home/CategoriesController.dart';
import '../../../core/constant/color.dart';
import '../../../core/services/services.dart';

class SendNotificationScreen extends StatelessWidget {
  final String? username;
  const SendNotificationScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    Get.put(UsersControllerImp());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'إرسال رسالة الى ${username}',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<UsersControllerImp>(
          builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Text(
                          'العنوان',
                          style: TextStyle(
                            color: Colors.black,
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 8.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                          child: TextFormField(
                            controller: controller.title,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 3.w),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.red),
                              ),
                              hintText: 'اكتب عنوان الرسالة',
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
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Text(
                          'الرسالة',
                          style: TextStyle(
                            color: Colors.black,
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 8.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                          child: TextFormField(
                            controller: controller.body,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 3.w),
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.red),
                              ),
                              hintText: 'اكتب الرسالة هنا',
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
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.singleotification(

                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 7.h,
                      width: 85.w,
                      margin: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 0),
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'إرسال',
                        style: TextStyle(
                          color: Colors.white,
                          height: 0.2.h,
                          fontSize: 15.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
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
