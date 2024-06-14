import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CategoriesController.dart';
import 'package:yumyum/controller/Home/ItemsController.dart';
import 'package:yumyum/core/class/statusrequest.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'AddCategoriesScreen.dart';
import 'AddItemsScreen.dart';
import 'EditCategoriesScreen.dart';
import 'EditItemsScreen.dart';
import 'HomeScreen.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsControllerImp());
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
            '${myServices.sharedPreferences.getString("categories_name_ar")}',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<ItemsControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              width: 100.w,
              height: 100.h,
              child: controller.statusRequest==StatusRequest.loading?
              RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(Duration(seconds: 2));
                  controller.onInit();
                },
                color: Colors.white,
                backgroundColor: AppColor.secondaryColor,
                child:SingleChildScrollView(
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
                          'جار تحميل الأصناف',
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
                  :controller.items.isEmpty
                  ? RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(Duration(seconds: 2));
                  controller.onInit();
                },
                color: Colors.white,
                backgroundColor: AppColor.secondaryColor,
                child:SingleChildScrollView(
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
                                'لا يوجد أصناف بعد',
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
                  await Future.delayed(Duration(seconds: 2));
                  controller.onInit();
                },
                color: Colors.white,
                backgroundColor: AppColor.secondaryColor,
                child:Directionality(
                        textDirection: TextDirection.ltr,
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          margin: EdgeInsets.only(
                            left: 3.w,
                            right: 3.w,
                          ),
                          child: ListView.builder(
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  height: 15.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(),
                                  child: FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                controller.deleteitems(
                                                    '${controller.items[index]['items_id']}',
                                                    '${controller.items[index]['items_image']}');
                                              },
                                              icon: Icon(Icons.delete),
                                              color: Colors.red,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                myServices.sharedPreferences
                                                    .setString("items_name_ar",
                                                        '${controller.items[index]['items_name_ar']}');
                                                myServices.sharedPreferences
                                                    .setString("items_id",
                                                        '${controller.items[index]['items_id']}');
                                                myServices.sharedPreferences
                                                    .setString("items_image",
                                                    '${controller.items[index]['items_image']}');
                                                Get.to(EditItemsScreen(
                                                  items_name: controller.items[index]['items_name_ar'].toString(),
                                                  items_desc: controller.items[index]['items_desc'].toString(),
                                                  items_price: controller.items[index]['items_price'].toString(),
                                                  items_discount: controller.items[index]['items_discount'].toString(),
                                                  items_subcat: controller.items[index]['items_subcat'].toString(),
                                                  restaurants_subcat: controller.items[index]['restaurants_subcat'].toString(),
                                                  restaurants_name: controller.items[index]['restaurants_name'].toString(),
                                                  items_image: controller.items[index]['items_image'].toString(),
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
                                              controller.items[index]
                                                  ['items_name_ar'],
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
                                              '${controller.items[index]['restaurants_name']}',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black26,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${controller.items[index]['items_price']}',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: AppColor.secondaryColor,
                                                    fontFamily: 'Cairo',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                Icon(
                                                  Icons.monetization_on_outlined,
                                                  color: AppColor.secondaryColor,
                                                  size: 14.sp,
                                                ),
                                              ],
                                            ),
                                            controller.items[index]
                                                        ['items_discount'] ==
                                                    0
                                                ? SizedBox()
                                                : Row(
                                                    children: [
                                                      Text(
                                                        '${controller.items[index]['items_discount']}',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors.red,
                                                          fontFamily: 'Cairo',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      ),
                                                      Icon(
                                                        EneftyIcons
                                                            .discount_shape_bold,
                                                        size: 16.sp,
                                                        color: AppColor.secondaryColor,
                                                      ),
                                                    ],
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
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 3.w, 0),
                                          height: 12.h,
                                          width: 31.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    '${AppLink.items_image}/${controller.items[index]['items_image']}'),
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
            Get.to(AddItemsScreen());
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
