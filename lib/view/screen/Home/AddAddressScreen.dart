import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/RestaurantsController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import '../../../controller/Home/AddressController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantsControllerImp());

    return Scaffold(
      body: GetBuilder<RestaurantsControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: controller.KGooglePlex != null
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      markers: controller.markers.toSet(),
                      onTap: (latlng) {
                        controller.addMarkers(latlng);
                      },
                      mapType: MapType.normal,
                      initialCameraPosition: controller.KGooglePlex!,
                      onMapCreated: (GoogleMapController controllermap) async {
                        controller.controllerCompleter!.complete(controllermap);
                      },
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height *
                          0.05, // 5% of screen height
                      child: Container(
                        height: 7.h,
                        width: 100.w,
                        padding: EdgeInsets.fromLTRB(4.w, 1.h, 20.w, 0.h),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: SearchField<String>(
                            searchStyle: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontFamily: 'Cairo',
                            ),
                            itemHeight: 7.h,
                            searchInputDecoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                EneftyIcons.search_normal_2_outline,
                                size: 20.sp,
                                color: AppColor.grey,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 3.w,
                              ),
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
                              hintText: 'إبحث عن مكان',
                              hintStyle: TextStyle(
                                height: 0.2.h,
                                fontSize: 11.sp,
                                fontFamily: 'Cairo',
                                letterSpacing: 1,
                              ),
                            ),
                            suggestions: (controller.searchlist is List)
                                ? controller.searchlist
                                .map(
                                  (e) => SearchFieldListItem<String>(
                                e['properties']['name'],
                                child: GestureDetector(
                                  onTap: () {
                                    List<dynamic> coordinates =
                                    e['geometry']['coordinates'];
                                    double latitude = coordinates[1];
                                    double longitude = coordinates[0];
                                    LatLng latLng =
                                    LatLng(latitude, longitude);

                                    // Add marker
                                    controller.addMarkers(latLng);
                                    controller.moveCameraTo(latLng);
                                    controller.searchlist = [];
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: FittedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${e['properties']['name']}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                          Text(
                                            '${e['properties']['state']}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 7.sp,
                                              color: Colors.grey,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                                .toList()
                                : [],
                            onSearchTextChanged: (query) {
                              controller.getsearch(query);
                              controller.update();
                            },
                          ),
                        ),
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
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 7.h,
                                width: 85.w,
                                margin: EdgeInsets.fromLTRB(0, 2.h, 5.w, 0),
                                decoration: BoxDecoration(
                                  color: AppColor.secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'تأكيد',
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 0.2.h,
                                    fontSize: 15.sp,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
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
