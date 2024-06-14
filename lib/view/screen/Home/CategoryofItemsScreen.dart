import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CategoriesController.dart';
import 'package:yumyum/controller/Home/ItemsController.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'AddCategoriesScreen.dart';
import 'EditCategoriesScreen.dart';
import 'HomeScreen.dart';
import 'ItemsScreen.dart';

class CategoryofItemsScreen extends StatelessWidget {
  const CategoryofItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesControllerImp());
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
            'المنتجات ',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<CategoriesControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              width: 100.w,
              height: 100.h,
              child: controller.categories.isEmpty
                  ? RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(Duration(seconds: 1));
                  controller.onInit();
                },
                color: Colors.white,
                backgroundColor: AppColor.secondaryColor,
                child: SingleChildScrollView(
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
                                'لا يوجد أنواع بعد',
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
                  )
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        margin: EdgeInsets.only(
                          left: 3.w,
                          right: 3.w,
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.1,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                myServices.sharedPreferences.setString("categories_name_ar",  '${controller.categories[index]['categories_name_ar']}');
                                myServices.sharedPreferences.setString("categories_id",  '${controller.categories[index]['categories_id']}');
                                Get.to(ItemsScreen());
                              },
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Container(
                                  margin: EdgeInsets.all(1.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 14.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColor.secondaryColor
                                                  .withOpacity(0.40),
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(10.sp),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    '${AppLink.categories_image}/${controller.categories[index]['categories_image']}'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 5.w,
                                          left: 5.w,
                                          top: 1.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${controller.categories[index]['categories_id']}',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.black26,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            Text(
                                              controller.categories[index]
                                                  ['categories_name_ar'],
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo',
                                              ),
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
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
