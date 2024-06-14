import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CategoriesController.dart';

import '../../../controller/Home/RestaurantsController.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'AddCategoriesScreen.dart';
import 'AddRestaurantsScreen.dart';
import 'EditCategoriesScreen.dart';
import 'EditeRestaurantScreen.dart';
import 'HomeScreen.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantsControllerImp());
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
            'المطاعم ',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<RestaurantsControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget:Container(
              width: 100.w,
              height: 100.h,
              margin: EdgeInsets.only(left: 1.w, right: 1.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.length,
                        // Set reverse to true
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              myServices.sharedPreferences.setString("categoryid",
                                  '${controller.categories[index]['categories_id']}');
                              controller.viewrestaurants();
                            },
                            child: Container(
                              width: 20.w,
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: ProgressiveImage(
                                      height: 8.h,
                                      width: 8.h,
                                      image: '${AppLink.categories_image}/${controller.categories[index]['categories_image']}',
                                      imageError: AppImageAsset.err,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      controller.categories[index]
                                      ['categories_name_ar'],
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: myServices.sharedPreferences
                                        .getInt("selectedcategory") ==
                                        index
                                        ? AppColor.secondaryColor
                                        : Colors.white,
                                    thickness: 0.3.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 3.w,
                          );
                        },
                      ),
                    ),
                    controller.restaurants.isEmpty
                        ? Center(
                      child: StreamBuilder<Object>(
                          stream: null,
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                Lottie.asset(
                                  AppImageAsset.emptyitems,
                                  height: 35.h,
                                ),
                                const Text(
                                  'لا يوجد مطاعم بعد',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          }),
                    )
                        : Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        width: 100.w,
                        height: 73.h,
                        margin: EdgeInsets.only(
                          left: 3.w,
                          right: 3.w,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.restaurants.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                height: 20.h,
                                width: 90.w,
                                decoration: BoxDecoration(),
                                child: FittedBox(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.deleteresturant(
                                                  '${controller.restaurants[index]['restaurants_id']}',
                                                  '${controller.restaurants[index]['restaurants_logo ']}',
                                                  '${controller.restaurants[index]['restaurants_background_image']}');
                                            },
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              myServices.sharedPreferences.setString("categories_name_ar",  '${controller.categories[index]['categories_name_ar']}');
                                              // myServices.sharedPreferences.setString("categories_id",  '${controller.categories[index]['categories_id']}');
                                              // myServices.sharedPreferences.setString("categories_image",  '${controller.categories[index]['categories_image']}');
                                              //
                                              // print(controller.categories[index]['categories_id'].toString());
                                              // print(controller.categories[index]['categories_id'].toString());
                                              // print(controller.categories[index]['categories_id'].toString());
                                              // print(controller.categories[index]['categories_name'].toString());
                                              // print(controller.categories[index]['categories_name'].toString());
                                              // print(controller.categories[index]['categories_name'].toString());
                                              // print(controller.restaurants[index]['restaurants_name'].toString(),);
                                              myServices.sharedPreferences.setString('city', controller.restaurants[index]['restaurants_location'].toString());
                                              Get.to(EditRestaurantsScreen(
                                                res_id: controller.restaurants[index]['restaurants_id'].toString(),
                                                res_name: controller.restaurants[index]['restaurants_name'].toString(),
                                                res_type: controller.restaurants[index]['restaurants_type'].toString(),
                                                res_city: controller.restaurants[index]['restaurants_location'].toString(),
                                                res_open: controller.restaurants[index]['restaurants_open'].toString(),
                                                res_close: controller.restaurants[index]['restaurants_close'].toString(),
                                                res_deliveryprice: controller.restaurants[index]['restaurants_deliveryprice'].toString(),
                                                res_isfulltime: controller.restaurants[index]['restaurants_is24'].toString(),
                                                res_subcat: controller.restaurants[index]['restaurants_subcat'].toString(),
                                                res_lat: controller.restaurants[index]['restaurants_lat'].toString(),
                                                res_lng: controller.restaurants[index]['restaurants_long'].toString(),
                                                res_logo: controller.restaurants[index]['restaurants_logo'].toString(),
                                                background_image: controller.restaurants[index]['restaurants_background_image'].toString(),

                                                categories_name:controller.categories[index]['categories_name'].toString() ,
                                              ));
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            controller.restaurants[index]
                                            ['restaurants_name'],
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${controller.restaurants[index]['restaurants_close']} - ${controller.restaurants[index]['restaurants_open']}',
                                                style: TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Icon(Icons.alarm)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${controller.restaurants[index]['restaurants_deliveryprice']}',
                                                style: TextStyle(
                                                  color: AppColor.grey,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Icon(Icons.delivery_dining)
                                            ],
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
                                            borderRadius:
                                            BorderRadius.circular(10.sp),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  '${AppLink.restaurants_image}/${controller.restaurants[index]['restaurants_background_image']}'),
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
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddRestaurantsScreen());
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
