import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/ItemsController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import '../../../controller/Home/CategoriesController.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import '../../widget/Auth/AuthButton.dart';

class AddItemsScreen extends StatelessWidget {
  const AddItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemsControllerImp());
    MyServices myServices = Get.find();
     // Initialize the index counter
      int index=0;

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
            'إضافة صنف',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<ItemsControllerImp>(
          builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget:RefreshIndicator(
              onRefresh: ()async{
                await Future.delayed(Duration(seconds: 2));
                controller.onInit();
              },
              color: Colors.white,
              backgroundColor: AppColor.secondaryColor,
              child: SingleChildScrollView(
                child:
                // controller.statusRequest == StatusRequest.loading
                //     ? Center(
                //     child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250))
                //     :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Text(
                        'اسم الصنف',
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                        child: TextFormField(
                          controller: controller.name,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 3.w),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.red),
                            ),
                            hintText: 'اسم الصنف',
                            hintStyle: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 1.h),
                      child: Text(
                        'وصف عن الصنف',
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                        child: TextFormField(
                          controller: controller.description,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 3.w),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.red),
                            ),
                            hintText: 'الوصف ',
                            hintStyle: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 1.h),
                      child: Text(
                        ' سعر الصنف',
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                        child: TextFormField(
                          controller: controller.price,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 3.w),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.red),
                            ),
                            hintText: 'السعر ',
                            hintStyle: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 1.h),
                      child: Text(
                        'قيمة الخصم (اختياري)',
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                        child: TextFormField(
                          controller: controller.discount,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 3.w),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.red),
                            ),
                            hintText: 'الخصم ',
                            hintStyle: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 1.h),
                      child: Text(
                        'اسم المطعم',
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                        child: TextFormField(
                          readOnly: true ,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 3.w),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.red),
                            ),
                            hintText: controller.namerestaurant.text,
                            hintStyle: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {

                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(0, 58.h, 0, 0),
                                  items: controller.restaurants
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    Map<String, dynamic> restaurant = entry.value;

                                    return PopupMenuItem(
                                      onTap: (){
                                        controller.updatenamerestaurant(restaurant['restaurants_name']);
                                        myServices.sharedPreferences.setString("restaurants_id",  '${controller.restaurants[index]['restaurants_id']}');
                                        controller.updateindex(index);
                                        //controller.restaurantsSubcat=[];
                                        controller.viewrestaurants();
                                      },
                                      value: restaurant['restaurants_name'],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            restaurant['restaurants_name'],
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                          Container(
                                            height: 3.h,
                                            width: 3.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.sp),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    '${AppLink.restaurants_image}/${restaurant['restaurants_logo']}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );

                                // Show dropdown when the arrow icon is pressed
                                // showRestaurantDropdown(controller.restaurants.cast<Map<String, dynamic>>(), context);
                              },
                              child: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColor.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 1.h),
                      child: Text(
                        'اسم القسم',
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                        child: TextFormField(
                          readOnly: true ,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 3.w),
                            border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.red),
                            ),
                            hintText: controller.selectedRestaurantIndex==null ? 'إسم المطعم مطلوب!' :controller.subcatrestaurant.text,
                            hintStyle: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {

                                controller.selectedRestaurantIndex==null?
                                Get.snackbar("أختر مطعم ", "يرجى إختيار اسم المطعم لمشاهدة الأقسام المتاحة")
                                    :
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(0, 50.h, 0, 0),
                                  items: List.generate(controller.restaurantsSubcat.length, (index) {
                                    return PopupMenuItem(
                                      onTap: () {
                                        controller.updateindexProduct(index , controller.restaurantsSubcat[index]);

                                      },
                                      child: Text(
                                        controller.restaurantsSubcat[index],
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    );
                                  }),
                                );

                                // Show dropdown when the arrow icon is pressed
                                // showRestaurantDropdown(controller.restaurants.cast<Map<String, dynamic>>(), context);
                              },
                              child: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColor.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                      height: 15.h,
                      width: 100.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'صورة النوع',
                            style: TextStyle(
                              color: Colors.black,
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 7.h,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.Imagefile == null
                                        ? 'أضف صورة النوع '
                                        : 'تمت اضافة الصورة ',
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () async {
                                      controller.pickImage(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Center(
                      child: AuthButton(
                        buttonText: 'إضافة الصنف',
                        onPressed: () {
                          controller.Imagefile  == null
                              ? Get.snackbar("أدخل صورة", "صورة المنتج مطلوبة") :  controller.additems();
                        },
                      ),

                    ),
                    SizedBox(height: 10.h,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

