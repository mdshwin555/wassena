import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/ItemsController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import 'package:yumyum/view/widget/Auth/AuthButton.dart';
import '../../../controller/Home/CategoriesController.dart';
import '../../../controller/Home/EdititemsController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';

class EditItemsScreen extends StatefulWidget {
  final String items_name;
  final String items_desc;
  final String items_price;
  final String items_discount;
  final String items_subcat;
  final String restaurants_name;
  final String items_image;
  final String restaurants_subcat;
  const EditItemsScreen({
    Key? key,
    required this.items_name,
    required this.items_desc,
    required this.items_price,
    required this.items_discount,
    required this.items_subcat,
    required this.restaurants_name,
    required this.items_image,
    required this.restaurants_subcat,
  }) : super(key: key);

  @override
  State<EditItemsScreen> createState() => _EditItemsScreenState();
}

class _EditItemsScreenState extends State<EditItemsScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(EditItemsControllerImp(
      items_name: widget.items_name,
      items_desc: widget.items_desc,
      items_price: widget.items_price,
      items_discount: widget.items_discount,
      items_subcat: widget.items_subcat,
      restaurants_name: widget.restaurants_name,
      items_image: widget.items_image,
      restaurants_subcat: widget.restaurants_subcat,
    ));
    MyServices myServices = Get.find();
    List<String> subcategories = [];

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
            'تعديل ${myServices.sharedPreferences.getString("items_name_ar")}',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<EditItemsControllerImp>(
          builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: RefreshIndicator(
    onRefresh: ()async{
    await Future.delayed(Duration(seconds: 2));
    controller.onInit();
    },
    color: Colors.white,
    backgroundColor: AppColor.secondaryColor,
    child:SingleChildScrollView(
                child: Column(
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
                          style: TextStyle(
                          height: 0.2.h,
                          fontSize: 11.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                        ),

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
                          style: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                          ),
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
                          // controller: controller.subcat,
                          readOnly: true,
                          style: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 3.w),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.grey),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColor.red),
                            ),

                            hintText: controller.restaurantsSubcat[controller.selectedRestaurantIndex!],
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
                                  position: RelativeRect.fromLTRB(0, 40.h, 0, 0),
                                  items: List.generate(
                                      controller.restaurantsSubcat.length, (index) {
                                    return PopupMenuItem(
                                      onTap: () {
                                        controller.updateindex(index);
                                          controller.updateindexProduct(
                                              index, controller.restaurantsSubcat[index]);
                                          controller.subcat.text =
                                          controller.restaurantsSubcat[index];
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
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                          ),

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
                            suffix: Text(' ل.س',   style: TextStyle(
                              height: 0.2.h,
                              fontSize: 11.sp,
                              fontFamily: 'Cairo',
                              letterSpacing: 1,
                            ),),
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
                          style: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                          ),
                          keyboardType: TextInputType.phone,
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
                          readOnly: true,
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
                            hintText: controller.restaurants_name,
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
                                   ' الصورة المضافة مسبقاً',
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon:  Icon( Icons.edit),
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
                    Padding(
                      padding: EdgeInsets.only(right: 6.0.w, bottom: 2.h),
                      child: AuthButton(
                        buttonText: 'تعديل',
                        onPressed: (){
                          controller.edititems();
                        },
                      ),
                    ),
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
