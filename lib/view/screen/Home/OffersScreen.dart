import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CategoriesController.dart';

import '../../../controller/Home/OffersController.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'AddCategoriesScreen.dart';
import 'AddOffersScreen.dart';
import 'EditCategoriesScreen.dart';
import 'HomeScreen.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OffersControllerImp());
    MyServices myServices = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.offAll(HomeScreen());
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'الإعلانات ',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<OffersControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: RefreshIndicator(
              onRefresh: ()async{
                await Future.delayed(Duration(seconds: 2));
                controller.onInit();
              },
              color: Colors.white,
              backgroundColor: AppColor.secondaryColor,
              child: SingleChildScrollView(
                child:Container(
                  width: 100.w,
                  height: 100.h,
                  child: controller.offers.isEmpty
                      ? Center(
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
                                'لا يوجد إعلانات بعد',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            margin: EdgeInsets.only(
                              left: 3.w,
                              right: 3.w,
                            ),
                            child: ListView.builder(
                              itemCount: controller.offers.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (a) {
                                          controller.deleteoffers(
                                              '${controller.offers[index]['offers_id']}',
                                              '${controller.offers[index]['offers_image']}');
                                        },
                                        backgroundColor:
                                        AppColor.secondaryColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons
                                            .delete_outline_rounded,
                                        borderRadius:
                                        BorderRadius.horizontal(
                                          right: Radius.circular(15.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    child: Container(
                                      height: 20.h,
                                      width: 100.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  '${AppLink.offers_image}/${controller.offers[index]['offers_image']}'),
                                              fit: BoxFit.fill,
                                            )),
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
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddOffersScreen());
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
