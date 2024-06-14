import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/CategoriesController.dart';
import 'package:yumyum/controller/Home/UsersController.dart';
import 'package:yumyum/view/screen/Home/SendAllNotificationScreen.dart';
import 'package:yumyum/view/screen/Home/SendNotificationScreen.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import 'AddCategoriesScreen.dart';
import 'EditCategoriesScreen.dart';
import 'HomeScreen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersControllerImp controller = Get.put(UsersControllerImp());
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
          actions: [
            IconButton(onPressed: (){
              Get.to(SendAllNotificationScreen());

            }, icon:  Icon(Icons.notifications))
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'المستخدمين ',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<UsersControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: RefreshIndicator(
              onRefresh: ()async{
                await Future.delayed(Duration(seconds: 1));
                controller.onInit();
              },
              color: Colors.white,
              backgroundColor: AppColor.secondaryColor,
              child: Container(
                width: 100.w,
                height: 100.h,
                child: controller.users.isEmpty
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
                              'لا يوجد مستخدمين بعد',
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
                          height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.only(
                            left: 3.w,
                            right: 3.w,
                          ),
                          child: ListView.builder(
                            itemCount: controller.users.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  height: 15.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              myServices.sharedPreferences.setString("users_id",  '${controller.users[index]['users_id']}');
                                              controller.blockusers();
                                              controller.updatenameblock();
                                            },
                                            icon: Icon(controller.users[index]['users_blocked']==0 ?Icons.block : Icons.verified_user),
                                            color: controller.users[index]['users_blocked']==0 ?Colors.red:Colors.green,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                               myServices.sharedPreferences.setString("users_id",  '${controller.users[index]['users_id']}');
                                              Get.to(SendNotificationScreen(username:controller.users[index]
                                              ['users_name']));
                                            },
                                            icon: Icon(EneftyIcons.send_2_bold),
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
                                            controller.users[index]
                                                ['users_name'],
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
                                            '${controller.users[index]['users_phone']}',
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
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniStartFloat,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.to(AddCategoriesScreen());
        //   },
        //   backgroundColor: AppColor.secondaryColor,
        //   child: const Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }
}
