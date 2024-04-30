import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/MainScreen.dart';
import '../../../controller/Home/AddressController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/services/services.dart';

class NextAddAddressScreen extends StatelessWidget {
  const NextAddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressController());
    MyServices myServices = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'إضافة تفاصيل العنوان',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.w600,
                fontSize: 12.sp),
          ),
        ),
        body: GetBuilder<AddressController>(
          builder: (controller) => controller.KGooglePlex != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: GoogleMap(
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              controller.markers.isNotEmpty
                                  ? controller.markers.first.position.latitude
                                  : 0.0,
                              controller.markers.isNotEmpty
                                  ? controller.markers.first.position.longitude
                                  : 0.0,
                            ),
                            zoom: 15.4746,
                          ),
                          onMapCreated: (GoogleMapController controllermap) {
                            controller.controllerCompleter!
                                .complete(controllermap);
                          },
                          markers: controller.markers.toSet(),
                          gestureRecognizers: Set()
                            ..add(Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            )),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 2.h, 0, 0),
                        child: Text(
                          controller.currentLocationName ==
                                  'Throttled! See geocode.xyz/pricing'
                              ? 'مكان غير معروف'
                              : '${controller.currentLocationName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 7.w, bottom: 1.h),
                        child: Text(
                          'تفاصيل العنوان',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            height: 0.2.h,
                            fontSize: 13.sp,
                            fontFamily: 'ElMessiri',
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 0),
                          child: TextFormField(
                            controller: controller.nameaddress,
                            style: TextStyle(
                              // Define the TextStyle for the entered text
                              fontFamily: 'ElMessiri',
                              fontSize: 11.sp,
                              color: Colors.black, // Customize color as needed
                              // Add other style properties as needed
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 3.w),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.red),
                              ),
                              hintText: 'اسم العنوان',
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
                        height: 8.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 0),
                          child: TextFormField(
                            controller: controller.phone,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              // Define the TextStyle for the entered text
                              fontFamily: 'ElMessiri',
                              fontSize: 11.sp,
                              color: Colors.black, // Customize color as needed
                              // Add other style properties as needed
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 3.w),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: AppColor.red),
                              ),
                              hintText: 'رقم الهاتف ',
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
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addAddress();
                          myServices.sharedPreferences.setString(
                              "myaddress", '${controller.currentLocationName}');
                          Get.offAll(MainScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 7.h,
                          width: 85.w,
                          margin: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 0),
                          decoration: BoxDecoration(
                            color: AppColor.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'إضافة العنوان',
                            style: TextStyle(
                              color: Colors.white,
                              height: 0.2.h,
                              fontSize: 13.sp,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Lottie.asset(
                    AppImageAsset.loadingmap,
                    height: 40.h,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text(
                  'جاري تحميل الخريطة',
                  style: TextStyle(
                    color: AppColor.grey,
                    fontFamily: 'ElMessiri',
                    fontWeight: FontWeight.w600,
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
