import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/RestaurantsController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import '../../../controller/Home/OrdersController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';

class ShowAddressUser extends StatelessWidget {
  const ShowAddressUser({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantsControllerImp());

    return Scaffold(
      body: GetBuilder<OrdersControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: controller
              .controllerCompleter ==
              null
              ? Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
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
                markers: Set<maps.Marker>.of(
                  controller.details.map((detail) {
                    return maps.Marker(
                      markerId: maps.MarkerId(detail['items_name'].toString()),
                      position: LatLng(
                        detail['address_lat'],
                        detail['address_long'],
                      ),
                      infoWindow: maps.InfoWindow(
                        title: detail['items_name_ar'],
                        snippet: detail['items_desc_ar'],
                      ),
                    );
                  }),
                ),
              ),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: CircleAvatar(
                  radius: 17.sp,
                  backgroundColor: AppColor.secondaryColor,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 5.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.makeCall(controller.details[0]['address_city']);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 7.h,
                              width: 40.w,

                              margin: EdgeInsets.fromLTRB(0, 2.h, 5.w, 0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                color: AppColor.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.call,color: Colors.white,),
                                  Text(
                                    ' إتصال ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      height: 0.2.h,
                                      fontSize: 15.sp,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 7.h,
                              width: 35.w,
                              margin: EdgeInsets.fromLTRB(0, 2.h, 5.w, 0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'رجوع',
                                style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  height: 0.2.h,
                                  fontSize: 15.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          )
              : Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Lottie.asset(
                  AppImageAsset.emptyitems,
                  height: 30.h,
                ),
                const Text(
                  'جاري تحميل الخريطة',
                  style: TextStyle(
                    color: AppColor.black,
                    fontFamily: 'Cairo',
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
