import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CartController.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import 'package:yumyum/core/constant/linkapi.dart';
import 'package:yumyum/view/screen/Home/AllOffersScreen.dart';
import 'package:yumyum/view/screen/Home/BasketScreen.dart';
import 'package:yumyum/view/screen/Home/ItemsScreen.dart';
import 'package:yumyum/view/screen/Home/NotificationScreen.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../controller/Home/ItemsController.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/services/services.dart';
import 'package:badges/badges.dart' as badges;
import 'AddAddressScreen.dart';
import 'ProductDetails.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    CartControllerImp cartController = Get.put(CartControllerImp());
    ItemsControllerImp itemscontroller = Get.put(ItemsControllerImp());
    MyServices myServices = Get.find();

    return Scaffold(
      body: GetBuilder<HomeControllerImp>(
        builder: (controller) => controller.statusRequest ==
                StatusRequest.loading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: YourShimmerWidget(), // Replace with your shimmer widget
              )
            : SizedBox(
                width: 100.w,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.w, left: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GetBuilder<CartControllerImp>(
                                  builder: (controller) => cartController
                                          .items.isEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            myServices.sharedPreferences
                                                        .getString(
                                                            "users_phone") ==
                                                    null
                                                ? null
                                                : cartController.getItems();
                                            Get.to(BasketScreen());
                                          },
                                          icon: Icon(EneftyIcons.bag_2_outline))
                                      : IconButton(
                                          onPressed: () {
                                            myServices.sharedPreferences
                                                        .getString(
                                                            "users_phone") ==
                                                    null
                                                ? null
                                                : cartController.getItems();
                                            Get.to(BasketScreen());
                                          },
                                          icon: badges.Badge(
                                              badgeContent: Text(
                                                '${cartController.items.length}',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              child: Icon(
                                                EneftyIcons.bag_2_outline,
                                                size: 22.sp,
                                              )),
                                        ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(NotificationsScreen());
                                    },
                                    icon:
                                        Icon(EneftyIcons.notification_outline)),
                              ],
                            ),

                               Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.getCurrentLocation();
                                      Get.to(AddAddressScreen());
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                                Icons.arrow_drop_down_outlined),
                                            Text(
                                              'موقعك',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          controller.statusRequest ==
                                                  StatusRequest.loading
                                              ? 'حاليًا جاري التحميل...'
                                              : controller.currentLocationName ==
                                                      'Throttled! See geocode.xyz/pricing'
                                                  ? 'مكان غير معروف'
                                                  : '${controller.currentLocationName}',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black26,
                                            fontFamily: 'ElMessiri',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xffFF7A2F),
                                  ),
                                ],
                              ),

                          ],
                        ),
                      ),
                      GetBuilder<HomeControllerImp>(
                        builder: (controller) {
                          final itemsName = controller.searchlist;
                          return Padding(
                            padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 0.h),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: SearchField<String>(
                                itemHeight: 13.h,
                                searchStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontFamily: 'ElMessiri',
                                ),
                                searchInputDecoration: InputDecoration(
                                  prefixIcon: Icon(
                                    EneftyIcons.search_normal_2_outline,
                                    size: 20.sp,
                                    color: AppColor.grey,
                                  ),
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
                                  hintText: 'إبحث عن منتجات,متاجر,مطاعم ...',
                                  hintStyle: TextStyle(
                                    height: 0.2.h,
                                    fontSize: 11.sp,
                                    fontFamily: 'ElMessiri',
                                    letterSpacing: 1,
                                  ),
                                ),
                                suggestions: (itemsName is List)
                                    ? itemsName
                                        .map(
                                          (e) => SearchFieldListItem<String>(
                                            e['items_name_ar'],
                                            child: GestureDetector(
                                              onTap: () {
                                                myServices.sharedPreferences
                                                    .setString("items_id",
                                                        "${e['items_id']}");
                                                Get.to(ProductDetails());
                                              },
                                              child: Container(
                                                height: 20.h,
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
                                                              .end,
                                                      children: [
                                                        Text(
                                                          e['items_name_ar'],
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                        Text(
                                                          e['items_name'],
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color:
                                                                Colors.black26,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 1.w,
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Hero(
                                                      tag: e['items_id'],
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 3.w, 0),
                                                        height: 12.h,
                                                        width: 31.w,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .sp),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      '${AppLink.items_image}/${e['items_image']}'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()
                                    : [],
                                // If itemsName is not a List, use an empty list
                                onSearchTextChanged: (query) {
                                  //print('===========');
                                  controller.getsearch(query);
                                  controller.update();
                                  //print('Search query: $query');
                                  // Add your logic to filter or search based on the query
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      controller.offers.isEmpty
                          ? CarouselSlider.builder(
                              options: CarouselOptions(
                                height: 30.h,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                //viewportFraction: 0.7,
                                aspectRatio: 45 / 19,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                viewportFraction: 0.85,
                                enlargeFactor: 0.53,
                                onPageChanged: (index, reason) {
                                  controller.updatecurrentIndex(index);
                                },
                              ),
                              itemBuilder: (context, index, realIndex) {
                                return Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    width: 90.w,
                                    height: 21.h,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 2.h,
                                      horizontal: 3.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                    ),
                                    child: ProgressiveImage(
                                      width: 90.w,
                                      height: 21.h,
                                      image: AppImageAsset.shimmarimageeror,
                                      fit: BoxFit.fill,
                                      imageError:
                                          AppImageAsset.shimmarimageeror,
                                    ),
                                  ),
                                );
                              },
                              itemCount: 5,
                            )
                          : Container(
                              height: 23.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  height: 30.h,
                                  autoPlay: true,
                                  enableInfiniteScroll: true,
                                  //viewportFraction: 0.7,
                                  aspectRatio: 45 / 19,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  viewportFraction: 0.85,
                                  enlargeFactor: 0.53,
                                  onPageChanged: (index, reason) {
                                    controller.updatecurrentIndex(index);
                                  },
                                ),
                                itemBuilder: (context, index, realIndex) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      width: 90.w,
                                      height: 21.h,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 2.h,
                                        horizontal: 3.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                      ),
                                      child: ProgressiveImage(
                                        width: 90.w,
                                        height: 21.h,
                                        image:
                                            '${AppLink.offers_image}/${controller.offers[index]['offers_image']}',
                                        fit: BoxFit.fill,
                                        imageError:
                                            AppImageAsset.shimmarimageeror,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: controller.offers.length,
                              ),
                            ),
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.offers.length,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              margin: EdgeInsets.symmetric(horizontal: 3.sp),
                              height: 6.sp,
                              width: 6.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.currentIndex.value == index
                                    ? Color(0xffFF7A2F)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.arrow_back_ios_new_outlined,
                            //       size: 12.sp,
                            //       color: Color(0xffFF7A2F),
                            //     ),
                            //     SizedBox(
                            //       width: 1.w,
                            //     ),
                            //     Text(
                            //       'عرض الكل',
                            //       style: TextStyle(
                            //         fontSize: 11.sp,
                            //         color: Color(0xffFF7A2F),
                            //         fontFamily: 'ElMessiri',
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Text(
                              'ماذا تريد أن تطلب ',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(3.w, 1.h, 5.w, 0),
                        child: SizedBox(
                          height: 14.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    myServices.sharedPreferences.setString(
                                        "categoryname",
                                        controller.categories[index]
                                            ['categories_name_ar']);
                                    myServices.sharedPreferences.setInt(
                                        "categoryid",
                                        controller.categories[index]
                                            ['categories_id']);
                                    myServices.sharedPreferences
                                                .getString("users_phone") ==
                                            null
                                        ? itemscontroller.getItemsnoauth()
                                        : itemscontroller.getItems();
                                    Get.to(ItemsScreen());
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30.sp,
                                        backgroundColor:
                                            Color(0xffFF7A2F).withOpacity(0.60),
                                        child: Image.network(
                                          '${AppLink.categories_image}/${controller.categories[index]['categories_image']}',
                                          height: 6.h,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        controller.categories[index]
                                            ['categories_name_ar'],
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontFamily: 'ElMessiri',
                                        ),
                                      ),
                                    ],
                                  ),
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
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(const AllOffersScreen());
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 12.sp,
                                    color: Color(0xffFF7A2F),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    'عرض الكل',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Color(0xffFF7A2F),
                                      fontFamily: 'ElMessiri',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'عروض و تخفيضات',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 25.h,
                        width: 100.w,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  myServices.sharedPreferences.setString(
                                      "items_id",
                                      "${controller.items[index]['items_id']}");
                                  Get.to(ProductDetails());
                                },
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Container(
                                    width: 52.w,
                                    margin: EdgeInsets.all(1.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Stack(
                                          children: [
                                            Hero(
                                              tag: controller.items[index]
                                                  ['items_id'],
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10.sp)),
                                                child: Container(
                                                  height: 14.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    10.sp)),
                                                  ),
                                                  child: ProgressiveImage(
                                                    height: 14.h,
                                                    width: double.infinity,
                                                    image:
                                                        '${AppLink.items_image}/${controller.items[index]['items_image']}',
                                                    fit: BoxFit.fill,
                                                    imageError: AppImageAsset
                                                        .shimmarimageeror,
                                                  ),
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
                                                            BorderRadius
                                                                .circular(
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
                                                ? SizedBox()
                                                : Positioned(
                                                    top: 1.h,
                                                    left: 2.w,
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
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
                                          padding: EdgeInsets.only(
                                              right: 2.w, left: 1.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller.items[index]
                                                    ['items_name_ar'],
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 2.w, left: 3.w),
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
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: controller.items[
                                                                    index][
                                                                'items_discount'] ==
                                                            0
                                                        ? Text(
                                                            '${controller.items[index]['items_price']} ل.س ',
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Color(
                                                                  0xffFF7A2F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'ElMessiri',
                                                            ),
                                                          )
                                                        : Column(
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
                                                                  color: Color(
                                                                      0xffFF7A2F),
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
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w, left: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_drop_down_outlined),
                              Container(
                                height: 2.h,
                                width: 15.w,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Container(
                            height: 1.h,
                            width: 40.w,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      const Icon(
                        Icons.location_on,
                        color: Color(0xffFF7A2F),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GetBuilder<HomeControllerImp>(
              builder: (controller) {
                final itemsName = controller.searchlist;
                return Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 0.h),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SearchField<String>(
                      itemHeight: 13.h,
                      searchStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontFamily: 'ElMessiri',
                      ),
                      searchInputDecoration: InputDecoration(
                        prefixIcon: Icon(
                          EneftyIcons.search_normal_2_outline,
                          size: 20.sp,
                          color: AppColor.grey,
                        ),
                        isDense: true,
                        enabled: false,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 3.w),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.blue),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.blue),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.blue),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.blue),
                        ),
                        hintText: 'إبحث عن منتجات,متاجر,مطاعم ...',
                        hintStyle: TextStyle(
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'ElMessiri',
                          letterSpacing: 1,
                        ),
                      ),
                      suggestions: (itemsName is List)
                          ? itemsName
                              .map(
                                (e) => SearchFieldListItem<String>(
                                  e['items_name_ar'],
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(ProductDetails(), arguments: {
                                        "productData": controller.searchlist,
                                        "dataIndex":
                                            controller.searchlist.indexOf(e),
                                      });
                                    },
                                    child: Container(
                                      height: 20.h,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                e['items_name_ar'],
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                              Text(
                                                e['items_name'],
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black26,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Hero(
                                            tag: e['items_id'],
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 3.w, 0),
                                              height: 12.h,
                                              width: 31.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${AppLink.items_image}/${e['items_image']}'),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                          : [],
                      // If itemsName is not a List, use an empty list
                      onSearchTextChanged: (query) {
                        controller.getsearch(query);
                        controller.update();
                        // Add your logic to filter or search based on the query
                      },
                    ),
                  ),
                );
              },
            ),
            Container(
              height: 23.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 30.h,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  //viewportFraction: 0.7,
                  aspectRatio: 45 / 19,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  viewportFraction: 0.85,
                  enlargeFactor: 0.53,
                ),
                itemBuilder: (context, index, realIndex) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: 90.w,
                      height: 21.h,
                      margin: EdgeInsets.symmetric(
                        vertical: 2.h,
                        horizontal: 3.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                  );
                },
                itemCount: 5,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 3.sp),
                    height: 8.sp,
                    width: 8.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 12.sp,
                        color: Color(0xffFF7A2F),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        height: 2.h,
                        width: 15.w,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Container(
                    height: 2.5.h,
                    width: 25.w,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.w, 2.h, 5.w, 0),
              child: SizedBox(
                height: 15.h,
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
                                Color(0xffFF7A2F).withOpacity(0.60),
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
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 12.sp,
                        color: Color(0xffFF7A2F),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        height: 2.h,
                        width: 15.w,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Container(
                    height: 3.h,
                    width: 35.w,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Container(
              height: 24.h,
              width: 100.w,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        width: 46.w,
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
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.only(right: 2.w, left: 1.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 2.h,
                                    width: 15.w,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 2.w, left: 3.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppImageAsset.bagadd,
                                    height: 2.5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          height: 2.h,
                                          width: 15.w,
                                          color: Colors.blue,
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
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
