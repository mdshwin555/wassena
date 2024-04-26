import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../controller/Home/OrdersController.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/services/services.dart';
import 'package:badges/badges.dart' as badges;
import 'OrdersDetailsScreen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    Get.put(OrdersControllerImp());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GetBuilder<OrdersControllerImp>(
          builder: (controller) => Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.fromLTRB(4.w, 2.h, 3.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectTab(0);
                          controller.getPinding();
                        },
                        child: controller.pinding.isNotEmpty
                            ? badges.Badge(
                                badgeContent: Text(
                                  '${controller.pinding.length}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 25.w,
                                  height: 5.h,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: controller.selectedIndex.value == 0
                                        ? Color(0xffFF7A2F)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.timelapse_rounded,
                                        color:
                                            controller.selectedIndex.value == 0
                                                ? Colors.white
                                                : Colors.grey,
                                        size: 11.sp,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        'معلقة',
                                        style: TextStyle(
                                          color:
                                              controller.selectedIndex.value ==
                                                      0
                                                  ? Colors.white
                                                  : Colors.grey,
                                          fontFamily: 'ElMessiri',
                                          fontWeight:
                                              controller.selectedIndex == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: 25.w,
                                height: 5.h,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value == 0
                                      ? Color(0xffFF7A2F)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.timelapse_rounded,
                                      color: controller.selectedIndex.value == 0
                                          ? Colors.white
                                          : Colors.grey,
                                      size: 11.sp,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      'معلقة',
                                      style: TextStyle(
                                        color:
                                            controller.selectedIndex.value == 0
                                                ? Colors.white
                                                : Colors.grey,
                                        fontFamily: 'ElMessiri',
                                        fontWeight:
                                            controller.selectedIndex == 0
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectTab(1);
                          controller.getOnWay();
                        },
                        child: controller.onway.isNotEmpty
                            ? badges.Badge(
                                badgeContent: Text(
                                  '${controller.onway.length}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: Container(
                                  width: 27.w,
                                  height: 5.h,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: controller.selectedIndex.value == 1
                                        ? Color(0xffFF7A2F)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.done_outline_outlined,
                                        color:
                                            controller.selectedIndex.value == 1
                                                ? Colors.white
                                                : Colors.grey,
                                        size: 11.sp,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        'عالطريق',
                                        style: TextStyle(
                                          color:
                                              controller.selectedIndex.value ==
                                                      1
                                                  ? Colors.white
                                                  : Colors.grey,
                                          fontFamily: 'ElMessiri',
                                          fontWeight:
                                              controller.selectedIndex == 1
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                width: 27.w,
                                height: 5.h,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value == 1
                                      ? Color(0xffFF7A2F)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.done_outline_outlined,
                                      color: controller.selectedIndex.value == 1
                                          ? Colors.white
                                          : Colors.grey,
                                      size: 11.sp,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      'عالطريق',
                                      style: TextStyle(
                                        color:
                                            controller.selectedIndex.value == 1
                                                ? Colors.white
                                                : Colors.grey,
                                        fontFamily: 'ElMessiri',
                                        fontWeight:
                                            controller.selectedIndex == 1
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectTab(2);
                          controller.getArchive();
                        },
                        child: controller.archive.isNotEmpty
                            ? badges.Badge(
                                badgeContent: Text(
                                  '${controller.archive.length}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 27.w,
                                  height: 5.h,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: controller.selectedIndex.value == 2
                                        ? Color(0xffFF7A2F)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_done_rounded,
                                        color:
                                            controller.selectedIndex.value == 2
                                                ? Colors.white
                                                : Colors.grey,
                                        size: 11.sp,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        'مستلمة',
                                        style: TextStyle(
                                          color:
                                              controller.selectedIndex.value ==
                                                      2
                                                  ? Colors.white
                                                  : Colors.grey,
                                          fontFamily: 'ElMessiri',
                                          fontWeight:
                                              controller.selectedIndex == 2
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: 27.w,
                                height: 5.h,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value == 2
                                      ? Color(0xffFF7A2F)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_done_rounded,
                                      color: controller.selectedIndex.value == 2
                                          ? Colors.white
                                          : Colors.grey,
                                      size: 11.sp,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      'مستلمة',
                                      style: TextStyle(
                                        color:
                                            controller.selectedIndex.value == 2
                                                ? Colors.white
                                                : Colors.grey,
                                        fontFamily: 'ElMessiri',
                                        fontWeight:
                                            controller.selectedIndex == 2
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  switch (controller.selectedIndex.value) {
                    case 0:
                      return myServices.sharedPreferences
                          .getString("users_phone") ==
                          null
                          ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Lottie.asset(
                              AppImageAsset.emptyorders,
                              height: 25.h,
                            ),
                            Column(
                              children: [
                                Text(
                                  'ليس لديك أوردرات بعد',
                                  style: const TextStyle(
                                    color: AppColor.grey,
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'هيا سجل دخول لنملأ سجل الطلبات',
                                  style: const TextStyle(
                                    color: AppColor.grey,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                          :controller.statusRequest == StatusRequest.loading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child:
                                  YourShimmerWidget(), // Replace with your shimmer widget
                            )
                          : controller.pinding.length == 0
                              ?  Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Lottie.asset(
                                            AppImageAsset.emptyorders,
                                            height: 25.h,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'ليس لديك أوردرات بعد',
                                                style: const TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                'هيا نملأ سجل الطلبات',
                                                style: const TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: ListView.builder(
                                      itemCount: controller.pinding.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            myServices.sharedPreferences.setString(
                                                "orders_id",
                                                "${controller.pinding[index]['orders_id']}");
                                            controller.getDetails();
                                            Get.to(OrdersDetails());
                                          },
                                          child: Card(
                                            child: Container(
                                              height: 15.h,
                                              width: 90.w,
                                              padding: EdgeInsets.fromLTRB(
                                                  4.w, 0, 4.w, 0),
                                              decoration: BoxDecoration(),
                                              child: FittedBox(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          ' ${Jiffy.parse('${controller.pinding[index]['orders_datetime']}').fromNow()}',
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Color(
                                                                0xffFF7A2F),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            myServices
                                                                .sharedPreferences
                                                                .setString(
                                                                    "orders_id",
                                                                    "${controller.pinding[index]['orders_id']}");
                                                            controller.removeorder(
                                                                "${controller.pinding[index]['orders_id']}");
                                                            controller
                                                                .getPinding();
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .delete_outline_rounded,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 28.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'رقم الطلب : ${controller.pinding[index]['orders_id']}',
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            " السعر : ${controller.pinding[index]['orders_price']} ل.س ",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'ElMessiri',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            " التوصيل : ${controller.pinding[index]['orders_pricedelivery']}",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  'ElMessiri',
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
                                        );
                                      },
                                    ),
                                  ),
                                );
                    case 1:
                      return myServices.sharedPreferences
                          .getString("users_phone") ==
                          null
                          ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Lottie.asset(
                              AppImageAsset.emptyorders,
                              height: 25.h,
                            ),
                            Column(
                              children: [
                                Text(
                                  'ليس لديك أوردرات بعد',
                                  style: const TextStyle(
                                    color: AppColor.grey,
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'هيا سجل دخول لنملأ سجل الطلبات',
                                  style: const TextStyle(
                                    color: AppColor.grey,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                          :controller.statusRequest == StatusRequest.loading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child:
                                  YourShimmerWidget(), // Replace with your shimmer widget
                            )
                          : controller.onway.length == 0
                              ?  Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Lottie.asset(
                                            AppImageAsset.emptyorders,
                                            height: 25.h,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'ليس لديك أوردرات بعد',
                                                style: const TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                'هيا نملأ سجل الطلبات',
                                                style: const TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: ListView.builder(
                                      itemCount: controller.onway.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            myServices.sharedPreferences.setString(
                                                "orders_id",
                                                "${controller.onway[index]['orders_id']}");
                                            controller.getDetails();
                                            Get.to(OrdersDetails());
                                          },
                                          child: Card(
                                            child: Container(
                                              height: 15.h,
                                              width: 90.w,
                                              padding: EdgeInsets.fromLTRB(
                                                  3.w, 0, 3.w, 0),
                                              decoration: BoxDecoration(),
                                              child: FittedBox(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          ' ${Jiffy.parse('${controller.onway[index]['orders_datetime']}').fromNow()}',
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Color(
                                                                0xffFF7A2F),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 28.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '  رقم الطلب :${controller.onway[index]['orders_id']}',
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            " السعر : ${controller.onway[index]['orders_price']}ل.س ",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'ElMessiri',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            " التوصيل : ${controller.onway[index]['orders_pricedelivery']}",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  'ElMessiri',
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
                                        );
                                      },
                                    ),
                                  ),
                                );
                    case 2:
                      return myServices.sharedPreferences
                          .getString("users_phone") ==
                          null
                          ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Lottie.asset(
                              AppImageAsset.emptyorders,
                              height: 25.h,
                            ),
                            Column(
                              children: [
                                Text(
                                  'ليس لديك أوردرات بعد',
                                  style: const TextStyle(
                                    color: AppColor.grey,
                                    fontFamily: 'ElMessiri',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'هيا سجل دخول لنملأ سجل الطلبات',
                                  style: const TextStyle(
                                    color: AppColor.grey,
                                    fontFamily: 'ElMessiri',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                          :controller.statusRequest == StatusRequest.loading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child:
                                  YourShimmerWidget(), // Replace with your shimmer widget
                            )
                          : controller.archive.length == 0
                              ?  Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Lottie.asset(
                                            AppImageAsset.emptyorders,
                                            height: 25.h,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'ليس لديك أوردرات بعد',
                                                style: const TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                'هيا نملأ سجل الطلبات',
                                                style: const TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: ListView.builder(
                                      itemCount: controller.archive.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            myServices.sharedPreferences.setString(
                                                "orders_id",
                                                "${controller.archive[index]['orders_id']}");
                                            controller.getDetails();
                                            Get.to(OrdersDetails());
                                          },
                                          child: Card(
                                            child: Container(
                                              height: 15.h,
                                              width: 90.w,
                                              padding: EdgeInsets.fromLTRB(
                                                  0.w, 0, 3.w, 0),
                                              decoration: BoxDecoration(),
                                              child: FittedBox(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          ' ${Jiffy.parse('${controller.archive[index]['orders_datetime']}').fromNow()}',
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Color(
                                                                0xffFF7A2F),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 28.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '  رقم الطلب :${controller.archive[index]['orders_id']}',
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            " السعر : ${controller.archive[index]['orders_price']} ل.س ",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'ElMessiri',
                                                            ),
                                                          ),
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            " التوصيل : ${controller.archive[index]['orders_pricedelivery']}",
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  'ElMessiri',
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
                                        );
                                      },
                                    ),
                                  ),
                                );
                    default:
                      return Container();
                  }
                }),
              ),
            ],
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
      height: 80.h,
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
