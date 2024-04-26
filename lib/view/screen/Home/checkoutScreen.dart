import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/AddAddressScreen.dart';
import '../../../controller/Home/CartController.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/services/services.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartControllerImp());
    MyServices myServices = Get.find();

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
          title: Text(
            'توصيل إلى العنوان ..',
            style: TextStyle(
              color: AppColor.black,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ),
        body: GetBuilder<CartControllerImp>(
          builder: (controller) => Container(
            width: 100.w,
            height: 100.h,
            padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.address.isEmpty
                      ? Center(
                          child: Container(
                            height: 63.h,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                Lottie.asset(
                                  AppImageAsset.emptyaddress,
                                  height: 20.h,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  'لا يوجد عناوين محفوظة بعد',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'ElMessiri',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  width: 35.w,
                                  height: 4.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(AddAddressScreen());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffFF7A2F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.sp),
                                      ),
                                    ),
                                    child: Text(
                                      'إضافة عنوان ',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.white,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : controller.statusRequest == StatusRequest.loading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child:
                                  YourShimmerWidget(), // Replace with your shimmer widget
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: 4.h,
                                    width: 88.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      color: Color(0xffFF7A2F).withOpacity(0.4),
                                    ),
                                    child: Text(
                                      'اضغط على العنوان الذي تريد توصيل الطلب إليه',
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    height: 57.h,
                                    child: ListView.builder(
                                      itemCount: controller.address.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            myServices.sharedPreferences.setInt(
                                                "addressid",
                                                controller.address[index]
                                                    ['address_id']);
                                            myServices.sharedPreferences
                                                .setInt("activeAddress", index);
                                            controller.getAddress();
                                          },
                                          child: Card(
                                            color: myServices.sharedPreferences
                                                        .getInt(
                                                            "activeAddress") ==
                                                    index
                                                ? Color(0xffFF7A2F)
                                                : Colors.white60,
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Container(
                                                height: 13.h,
                                                width: 90.w,
                                                margin: EdgeInsets.fromLTRB(
                                                    5.w, 1.h, 5.w, 0),
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                '${controller.address[index]['address_name']}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'ElMessiri',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Icon(
                                                                EneftyIcons
                                                                    .location_bold,
                                                                color: myServices
                                                                            .sharedPreferences
                                                                            .getInt(
                                                                                "activeAddress") ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Color(
                                                                        0xffFF7A2F),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 0.5.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  '${controller.address[index]['address_street'] == 'Throttled! See geocode.xyz/pricing' ? 'مكان غير معروف' : controller.address[index]['address_street']}\n ${controller.address[index]['address_city']}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: myServices.sharedPreferences.getInt("activeAddress") ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black26,
                                                                    fontFamily:
                                                                        'ElMessiri',
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Icon(
                                                                EneftyIcons
                                                                    .info_circle_bold,
                                                                color: myServices
                                                                            .sharedPreferences
                                                                            .getInt(
                                                                                "activeAddress") ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Color(
                                                                        0xffFF7A2F),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  Container(
                    height: 25.h,
                    width: 100.w,
                    child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: 15.h,
                            width: 100.w,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(1.w, 0, 1.w, 0.h),
                              child: TextFormField(
                                maxLines: 3,
                                style: TextStyle(
                                  height: 0.2.h,
                                  fontSize: 11.sp,
                                  fontFamily: 'ElMessiri',
                                  letterSpacing: 1,
                                ),
                                controller: controller.description,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.5.h, horizontal: 3.w),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: AppColor.grey),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: AppColor.grey),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: AppColor.red),
                                  ),
                                  labelText: 'ملاحظات إضافية',
                                  labelStyle: TextStyle(
                                    height: 0.2.h,
                                    fontSize: 11.sp,
                                    fontFamily: 'ElMessiri',
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 90.w,
                          height: 7.h,
                          child: ElevatedButton(
                            onPressed: () {
                              myServices.sharedPreferences
                                          .getInt("addressid") ==
                                      null
                                  ? null
                                  : controller.checkout(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: myServices.sharedPreferences
                                          .getInt("addressid") ==
                                      null
                                  ? Colors.grey
                                  : Color(0xffFF7A2F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: controller.statusRequest ==
                                      StatusRequest.loading
                                  ? Transform.scale(
                                      scale: 5,
                                      child: Lottie.asset(
                                          AppImageAsset.dotsloading))
                                  : Text(
                                      'تأكيد الطلب',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class YourShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      height: 62.h,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xffFF7A2F),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                height: 14.h,
                width: 90.w,
                margin: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
                decoration: BoxDecoration(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 2.h,
                                width: 30.w,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 2.h,
                                  width: 30.w,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
