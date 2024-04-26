import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/OrdersScreen.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../controller/Home/OrdersController.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'TrackingScreen.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersControllerImp ordersController = Get.put(OrdersControllerImp());
    ordersController.getDetails();
    MyServices myServices = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Add this line
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'طلب رقم : ${myServices.sharedPreferences.getString("orders_id")!}',
            style: TextStyle(
              color: AppColor.black,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
        body: GetBuilder<OrdersControllerImp>(
          builder: (controller) => SingleChildScrollView(
            child: controller.statusRequest == StatusRequest.loading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child:
                        YourShimmerWidget(), // Replace with your shimmer widget
                  )
                : SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 54.h,
                          width: 100.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: ListView.builder(
                              itemCount: controller.details.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    height: 15.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(),
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
                                            fontFamily: 'ElMessiri',
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
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
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                              Text(
                                                "${controller.details[index]['restaurants_name']}",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black26,
                                                  fontFamily: 'ElMessiri',
                                                ),
                                              ),
                                              Text(
                                                " ل.س ${controller.details[index]['itemsprice']}",
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.red,
                                                  fontFamily: 'ElMessiri',
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                            ],
                                          ),
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
                                );
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
                              fontFamily: 'ElMessiri',
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        Container(
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
                                  height: 14.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: controller.statusRequest ==
                                              StatusRequest.loading ||
                                          controller.details.isEmpty
                                      ? Center(
                                          child:
                                              const CircularProgressIndicator(
                                                  color: AppColor.white),
                                        )
                                      : GoogleMap(
                                          zoomControlsEnabled: false,
                                          initialCameraPosition: CameraPosition(
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
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              controller.statusRequest ==
                                          StatusRequest.loading ||
                                      controller.details.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColor.white),
                                    )
                                  : Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                EneftyIcons.location_bold,
                                                color: Color(0xffFF7A2F),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${controller.details[0]['address_street'] == 'Throttled! See geocode.xyz/pricing' ? 'مكان غير معروف' : controller.details[0]['address_street']}',
                                                  style: TextStyle(
                                                    color: AppColor.black,
                                                    fontFamily: 'ElMessiri',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                  ),
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
                                                EneftyIcons.call_calling_bold,
                                                color: Color(0xffFF7A2F),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${controller.details[0]['address_city']}',
                                                  style: TextStyle(
                                                    color: AppColor.black,
                                                    fontFamily: 'ElMessiri',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
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
                      ],
                    ),
                  ),
          ),
        ),
        floatingActionButton: GetBuilder<OrdersControllerImp>(
          builder: (controller) => controller.statusRequest ==
                  StatusRequest.loading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child:
                      YourShimmerWidget2(), // Replace with your shimmer widget
                )
              : Container(
                  width: 100.w,
                  child: Row(
                    children: [
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          myServices.sharedPreferences.setString("orders_id",
                              "${controller.details[0]['orders_id']}");
                          controller.details[0]['orders_status'] == 0 ||
                                  controller.details[0]['orders_status'] == 1 ||
                                  controller.details[0]['orders_status'] == 2
                              ? controller.removeorder(
                                  "${controller.details[0]['orders_id']}")
                              : controller.details[0]['orders_status'] == 3
                                  ? {
                                      Get.to(TrackingScreen()),
                                      controller.getDeliveryLocation(),
                                    }
                                  : print('ReOrder ');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 7.h,
                          width: 59.w,
                          // controller.details[0]['orders_rating'] == 0 ? 60.w : 92.w,
                          decoration: BoxDecoration(
                            color: Color(0xffFF7A2F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: controller.details.isEmpty
                              ? CircularProgressIndicator(
                                  color: Color(0xffFF7A2F),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<OrdersControllerImp>(
                                      builder: (controller) => Text(
                                        controller.details[0]
                                                        ['orders_status'] ==
                                                    0 ||
                                                controller.details[0]
                                                        ['orders_status'] ==
                                                    1 ||
                                                controller.details[0]
                                                        ['orders_status'] ==
                                                    2
                                            ? 'إلغاء الأوردر'
                                            : controller.details[0]
                                                        ['orders_status'] ==
                                                    3
                                                ? 'تتبع الديلفري'
                                                : 'طلب مرة أخرى',
                                        style: TextStyle(
                                          color: Colors.white,
                                          height: 0.2.h,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ElMessiri',
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return AlertDialog(
                                    title: Text(
                                      'ماهو تقييمك للأوردر',
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'أضف وصفًا إضافيًا هنا إذا كان لديك ملاحظات عن الأوردر أو موظف التوصيل',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'ElMessiri',
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Image.asset(
                                            controller.ratingImages[controller
                                                    .selectedRating.value -
                                                1],
                                            height: 100,
                                            width: 100,
                                          ),
                                          SizedBox(height: 20),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: FittedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children:
                                                    List.generate(5, (index) {
                                                  return IconButton(
                                                    icon: Icon(
                                                        index <
                                                                controller
                                                                    .selectedRating
                                                                    .value
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color:
                                                            Color(0xffFF7A2F),
                                                        size: 25.sp),
                                                    onPressed: () {
                                                      setState(() {
                                                        controller
                                                            .selectedRating
                                                            .value = index + 1;
                                                      });
                                                    },
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            controller: controller.comment,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'أكتب ملاحظاتك واقتراحاتك هنا',
                                                hintTextDirection:
                                                    TextDirection.rtl),
                                          ),
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
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'ElMessiri',
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // //print(
                                          //     'rating: ${controller.selectedRating.value}, comment: ${controller.commentController.text}');

                                          if (controller.selectedRating.value <
                                              3) {
                                            // Handle low rating scenario
                                          } else {
                                            // Handle higher rating scenario
                                          }

                                          controller.rateorder();
                                          Get.back();
                                        },
                                        child: Text(
                                          'إرسال',
                                          style: TextStyle(
                                            color: Color(0xffFF7A2F),
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
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
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 7.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffFF7A2F), width: 0.5.w),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '⭐️ تقييم',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.black,
                              height: 0.2.h,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ),
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
      height: 100.h,
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 54.h,
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 15.h,
                    width: 90.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 3.h,
                              width: 35.w,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Container(
                              height: 1.6.h,
                              width: 20.w,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Container(
                              height: 2.h,
                              width: 25.w,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Container(
                              height: 1.5.h,
                              width: 15.w,
                              color: Colors.blue,
                            ),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        border: Border.all(color: Colors.blue, width: 0.4.w)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 1.5.h,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.w, 1.h, 5.w, 0),
            child: Container(
              height: 3.h,
              width: 30.w,
              color: Colors.blue,
            ),
          ),
          Container(
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
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 3.h,
                            width: 40.w,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 2.h,
                            width: 30.w,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 2.h,
                            width: 25.w,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
              color: Color(0xffFF7A2F),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 3.w),
          Container(
            alignment: Alignment.center,
            height: 7.h,
            width: 30.w,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffFF7A2F), width: 0.5.w),
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
