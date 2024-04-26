import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumyum/controller/Home/ContactUs_Controller.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../widget/Auth/AuthButton.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactUs_ControllerImp());

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
            'تواصل معنا',
            style: TextStyle(
              color: AppColor.black,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ),
        body: GetBuilder<ContactUs_ControllerImp>(
          builder: (controller) => Container(
            height: 100.h,
            width: 100.w,
            margin: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImageAsset.contact_us,
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: SizedBox(
                      child: TextFormField(
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                        controller: controller.title,
                        cursorColor: Color(0xffFF7A2F),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.5.w),
                          isDense: true,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Color(0xffFF7A2F),
                            ),
                          ),
                          hintText: 'الموضوع',
                          errorStyle: TextStyle(
                              fontFamily: 'ElMessiri', fontSize: 8.sp),
                          hintStyle: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'ElMessiri',
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: SizedBox(
                      child: TextFormField(
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                        controller: controller.subject,
                        maxLines: 5,
                        cursorColor: Color(0xffFF7A2F),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.5.w),
                          isDense: true,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Color(0xffFF7A2F),
                            ),
                          ),
                          hintText: 'نص الرسالة',
                          errorStyle: TextStyle(
                              fontFamily: 'ElMessiri', fontSize: 8.sp),
                          hintStyle: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'ElMessiri',
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.contactus(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 7.h,
                      width: 90.w,
                      margin: EdgeInsets.fromLTRB(0.w, 2.h, 0.w, 0),
                      decoration: BoxDecoration(
                        color: controller.statusRequest == StatusRequest.loading
                            ? Colors.grey
                            : Color(0xffFF7A2F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: controller.statusRequest == StatusRequest.loading
                          ? Transform.scale(
                              scale: 3,
                              child: Lottie.asset(
                                AppImageAsset.dotsloading,
                              ),
                            )
                          : Text(
                              'إرسال',
                              style: TextStyle(
                                color: Colors.white,
                                height: 0.2.h,
                                fontSize: 12.sp,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              "fb://facewebmodal/f?href=https://www.facebook.com/profile.php?id=61556808508109"));
                        },
                        child: Image.asset(
                          AppImageAsset.facebook,
                          height: 4.h,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              "whatsapp://send?phone=+963968557674&text=مرحبا"));
                        },
                        child: Image.asset(
                          AppImageAsset.whatsapp,
                          height: 4.h,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse("tel:0958768548"));
                        },
                        child: Image.asset(
                          AppImageAsset.phone,
                          height: 4.h,
                        ),
                      ),
                    ],
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
