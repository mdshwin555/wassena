import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/OffersScreen.dart';
import '../../../controller/Home/CaptainControllerImp.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../controller/Home/OrdersController.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/services/services.dart';
import '../Auth/signIn.dart';
import 'CategoriesScreen.dart';
import 'CategoryofItemsScreen.dart';
import 'OnlineCaptains.dart';
import 'OrdersDetailsScreen.dart';
import 'package:badges/badges.dart' as badges;
import 'OrdersScreen.dart';
import 'RestaurantsScreen.dart';
import 'TotalCaptains.dart';
import 'UsersScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    MyServices myServices = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Control panel',
          style: TextStyle(
            color: AppColor.primaryColor,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext innerContext) {
              // Using Builder to get a new context associated with the Scaffold
              return IconButton(
                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: 95.w,
                        child: AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.sp)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.0),
                              Text(
                                'هل أنت متأكد أنك تريد تسجيل الخروج ؟',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 6.h,
                                      width: 20.w,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.snackbar("تمت تسجيل الخروج", "لقد قمت بتسجيل الخروج من حساب أدمن");
                                          myServices.sharedPreferences.remove('token');
                                          Get.offAll(() => SignInScreen());
                                        },
                                        style: ElevatedButton
                                            .styleFrom(
                                          backgroundColor:
                                          AppColor.primaryColor,
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .circular(10.0),
                                          ),
                                        ),
                                        child: Text(
                                          'نعم',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 6.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(10),
                                            border: Border.all(
                                              color:
                                              AppColor.primaryColor,
                                              width: 0.3.h,
                                            )),
                                        child: Text(
                                          'لا',
                                          style: TextStyle(
                                            color:
                                            AppColor.primaryColor,
                                            height: 0.2.h,
                                            fontSize: 15.sp,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: GetBuilder<HomeControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget:RefreshIndicator(
            onRefresh: ()async{
              await Future.delayed(Duration(seconds: 1));
              controller.onInit();
            },
            color: Colors.white,
            backgroundColor: AppColor.secondaryColor,
            child: SingleChildScrollView(
              child:Container(
                width: 100.w,
                height: 100.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(4.w, 0.h, 4.w, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                Get.to(OnlineCaptains());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(4.w, 2.3.h, 4.w, 0),
                                height: 14.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    gradient: const LinearGradient(
                                        colors: [
                                          AppColor.secondaryColor,
                                          AppColor.secondaryColor2,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     Text(
                                      '(${controller.online_captains.length})',
                                      // textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,                                ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                     Text(
                                      'Online Captains',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){

                                Get.to(TotalCaptains());
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(4.w, 2.3.h, 4.w, 0),
                                height: 14.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Colors.blueGrey,
                                          AppColor.primaryColor,

                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     Text(
                                       '(${controller.captains.length})',
                                      //textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                     Text(
                                      'Total Captains',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.white,
                                        fontFamily: 'Cairo',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('W',style:TextStyle(
                          color: AppColor.secondaryColor,
                          fontFamily: 'Cairo',
                          fontSize: 33.sp,
                          fontWeight: FontWeight.bold,
                        ) ,),
                        Text('asena',style:TextStyle(
                          color: AppColor.primaryColor,
                          fontFamily: 'Cairo',
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ) ,),
                        SizedBox(width: 3.w,),
                        Text('Dashboard',style:TextStyle(
                          color: AppColor.primaryColor,
                          fontFamily: 'Cairo',
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ) ,),

                      ],
                    ),
                  ),

                    Container(
                      height: 50.h,
                      width: 100.w,
                      padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Get.to(CategoriesScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0.w, 2.3.h, 0.w, 0),
                                  height: 14.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    image: DecorationImage(
                                      image: AssetImage(AppImageAsset.catigories),
                                      // Replace with the actual path to your image
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'الأنواع',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(CategoryofItemsScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0.w, 2.3.h, 0.w, 0),
                                  height: 14.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    image: DecorationImage(
                                      image: AssetImage(AppImageAsset.items),
                                      // Replace with the actual path to your image
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'المنتجات',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(RestaurantsScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0.w, 2.3.h, 0.w, 0),
                                  height: 14.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    image: DecorationImage(
                                      image: AssetImage(AppImageAsset.restaurants),
                                      // Replace with the actual path to your image
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'المطاعم',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Get.to(OrdersScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0.w, 2.3.h, 0.w, 0),
                                  height: 14.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    image: DecorationImage(
                                      image: AssetImage(AppImageAsset.orders),
                                      // Replace with the actual path to your image
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'الأوردرات',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(OffersScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0.w, 2.3.h, 0.w, 0),
                                  height: 14.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    image: DecorationImage(
                                      image: AssetImage(AppImageAsset.reports),
                                      // Replace with the actual path to your image
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'الإعلانات',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(UsersScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0.w, 2.3.h, 0.w, 0),
                                  height: 14.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    image: DecorationImage(
                                      image: AssetImage(AppImageAsset.notification),
                                      // Replace with the actual path to your image
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'الإشعارات',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        // Container inside the drawer
        child: Transform.scale(
          scale: 8,
          origin: Offset(-44.w, 0),
          child: CircleAvatar(
            radius: 500.sp,
          ),
        ),
      ),
    );
  }
}
