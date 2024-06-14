import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/AddAddressScreen.dart';
import 'package:yumyum/view/screen/Home/OrdersScreen.dart';
import 'dart:ui' as ui;
import '../../../controller/Home/OrdersController.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'ShowAddressUser.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersControllerImp());
    MyServices myServices = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Add this line
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.off(OrdersScreen());
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'طلب رقم : ${myServices.sharedPreferences.getString("orders_id")!}',
            style: TextStyle(
              color: AppColor.black,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
        body: GetBuilder<OrdersControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              height: 100.h,
              width: 100.w,
              child: SingleChildScrollView(
                child: controller.statusRequest == StatusRequest.loading ||
                        controller.details.isEmpty
                    ? RefreshIndicator(
                  onRefresh: ()async{
                    await Future.delayed(Duration(seconds: 2));
                    controller.onInit();
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
                    : RefreshIndicator(
                  onRefresh: ()async{
                    await Future.delayed(Duration(seconds: 2));
                    controller.onInit();
                  },
                  color: Colors.white,
                  backgroundColor: AppColor.secondaryColor,
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 56.h,
                              width: 100.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.details.length+1,
                                  itemBuilder: (context, index) {
                                    if(index == controller.details.length){
                                      return  Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(2.w, 1.h, 5.w, 0),
                                            child: Text(
                                              ':ملاحظات على الأوردر ',
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 0),
                                            height: 14.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.sp),
                                              border: Border.all(
                                                color: Colors.black54,
                                                width: 0.2.w,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 2.h, 5.w, 0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    controller.details[0]['orders_description']=='' ? 'لا يوجد ملاحظات': '${controller.details[0]['orders_description']}',
                                                    style: TextStyle(
                                                      color: controller.details[0]['orders_description']!='' ?
                                                      AppColor.black : Colors.grey,
                                                      fontFamily: 'Cairo',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    EneftyIcons.book_bold,
                                                    color: AppColor.secondaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2.h,),
                                          Container(
                                            width: 100.w,
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 1.h),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'تفاصيل الطلب :',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Cairo',
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller.details.length,
                                                      itemBuilder: (context, index) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              controller.details[index]
                                                              ['items_name_ar'],
                                                              style: TextStyle(
                                                                fontSize: 13.sp,
                                                                fontFamily: 'Cairo',
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  ' SYP',
                                                                  textDirection: TextDirection.ltr,
                                                                  style: TextStyle(
                                                                    fontSize: 13.sp,
                                                                    fontFamily: 'Cairo',
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${controller.addCommasToNumber((controller.details[index]['itemsprice'] - controller.details[index]['itemsprice'] * controller.details[index]['items_discount'] / 100).toInt())}',
                                                                  textDirection: TextDirection.ltr,
                                                                  style: TextStyle(
                                                                    fontSize: 13.sp,
                                                                    fontFamily: 'Cairo',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'التوصيل',
                                                        style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color: AppColor.secondaryColor2,
                                                          fontFamily: 'Cairo',
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: (){
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return Container(
                                                                      width: 95.w,
                                                                      child: AlertDialog(
                                                                        backgroundColor: Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                            BorderRadius.circular(10.sp)),
                                                                        content: Column(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            SizedBox(height: 10.0),
                                                                            Text(
                                                                              ' تعديل سعر التوصيل للطلب (${myServices.sharedPreferences.getString("orders_id")!})',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontSize: 11.sp,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: 'Cairo',
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 2.h,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: controller.new_delivery_price,
                                                                              keyboardType: TextInputType.number,
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
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
                                                                                suffix: Text('SYP'),
                                                                                hintText: controller.new_delivery_price.text,
                                                                                hintStyle: TextStyle(
                                                                                  height: 0.2.h,
                                                                                  fontSize: 11.sp,
                                                                                  fontFamily: 'Cairo',
                                                                                  letterSpacing: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 2.h,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    height: 6.h,
                                                                                    width: 20.w,
                                                                                    child: ElevatedButton(
                                                                                      onPressed: () {

                                                                                        controller.updateDeliveryPriceOrder(
                                                                                          myServices.sharedPreferences.getString("orders_id")!,
                                                                                            controller.new_delivery_price.text
                                                                                        );
                                                                                        Get.back();
                                                                                      },
                                                                                      style: ElevatedButton
                                                                                          .styleFrom(
                                                                                        backgroundColor:
                                                                                        AppColor.secondaryColor,
                                                                                        shape:
                                                                                        RoundedRectangleBorder(
                                                                                          borderRadius:
                                                                                          BorderRadius
                                                                                              .circular(10.0),
                                                                                        ),
                                                                                      ),
                                                                                      child: Text(
                                                                                        'تعديل',
                                                                                        style: TextStyle(
                                                                                          fontSize: 10.sp,
                                                                                          color: Colors.white,
                                                                                          fontWeight:
                                                                                          FontWeight.bold,
                                                                                          fontFamily: 'Cairo',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                Expanded(
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      height: 6.h,
                                                                                      width: 20.w,
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius:
                                                                                          BorderRadius
                                                                                              .circular(10),
                                                                                          border: Border.all(
                                                                                            color:
                                                                                            AppColor.grey,
                                                                                            width: 0.3.h,
                                                                                          )),
                                                                                      child: Text(
                                                                                        'لا',
                                                                                        style: TextStyle(
                                                                                          color:
                                                                                          AppColor.grey,
                                                                                          height: 0.2.h,
                                                                                          fontSize: 15.sp,
                                                                                          fontWeight:
                                                                                          FontWeight.bold,
                                                                                          fontFamily: 'Cairo',
                                                                                        ),
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
                                                                  },
                                                                );
                                                              },
                                                              child: Icon(EneftyIcons.edit_2_bold,color: AppColor.black,)),
                                                          Text(
                                                            ' SYP',
                                                            textDirection: TextDirection.ltr,
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              color: AppColor.secondaryColor2,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            '${controller.addCommasToNumber(controller.details[0]['orders_pricedelivery'].toInt())} ',
                                                            textDirection: TextDirection.ltr,
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              color: AppColor.secondaryColor2,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'السعر الإجمالي',
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.red,
                                                            fontFamily: 'Cairo',
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            ' SYP',
                                                            textDirection: TextDirection.ltr,
                                                            style: TextStyle(
                                                                fontSize: 13.sp,
                                                                color: Colors.red,
                                                                fontFamily: 'Cairo',
                                                                fontWeight: FontWeight.bold),
                                                          ),

                                                          Text(
                                                            ' ${controller.addCommasToNumber(controller.details[0]['orders_totalprice'].toInt())}',
                                                            textDirection: TextDirection.ltr,
                                                            style: TextStyle(
                                                                fontSize: 13.sp,
                                                                color: Colors.red,
                                                                fontFamily: 'Cairo',
                                                                fontWeight: FontWeight.bold),
                                                          ),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else{
                                      return Card(
                                        child: Container(
                                          height: 15.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(),
                                          child: FittedBox(
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width:4.w),
                                                Text(
                                                  "X${controller.details[index]['countitems']}",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Cairo',
                                                  ),
                                                ),
                                                SizedBox(width:19.w),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${controller.details[index]['items_name_ar']}',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Cairo',
                                                      ),
                                                    ),
                                                    Text(
                                                      "${controller.details[index]['restaurants_name']}",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.black26,
                                                        fontFamily: 'Cairo',
                                                      ),
                                                    ),
                                                    Text(
                                                      " ل.س ${controller.addCommasToNumber(controller.details[index]['itemsprice'])}",
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color: Colors.red,
                                                          fontFamily: 'Cairo',
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Container(
                                                  margin:
                                                  EdgeInsets.fromLTRB(0, 0, 3.w, 0),
                                                  height: 12.h,
                                                  width: 31.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(10.sp),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${AppLink.items_image}/${controller.details[index]['items_image']}'),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(2.w, 1.h, 5.w, 0),
                              child: Text(
                                'عنوان التوصيل :',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Get.to(ShowAddressUser());
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 0),
                                height: 18.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  border: Border.all(
                                    color: Colors.black54,
                                    width: 0.2.w,
                                  ),
                                ),
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
                                        height: 19.h,
                                        width: 45.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                        child: controller.statusRequest ==
                                                StatusRequest.loading
                                            ? Center(
                                                child:
                                                    const CircularProgressIndicator(
                                                        color: AppColor.white),
                                              )
                                            : GoogleMap(
                                                zoomControlsEnabled: false,
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target: LatLng(
                                                    controller.details[0]
                                                        ['address_lat'],
                                                    controller.details[0]
                                                        ['address_long'],
                                                  ),
                                                  zoom: 15.4746,
                                                ),
                                                onMapCreated: (GoogleMapController
                                                    controllermap) {
                                                  if (controller
                                                          .controllerCompleter !=
                                                      null) {
                                                    controller.controllerCompleter!
                                                        .complete(controllermap);
                                                  }
                                                },
                                                mapType: MapType.normal,
                                                markers: Set<Marker>.of(
                                                  controller.details.map((detail) {
                                                    return Marker(
                                                      markerId: MarkerId(
                                                          detail['items_name']
                                                              .toString()),
                                                      position: LatLng(
                                                        detail['address_lat'],
                                                        detail['address_long'],
                                                      ),
                                                      infoWindow: InfoWindow(
                                                        title:
                                                            detail['items_name_ar'],
                                                        snippet:
                                                            detail['items_desc_ar'],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Column(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                EneftyIcons.profile_bold,
                                                color: AppColor.secondaryColor,
                                                size: 22.sp,
                                              ),
                                              Text(
                                                '${controller.details[0]['users_name']}',
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                EneftyIcons.location_bold,
                                                color: AppColor.secondaryColor,
                                                size: 22.sp,
                                              ),
                                              Text(
                                                '${controller.details[0]['address_street'] == 'Throttled! See geocode.xyz/pricing' || controller.details[0]['address_street']=='null' ? '${controller.details[0]['users_city']}-${controller.details[0]['address_name']}' : '${controller.details[0]['users_city']}-${controller.details[0]['address_street']}'}',
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              SizedBox(width: 34.w,)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            children: [
                                               Icon(
                                                EneftyIcons.call_calling_bold,
                                                color: AppColor.secondaryColor,
                                                 size: 22.sp,
                                              ),
                                              Text(
                                                '${controller.details[0]['address_city']}',
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                          ],
                        ),
                    ),
              ),
            ),
          ),
        ),
        floatingActionButton: GetBuilder<OrdersControllerImp>(
          builder: (controller) {

            if (controller.details.isNotEmpty) {
                 return  Container(
                   width: 100.w,
                   child: controller.details[0]['orders_status'] == 0
                       ? FittedBox(
                     child: Row(
                       children: [
                         SizedBox(width: 8.w),
                         GestureDetector(
                           onTap: () {
                             showDialog(
                               context: context,
                               builder: (BuildContext context) {
                                 return Container(
                                   width: 95.w,
                                   child: AlertDialog(
                                     backgroundColor: Colors.white,
                                     shape: RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius.circular(10.sp)),
                                     content: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         SizedBox(height: 10.0),
                                         Text(
                                           'هل أنت متأكد أنك تريد رفض هذا الأوردر ؟',
                                           textAlign: TextAlign.center,
                                           style: TextStyle(
                                             fontSize: 11.sp,
                                             color: Colors.black,
                                             fontWeight: FontWeight.bold,
                                             fontFamily: 'Cairo',
                                           ),
                                         ),
                                         SizedBox(
                                           height: 2.h,
                                         ),
                                         Row(
                                           children: [
                                             Expanded(
                                               child: Container(
                                                 height: 6.h,
                                                 width: 20.w,
                                                 child: ElevatedButton(
                                                   onPressed: () {
                                                     myServices.sharedPreferences.setString("orders_id",
                                                         "${controller.details[0]['orders_id']}");

                                                     controller.reject(
                                                       '${myServices.sharedPreferences.getString("orders_id")}',
                                                       '${myServices.sharedPreferences.getString("orders_usersid")}',
                                                     );
                                                   },
                                                   style: ElevatedButton
                                                       .styleFrom(
                                                     backgroundColor:
                                                    Colors.red,
                                                     shape:
                                                     RoundedRectangleBorder(
                                                       borderRadius:
                                                       BorderRadius
                                                           .circular(10.0),
                                                     ),
                                                   ),
                                                   child: Text(
                                                     'نعم',
                                                     style: TextStyle(
                                                       fontSize: 10.sp,
                                                       color: Colors.white,
                                                       fontWeight:
                                                       FontWeight.bold,
                                                       fontFamily: 'Cairo',
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                             SizedBox(
                                               width: 5.w,
                                             ),
                                             Expanded(
                                               child: GestureDetector(
                                                 onTap: () {
                                                   Get.back();
                                                 },
                                                 child: Container(
                                                   alignment: Alignment.center,
                                                   height: 6.h,
                                                   width: 20.w,
                                                   decoration: BoxDecoration(
                                                       borderRadius:
                                                       BorderRadius
                                                           .circular(10),
                                                       border: Border.all(
                                                         color:
                                                         AppColor.primaryColor,
                                                         width: 0.3.h,
                                                       )),
                                                   child: Text(
                                                     'لا',
                                                     style: TextStyle(
                                                       color:
                                                       AppColor.primaryColor,
                                                       height: 0.2.h,
                                                       fontSize: 15.sp,
                                                       fontWeight:
                                                       FontWeight.bold,
                                                       fontFamily: 'Cairo',
                                                     ),
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
                               },
                             );
                           },
                           child: Container(
                             alignment: Alignment.center,
                             height: 7.h,
                             width: 45.w,
                             // controller.details[0]['orders_rating'] == 0 ? 60.w : 92.w,
                             decoration: BoxDecoration(
                               color: AppColor.secondaryColor,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: controller.details.isEmpty
                                 ? CircularProgressIndicator(
                               color: AppColor.secondaryColor,
                             )
                                 : Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 GetBuilder<OrdersControllerImp>(
                                   builder: (controller) => Text(
                                     'رفض الأوردر',
                                     style: TextStyle(
                                       color: Colors.white,
                                       height: 0.2.h,
                                       fontSize: 12.sp,
                                       fontWeight: FontWeight.bold,
                                       fontFamily: 'Cairo',
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 2.w,
                                 ),
                                 Icon(
                                   EneftyIcons.shopping_cart_outline,
                                   color: Colors.white,
                                   size: 17.sp,
                                 ),
                               ],
                             ),
                           ),
                         ),
                         SizedBox(width: 3.w),
                         GestureDetector(
                           onTap: () {
                             myServices.sharedPreferences.setString("orders_id",
                                 "${controller.details[0]['orders_id']}");

                             controller.approve(
                               '${myServices.sharedPreferences.getString("orders_id")}',
                               '${myServices.sharedPreferences.getString("orders_usersid")}',
                             );
                           },
                           child: Container(
                             alignment: Alignment.center,
                             height: 7.h,
                             width: 45.w,
                             // controller.details[0]['orders_rating'] == 0 ? 60.w : 92.w,
                             decoration: BoxDecoration(
                               color: AppColor.secondaryColor,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: controller.details.isEmpty
                                 ? CircularProgressIndicator(
                               color: AppColor.secondaryColor,
                             )
                                 : Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 GetBuilder<OrdersControllerImp>(
                                   builder: (controller) => Text(
                                     'قبول الأوردر',
                                     style: TextStyle(
                                       color: Colors.white,
                                       height: 0.2.h,
                                       fontSize: 12.sp,
                                       fontWeight: FontWeight.bold,
                                       fontFamily: 'Cairo',
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 2.w,
                                 ),
                                 Icon(
                                   EneftyIcons.shopping_cart_outline,
                                   color: Colors.white,
                                   size: 17.sp,
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ],
                     ),
                   )
                       : controller.details[0]['orders_status'] == 1
                       ? GestureDetector(
                     onTap: () {
                       myServices.sharedPreferences.setString("orders_id",
                           "${controller.details[0]['orders_id']}");

                       controller.prepare(
                         '${myServices.sharedPreferences.getString("orders_id")}',
                         '${myServices.sharedPreferences.getString("orders_usersid")}',
                       );
                     },
                     child: Container(
                       alignment: Alignment.center,
                       height: 7.h,
                       margin: EdgeInsets.only(right: 9.w),
                       decoration: BoxDecoration(
                         color: AppColor.secondaryColor,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: controller.details.isEmpty
                           ? CircularProgressIndicator(
                         color: AppColor.secondaryColor,
                       )
                           : Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           GetBuilder<OrdersControllerImp>(
                             builder: (controller) => Text(
                               'انتهاء التحضير',
                               style: TextStyle(
                                 color: Colors.white,
                                 height: 0.2.h,
                                 fontSize: 12.sp,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Cairo',
                               ),
                             ),
                           ),
                           SizedBox(
                             width: 2.w,
                           ),
                           Icon(
                             EneftyIcons.shopping_cart_outline,
                             color: Colors.white,
                             size: 17.sp,
                           ),
                         ],
                       ),
                     ),
                   )
                       : controller.details[0]['orders_status'] == 2 || controller.details[0]['orders_status'] == 3
                       ? GestureDetector(
                     onTap: () {
                       myServices.sharedPreferences.setString(
                           "orders_id",
                           "${controller.details[0]['orders_id']}");

                       // controller.prepare(
                       //   '${myServices.sharedPreferences.getString(
                       //       "orders_id")}',
                       //   '${myServices.sharedPreferences.getString(
                       //       "orders_usersid")}',
                       // );
                     },
                     child: Container(
                       alignment: Alignment.center,
                       height: 7.h,
                       margin: EdgeInsets.only(right: 9.w),
                       decoration: BoxDecoration(
                         color: AppColor.secondaryColor,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: controller.details.isEmpty
                           ? CircularProgressIndicator(
                         color: AppColor.secondaryColor,
                       )
                           : Row(
                         mainAxisAlignment:
                         MainAxisAlignment.center,
                         children: [
                           GetBuilder<OrdersControllerImp>(
                             builder: (controller) => Text(
                               'تتبع الديلفري ',
                               style: TextStyle(
                                 color: Colors.white,
                                 height: 0.2.h,
                                 fontSize: 12.sp,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'Cairo',
                               ),
                             ),
                           ),
                           SizedBox(
                             width: 2.w,
                           ),
                           Icon(
                             EneftyIcons.car_outline,
                             color: Colors.white,
                             size: 17.sp,
                           ),
                         ],
                       ),
                     ),
                   )
                       : SizedBox(),
                 );
            }else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(',Sorry, something went wrong'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: (){Get.off(OrdersScreen());},
                            child: Text('try again',style: TextStyle(fontWeight: FontWeight.bold),)),
                        Text(' Please'),
                      ],
                    ),
                  ],
                ),
              );
            }

          }
      ),
      ),
    );
  }
}

class YourShimmerWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Container(
            alignment: Alignment.center,
            height: 7.h,
            width: 59.w,
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 3.w),
          Container(
            alignment: Alignment.center,
            height: 7.h,
            width: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.secondaryColor, width: 0.5.w),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 2.h,
              width: 15.w,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
