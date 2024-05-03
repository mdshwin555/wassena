import 'dart:math';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../controller/Home/RestaurantsController.dart';
import '../../../controller/Home/RestaurantsControllerByID.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'ProductDetails.dart';

class RestaurantsItemsID extends StatelessWidget {
  const RestaurantsItemsID({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantsByIDControllerImp restaurantsController =
        Get.put(RestaurantsByIDControllerImp());
    MyServices myServices = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GetBuilder<RestaurantsByIDControllerImp>(
          builder: (controller) => controller.statusRequest ==
              StatusRequest.loading||controller.restaurants.isEmpty
              ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: YourShimmerWidget(), // Replace with your shimmer widget
          )
              :Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 44.h,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 0.h,
                                child: Container(
                                  width: 100.w,
                                  height: 27.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                        '${AppLink.restaurants_image}/${controller.restaurants[0]['restaurants_background_image']}'),
                                    fit: BoxFit.fill,
                                  )),
                                ),
                              ),
                              Positioned(
                                top: 20.h,
                                child: Container(
                                  height: 22.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.sp),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 3.h,
                                right: 5.w,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: CircleAvatar(
                                    radius: 18.sp,
                                    backgroundColor: AppColor.secondaryColor,
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 17.h,
                                child: Container(
                                  height: 9.h,
                                  width: 9.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100.sp),
                                    border: Border.all(
                                        color: Colors.white, width: 0.1.w),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${AppLink.restaurants_image}/${controller.restaurants[0]['restaurants_logo']}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 26.h,
                                child: Text(
                                  '${controller.restaurants[0]['restaurants_name']}',
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontFamily: 'ElMessiri',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp),
                                ),
                              ),
                              Positioned(
                                top: 22.h,
                                right: 10.w,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImageAsset.star,
                                      height: 2.h,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Transform.translate(
                                      offset: Offset(0,0.5.h),
                                      child: Text(
                                        '${controller.restaurants[0]['restaurants_rating']}',
                                        style: TextStyle(
                                          color: AppColor.grey,
                                          fontFamily: 'ElMessiri',
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 30.h,
                                child: Text(
                                  '${controller.restaurants[0]['restaurants_type']}',
                                  style: TextStyle(
                                      color: AppColor.grey,
                                      fontFamily: 'ElMessiri',
                                      fontSize: 11.sp),
                                ),
                              ),
                              Positioned(
                                top: 32.8.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    controller.restaurants[
                                    0]
                                    ['restaurants_is24'] ==
                                        1
                                        ? Text(
                                      '24/24',
                                      style: TextStyle(
                                        color: AppColor.grey,
                                        fontFamily: 'ElMessiri',
                                        fontSize: 10.sp,
                                      ),
                                    )
                                        : Text(
                                      // Call _formatTime function to display time in 12-hour format
                                      '${controller.formatTime(controller.restaurants[0]['restaurants_open'])} - ${controller.formatTime(controller.restaurants[0]['restaurants_close'])}',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: AppColor.grey,
                                        fontFamily: 'ElMessiri',
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 36.h,
                                child: Container(
                                  width: 75.w,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppImageAsset.delivery,
                                              height: 3.h,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, 0.4.h),
                                              child:controller.distance==null?SizedBox(): Text(
                                                '${controller.addCommasToNumber((((controller.distance! * 2000).toInt() + 250) ~/ 500) * 500)} ل.س ',
                                                style: TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                  fontSize: 9.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              EneftyIcons.map_2_bold,
                                              color: AppColor.secondaryColor,
                                                size: 19.sp,
                                              ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0,0.2.h),
                                              child: Text(
                                                ' ${controller.distance?.toStringAsFixed(2)} كم ',
                                                style: TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                  fontSize: 9.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppImageAsset.alarm,
                                              height: 3.h,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0,0.5.h),
                                              child: Text(
                                                '${controller.duration?.toStringAsFixed(0)} د ',
                                                style: TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                  fontSize: 9.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              controller.restaurants[0]
                                          ['restaurants_is24'] ==
                                      1
                                  ? Positioned(
                                      top: 24.h,
                                      left: 55.w,
                                      child: CircleAvatar(
                                        radius: 5.sp,
                                        backgroundColor: Color(0xff26da12),
                                      ),
                                    )
                                  : controller.isRestaurantOpen(
                                              controller.restaurants[0]) ==
                                          true
                                      ? Positioned(
                                          top: 24.h,
                                          left: 55.w,
                                          child: CircleAvatar(
                                            radius: 5.sp,
                                            backgroundColor: Color(0xff26da12),
                                          ),
                                        )
                                      : Positioned(
                                          top: 24.h,
                                          left: 55.w,
                                          child: CircleAvatar(
                                            radius: 5.sp,
                                            backgroundColor: Colors.grey,
                                          ),
                                        ),
                            ],
                          ),
                        ),
                        controller.statusRequest == StatusRequest.loading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child:
                                    YourShimmerWidget(), // Replace with your shimmer widget
                              )
                            : controller.items.isEmpty
                                ? Center(
                                    child: Column(
                                      children: [
                                        Lottie.asset(
                                          AppImageAsset.emptyitems,
                                          height: 23.h,
                                        ),
                                        const Text(
                                          'لا يوجد أصناف بعد',
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily: 'ElMessiri',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 75.h,
                                    padding: EdgeInsets.only(top: 1.h),
                                    margin: EdgeInsets.only(
                                      left: 1.w,
                                      right: 1.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: 4.w,
                                            bottom: 1.h,
                                          ),
                                          child: Text(
                                            'المنتجات :',
                                            style: TextStyle(
                                              color: AppColor.black,
                                              fontFamily: 'ElMessiri',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 68.h,
                                          child: GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 0.1,
                                              mainAxisSpacing: 2,
                                              childAspectRatio: 0.92,
                                            ),
                                            itemCount: controller.items.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  myServices.sharedPreferences
                                                      .setString("items_id",
                                                          "${controller.items[index]['items_id']}");
                                                  Get.to(ProductDetails());
                                                },
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Container(
                                                    margin: EdgeInsets.all(1.w),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.sp),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Hero(
                                                              tag: controller
                                                                          .items[
                                                                      index]
                                                                  ['items_id'],
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .vertical(
                                                                            top:
                                                                                Radius.circular(10.sp)),
                                                                child:
                                                                    Container(
                                                                  height: 14.h,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top:
                                                                                Radius.circular(10.sp)),
                                                                  ),
                                                                  child:
                                                                      ProgressiveImage(
                                                                    width:
                                                                        300.0,
                                                                    image:
                                                                        '${AppLink.items_image}/${controller.items[index]['items_image']}',
                                                                    height:
                                                                        200.0,
                                                                    imageError:
                                                                        AppImageAsset
                                                                            .shimmarimageeror,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            controller.items[
                                                                            index]
                                                                        [
                                                                        'items_discount'] ==
                                                                    0
                                                                ? SizedBox()
                                                                : Transform
                                                                    .translate(
                                                                    offset: Offset(
                                                                        -2.w,
                                                                        -1.5.h),
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          AppImageAsset
                                                                              .offer,
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Text(
                                                                          '%${controller.items[index]['items_discount']}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11.sp,
                                                                            color:
                                                                                Colors.white,
                                                                            fontFamily:
                                                                                'ElMessiri',
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 2.w,
                                                                  left: 2.w),
                                                          child: FittedBox(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  controller.items[
                                                                          index]
                                                                      [
                                                                      'items_name_ar'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        'ElMessiri',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 2.w,
                                                                  left: 2.w),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .addToCart(
                                                                    index,
                                                                    '${controller.items[index]['items_id']}',
                                                                    '0',
                                                                  );
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  AppImageAsset
                                                                      .addtocart,
                                                                  height: 3.5.h,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 1.h),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Directionality(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    child: controller.items[index]['items_discount'] ==
                                                                            0
                                                                        ? Text(
                                                                            '${controller.items[index]['items_price']} ل.س ',
                                                                            textDirection:
                                                                                TextDirection.rtl,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 10.sp,
                                                                              color: AppColor.secondaryColor2,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'ElMessiri',
                                                                            ),
                                                                          )
                                                                        : FittedBox(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  '${(controller.items[index]['items_price'] - controller.items[index]['items_price'] * (controller.items[index]['items_discount'] / 100)).toInt()} ل.س ',
                                                                                  textDirection: TextDirection.rtl,
                                                                                  style: TextStyle(
                                                                                    fontSize: 10.sp,
                                                                                    color: AppColor.secondaryColor2,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontFamily: 'ElMessiri',
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  '${controller.items[index]['items_price']}',
                                                                                  textDirection: TextDirection.rtl,
                                                                                  style: TextStyle(
                                                                                    decoration: TextDecoration.lineThrough,
                                                                                    fontSize: 9.sp,
                                                                                    color: Colors.grey,
                                                                                    fontFamily: 'ElMessiri',
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                  ),
                                                                ],
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
                                        ),
                                      ],
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
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
      width: 100.w,
      height: 100.h,
      margin: EdgeInsets.only(left: 1.w, right: 1.w),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 60.h,
              width: 100.w,
              padding: EdgeInsets.only(top: 3.h),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.1,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.95,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      margin: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 14.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.sp)),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(2.w, 11.5.h),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 5.5.h,
                                      width: 5.5.h,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(100.sp),
                                        border: Border.all(
                                            color: AppColor.secondaryColor,
                                            width: 0.3.w),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.h,
                                      right: 0.w,
                                      child: CircleAvatar(
                                        radius: 5.sp,
                                        backgroundColor: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Padding(
                            padding: EdgeInsets.only(right: 2.w, left: 1.w),
                            child: FittedBox(
                              child: Container(
                                height: 2.h,
                                width: 15.w,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 2.h,
                                  width: 15.w,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


