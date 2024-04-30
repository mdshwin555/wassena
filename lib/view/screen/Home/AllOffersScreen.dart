import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/HomeController.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'ProductDetails.dart';

class AllOffersScreen extends StatelessWidget {
  const AllOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    MyServices myServices = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title:  Text(
            'عروض و تخفيضات',
            style: TextStyle(
              color: AppColor.black,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ),
        body: GetBuilder<HomeControllerImp>(
          builder: (controller) => controller.statusRequest ==
              StatusRequest.loading
              ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: YourShimmerWidget(), // Replace with your shimmer widget
          ):controller.items.isEmpty
              ? Center(
            child: Column(
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Lottie.asset(
                  AppImageAsset.emptyitems,
                  height: 35.h,
                ),
                const Text(
                  'لا يوجد عروض بعد',
                  style: TextStyle(
                    color: AppColor.black,
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
              width: 100.w,
              height: 100.h,
              padding: EdgeInsets.only(top: 1.h),
              margin: EdgeInsets.only(left: 1.w, right: 1.w),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.1,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.92,
                ),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      myServices.sharedPreferences.setString("items_id",
                          "${controller.items[index]['items_id']}");
                      Get.to(const ProductDetails());
                    },
                    child: Directionality(
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
                                Hero(
                                  tag: controller.items[index]
                                  ['items_id'],
                                  child: Container(
                                    height: 14.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10.sp)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${AppLink.items_image}/${controller.items[index]['items_image']}'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(2.w, 11.5.h),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(
                                            100.sp),
                                        child: Container(
                                          height: 5.5.h,
                                          width: 5.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                              100.sp,
                                            ),
                                          ),
                                          child: ProgressiveImage(
                                            height: 5.5.h,
                                            width: 5.5.h,
                                            image:
                                            '${AppLink.restaurants_image}/${controller.items[index]['restaurants_logo']}',
                                            imageError: AppImageAsset
                                                .shimmarimageeror,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller.items[index]
                                ['items_discount'] ==
                                    0
                                    ? const SizedBox()
                                    : Transform.translate(
                                  offset: Offset(-2.w, -1.5.h),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        AppImageAsset.offer,
                                        height: 5.h,
                                      ),
                                      Text(
                                        '%${controller.items[index]['items_discount']}',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.white,
                                          fontFamily: 'ElMessiri',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding:
                              EdgeInsets.only(right: 2.w, left: 2.w),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.items[index]
                                      ['items_name_ar'],
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(right: 2.w, left: 2.w),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.addToCart(
                                        index,
                                        '${controller.items[index]['items_id']}',
                                        '1',
                                      );
                                    },
                                    child: Image.asset(
                                      AppImageAsset.addtocart,
                                      height: 3.5.h,
                                    ),
                                  ),
                                  SizedBox(width: 1.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Directionality(
                                        textDirection:
                                        TextDirection.rtl,
                                        child: controller.items[index]
                                        [
                                        'items_discount'] ==
                                            0
                                            ? Text(
                                          '${controller.items[index]['items_price']} ل.س ',
                                          textDirection:
                                          TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: AppColor.secondaryColor,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            'ElMessiri',
                                          ),
                                        )
                                            : FittedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                '${(controller.items[index]['items_price'] - controller.items[index]['items_price'] * (controller.items[index]['items_discount'] / 100)).toInt()} ل.س ',
                                                textDirection:
                                                TextDirection
                                                    .rtl,
                                                style:
                                                TextStyle(
                                                  fontSize:
                                                  10.sp,
                                                  color: Color(0xff85ac05),
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontFamily:
                                                  'ElMessiri',
                                                ),
                                              ),
                                              Text(
                                                '${controller.items[index]['items_price']}',
                                                textDirection:
                                                TextDirection
                                                    .rtl,
                                                style:
                                                TextStyle(
                                                  decoration:
                                                  TextDecoration
                                                      .lineThrough,
                                                  fontSize:
                                                  9.sp,
                                                  color: Colors
                                                      .grey,
                                                  fontFamily:
                                                  'ElMessiri',
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.only(top: 1.h),
        margin: EdgeInsets.only(left: 1.w, right: 1.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.1,
            mainAxisSpacing: 2,
            childAspectRatio: 0.97,
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
                    Container(
                      height: 14.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.sp)),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding:
                      EdgeInsets.only(right: 2.w, left: 2.w),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 2.5.h,
                              width: 15.w,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(right: 2.w, left: 2.w),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AppImageAsset.addtocart,
                            height: 3.5.h,
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
    );
  }
}
