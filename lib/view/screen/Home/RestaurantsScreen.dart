import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/RestaurantsController.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'RestaurantsItemsScreen.dart';
import 'dart:math';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantsControllerImp controller = Get.put(RestaurantsControllerImp());
    HomeControllerImp homeController = Get.put(HomeControllerImp());
    controller.viewrestaurants();
    MyServices myServices = Get.find();

    return GetBuilder<RestaurantsControllerImp>(
      builder: (controller) => Scaffold(
        body: Container(
          height: 100.h,
          child: Column(
            children: [
              homeController.categories.isEmpty
                  ? Container(
                      width: 100.w,
                      height: 15.h,
                      margin: EdgeInsets.only(left: 1.w, right: 1.w),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.w, 2.h, 5.w, 0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30.sp,
                                    backgroundColor:
                                    AppColor.secondaryColor.withOpacity(0.60),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: 15.w,
                                    color: AppColor.secondaryColor.withOpacity(0.60),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 3.w,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                      height: 14.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: homeController.categories.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              myServices.sharedPreferences.setInt(
                                  "categoryid",
                                  homeController.categories[index]
                                      ['categories_id']);
                              myServices.sharedPreferences
                                  .setInt("selectedcategory", index);
                              controller.viewrestaurants();
                            },
                            child: SizedBox(
                              width: 20.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 8.h,
                                    padding: EdgeInsets.all(1.w),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(50.sp),
                                      color: AppColor.secondaryColor
                                          .withOpacity(0.60),
                                    ),
                                    child: Image.network(
                                      '${AppLink.categories_image}/${homeController.categories[index]['categories_image']}',
                                      height: 8.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      homeController.categories[index]
                                          ['categories_name_ar'],
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: myServices.sharedPreferences
                                                .getInt("selectedcategory") ==
                                            index
                                        ? AppColor.secondaryColor2
                                        : Colors.white,
                                    thickness: 0.3.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 3.w,
                          );
                        },
                      ),
                    ),
              controller.statusRequest == StatusRequest.loading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child:
                          YourShimmerWidget(), // Replace with your shimmer widget
                    )
                  : Container(
                      width: 100.w,
                      height: 60.h,
                      margin: EdgeInsets.only(left: 1.w, right: 1.w),
                      child: Column(
                        children: [
                          controller.restaurants.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Lottie.asset(
                                        AppImageAsset.emptyrestaurants,
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      const Text(
                                        'عذرا لا  يوجد متاجر بعد',
                                        style: TextStyle(
                                          color: AppColor.grey,
                                          fontFamily: 'ElMessiri',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    height: 60.h,
                                    width: 100.w,
                                    padding: EdgeInsets.only(top: 1.h),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0.1,
                                        mainAxisSpacing: 2,
                                        childAspectRatio: 0.93,
                                      ),
                                      itemCount: controller.restaurants.length,
                                      itemBuilder: (context, index) {

                                        return Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: GestureDetector(
                                            onTap: () {
                                              myServices.sharedPreferences
                                                  .setString(
                                                      "restaurants_name",
                                                      controller.restaurants[
                                                              index]
                                                          ['restaurants_name']);
                                              myServices.sharedPreferences
                                                  .setInt(
                                                      "restaurants_id",
                                                      controller.restaurants[
                                                              index]
                                                          ['restaurants_id']);
                                              myServices.sharedPreferences
                                                  .setInt("restaurants_index",
                                                      index);
                                              myServices.sharedPreferences
                                                          .getString(
                                                              "users_phone") ==
                                                      null
                                                  ? controller
                                                      .viewitemsrestaurantsnoauth()
                                                  : controller
                                                      .viewitemsrestaurants();

                                               controller.calculateDistance(
                                                  controller.lat == null
                                                      ? 33.555555
                                                      : controller.lat!,
                                                  controller.long == null
                                                      ? 33.55555
                                                      : controller.long!,
                                                  controller.restaurants[index]
                                                  ['restaurants_lat'],
                                                  controller.restaurants[index]
                                                  ['restaurants_long']);

                                              Get.to(RestaurantsItemsScreen());
                                            },
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
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Hero(
                                                        tag: controller
                                                                    .restaurants[
                                                                index]
                                                            ['restaurants_id'],
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          10.sp)),
                                                          child: Container(
                                                            height: 14.h,
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                ProgressiveImage(
                                                              width: 300.0,
                                                              image:
                                                                  '${AppLink.restaurants_image}/${controller.restaurants[index]['restaurants_background_image']}',
                                                              height: 200.0,
                                                              imageError:
                                                                  AppImageAsset
                                                                      .shimmarimageeror,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Transform.translate(
                                                        offset:
                                                            Offset(2.w, 11.5.h),
                                                        child: Stack(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100.sp),
                                                              child: Container(
                                                                height: 5.5.h,
                                                                width: 5.5.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    100.sp,
                                                                  ),
                                                                ),
                                                                child:
                                                                    ProgressiveImage(
                                                                  height: 5.5.h,
                                                                  width: 5.5.h,
                                                                  image:
                                                                      '${AppLink.restaurants_image}/${controller.restaurants[index]['restaurants_logo']}',
                                                                  imageError:
                                                                      AppImageAsset
                                                                          .shimmarimageeror,
                                                                ),
                                                              ),
                                                            ),
                                                            controller.restaurants[
                                                                            index]
                                                                        [
                                                                        'restaurants_is24'] ==
                                                                    1
                                                                ? Positioned(
                                                                    bottom: 0.h,
                                                                    right: 0.w,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          5.sp,
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xff26da12),
                                                                    ),
                                                                  )
                                                                : controller.isRestaurantOpen(
                                                                            controller.restaurants[index]) ==
                                                                        true
                                                                    ? Positioned(
                                                                        bottom:
                                                                            0.h,
                                                                        right:
                                                                            0.w,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              5.sp,
                                                                          backgroundColor:
                                                                              Color(0xff26da12),
                                                                        ),
                                                                      )
                                                                    : Positioned(
                                                                        bottom:
                                                                            0.h,
                                                                        right:
                                                                            0.w,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              5.sp,
                                                                          backgroundColor:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 2.w, left: 1.w),
                                                    child: FittedBox(
                                                      child: Text(
                                                        controller.restaurants[
                                                                index][
                                                            'restaurants_name'],
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'ElMessiri',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.5.h),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 2.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          controller.restaurants[
                                                                  index][
                                                              'restaurants_type'],
                                                          style: TextStyle(
                                                            fontSize: 9.sp,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // controller.restaurants[index][
                                                  //             'restaurants_deliveryprice'] ==
                                                  //         0
                                                  //     ? Container(
                                                  //         height: 2.8.h,
                                                  //         width: 25.w,
                                                  //         margin:
                                                  //             EdgeInsets.only(
                                                  //           right: 2.w,
                                                  //         ),
                                                  //         alignment:
                                                  //             Alignment.center,
                                                  //         decoration: BoxDecoration(
                                                  //             color: Color(
                                                  //                     0xffFF7A2F)
                                                  //                 .withOpacity(
                                                  //                     0.20),
                                                  //             borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(
                                                  //                         15.sp)),
                                                  //         child: Text(
                                                  //           'توصيل مجاني',
                                                  //           style: TextStyle(
                                                  //             fontSize: 10.sp,
                                                  //             color: Color(
                                                  //                 0xffFF7A2F),
                                                  //             fontFamily:
                                                  //                 'ElMessiri',
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     :
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(
                                                  //       right: 2.w, top: 1.h),
                                                  //   child: FittedBox(
                                                  //     child: Text(
                                                  //       'قيمة التوصيل:  ل.س ',
                                                  //       textAlign:
                                                  //           TextAlign.right,
                                                  //       style: TextStyle(
                                                  //         fontSize: 9.sp,
                                                  //         color: Colors.black54,
                                                  //         fontFamily:
                                                  //             'ElMessiri',
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
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

class YourShimmerWidget extends StatelessWidget {
  const YourShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 66.h,
      margin: EdgeInsets.only(left: 1.w, right: 1.w),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 60.h,
          width: 100.w,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.1,
              mainAxisSpacing: 2,
              childAspectRatio: 0.95,
            ),
            itemCount: 4,
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
                                    borderRadius: BorderRadius.circular(100.sp),
                                    border: Border.all(
                                        color: AppColor.secondaryColor2, width: 0.3.w),
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
    );
  }
}

class YourShimmerWidget2 extends StatelessWidget {
  const YourShimmerWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 15.h,
      margin: EdgeInsets.only(left: 1.w, right: 1.w),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.w, 2.h, 5.w, 0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 30.sp,
                    backgroundColor: AppColor.secondaryColor.withOpacity(0.60),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    height: 2.h,
                    width: 15.w,
                    color: Colors.blue,
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 3.w,
              );
            },
          ),
        ),
      ),
    );
  }
}
