import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/HomeScreen.dart';
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
    OrdersControllerImp controller = Get.put(OrdersControllerImp());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.offAll(HomeScreen());
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'الطلبات',
            style: TextStyle(
              color: AppColor.black,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: GetBuilder<OrdersControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: 5.h,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.selectTab(0);
                            controller.getPending();
                          },
                          child: controller.pending.isNotEmpty
                              ? badges.Badge(
                            badgeContent: Text(
                              '${controller.pending.length}',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: 23.w,
                              height: 5.h,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == 0
                                    ? AppColor.secondaryColor
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
                                      fontFamily: 'Cairo',
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
                                  ? AppColor.secondaryColor
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
                                    fontFamily: 'Cairo',
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
                        SizedBox(width: 3.w,),
                        GestureDetector(
                          onTap: () {
                            controller.selectTab(1);
                            controller.getPreparing();
                          },
                          child: controller.preparing.isNotEmpty
                              ? badges.Badge(
                            badgeContent: Text(
                              '${controller.preparing.length}',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: Container(
                              width: 26.w,
                              height: 5.h,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == 1
                                    ? AppColor.secondaryColor
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
                                    'بالتحضير',
                                    style: TextStyle(
                                      color:
                                      controller.selectedIndex.value ==
                                          1
                                          ? Colors.white
                                          : Colors.grey,
                                      fontFamily: 'Cairo',
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
                            width: 26.w,
                            height: 5.h,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: controller.selectedIndex.value == 1
                                  ? AppColor.secondaryColor
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
                                  'بالتحضير',
                                  style: TextStyle(
                                    color:
                                    controller.selectedIndex.value == 1
                                        ? Colors.white
                                        : Colors.grey,
                                    fontFamily: 'Cairo',
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
                        SizedBox(width: 3.w,),
                        GestureDetector(
                          onTap: () {
                            controller.selectTab(2);
                            controller.getOnWay();
                          },
                          child: controller.onway.isNotEmpty
                              ? badges.Badge(
                            badgeContent: Text(
                              '${controller.onway.length}',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: 27.w,
                              height: 5.h,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == 2
                                    ? AppColor.secondaryColor
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
                                    'عالطريق',
                                    style: TextStyle(
                                      color:
                                      controller.selectedIndex.value ==
                                          2
                                          ? Colors.white
                                          : Colors.grey,
                                      fontFamily: 'Cairo',
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
                                  ? AppColor.secondaryColor
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
                                  'عالطريق',
                                  style: TextStyle(
                                    color:
                                    controller.selectedIndex.value == 2
                                        ? Colors.white
                                        : Colors.grey,
                                    fontFamily: 'Cairo',
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
                        SizedBox(width: 3.w,),
                        GestureDetector(
                          onTap: () {
                            controller.selectTab(3);
                            controller.getarchive();
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
                                color: controller.selectedIndex.value == 3
                                    ? AppColor.secondaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_done_rounded,
                                    color:
                                    controller.selectedIndex.value == 3
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
                                          3
                                          ? Colors.white
                                          : Colors.grey,
                                      fontFamily: 'Cairo',
                                      fontWeight:
                                      controller.selectedIndex == 3
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
                              color: controller.selectedIndex.value == 3
                                  ? AppColor.secondaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_done_rounded,
                                  color: controller.selectedIndex.value == 3
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 11.sp,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  'مستلمة',
                                  style: TextStyle(
                                    color:
                                    controller.selectedIndex.value == 3
                                        ? Colors.white
                                        : Colors.grey,
                                    fontFamily: 'Cairo',
                                    fontWeight:
                                    controller.selectedIndex == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w,),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    switch (controller.selectedIndex.value) {
                      case 0:
                        return controller.statusRequest == StatusRequest.loading
                            ?RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(0);
                            controller.getPending();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: Shimmer.fromColors(
                                                        baseColor: Colors.grey[300]!,
                                                        highlightColor: Colors.grey[100]!,
                                                        child:
                                                        YourShimmerWidget(), // Replace with your shimmer widget
                                                      ),
                            )
                            : controller.pending.length == 0
                            ?  RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(0);
                            controller.getPending();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Center(
                                                          child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Lottie.asset(
                                    AppImageAsset.emptyitems,
                                    height: 25.h,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'ليس لديك أوردرات بعد',
                                        style: TextStyle(
                                          color: AppColor.grey,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 2.h,),
                                      InkWell(
                                        onTap: (){
                                          controller.selectTab(0);
                                          controller.getPending();
                                        },
                                        child: Text(
                                          'تحديث القائمة',
                                          style: TextStyle(
                                            color: AppColor.secondaryColor,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                                          ),
                                                        ),
                          ),
                            )
                            : RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(0);
                            controller.getPending();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child:Padding(
                                                        padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                                                        child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: ListView.builder(
                                itemCount: controller.pending.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      myServices.sharedPreferences.setString(
                                          "orders_id",
                                          "${controller.pending[index]['orders_id']}");
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
                                                    ' ${Jiffy.parse('${controller.pending[index]['orders_datetime']}').fromNow()}',
                                                    style: TextStyle(
                                                      fontSize: 19.sp,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Cairo',
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h,),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          myServices
                                                              .sharedPreferences
                                                              .setString(
                                                              "orders_id",
                                                              '${controller.pending[index]['orders_id']}');
                                                          controller.reject(
                                                            '${controller.pending[index]['orders_id']}',
                                                            '${controller.pending[index]['orders_usersid']}',
                                                          );
                                                        },
                                                        child: Container(
                                                          alignment:
                                                          Alignment.center,
                                                          width: 45.w,
                                                          height: 8.h,
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xffFC7A79),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(5.sp),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons.close,
                                                                color: Colors.white,
                                                                size: 17.sp,
                                                              ),
                                                              SizedBox(width: 1.w),
                                                               Text(
                                                                'رفض',
                                                                style: TextStyle(
                                                                  fontSize: 18.sp,
                                                                  color:
                                                                  Colors.white,
                                                                  fontFamily:
                                                                  'Cairo',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          myServices
                                                              .sharedPreferences
                                                              .setString(
                                                              "orders_id",
                                                              '${controller.pending[index]['orders_id']}');
                                                          controller.approve(
                                                            '${controller.pending[index]['orders_id']}',
                                                            '${controller.pending[index]['orders_usersid']}',
                                                          );
                                                        },
                                                        child: Container(
                                                          alignment:
                                                          Alignment.center,
                                                          width: 45.w,
                                                          height: 8.h,
                                                          decoration: BoxDecoration(
                                                            color: AppColor.secondaryColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(5.sp),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .done_outline_outlined,
                                                                color: Colors.white,
                                                                size: 17.sp,
                                                              ),
                                                              SizedBox(width: 1.w),
                                                               Text(
                                                                'قبول',
                                                                style: TextStyle(
                                                                  fontSize: 18.sp,
                                                                  color:
                                                                  Colors.white,
                                                                  fontFamily:
                                                                  'Cairo',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                    'رقم الطلب : ${controller.pending[index]['orders_id']}',
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Cairo',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      " السعر : ${controller.pending[index]['orders_totalprice']} ل.س ",
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.red,
                                                        fontFamily:
                                                        'Cairo',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      " التوصيل : ${controller.pending[index]['orders_pricedelivery']} ل.س ",
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color:
                                                        AppColor.secondaryColor,
                                                        fontFamily:
                                                        'Cairo',
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
                                                      ),
                            );
                      case 1:
                        return controller.statusRequest == StatusRequest.loading
                            ? RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(1);
                            controller.getPreparing();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child:Shimmer.fromColors(
                                                          baseColor: Colors.grey[300]!,
                                                          highlightColor: Colors.grey[100]!,
                                                          child:
                                                          YourShimmerWidget(), // Replace with your shimmer widget
                                                        ),
                              ),
                            )
                            : controller.preparing.length == 0
                            ?  RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(1);
                            controller.getPreparing();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Center(
                                                          child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Lottie.asset(
                                    AppImageAsset.emptyitems,
                                    height: 25.h,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'ليس لديك أوردرات بعد',
                                        style: const TextStyle(
                                          color: AppColor.grey,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                                          ),
                                                        ),
                              ),
                            )
                            : RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(1);
                            controller.getPreparing();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                                                        child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: ListView.builder(
                                itemCount: controller.preparing.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      myServices.sharedPreferences.setString(
                                          "orders_id",
                                          "${controller.preparing[index]['orders_id']}");
                                      myServices.sharedPreferences.setString(
                                          "orders_usersid",
                                          "${controller.preparing[index]['orders_usersid']}");
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
                                                    ' ${Jiffy.parse('${controller.preparing[index]['orders_datetime']}').fromNow()}',
                                                    style: TextStyle(
                                                      fontSize: 8.sp,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Cairo',
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h,),
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     myServices.sharedPreferences
                                                  //         .setString("orders_id",
                                                  //         '${controller.preparing[index]['orders_id']}');
                                                  //     controller.prepare(
                                                  //       '${myServices.sharedPreferences.getString(
                                                  //           "orders_id")}',
                                                  //       '${myServices.sharedPreferences.getString(
                                                  //           "orders_usersid")}',
                                                  //     );
                                                  //   },
                                                  //   child: Container(
                                                  //     alignment: Alignment.center,
                                                  //     width: 35.w,
                                                  //     height: 5.h,
                                                  //     decoration: BoxDecoration(
                                                  //       color:
                                                  //       AppColor.secondaryColor,
                                                  //       borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           5.sp),
                                                  //     ),
                                                  //     child: Row(
                                                  //       mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .center,
                                                  //       children: [
                                                  //         Icon(
                                                  //           Icons
                                                  //               .done_outline_outlined,
                                                  //           color: Colors.white,
                                                  //           size: 9.sp,
                                                  //         ),
                                                  //         SizedBox(width: 1.w),
                                                  //          Text(
                                                  //           'إنتهاء التحضير',
                                                  //           style: TextStyle(
                                                  //             fontSize: 8.sp,
                                                  //             color: Colors.white,
                                                  //             fontFamily:
                                                  //             'Cairo',
                                                  //             fontWeight:
                                                  //             FontWeight.bold,
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .end,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(
                                                    '  رقم الطلب :${controller.preparing[index]['orders_id']}',
                                                    style: TextStyle(
                                                      fontSize: 9.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Cairo',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      " السعر : ${controller.addCommasToNumber(controller.preparing[index]['orders_totalprice'])} ل.س",
                                                      style: TextStyle(
                                                        fontSize: 8.sp,
                                                        color: Colors.red,
                                                        fontFamily:
                                                        'Cairo',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      " توصيل: ${controller.preparing[index]['orders_pricedelivery']} ل.س ",
                                                      style: TextStyle(
                                                        fontSize: 8.sp,
                                                        color:
                                                        AppColor.secondaryColor2,
                                                        fontFamily:
                                                        'Cairo',
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
                                                      ),
                            );
                      case 2:
                        return controller.statusRequest == StatusRequest.loading
                            ? RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(2);
                            controller.getOnWay();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Shimmer.fromColors(
                                                          baseColor: Colors.grey[300]!,
                                                          highlightColor: Colors.grey[100]!,
                                                          child:
                                                          YourShimmerWidget(), // Replace with your shimmer widget
                                                        ),
                              ),
                            )
                            : controller.onway.length == 0
                            ? RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(2);
                            controller.getOnWay();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Center(
                                                          child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Lottie.asset(
                                    AppImageAsset.emptyitems,
                                    height: 25.h,
                                  ),
                                  const Column(
                                    children: [
                                      Text(
                                        'ليس لديك أوردرات بعد',
                                        style: TextStyle(
                                          color: AppColor.grey,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                                          ),
                                                        ),
                              ),
                            )
                            : RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(2);
                            controller.getOnWay();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: Padding(
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
                                      myServices.sharedPreferences.setString(
                                          "orders_usersid",
                                          "${controller.onway[index]['orders_usersid']}");
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
                                                    ' ${Jiffy.parse('${controller.onway[index]['orders_datetime']}').fromNow()}',
                                                    style: TextStyle(
                                                      fontSize: 8.sp,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Cairo',
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h,),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // controller.getCurrentLocation();
                                                      // Get.to(TrackingScreen());
                                                      // myServices.sharedPreferences
                                                      //     .setString("orders_id",
                                                      //     '${controller.onway[index]['orders_id']}');
                                                      // controller.approve(
                                                      //   '${controller.onway[index]['orders_id']}',
                                                      //   '${controller.onway[index]['orders_usersid']}',
                                                      // );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        width: 35.w,
                                                        height: 5.h,
                                                        decoration: BoxDecoration(
                                                          color:
                                                          AppColor.secondaryColor,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5.sp),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .delivery_dining,
                                                              color: Colors.white,
                                                              size: 14.sp,
                                                            ),
                                                            SizedBox(width: 1.w),
                                                             Text(
                                                              'تتبع الديلفري',
                                                              style: TextStyle(
                                                                fontSize: 8.sp,
                                                                color: Colors.white,
                                                                fontFamily:
                                                                'Cairo',
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                                                      fontSize: 10.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Cairo',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),

                                                  FittedBox(
                                                    child: Text(
                                                      "  السعر : ${controller.addCommasToNumber(controller.onway[index]['orders_totalprice'])} ل.س",
                                                      style: TextStyle(
                                                        fontSize: 9.sp,
                                                        color: Colors.red,
                                                        fontFamily:
                                                        'Cairo',
                                                      ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      " + ${controller.onway[index]['orders_pricedelivery']}",
                                                      style: TextStyle(
                                                        fontSize: 9.sp,
                                                        color:
                                                        AppColor.secondaryColor2,
                                                        fontFamily:
                                                        'Cairo',
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
                                                      ),
                            );

                      case 3:
                        return controller.statusRequest == StatusRequest.loading
                            ? RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(3);
                            controller.getarchive();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child:  Shimmer.fromColors(
                                                          baseColor: Colors.grey[300]!,
                                                          highlightColor: Colors.grey[100]!,
                                                          child:
                                                          YourShimmerWidget(), // Replace with your shimmer widget
                                                        ),
                              ),
                            )
                            : controller.archive.length == 0
                            ?  RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(3);
                            controller.getarchive();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Center(
                                                          child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Lottie.asset(
                                    AppImageAsset.emptyitems,
                                    height: 25.h,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'ليس لديك أوردرات بعد',
                                        style: const TextStyle(
                                          color: AppColor.grey,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                                          ),
                                                        ),
                              ),
                            )
                            : RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(Duration(seconds: 2));
                            controller.selectTab(3);
                            controller.getarchive();
                          },
                          color: Colors.white,
                          backgroundColor: AppColor.secondaryColor,
                          child: Padding(
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
                                      myServices.sharedPreferences.setString(
                                          "orders_usersid",
                                          "${controller.archive[index]['orders_usersid']}");
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
                                                      'Cairo',
                                                    ),
                                                  ),
                                                ],
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
                                                      'Cairo',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      " السعر : ${controller.archive[index]['orders_totalprice']} ل.س ",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.red,
                                                        fontFamily:
                                                        'Cairo',
                                                      ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      " + ${controller.archive[index]['orders_pricedelivery']}",
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color:
                                                        Colors.green,
                                                        fontFamily:
                                                        'Cairo',
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
                                                      ),
                            );
                      default:
                        return Container();
                    }
                  }),
                ),
              ],
            ),
            // TabBarView(
            //   children: [
            //     // controller.pending.length == 0
            //     //     ? Center(
            //     //         child: Column(
            //     //           children: [
            //     //             SizedBox(
            //     //               height: 12.h,
            //     //             ),
            //     //             Lottie.asset(
            //     //               AppImageAsset.emptyitems,
            //     //               height: 35.h,
            //     //             ),
            //     //             const Text(
            //     //               'لا يوجد أوردرات بعد',
            //     //               style: TextStyle(
            //     //                 color: AppColor.black,
            //     //                 fontFamily: 'Cairo',
            //     //                 fontWeight: FontWeight.w600,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       )
            //     //     : Padding(
            //     //         padding: EdgeInsets.symmetric(
            //     //             horizontal: 2.w, vertical: 1.h),
            //     //         child: Directionality(
            //     //           textDirection: TextDirection.ltr,
            //     //           child: ListView.builder(
            //     //             itemCount: controller.pending.length,
            //     //             itemBuilder: (context, index) {
            //     //               return GestureDetector(
            //     //                 onTap: () {
            //     //                   myServices.sharedPreferences.setString(
            //     //                       "orders_id",
            //     //                       "${controller.pending[index]['orders_id']}");
            //     //                   myServices.sharedPreferences.setString(
            //     //                       "orders_usersid",
            //     //                       "${controller.pending[index]['orders_usersid']}");
            //     //                   controller.getDetails();
            //     //                   Get.to(OrdersDetails());
            //     //                 },
            //     //                 child: Card(
            //     //                   child: Container(
            //     //                     height: 15.h,
            //     //                     width: 90.w,
            //     //                     padding:
            //     //                         EdgeInsets.fromLTRB(0.w, 0, 3.w, 0),
            //     //                     decoration: BoxDecoration(),
            //     //                     child: Row(
            //     //                       crossAxisAlignment:
            //     //                           CrossAxisAlignment.center,
            //     //                       mainAxisAlignment:
            //     //                           MainAxisAlignment.end,
            //     //                       children: [
            //     //                         Column(
            //     //                           mainAxisAlignment:
            //     //                               MainAxisAlignment.center,
            //     //                           crossAxisAlignment:
            //     //                               CrossAxisAlignment.center,
            //     //                           children: [
            //     //                             Text(
            //     //                               textDirection:
            //     //                                   TextDirection.rtl,
            //     //                               ' ${Jiffy.parse('${controller.pending[index]['orders_datetime']}').fromNow()}',
            //     //                               style: TextStyle(
            //     //                                 fontSize: 10.sp,
            //     //                                 color: AppColor.secondaryColor,
            //     //                                 fontWeight: FontWeight.bold,
            //     //                                 fontFamily: 'Cairo',
            //     //                               ),
            //     //                             ),
            //     //                             SizedBox(
            //     //                               height: 1.h,
            //     //                             ),
            //     //                             Row(
            //     //                               children: [
            //     //                                 GestureDetector(
            //     //                                   onTap: () {
            //     //                                     myServices
            //     //                                         .sharedPreferences
            //     //                                         .setString(
            //     //                                             "orders_id",
            //     //                                             '${controller.pending[index]['orders_id']}');
            //     //                                     controller.reject(
            //     //                                       '${controller.pending[index]['orders_id']}',
            //     //                                       '${controller.pending[index]['orders_usersid']}',
            //     //                                     );
            //     //                                   },
            //     //                                   child: Container(
            //     //                                     alignment:
            //     //                                         Alignment.center,
            //     //                                     width: 25.w,
            //     //                                     height: 5.h,
            //     //                                     decoration: BoxDecoration(
            //     //                                       color: const Color(
            //     //                                           0xffFC7A79),
            //     //                                       borderRadius:
            //     //                                           BorderRadius
            //     //                                               .circular(5.sp),
            //     //                                     ),
            //     //                                     child: Row(
            //     //                                       mainAxisAlignment:
            //     //                                           MainAxisAlignment
            //     //                                               .center,
            //     //                                       children: [
            //     //                                         Icon(
            //     //                                           Icons.close,
            //     //                                           color: Colors.white,
            //     //                                           size: 11.sp,
            //     //                                         ),
            //     //                                         SizedBox(width: 1.w),
            //     //                                         const Text(
            //     //                                           'رفض',
            //     //                                           style: TextStyle(
            //     //                                             color:
            //     //                                                 Colors.white,
            //     //                                             fontFamily:
            //     //                                                 'Cairo',
            //     //                                             fontWeight:
            //     //                                                 FontWeight
            //     //                                                     .bold,
            //     //                                           ),
            //     //                                         ),
            //     //                                       ],
            //     //                                     ),
            //     //                                   ),
            //     //                                 ),
            //     //                                 SizedBox(
            //     //                                   width: 1.w,
            //     //                                 ),
            //     //                                 GestureDetector(
            //     //                                   onTap: () {
            //     //                                     myServices
            //     //                                         .sharedPreferences
            //     //                                         .setString(
            //     //                                             "orders_id",
            //     //                                             '${controller.pending[index]['orders_id']}');
            //     //                                     controller.approve(
            //     //                                       '${controller.pending[index]['orders_id']}',
            //     //                                       '${controller.pending[index]['orders_usersid']}',
            //     //                                     );
            //     //                                   },
            //     //                                   child: Container(
            //     //                                     alignment:
            //     //                                         Alignment.center,
            //     //                                     width: 25.w,
            //     //                                     height: 5.h,
            //     //                                     decoration: BoxDecoration(
            //     //                                       color: const Color(
            //     //                                           0xff94E17C),
            //     //                                       borderRadius:
            //     //                                           BorderRadius
            //     //                                               .circular(5.sp),
            //     //                                     ),
            //     //                                     child: Row(
            //     //                                       mainAxisAlignment:
            //     //                                           MainAxisAlignment
            //     //                                               .center,
            //     //                                       children: [
            //     //                                         Icon(
            //     //                                           Icons
            //     //                                               .done_outline_outlined,
            //     //                                           color: Colors.white,
            //     //                                           size: 11.sp,
            //     //                                         ),
            //     //                                         SizedBox(width: 1.w),
            //     //                                         const Text(
            //     //                                           'قبول',
            //     //                                           style: TextStyle(
            //     //                                             color:
            //     //                                                 Colors.white,
            //     //                                             fontFamily:
            //     //                                                 'Cairo',
            //     //                                             fontWeight:
            //     //                                                 FontWeight
            //     //                                                     .bold,
            //     //                                           ),
            //     //                                         ),
            //     //                                       ],
            //     //                                     ),
            //     //                                   ),
            //     //                                 ),
            //     //                               ],
            //     //                             ),
            //     //                           ],
            //     //                         ),
            //     //                         // SizedBox(
            //     //                         //   width: 28.w,
            //     //                         // ),
            //     //                         Column(
            //     //                           crossAxisAlignment:
            //     //                               CrossAxisAlignment.center,
            //     //                           mainAxisAlignment:
            //     //                               MainAxisAlignment.center,
            //     //                           children: [
            //     //                             Text(
            //     //                               '  رقم الطلب :${controller.pending[index]['orders_id']}',
            //     //                               style: TextStyle(
            //     //                                 fontSize: 13.sp,
            //     //                                 color: Colors.black,
            //     //                                 fontWeight: FontWeight.bold,
            //     //                                 fontFamily: 'Cairo',
            //     //                               ),
            //     //                             ),
            //     //                             SizedBox(
            //     //                               height: 1.h,
            //     //                             ),
            //     //                             FittedBox(
            //     //                               child: Text(
            //     //                                 " السعر : ${controller.pending[index]['orders_price']}",
            //     //                                 style: TextStyle(
            //     //                                   fontSize: 12.sp,
            //     //                                   color: Colors.red,
            //     //                                   fontFamily: 'Cairo',
            //     //                                 ),
            //     //                               ),
            //     //                             ),
            //     //                             FittedBox(
            //     //                               child: Text(
            //     //                                 " + ${controller.pending[index]['orders_pricedelivery']}",
            //     //                                 style: TextStyle(
            //     //                                   fontSize: 12.sp,
            //     //                                   color: Color(0xff94E17C),
            //     //                                   fontFamily: 'Cairo',
            //     //                                 ),
            //     //                               ),
            //     //                             ),
            //     //                           ],
            //     //                         ),
            //     //                       ],
            //     //                     ),
            //     //                   ),
            //     //                 ),
            //     //               );
            //     //             },
            //     //           ),
            //     //         ),
            //     //       ),
            //     // controller.preparing.length == 0
            //     //     ? Center(
            //     //         child: Column(
            //     //           children: [
            //     //             SizedBox(
            //     //               height: 12.h,
            //     //             ),
            //     //             Lottie.asset(
            //     //               AppImageAsset.emptyitems,
            //     //               height: 35.h,
            //     //             ),
            //     //             Text(
            //     //               'لا يوجد أصناف بعد',
            //     //               style: const TextStyle(
            //     //                 color: AppColor.black,
            //     //                 fontFamily: 'Cairo',
            //     //                 fontWeight: FontWeight.w600,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       )
            //     //     : Padding(
            //     //         padding: EdgeInsets.symmetric(
            //     //             horizontal: 2.w, vertical: 1.h),
            //     //         child: Directionality(
            //     //           textDirection: TextDirection.ltr,
            //     //           child: ListView.builder(
            //     //             itemCount: controller.preparing.length,
            //     //             itemBuilder: (context, index) {
            //     //               return GestureDetector(
            //     //                 onTap: () {
            //     //                   myServices.sharedPreferences.setString(
            //     //                       "orders_id",
            //     //                       "${controller.preparing[index]['orders_id']}");
            //     //                   myServices.sharedPreferences.setString(
            //     //                       "orders_usersid",
            //     //                       "${controller.preparing[index]['orders_usersid']}");
            //     //                   controller.getDetails();
            //     //                   Get.to(OrdersDetails());
            //     //                 },
            //     //                 child: Card(
            //     //                   child: Container(
            //     //                     height: 15.h,
            //     //                     width: 90.w,
            //     //                     padding:
            //     //                         EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
            //     //                     decoration: BoxDecoration(),
            //     //                     child: Row(
            //     //                       crossAxisAlignment:
            //     //                           CrossAxisAlignment.center,
            //     //                       mainAxisAlignment:
            //     //                           MainAxisAlignment.spaceBetween,
            //     //                       children: [
            //     //                         Column(
            //     //                           mainAxisAlignment:
            //     //                               MainAxisAlignment.center,
            //     //                           crossAxisAlignment:
            //     //                               CrossAxisAlignment.center,
            //     //                           children: [
            //     //                             Text(
            //     //                               textDirection:
            //     //                                   TextDirection.rtl,
            //     //                               ' ${Jiffy.parse('${controller.preparing[index]['orders_datetime']}').fromNow()}',
            //     //                               style: TextStyle(
            //     //                                 fontSize: 10.sp,
            //     //                                 color: AppColor.secondaryColor,
            //     //                                 fontWeight: FontWeight.bold,
            //     //                                 fontFamily: 'Cairo',
            //     //                               ),
            //     //                             ),
            //     //                             SizedBox(
            //     //                               height: 1.h,
            //     //                             ),
            //     //                             GestureDetector(
            //     //                               onTap: () {
            //     //                                 myServices.sharedPreferences
            //     //                                     .setString("orders_id",
            //     //                                         '${controller.preparing[index]['orders_id']}');
            //     //                                 controller.approve(
            //     //                                   '${controller.preparing[index]['orders_id']}',
            //     //                                   '${controller.preparing[index]['orders_usersid']}',
            //     //                                 );
            //     //                               },
            //     //                               child: Container(
            //     //                                 alignment: Alignment.center,
            //     //                                 width: 35.w,
            //     //                                 height: 5.h,
            //     //                                 decoration: BoxDecoration(
            //     //                                   color:
            //     //                                       const Color(0xff94E17C),
            //     //                                   borderRadius:
            //     //                                       BorderRadius.circular(
            //     //                                           5.sp),
            //     //                                 ),
            //     //                                 child: Row(
            //     //                                   mainAxisAlignment:
            //     //                                       MainAxisAlignment
            //     //                                           .center,
            //     //                                   children: [
            //     //                                     Icon(
            //     //                                       Icons
            //     //                                           .done_outline_outlined,
            //     //                                       color: Colors.white,
            //     //                                       size: 11.sp,
            //     //                                     ),
            //     //                                     SizedBox(width: 1.w),
            //     //                                     const Text(
            //     //                                       'انتهاء التحضير',
            //     //                                       style: TextStyle(
            //     //                                         color: Colors.white,
            //     //                                         fontFamily:
            //     //                                             'Cairo',
            //     //                                         fontWeight:
            //     //                                             FontWeight.bold,
            //     //                                       ),
            //     //                                     ),
            //     //                                   ],
            //     //                                 ),
            //     //                               ),
            //     //                             ),
            //     //                           ],
            //     //                         ),
            //     //                         // SizedBox(
            //     //                         //   width: 28.w,
            //     //                         // ),
            //     //                         Column(
            //     //                           crossAxisAlignment:
            //     //                               CrossAxisAlignment.center,
            //     //                           mainAxisAlignment:
            //     //                               MainAxisAlignment.center,
            //     //                           children: [
            //     //                             Text(
            //     //                               '  رقم الطلب :${controller.preparing[index]['orders_id']}',
            //     //                               style: TextStyle(
            //     //                                 fontSize: 13.sp,
            //     //                                 color: Colors.black,
            //     //                                 fontWeight: FontWeight.bold,
            //     //                                 fontFamily: 'Cairo',
            //     //                               ),
            //     //                             ),
            //     //                             SizedBox(
            //     //                               height: 1.h,
            //     //                             ),
            //     //                             FittedBox(
            //     //                               child: Text(
            //     //                                 " السعر : ${controller.preparing[index]['orders_price']}",
            //     //                                 style: TextStyle(
            //     //                                   fontSize: 12.sp,
            //     //                                   color: Colors.red,
            //     //                                   fontFamily: 'Cairo',
            //     //                                 ),
            //     //                               ),
            //     //                             ),
            //     //                             FittedBox(
            //     //                               child: Text(
            //     //                                 " + ${controller.preparing[index]['orders_pricedelivery']}",
            //     //                                 style: TextStyle(
            //     //                                   fontSize: 12.sp,
            //     //                                   color: Color(0xff94E17C),
            //     //                                   fontFamily: 'Cairo',
            //     //                                 ),
            //     //                               ),
            //     //                             ),
            //     //                           ],
            //     //                         ),
            //     //                       ],
            //     //                     ),
            //     //                   ),
            //     //                 ),
            //     //               );
            //     //             },
            //     //           ),
            //     //         ),
            //     //       ),
            //
            //
            //     controller.onway.length == 0
            //         ? Center(
            //       child: Column(
            //         children: [
            //           SizedBox(
            //             height: 12.h,
            //           ),
            //           Lottie.asset(
            //             AppImageAsset.emptyitems,
            //             height: 35.h,
            //           ),
            //           Text(
            //             'لا يوجد أصناف بعد',
            //             style: const TextStyle(
            //               color: AppColor.black,
            //               fontFamily: 'Cairo',
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //         : Padding(
            //       padding: EdgeInsets.symmetric(
            //           horizontal: 2.w, vertical: 1.h),
            //       child: Directionality(
            //         textDirection: TextDirection.ltr,
            //         child: ListView.builder(
            //           itemCount: controller.onway.length,
            //           itemBuilder: (context, index) {
            //             return GestureDetector(
            //               onTap: () {
            //                 myServices.sharedPreferences.setString(
            //                     "orders_id",
            //                     "${controller.onway[index]['orders_id']}");
            //                 myServices.sharedPreferences.setString(
            //                     "orders_usersid",
            //                     "${controller.onway[index]['orders_usersid']}");
            //                 controller.getDetails();
            //                 Get.to(OrdersDetails());
            //               },
            //               child: Card(
            //                 child: Container(
            //                   height: 15.h,
            //                   width: 90.w,
            //                   padding:
            //                   EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
            //                   decoration: BoxDecoration(),
            //                   child: Row(
            //                     crossAxisAlignment:
            //                     CrossAxisAlignment.center,
            //                     mainAxisAlignment:
            //                     MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Column(
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.center,
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             textDirection:
            //                             TextDirection.rtl,
            //                             ' ${Jiffy.parse('${controller.onway[index]['orders_datetime']}').fromNow()}',
            //                             style: TextStyle(
            //                               fontSize: 10.sp,
            //                               color: AppColor.secondaryColor,
            //                               fontWeight: FontWeight.bold,
            //                               fontFamily: 'Cairo',
            //                             ),
            //                           ),
            //                           SizedBox(
            //                             height: 1.h,
            //                           ),
            //                           GestureDetector(
            //                             onTap: () {
            //                               myServices.sharedPreferences
            //                                   .setString("orders_id",
            //                                   '${controller.onway[index]['orders_id']}');
            //                               controller.approve(
            //                                 '${controller.onway[index]['orders_id']}',
            //                                 '${controller.onway[index]['orders_usersid']}',
            //                               );
            //                             },
            //                             child: Container(
            //                               alignment: Alignment.center,
            //                               width: 35.w,
            //                               height: 5.h,
            //                               decoration: BoxDecoration(
            //                                 color:
            //                                 const Color(0xff94E17C),
            //                                 borderRadius:
            //                                 BorderRadius.circular(
            //                                     5.sp),
            //                               ),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                 MainAxisAlignment
            //                                     .center,
            //                                 children: [
            //                                   Icon(
            //                                     Icons
            //                                         .delivery_dining,
            //                                     color: Colors.white,
            //                                     size: 13.sp,
            //                                   ),
            //                                   SizedBox(width: 1.w),
            //                                   const Text(
            //                                     'تتبع الديلفري',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontFamily:
            //                                       'Cairo',
            //                                       fontWeight:
            //                                       FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       // SizedBox(
            //                       //   width: 28.w,
            //                       // ),
            //                       Column(
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             '  رقم الطلب :${controller.onway[index]['orders_id']}',
            //                             style: TextStyle(
            //                               fontSize: 13.sp,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.bold,
            //                               fontFamily: 'Cairo',
            //                             ),
            //                           ),
            //                           SizedBox(
            //                             height: 1.h,
            //                           ),
            //                           FittedBox(
            //                             child: Text(
            //                               " السعر : ${controller.onway[index]['orders_price']}",
            //                               style: TextStyle(
            //                                 fontSize: 12.sp,
            //                                 color: Colors.red,
            //                                 fontFamily: 'Cairo',
            //                               ),
            //                             ),
            //                           ),
            //                           FittedBox(
            //                             child: Text(
            //                               " + ${controller.onway[index]['orders_pricedelivery']}",
            //                               style: TextStyle(
            //                                 fontSize: 12.sp,
            //                                 color: Color(0xff94E17C),
            //                                 fontFamily: 'Cairo',
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //
            //     controller.archive.length == 0
            //         ? Center(
            //       child: Column(
            //         children: [
            //           SizedBox(
            //             height: 12.h,
            //           ),
            //           Lottie.asset(
            //             AppImageAsset.emptyitems,
            //             height: 35.h,
            //           ),
            //           Text(
            //             'لا يوجد أصناف بعد',
            //             style: const TextStyle(
            //               color: AppColor.black,
            //               fontFamily: 'Cairo',
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //         : Padding(
            //       padding: EdgeInsets.symmetric(
            //           horizontal: 2.w, vertical: 1.h),
            //       child: Directionality(
            //         textDirection: TextDirection.ltr,
            //         child: ListView.builder(
            //           itemCount: controller.archive.length,
            //           itemBuilder: (context, index) {
            //             return GestureDetector(
            //               onTap: () {
            //                 myServices.sharedPreferences.setString(
            //                     "orders_id",
            //                     "${controller.archive[index]['orders_id']}");
            //                 myServices.sharedPreferences.setString(
            //                     "orders_usersid",
            //                     "${controller.archive[index]['orders_usersid']}");
            //                 controller.getDetails();
            //                 Get.to(OrdersDetails());
            //               },
            //               child: Card(
            //                 child: Container(
            //                   height: 15.h,
            //                   width: 90.w,
            //                   padding:
            //                   EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
            //                   decoration: BoxDecoration(),
            //                   child: Row(
            //                     crossAxisAlignment:
            //                     CrossAxisAlignment.center,
            //                     mainAxisAlignment:
            //                     MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Column(
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.center,
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             textDirection:
            //                             TextDirection.rtl,
            //                             ' ${Jiffy.parse('${controller.archive[index]['orders_datetime']}').fromNow()}',
            //                             style: TextStyle(
            //                               fontSize: 10.sp,
            //                               color: AppColor.secondaryColor,
            //                               fontWeight: FontWeight.bold,
            //                               fontFamily: 'Cairo',
            //                             ),
            //                           ),
            //                           SizedBox(
            //                             height: 1.h,
            //                           ),
            //                           // GestureDetector(
            //                           //   onTap: () {
            //                           //     myServices.sharedPreferences
            //                           //         .setString("orders_id",
            //                           //         '${controller.accepted[index]['orders_id']}');
            //                           //     controller.approve(
            //                           //       '${controller.accepted[index]['orders_id']}',
            //                           //       '${controller.accepted[index]['orders_usersid']}',
            //                           //     );
            //                           //   },
            //                           //   child: Container(
            //                           //     alignment: Alignment.center,
            //                           //     width: 35.w,
            //                           //     height: 5.h,
            //                           //     decoration: BoxDecoration(
            //                           //       color:
            //                           //       const Color(0xff94E17C),
            //                           //       borderRadius:
            //                           //       BorderRadius.circular(
            //                           //           5.sp),
            //                           //     ),
            //                           //     child: Row(
            //                           //       mainAxisAlignment:
            //                           //       MainAxisAlignment
            //                           //           .center,
            //                           //       children: [
            //                           //         Icon(
            //                           //           Icons
            //                           //               .delivery_dining,
            //                           //           color: Colors.white,
            //                           //           size: 13.sp,
            //                           //         ),
            //                           //         SizedBox(width: 1.w),
            //                           //         const Text(
            //                           //           'تتبع الديلفري',
            //                           //           style: TextStyle(
            //                           //             color: Colors.white,
            //                           //             fontFamily:
            //                           //             'Cairo',
            //                           //             fontWeight:
            //                           //             FontWeight.bold,
            //                           //           ),
            //                           //         ),
            //                           //       ],
            //                           //     ),
            //                           //   ),
            //                           // ),
            //                         ],
            //                       ),
            //                       // SizedBox(
            //                       //   width: 28.w,
            //                       // ),
            //                       Column(
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             '  رقم الطلب :${controller.archive[index]['orders_id']}',
            //                             style: TextStyle(
            //                               fontSize: 13.sp,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.bold,
            //                               fontFamily: 'Cairo',
            //                             ),
            //                           ),
            //                           SizedBox(
            //                             height: 1.h,
            //                           ),
            //                           FittedBox(
            //                             child: Text(
            //                               " السعر : ${controller.archive[index]['orders_price']}",
            //                               style: TextStyle(
            //                                 fontSize: 12.sp,
            //                                 color: Colors.red,
            //                                 fontFamily: 'Cairo',
            //                               ),
            //                             ),
            //                           ),
            //                           FittedBox(
            //                             child: Text(
            //                               " + ${controller.archive[index]['orders_pricedelivery']}",
            //                               style: TextStyle(
            //                                 fontSize: 12.sp,
            //                                 color: Color(0xff94E17C),
            //                                 fontFamily: 'Cairo',
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
            color: AppColor.secondaryColor,
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
