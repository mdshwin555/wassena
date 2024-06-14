import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CategoriesController.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'AddCategoriesScreen.dart';
import 'EditCategoriesScreen.dart';
import 'HomeScreen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
            'الأنواع ',
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
                  physics: AlwaysScrollableScrollPhysics(),
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
                  : RefreshIndicator(
    onRefresh: ()async{
    await Future.delayed(Duration(seconds: 1));
    controller.onInit();
    },
    color: Colors.white,
    backgroundColor: AppColor.secondaryColor,
    child:  Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          margin: EdgeInsets.only(
                            left: 3.w,
                            right: 3.w,
                          ),
                          child: ListView.builder(
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  height: 15.h,
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
                                                controller.deletecategories(
                                                    '${controller.categories[index]['categories_id']}',
                                                    '${controller.categories[index]['categories_image']}');
                                              },
                                              icon: Icon(Icons.delete),
                                              color: Colors.red,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                myServices.sharedPreferences.setString("categories_name_ar",  '${controller.categories[index]['categories_name_ar']}');
                                                myServices.sharedPreferences.setString("categories_id",  '${controller.categories[index]['categories_id']}');
                                                myServices.sharedPreferences.setString("categories_image",  '${controller.categories[index]['categories_image']}');
                                                controller.updatename(controller.categories[index]['categories_name_ar']);
                                                Get.to(EditCategoriesScreen());
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
                                              controller.categories[index]
                                                  ['categories_name_ar'],
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
                                            Text(
                                              'رقم : ${controller.categories[index]['categories_id']}',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black26,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
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
                                                    '${AppLink.categories_image}/${controller.categories[index]['categories_image']}'),
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
                  ),
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddCategoriesScreen());
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
