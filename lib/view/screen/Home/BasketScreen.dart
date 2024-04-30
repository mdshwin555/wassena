import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CartController.dart';
import 'package:yumyum/core/constant/imgaeasset.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'checkoutScreen.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartControllerImp());
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
          title: Text(
            ' سلة المشتريات',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.w600,
                fontSize: 13.sp),
          ),
        ),
        body: GetBuilder<CartControllerImp>(
          builder: (controller) =>  myServices.sharedPreferences.getString("token") == null?
               Center(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Lottie.asset(
                  AppImageAsset.emptycart,
                  height: 50.h,
                ),
                Transform.translate(
                  offset: Offset(0, -17.h),
                  child: Column(
                    children: [
                      Text(
                        ' سلة مشترياتك فارغة',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'ElMessiri',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'سجل دخولك الآن واملأها بالمنتجات',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ):controller.statusRequest ==
                  StatusRequest.loading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child:
                      YourShimmerWidget(), // Replace with your shimmer widget
                )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                              height:
                                  controller.items.length == 0 ? 100.h : 47.h,
                              padding: const EdgeInsets.all(16.0),
                              child: controller.items.length == 0
                                  ? Center(
                                      child: Column(
                                        children: [
                                          controller.items.length == 0
                                              ? SizedBox(
                                                  height: 10.h,
                                                )
                                              : SizedBox(),
                                          Lottie.asset(
                                            AppImageAsset.emptycart,
                                            height: 50.h,
                                          ),
                                          Transform.translate(
                                            offset: Offset(0, -17.h),
                                            child: Column(
                                              children: [
                                                Text(
                                                  ' سلة مشترياتك فارغة',
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'ElMessiri',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  'هيا لنملأها',
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'ElMessiri',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: controller.items.length,
                                      itemBuilder: (context, index) {
                                        return Slidable(
                                          endActionPane: ActionPane(
                                            motion: ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: (a) {},
                                                backgroundColor:
                                                AppColor.secondaryColor,
                                                foregroundColor: Colors.white,
                                                icon: Icons
                                                    .delete_outline_rounded,
                                                borderRadius:
                                                BorderRadius.horizontal(
                                                  right: Radius.circular(15.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          child: Card(
                                            child: Container(
                                              height: 15.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(),
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
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        controller.items[index]
                                                            ['items_name_ar'],
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
                                                        controller.items[index]
                                                            ['restaurants_name'],
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors.black26,
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
                                                          // Text(
                                                          //   '${controller.items[index]['itemsprice'] - controller.items[index]['itemsprice'] * controller.items[index]['items_discount'] / 100}',
                                                          //   style: TextStyle(
                                                          //     fontSize: 10.sp,
                                                          //     color: Color(0xffFF7A2F),
                                                          //     fontWeight: FontWeight.bold,
                                                          //     fontFamily: 'ElMessiri',
                                                          //   ),
                                                          // ),
                                                          SizedBox(
                                                            width: 3.w,
                                                          ),
                                                          Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .addToCart(
                                                                          '${controller.items[index]['items_id']}',
                                                                          '0');
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 13.sp,
                                                                  backgroundColor:
                                                                  AppColor.secondaryColor,
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 12.sp,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Text(
                                                                '${controller.items[index]['countitems']}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'ElMessiri',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .removeFromCart(
                                                                          '${controller.items[index]['items_id']}');
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 13.sp,
                                                                  backgroundColor:
                                                                  AppColor.secondaryColor,
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 12.sp,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 3.w, 0),
                                                    height: 12.h,
                                                    width: 31.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              '${AppLink.items_image}/${controller.items[index]['items_image']}'),
                                                          fit: BoxFit.cover,
                                                        )),
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
                          controller.items.length != 0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 1.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            controller: controller.coupon,
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                EneftyIcons
                                                    .ticket_discount_bold,
                                                size: 20.sp,
                                                color: AppColor.secondaryColor,
                                              ),
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 1.5.h,
                                                      horizontal: 3.w),
                                              border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: AppColor.grey),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: AppColor.grey),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColor.primaryColor),
                                              ),
                                              errorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: AppColor.red),
                                              ),
                                              hintText: 'أكتب كود الخصم هنا',
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
                                        width: 2.w,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 90.w,
                                          height: 6.h,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.checkcoupon();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColor.secondaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Text(
                                              'تأكيد',
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.white,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          controller.items.length != 0
                              ? Container(
                                  width: 90.w,
                                  height: 20.h,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 1.h,
                                  ),
                                  padding:
                                      EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0.2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'تفاصيل الطلب :',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ElMessiri',
                                            ),
                                          ),
                                          Container(
                                            // height: 11.h,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  controller.items.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      controller.items[index]
                                                          ['items_name_ar'],
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontFamily: 'ElMessiri',
                                                      ),
                                                    ),
                                                    Text(
                                                      '${(controller.items[index]['itemsprice'] - controller.items[index]['itemsprice'] * controller.items[index]['items_discount'] / 100).toInt()}',
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontFamily: 'ElMessiri',
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          controller.items.length == 0
                                              ? SizedBox()
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'التوصيل',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.green,
                                                        fontFamily: 'ElMessiri',
                                                      ),
                                                    ),
                                                    Text(
                                                      '${controller.deliveryprice.toInt()} ',
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.green,
                                                        fontFamily: 'ElMessiri',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 1.h,
                          ),
                          controller.items.length != 0
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 5.w),
                                        width: 90.w,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            controller.getAddress();
                                            Get.to(CheckoutScreen());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              'إتمام الشراء ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Text(
                                              'القيمة الإجمالية',
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Text(
                                              controller.items.length == 0
                                                  ? '0'
                                                  : '${controller.totalprice.toInt() + controller.deliveryprice.toInt()} ل.س',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                )
                              : SizedBox(),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              height: 47.h,
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: 15.h,
                    width: 90.w,
                    decoration: BoxDecoration(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 2.h,
                              width: 40.w,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Container(
                              height: 2.h,
                              width: 30.w,
                              color: Colors.blue,
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
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13.sp,
                                      backgroundColor: AppColor.secondaryColor,
                                      child: Icon(
                                        Icons.add,
                                        size: 12.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Container(
                                      height: 2.h,
                                      width: 5.w,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    CircleAvatar(
                                      radius: 13.sp,
                                      backgroundColor: AppColor.secondaryColor,
                                      child: Icon(
                                        Icons.remove,
                                        size: 12.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
                          height: 12.h,
                          width: 31.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.h,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          EneftyIcons.ticket_discount_bold,
                          size: 20.sp,
                          color: AppColor.secondaryColor,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 3.w),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.grey),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.primaryColor),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColor.red),
                        ),
                        hintText: '',
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
                  width: 2.w,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 90.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.sp)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 90.w,
            height: 20.h,
            alignment: Alignment.topRight,
            margin: EdgeInsets.symmetric(
              vertical: 1.h,
            ),
            padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0.2.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 3.h,
                      width: 40.w,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      // height: 11.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 2.h,
                                width: 30.w,
                                color: Colors.blue,
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
                            height: 0.5.h,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.sp)),
                  padding: EdgeInsets.only(right: 5.w),
                  width: 90.w,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        height: 2.5.h,
                        width: 25.w,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        height: 1.5.h,
                        width: 15.w,
                        color: Colors.blue,
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
