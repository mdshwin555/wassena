import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/SavedAddressController.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/services/services.dart';
import 'AddAddressScreen.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    Get.put(SavedAddressControllerImp());

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
          centerTitle: true,
          title: Text(
            'العناوين المحفوظة',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'ElMessiri',
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
            ),
          ),
        ),
        body: GetBuilder<SavedAddressControllerImp>(
          builder: (controller) => Container(
            width: 100.w,
            height: 100.h,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 0),
            child:  myServices.sharedPreferences
                .getString("users_phone") ==
                null?Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Lottie.asset(
                  AppImageAsset.emptyaddress,
                  height: 25.h,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'لم يتم العثور على عناوين محفوظة ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'ElMessiri',
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ):controller.statusRequest ==
                StatusRequest.loading
                ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: YourShimmerWidget(), // Replace with your shimmer widget
            ):controller.address.length == 0
                ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Lottie.asset(
                    AppImageAsset.emptyaddress,
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'لم يتم العثور على عناوين محفوظة ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'ElMessiri',
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            )
                : SizedBox(
              height: 80.h,
              child: ListView.builder(
                itemCount: controller.address.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (a) {
                            controller.removeAddress(controller
                                .address[index]['address_id']);
                          },
                          backgroundColor: Color(0xffFF7A2F),
                          foregroundColor: Colors.white,
                          icon: Icons.delete_outline_rounded,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(15.sp),
                          ),
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (a) {
                            controller.removeAddress(controller
                                .address[index]['address_id']);
                          },
                          backgroundColor: Color(0xffFF7A2F),
                          foregroundColor: Colors.white,
                          icon: Icons.delete_outline_rounded,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(15.sp),
                          ),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: myServices.sharedPreferences
                            .getInt("activeAddress") ==
                            index
                            ? Color(0xffFF7A2F)
                            : Colors.white60,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            height: 15.h,
                            width: 90.w,
                            margin:
                            EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
                            decoration: BoxDecoration(),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.removeAddress(controller
                                        .address[index]['address_id']);
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    color: myServices.sharedPreferences
                                        .getInt(
                                        "activeAddress") ==
                                        index
                                        ? Colors.white
                                        : Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${controller.address[index]['address_name']}',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontFamily: 'ElMessiri',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          const Icon(
                                            EneftyIcons.location_bold,
                                            color: Color(0xffFF7A2F),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '${controller.address[index]['address_street']=='Throttled! See geocode.xyz/pricing'?'مكان غير معروف':controller.address[index]['address_street']}\n ${controller.address[index]['address_city']}',
                                              textAlign:
                                              TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: myServices
                                                    .sharedPreferences
                                                    .getInt(
                                                    "activeAddress") ==
                                                    index
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontFamily: 'ElMessiri',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          const Icon(
                                            EneftyIcons
                                                .info_circle_bold,
                                            color: Color(0xffFF7A2F),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddAddressScreen());
          },
          backgroundColor: Color(0xffFF7A2F),
          child: const Icon(
            EneftyIcons.location_add_outline,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
class YourShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xffFF7A2F),

            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                height: 13.h,
                width: 90.w,
                margin:
                EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
                decoration: BoxDecoration(),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 2.h,
                                width: 30.w,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              const Icon(
                                EneftyIcons.location_bold,
                                color: Color(0xffFF7A2F),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child:  Container(
                                  height: 2.h,
                                  width: 30.w,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              const Icon(
                                EneftyIcons
                                    .info_circle_bold,
                                color: Color(0xffFF7A2F),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
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
    );
  }
}
