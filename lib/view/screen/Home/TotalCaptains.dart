import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CaptainControllerImp.dart';
import 'package:yumyum/controller/Home/CategoriesController.dart';

import '../../../controller/Home/RestaurantsController.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'AddCaptainsScreen.dart';
import 'AddCategoriesScreen.dart';
import 'AddRestaurantsScreen.dart';
import 'EditCategoriesScreen.dart';
import 'EditeRestaurantScreen.dart';
import 'HomeScreen.dart';

class TotalCaptains extends StatelessWidget {
  const TotalCaptains({super.key});

  @override
  Widget build(BuildContext context) {
    CaptainControllerImp controller = Get.put(CaptainControllerImp());
    MyServices myServices = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.offAll(HomeScreen());
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Total Captains ',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<CaptainControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              width: 100.w,
              height: 100.h,
              child: controller.captains.isEmpty
                  ? RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(Duration(seconds: 1));
                  controller.onInit();
                },
                color: Colors.white,
                backgroundColor: AppColor.secondaryColor,
                child: Center(
                                    child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Lottie.asset(
                        AppImageAsset.emptyitems,
                        height: 35.h,
                      ),
                      const Text(
                        'لا يوجد كابتن بعد',
                        style: TextStyle(
                          color: AppColor.black,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                                    ),
                                  ),
                  )
                  : RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(Duration(seconds: 1));
                  controller.onInit();
                },
                color: Colors.white,
                backgroundColor: AppColor.secondaryColor,
                child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Container(
                    width: 100.w,
                    height: 100.h,
                    margin: EdgeInsets.only(
                      left: 3.w,
                      right: 3.w,
                    ),
                    child: ListView.builder(
                      itemCount: controller.captains.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            height: 15.h,
                            width: 90.w,
                            decoration: BoxDecoration(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [

                                controller.captains[index]['delivery_online']==1 ?  Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    children: [

                                      Icon(Icons.circle,color: Colors.green,size: 10.sp,),
                                      Text(' Online ',style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black45,
                                        fontFamily: 'Cairo',
                                      )),
                                    ],
                                  ),
                                ):
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    children: [

                                      Icon(Icons.circle,color: Colors.red,size: 10.sp,),
                                      Text(' Offline ',style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black45,
                                        fontFamily: 'Cairo',
                                      ),),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [

                                        Text(
                                          '${controller.captains[index]
                                          ['delivery_name']}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black26,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                        Text(
                                          ' : إسم الكابتن',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [

                                        Row(
                                          children: [

                                            IconButton(onPressed: (){
                                              controller.makeCall(controller.captains[index]['delivery_phone']);
                                            }, icon: Icon(Icons.call), color: AppColor.secondaryColor,),

                                            SizedBox(width: 1.w),
                                            Text(
                                              '${controller.captains[index]['delivery_phone']}',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black26,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          ' : رقم الجوال',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                                    ),
                                  ),
                  ),
            ),
          ),
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddCaptainsScreen());
          },
          backgroundColor: AppColor.secondaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
