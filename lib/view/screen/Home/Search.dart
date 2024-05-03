import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/RestaurantsControllerByID.dart';
import 'package:yumyum/view/screen/Home/RestaurantsItemsByID.dart';

import '../../../controller/Home/SearchController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/functions/validinput.dart';
import '../../../core/services/services.dart';
import '../../widget/Auth/CustomTextField.dart';
import 'RestaurantsItemsScreen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SearchControllerImp());
    MyServices myServices = Get.find();


    return  GetBuilder<SearchControllerImp>(
      builder: (controller) =>   Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: Text(
            'البحث',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 16.sp,
              color: Colors.white ,
            ),
          ),
          leading: SizedBox(),
          actions: [IconButton(onPressed: (){Get.back();}, icon: Padding(
            padding:  EdgeInsets.only(right: 4.0.w),
            child: Icon(Icons.arrow_forward_ios_rounded),
          ),color: Colors.white,)],
          centerTitle: true,
        ),
        
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  width: 100.w,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 0),
                    child: SizedBox(
                      child: TextFormField(
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 11.sp,
                          color: Colors.black ,
                        ),
                        onChanged: (value){
                          controller.getsearch(value);
                        },
                        onFieldSubmitted: (value){
                          controller.getsearch(value!);
                        },
                        controller: controller.search,
                        cursorColor: AppColor.secondaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.5.w),
                          isDense: true,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color:AppColor.secondaryColor,),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: AppColor.red),
                          ),
                          hintText: 'ابحث عن مطاعم و منتجات ',
                          errorStyle: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 8.sp
                          ),
                          suffixIcon: IconButton(onPressed: () {  controller.getsearch(controller.search.text); }, icon: Icon(   EneftyIcons.search_normal_outline),
                           ),
                          hintStyle: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'ElMessiri',
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 4.h,
                color: Colors.white,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TabBar(
                  indicatorColor: AppColor.secondaryColor,
                  onTap: (val){
                    controller.updateType(val);
                    print(controller.type);
                  },
                  labelStyle: TextStyle(
                    color: AppColor.secondaryColor,
                    height: 0.2.h,
                    fontSize: 15.sp,
                    fontFamily: 'ElMessiri',
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      text: controller.type==0? ' المطاعم (${controller.searchliststore.length})':' المطاعم ',

                    ),
                    Tab(
                      text: controller.type==1? ' المنتجات (${controller.searchlistitem.length})':' المنتجات ',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Expanded(
                child: TabBarView(
                 physics:NeverScrollableScrollPhysics() ,
                  children: [
                    // First Tab View for Stores
                   Container(
                     height: 80.h,
                     child:
                        controller.searchliststore.isEmpty
                       
                        ?
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 14.h,),
                              Transform.scale(
                                scale: 0.6.h,
                                child: Lottie.asset(
                                  AppImageAsset.nostore,
                                  height: 25.h,
                                ),
                              ),
                             FittedBox(
                               child:  Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(' !ضمن المطاعم ',style: TextStyle(
                                     fontSize: 10.sp,
                                     color: Colors.black,
                                     fontFamily: 'ElMessiri',
                                   ),),
                                   Text(' ${controller.search.text} ',style: TextStyle(
                                     fontSize: 10.sp,
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold,
                                     fontFamily: 'ElMessiri',
                                   ),),
                                   Text(' عذراَ ,لا يوجد',style: TextStyle(
                                     fontSize: 10.sp,
                                     color: Colors.black,
                                     fontFamily: 'ElMessiri',
                                   ),),
                                 ],
                               ),
                             )
                            ],
                          ),
                        )
                        :
                        controller.type==1? Center(
                       child: Text('..يرجى الإنتظار قليلاً'),
                     ):ListView.separated(
                         itemCount: controller.searchliststore.length,
                         itemBuilder: (BuildContext context, int index){

                       return Directionality(
                         textDirection: TextDirection.ltr,
                         child: GestureDetector(
                           onTap: () {
                             myServices.sharedPreferences
                                 .setString(
                                 "restaurants_name",
                                 controller.searchliststore[
                                 index]
                                 ['restaurants_name']);
                             myServices.sharedPreferences
                                 .setInt(
                                 "restaurants_id",
                                 controller.searchliststore[
                                 index]
                                 ['restaurants_id']);
                             myServices.sharedPreferences
                                 .setInt("restaurants_index",
                                 index);
                             myServices.sharedPreferences
                                 .getString(
                                 "users_phone") ==
                                 null
                                 ? controller
                                 .viewitemsrestaurantsnoauth()
                                 : controller
                                 .viewitemsrestaurants();

                             Get.to(RestaurantsItemsID());
                           },
                           child: Container(
                             margin: EdgeInsets.all(1.w),
                             padding: EdgeInsets.symmetric(horizontal:  2.0.w,),
                             decoration: BoxDecoration(
                              color: Colors.white,
                               borderRadius:
                               BorderRadius.circular(
                                   10.sp),
                             ),
                             child: Column(
                               crossAxisAlignment:
                               CrossAxisAlignment.end,
                               children: [
                                 Stack(
                                   children: [
                                     Hero(
                                       tag: controller
                                           .searchliststore[
                                       index]
                                       ['restaurants_id'],
                                       child: ClipRRect(
                                         borderRadius:
                                         BorderRadius.vertical(
                                             top: Radius
                                                 .circular(
                                                 10.sp)),
                                         child: Container(
                                           height: 14.h,
                                           width:
                                           double.infinity,
                                           child:
                                           ProgressiveImage(
                                             width: double.infinity,
                                             image:
                                             '${AppLink.restaurants_image}/${controller.searchliststore[index]['restaurants_background_image']}',
                                             height: 200.0,
                                             imageError:
                                             AppImageAsset
                                                 .shimmarimageeror,
                                           ),
                                         ),
                                       ),
                                     ),
                                     Transform.translate(
                                       offset:
                                       Offset(2.w, 11.5.h),
                                       child: Stack(
                                         children: [
                                           ClipRRect(
                                             borderRadius:
                                             BorderRadius
                                                 .circular(
                                                 100.sp),
                                             child: Container(
                                               height: 5.5.h,
                                               width: 5.5.h,
                                               decoration:
                                               BoxDecoration(
                                                 borderRadius:
                                                 BorderRadius
                                                     .circular(
                                                   100.sp,
                                                 ),
                                               ),
                                               child:
                                               ProgressiveImage(
                                                 height: 5.5.h,
                                                 width: 5.5.h,
                                                 image:
                                                 '${AppLink.restaurants_image}/${controller.searchliststore[index]['restaurants_logo']}',
                                                 imageError:
                                                 AppImageAsset
                                                     .shimmarimageeror,
                                               ),
                                             ),
                                           ),
                                           controller.searchliststore[
                                           index]
                                           [
                                           'restaurants_is24'] ==
                                               1
                                               ? Positioned(
                                             bottom: 0.h,
                                             right: 0.w,
                                             child:
                                             CircleAvatar(
                                               radius:
                                               5.sp,
                                               backgroundColor:
                                               Color(
                                                   0xff26da12),
                                             ),
                                           )
                                               : controller.isRestaurantOpen(
                                               controller.searchliststore[index]) ==
                                               true
                                               ? Positioned(
                                             bottom:
                                             0.h,
                                             right:
                                             0.w,
                                             child:
                                             CircleAvatar(
                                               radius:
                                               5.sp,
                                               backgroundColor:
                                               Color(0xff26da12),
                                             ),
                                           )
                                               : Positioned(
                                             bottom:
                                             0.h,
                                             right:
                                             0.w,
                                             child:
                                             CircleAvatar(
                                               radius:
                                               5.sp,
                                               backgroundColor:
                                               Colors.grey,
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: 8.0),
                                 Padding(
                                   padding: EdgeInsets.only(
                                       right: 2.w, left: 1.w,bottom: 7),
                                   child: FittedBox(
                                     child: Text(
                                       controller.searchliststore[
                                       index][
                                       'restaurants_name'],
                                       style: TextStyle(
                                         fontSize: 12.sp,
                                         color: AppColor.secondaryColor,
                                         fontWeight:
                                         FontWeight.bold,
                                         fontFamily:
                                         'ElMessiri',
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(height: 0.5.h),
                                 Padding(
                                   padding: EdgeInsets.only(
                                       right: 2.w,bottom: 2.h),
                                   child: Column(
                                     mainAxisAlignment:
                                     MainAxisAlignment.end,
                                     // crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Text(
                                         controller.searchliststore[
                                         index][
                                         'restaurants_type'],
                                         style: TextStyle(
                                           fontSize: 9.sp,
                                           color:
                                           Colors.black54,
                                           fontFamily:
                                           'ElMessiri',
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding: EdgeInsets.only(
                                       right: 2.w,bottom: 2.h),
                                   child: Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.end,
                                     // crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Text(
                                         '${controller.addCommasToNumber(controller.searchliststore[
                                         index][
                                         'restaurants_deliveryprice'])} SYP',
                                         style: TextStyle(
                                           fontSize: 11.sp,
                                           color:
                                           AppColor.black,
                                           fontFamily:
                                           'ElMessiri',
                                         ),
                                       ),
                                       Text(
                                         '   :سعر التوصيل  ',
                                         style: TextStyle(
                                           fontSize: 11.sp,
                                           color:
                                           AppColor.black,
                                           fontFamily:
                                           'ElMessiri',
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

                     }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 0.7.h,); },),
                   ),
                    // Second Tab View for Items
                    Container(
                      height: 80.h,
                      child:  controller.searchlistitem.isEmpty

                          ?
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 14.h,),
                            Stack(
                              children: [
                            Transform.scale(
                              scale: 0.6.h,
                              child: Lottie.asset(
                                    AppImageAsset.nostore,
                                    height: 25.h,
                                  ),
                                ),
                            Positioned(
                                    bottom: 8.h,
                                    right: 18.w,
                                    child:  CircleAvatar(
                                        radius: 30.sp,
                                        backgroundColor: AppColor.secondaryColor,
                                        child: Icon(Icons.restaurant,color: Colors.white,size: 40.sp,))),
                              ],
                            ),
                            FittedBox(
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(' !ضمن المنتجات ',style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontFamily: 'ElMessiri',
                                  ),),
                                  Text(' ${controller.search.text} ',style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ElMessiri',
                                  ),),
                                  Text(' عذراَ ,لا يوجد',style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontFamily: 'ElMessiri',
                                  ),),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                          :
                      controller.type==0? Center(
                        child: Text('..يرجى الإنتظار قليلاً'),
                      ):ListView.separated(
                        itemCount: controller.searchlistitem.length,
                        itemBuilder: (BuildContext context, int index){

                          return Directionality(
                            textDirection: TextDirection.ltr,
                            child: GestureDetector(
                              onTap: () {
                                myServices.sharedPreferences
                                    .setString(
                                    "restaurants_name",
                                    controller.items[
                                    index]
                                    ['restaurants_name']);
                                myServices.sharedPreferences
                                    .setInt(
                                    "restaurants_id",
                                    controller.items[
                                    index]
                                    ['restaurants_id']);
                                myServices.sharedPreferences
                                    .setInt("restaurants_index",
                                    index);
                                myServices.sharedPreferences
                                    .getString(
                                    "users_phone") ==
                                    null
                                    ? controller
                                    .viewitemsrestaurantsnoauth()
                                    : controller
                                    .viewitemsrestaurants();

                                controller.calculateDistance(
                                    controller.lat == null
                                        ? 33.555555
                                        : controller.lat!,
                                    controller.long == null
                                        ? 33.55555
                                        : controller.long!,
                                    controller.items[index]
                                    ['restaurants_lat'],
                                    controller.items[index]
                                    ['restaurants_long']);

                                Get.to(RestaurantsItemsScreen());
                              },
                              child: Container(
                                margin: EdgeInsets.all(1.w),
                                padding: EdgeInsets.symmetric(horizontal:  2.0.w,),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(
                                      10.sp),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        Hero(
                                          tag: controller
                                              .searchlistitem[
                                          index]
                                          ['items_id'],
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.vertical(
                                                top: Radius
                                                    .circular(
                                                    10.sp)),
                                            child: Container(
                                              height: 14.h,
                                              width:
                                              double.infinity,
                                              child:
                                              ProgressiveImage(
                                                width: double.infinity,
                                                image:
                                                '${AppLink.items_image}/${controller.searchlistitem[index]['items_image']}',
                                                height: 200.0,
                                                imageError:
                                                AppImageAsset
                                                    .shimmarimageeror,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset:
                                          Offset(2.w, 11.5.h),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    100.sp),
                                                child: Container(
                                                  height: 5.5.h,
                                                  width: 5.5.h,
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                      100.sp,
                                                    ),
                                                  ),
                                                  child:
                                                  ProgressiveImage(
                                                    height: 5.5.h,
                                                    width: 5.5.h,
                                                    image:
                                                    '${AppLink.restaurants_image}/${controller.searchlistitem[index]['restaurants_logo']}',
                                                    imageError:
                                                    AppImageAsset
                                                        .shimmarimageeror,
                                                  ),
                                                ),
                                              ),
                                              controller.searchlistitem[
                                              index]
                                              [
                                              'restaurants_is24'] ==
                                                  1
                                                  ? Positioned(
                                                bottom: 0.h,
                                                right: 0.w,
                                                child:
                                                CircleAvatar(
                                                  radius:
                                                  5.sp,
                                                  backgroundColor:
                                                  Color(
                                                      0xff26da12),
                                                ),
                                              )
                                                  :
                                              controller.isRestaurantOpen(
                                                  controller.searchlistitem[index]) ==
                                                  true
                                                  ? Positioned(
                                                bottom:
                                                0.h,
                                                right:
                                                0.w,
                                                child:
                                                CircleAvatar(
                                                  radius:
                                                  5.sp,
                                                  backgroundColor:
                                                  Color(0xff26da12),
                                                ),
                                              )
                                                  : Positioned(
                                                bottom:
                                                0.h,
                                                right:
                                                0.w,
                                                child:
                                                CircleAvatar(
                                                  radius:
                                                  5.sp,
                                                  backgroundColor:
                                                  Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 2.w, left: 1.w,bottom: 7),
                                      child: FittedBox(
                                        child: Text(
                                          controller.searchlistitem[
                                          index][
                                          'items_name'],
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColor.secondaryColor,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            'ElMessiri',
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 2.w,bottom: 2.h),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.searchlistitem[
                                            index][
                                            'restaurants_name'],
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color:
                                              Colors.black54,
                                              fontFamily:
                                              'ElMessiri',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 2.w,bottom: 2.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${controller.addCommasToNumber(controller.searchlistitem[
                                            index][
                                            'items_price'])} SYP',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color:
                                              AppColor.black,
                                              fontFamily:
                                              'ElMessiri',
                                            ),
                                          ),
                                          Text(
                                            '   :سعر المنتج  ',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color:
                                              AppColor.black,
                                              fontFamily:
                                              'ElMessiri',
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

                        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 0.7.h,); },),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
