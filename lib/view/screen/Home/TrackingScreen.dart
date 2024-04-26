import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/OrdersController.dart';
import '../../../core/services/services.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersControllerImp());
    MyServices myServices = Get.find();

    return Scaffold(
      body: GetBuilder<OrdersControllerImp>(
        builder: (controller) =>  controller.cameraposition != null
            ? Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              markers: controller.markers.toSet(),
              mapType: MapType.normal,
              polylines: controller.polylineSet,
              initialCameraPosition: controller.cameraposition!,
              onMapCreated: (GoogleMapController controllermap) {
                if (controller.controllerCompleter != null &&
                    !controller.controllerCompleter!.isCompleted) {
                  controller.controllerCompleter!
                      .complete(controllermap);
                }
              },
            ),
            Positioned(
              top: 5.h,
              right: 5.w,
              child: CircleAvatar(
                radius: 17.sp,
                backgroundColor: Color(0xffFF7A2F),
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
                bottom: 3.h,
                child: Container(
                  height: 25.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2.h, 5.w, 0),
                        child: Text(
                          'تتبع عامل التوصيل',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 1.h, 5.w, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${controller.duration}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                            SizedBox(width: 2.w,),
                            Icon(
                              EneftyIcons.clock_2_bold,
                              color: Colors.black54,
                              size: 17.sp,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 1.h, 5.w, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${controller.distance}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                            SizedBox(width: 2.w,),
                            Icon(
                              EneftyIcons.map_2_bold,
                              color: Colors.black54,
                              size: 17.sp,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.addAddress();
                          myServices.sharedPreferences.setString(
                              "myaddress",
                              '${controller.currentLocationName}');
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 7.h,
                          width: 85.w,
                          margin: EdgeInsets.fromLTRB(0, 2.h, 5.w, 0),
                          decoration: BoxDecoration(
                            color: Color(0xffFF7A2F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'تأكيد',
                            style: TextStyle(
                              color: Colors.white,
                              height: 0.2.h,
                              fontSize: 15.sp,
                              fontFamily: 'ElMessiri',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        )
            : Center(child: CircularProgressIndicator(
          color: Color(0xffFF7A2F),
        )),
      ),
    );
  }
}
