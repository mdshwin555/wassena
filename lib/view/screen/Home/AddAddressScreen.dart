import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/core/class/statusrequest.dart';
import 'package:yumyum/view/screen/Home/nextAddAddressScreen.dart';
import '../../../controller/Home/AddressController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/services/services.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressController());
    MyServices myServices = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AddressController>(
        builder: (controller) => controller.KGooglePlex != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    buildingsEnabled: true,
                    zoomControlsEnabled: false,
                    //markers: controller.markers.toSet(),
                    onCameraMove: (CameraPosition cameraPosition) {
                      LatLng latLng = cameraPosition.target;
                     if(myServices.sharedPreferences.getString('users_city')=='الزبداني'){
                       if (controller.isMarkerInsidePolygon(latLng, controller.getZabadaniPolygonPoints()) || controller.isMarkerRawda(latLng)) {
                         controller.addMarkers(latLng);
                         controller.setButtonColor(AppColor.secondaryColor,);
                       } else {
                         controller.setButtonColor(Colors.grey);
                       }
                     }else{
                       if (controller.isMarkerInsidePolygon(latLng, controller.getDamascusPolygonPoints())) {
                         controller.addMarkers(latLng);
                         controller.setButtonColor(AppColor.secondaryColor,);
                       } else {
                         controller.setButtonColor(Colors.grey);
                       }
                     }
                    },
                    mapType: MapType.terrain,
                    initialCameraPosition: controller.KGooglePlex!,
                    onMapCreated: (GoogleMapController controllermap) async {
                      controller.controllerCompleter!.complete(controllermap);
                    },
                    polygons: {
                      myServices.sharedPreferences.getString('users_city')=='الزبداني'? Polygon(
                        polygonId: PolygonId("madaya_polygon"),
                        points:  controller.getZabadaniPolygonPoints(), // Function to get polygon points
                        strokeWidth: 2,
                        strokeColor: Colors.red, // Change stroke color as needed
                        fillColor: Color(0xff133032).withOpacity(0.06),
                      ):
                      Polygon(
                        polygonId: PolygonId("damascus_polygon"),
                        points:  controller.getDamascusPolygonPoints(), // Function to get polygon points
                        strokeWidth: 2,
                        strokeColor: Colors.red, // Change stroke color as needed
                        fillColor: Color(0xff133032).withOpacity(0.06),
                      )
                    },
                  ),
                  Center(
                    child: controller.statusRequest == StatusRequest.loading
                        ? Image.asset(
                            'assets/images/marker2.png',
                            height: 16.h,
                          )
                        : Image.asset(
                          'assets/images/marker3.png',
                          height: 13.h,
                        ),
                  ),
                  Positioned(
                    bottom: 13.h,
                    right: 5.w,
                    child: CircleAvatar(
                      radius: 17.sp,
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          controller.getCurrentLocation();
                        },
                        icon: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                            fontFamily: 'ElMessiri',
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
                            hintText: controller.currentLocationName ==
                                    'Throttled! See geocode.xyz/pricing'
                                ? 'مكان غير معروف'
                                : '${controller.currentLocationName}',
                            hintStyle: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'ElMessiri',
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
                                                    fontFamily: 'ElMessiri',
                                                  ),
                                                ),
                                                Text(
                                                  '${e['properties']['state']}',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 7.sp,
                                                    color: Colors.grey,
                                                    fontFamily: 'ElMessiri',
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
                    top: 6.5.h,
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
                    bottom: 3.h,
                    left: 7.5.w,
                    child: GestureDetector(
                      onTap: () {
                        if (myServices.sharedPreferences.getString("token") ==
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
                          controller.buttonColor == Colors.grey
                              ? null
                              : Get.to(NextAddAddressScreen());
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 7.h,
                        width: 85.w,
                        margin: EdgeInsets.fromLTRB(0, 2.h, 5.w, 0),
                        decoration: BoxDecoration(
                          color:
                              controller.statusRequest == StatusRequest.loading
                                  ? Colors.grey
                                  : controller.buttonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: controller.statusRequest == StatusRequest.loading
                            ? Transform.scale(
                                scale: 3,
                                child: Lottie.asset(
                                  AppImageAsset.dotsloading,
                                ),
                              )
                            : Text(
                                controller.buttonColor == Colors.grey
                                    ? 'عذراَ! غير متاح التوصيل في هذه المنطقة'
                                    : 'تأكيد',
                                style: TextStyle(
                                  color: Colors.white,
                                  height: 0.2.h,
                                  fontSize: 11.sp,
                                  fontFamily: 'ElMessiri',
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
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
                      '..جاري تحميل الخريطة',
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
    );
  }
}
