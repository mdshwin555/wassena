import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/ProductDetailsController.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../controller/Home/ItemsController.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDetailsControllerImp productDetailsController =
        Get.put(ProductDetailsControllerImp());
    productDetailsController.getDetails();
    ItemsControllerImp itemscontroller = Get.put(ItemsControllerImp());
    MyServices myServices = Get.find();

    return GetBuilder<ProductDetailsControllerImp>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: controller.statusRequest == StatusRequest.loading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child:
                      YourShimmerWidget(), // Replace with your shimmer widget
                )
              : Container(
                  height: 100.h,
                  width: 100.w,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: controller.details[0]['items_id'],
                              child: SizedBox(
                                width: 100.w,
                                height: 35.h,
                                child: ProgressiveImage(
                                  height: 35.h,
                                  width: 100.w,
                                  fit: BoxFit.fill,
                                  image:
                                      '${AppLink.items_image}/${controller.details[0]['items_image']}',
                                ),
                              ),
                            ),
                            Positioned(
                              top: 3.h,
                              left: 5.w,
                              child: GestureDetector(
                                onTap: () {
                                  if (controller.isFavorite!) {
                                    controller.removeFromFav(
                                        '${controller.details[0]['items_id']}');
                                    controller.updatedisfavtrue(
                                      controller.isFavorite!,
                                      '${controller.details[0]['items_id']}',
                                    );
                                  } else {
                                    controller.addToFav(
                                        '${controller.details[0]['items_id']}');
                                    controller.updatedisfavfalse(
                                      controller.isFavorite!,
                                      '${controller.details[0]['items_id']}',
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 18.sp,
                                  backgroundColor: Color(0xffFF7A2F),
                                  child: Icon(
                                    controller.isFavorite!
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 20.sp,
                                    color: Colors.red,
                                  ),
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
                                  backgroundColor: Color(0xffFF7A2F),
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                             offset: Offset(10.w,32.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.sp),
                                child: Container(
                                  height: 6.h,
                                  width: 6.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      100.sp,
                                    ),
                                  ),
                                  child: ProgressiveImage(
                                    height: 6.h,
                                    width: 6.h,
                                    image:
                                        '${AppLink.restaurants_image}/${controller.details[0]['restaurants_logo']}',
                                    imageError: AppImageAsset.shimmarimageeror,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [],
                              ),
                              Text(
                                controller.details[0]['items_name_ar'],
                                style: TextStyle(
                                  fontSize: 15.sp,
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
                            right: 5.w,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                    5,
                                    (index) {
                                      if (controller.details[0]['avg_rating'] !=
                                          null) {
                                        double rating = double.parse(
                                            '${controller.details[0]['avg_rating']}');
                                        if (index < rating.floor()) {
                                          return Icon(
                                            Icons.star,
                                            color: Color(0xffFF7A2F),
                                            size: 23.sp,
                                          );
                                        } else if (index == rating.floor() &&
                                            rating % 1 != 0) {
                                          return Icon(
                                            Icons.star_half,
                                            color: Color(0xffFF7A2F),
                                            size: 23.sp,
                                          );
                                        } else {
                                          return Icon(
                                            Icons.star_outline,
                                            color: Color(0xffFF7A2F),
                                            size: 23.sp,
                                          );
                                        }
                                      } else {
                                        // Display outlined star for unrated stars or when avg_rating is null
                                        return Icon(
                                          EneftyIcons.star_outline,
                                          color: Color(0xffFF7A2F),
                                          size: 18.sp,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 1.w,
                                    top: 1.h,
                                  ),
                                  child: Text(
                                    ' | ${controller.details[0]['rating_count']} أشخاص ',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ElMessiri',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Divider(
                          color: Colors.black26,
                          thickness: 0.1.h,
                          indent: 6.w,
                          endIndent: 6.w,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 5.w,
                          ),
                          child: Text(
                            'الوصف ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 5.w,
                            top: 0.5.h,
                            left: 5.w,
                          ),
                          child: Text(
                            controller.details[0]['items_desc_ar'],
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black26,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Divider(
                          color: Colors.black26,
                          thickness: 0.1.h,
                          indent: 6.w,
                          endIndent: 6.w,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        floatingActionButton: controller.statusRequest == StatusRequest.loading
            ? SizedBox()
            : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: Offset(4.w,0),
                  child: Container(
                    height: 11.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.sp)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.details[0]['items_discount'] == 0
                            ? Text(
                                '${controller.quantity * controller.details[0]['items_price']} ل.س ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xffFF7A2F),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ElMessiri',
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${controller.quantity * (controller.details[0]['items_price'] - controller.details[0]['items_price'] * (controller.details[0]['items_discount'] / 100)).toInt()} ل.س ',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xffFF7A2F),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ElMessiri',
                                    ),
                                  ),
                                  Text(
                                    '${controller.quantity * controller.details[0]['items_price']}',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      fontFamily: 'ElMessiri',
                                    ),
                                  ),
                                ],
                              ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.plusquantity();
                              },
                              child: CircleAvatar(
                                radius: 15.sp,
                                backgroundColor: Color(0xffFF7A2F),
                                child: Icon(
                                  Icons.add,
                                  size: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              controller.quantity.toString(),
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.minesquantity();
                              },
                              child: CircleAvatar(
                                radius: 15.sp,
                                backgroundColor: Color(0xffFF7A2F),
                                child: Icon(
                                  Icons.remove,
                                  size: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (myServices.sharedPreferences
                                .getString("token") ==
                            null) {
                          BuildContext context = Get.context!;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    " ! يجب تسجيل الدخول أولا ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ElMessiri',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          myServices.sharedPreferences
                                      .getString("ratingitems_id") ==
                                  controller.details[0]['items_id']
                              ? Get.snackbar("عذراً",
                                  "لقد قمت بتقييم هذا المنتج بالفعل")
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return AlertDialog(
                                          title: Text(
                                            'ماهو تقييمك ل${controller.details[0]['items_name_ar']}',
                                            textAlign: TextAlign.center,
                                            textDirection:
                                                TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.black,
                                              height: 0.2.h,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ElMessiri',
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize:
                                                  MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 20),
                                                Obx(
                                                  () => Image.asset(
                                                    controller.ratingImages[
                                                        controller
                                                                .selectedRating
                                                                .value -
                                                            1],
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: FittedBox(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children:
                                                          List.generate(5,
                                                              (index) {
                                                        return Obx(
                                                            () =>
                                                                IconButton(
                                                                  icon: Icon(
                                                                      index < controller.selectedRating.value
                                                                          ? EneftyIcons.star_bold
                                                                          : EneftyIcons.star_outline,
                                                                      color: Color(0xffFF7A2F),
                                                                      size: 25.sp),
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .selectedRating
                                                                        .value = index + 1;
                                                                  },
                                                                ));
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'إلغاء',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // //print(
                                                //     'rating: ${controller.selectedRating.value}, comment: ${controller.commentController.text}');

                                                if (controller
                                                        .selectedRating
                                                        .value <
                                                    3) {
                                                  // Handle low rating scenario
                                                } else {
                                                  // Handle higher rating scenario
                                                }
                                                controller.addRate(
                                                    '${controller.details[0]['items_id']}');
                                                Get.back();
                                              },
                                              child: Text(
                                                'إرسال',
                                                style: TextStyle(
                                                  color: Color(0xffFF7A2F),
                                                  fontSize: 13.sp,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 7.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xffFF7A2F), width: 0.5.w),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              EneftyIcons.star_bold,
                              color: Color(0xffFF7A2F),
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              'تقييم  ',
                              style: TextStyle(
                                color: Colors.black,
                                height: 0.2.h,
                                fontSize: 12.sp,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        itemscontroller.addToCart(
                            '${controller.details[0]['items_id']}',
                            '${controller.quantity}');
                      },
                      child: GetBuilder<ItemsControllerImp>(
                        builder: (controller) => Container(
                          alignment: Alignment.center,
                          height: 7.h,
                          width: 64.w,
                          decoration: BoxDecoration(
                            color: Color(0xffFF7A2F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: controller.statusRequest ==
                                  StatusRequest.loading
                              ? Transform.scale(
                                  scale: 3,
                                  child: Lottie.asset(
                                      AppImageAsset.dotsloading))
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      EneftyIcons.shopping_cart_outline,
                                      color: Colors.white,
                                      size: 17.sp,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text(
                                      'إضافة إلى السلة',
                                      style: TextStyle(
                                        color: Colors.white,
                                        height: 0.2.h,
                                        fontSize: 12.sp,
                                        fontFamily: 'ElMessiri',
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}

class YourShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  top: 3.h,
                  left: 5.w,
                  child: CircleAvatar(
                    radius: 18.sp,
                    backgroundColor: Color(0xffFF7A2F),
                  ),
                ),
                Positioned(
                  top: 3.h,
                  right: 5.w,
                  child: CircleAvatar(
                    radius: 18.sp,
                    backgroundColor: Color(0xffFF7A2F),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 2.h,
                        width: 15.w,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Container(
                    height: 2.h,
                    width: 15.w,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 5.w,
                top: 1.h,
              ),
              child: Container(
                height: 2.h,
                width: 15.w,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 5.w,
                top: 1.h,
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        5, // Always show a total of 5 stars
                        (index) {
                          if (index < 5) {
                            // Display bold star for each rated star
                            return Icon(
                              EneftyIcons.star_bold,
                              color: Color(0xffFF7A2F),
                              size: 18.sp,
                            );
                          } else {
                            // Display outlined star for unrated stars
                            return Icon(
                              EneftyIcons.star_outline,
                              color: Color(0xffFF7A2F),
                              size: 18.sp,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              color: Colors.black26,
              thickness: 0.1.h,
              indent: 6.w,
              endIndent: 6.w,
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 5.w,
              ),
              child: Container(
                height: 2.h,
                width: 15.w,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 5.w,
                top: 0.5.h,
                left: 5.w,
              ),
              child: Container(
                height: 2.h,
                width: 40.w,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              color: Colors.black26,
              thickness: 0.1.h,
              indent: 6.w,
              endIndent: 6.w,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15.sp,
                        backgroundColor: Color(0xffFF7A2F),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Container(
                        height: 2.h,
                        width: 5.w,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      CircleAvatar(
                        radius: 15.sp,
                        backgroundColor: Color(0xffFF7A2F),
                      ),
                    ],
                  ),
                  Container(
                    height: 2.h,
                    width: 15.w,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      ),
    );
  }
}
