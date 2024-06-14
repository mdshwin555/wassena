import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/ItemsController.dart';
import 'package:yumyum/controller/Home/RestaurantsController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import '../../../controller/Home/CategoriesController.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';
import '../../../core/services/services.dart';
import '../../widget/Auth/AuthButton.dart';
import 'AddAddressScreen.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class AddRestaurantsScreen extends StatefulWidget {
  const AddRestaurantsScreen({super.key});

  @override
  State<AddRestaurantsScreen> createState() => _AddRestaurantsScreenState();
}

class _AddRestaurantsScreenState extends State<AddRestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(RestaurantsControllerImp());
    MyServices myServices = Get.find();
    List<String> subcategories = [];


    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () {
                Get.back();
              }),
        ],
        leading: SizedBox(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'إضافة مطعم',
          style: TextStyle(
              color: AppColor.black,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              fontSize: 15.sp),
        ),
      ),
      body: GetBuilder<RestaurantsControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: RefreshIndicator(
    onRefresh: ()async{
    await Future.delayed(Duration(seconds: 1));
    controller.onInit();
    },
    color: Colors.white,
    backgroundColor: AppColor.secondaryColor,
    child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w),
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
                        textAlign: TextAlign.right,
                        controller: controller.name,
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
                          hintText: 'اسم المطعم',
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
                      'نوع الأكل',
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
                        controller: controller.type,
                        textAlign: TextAlign.right,
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
                          hintText: 'الأنواع ',
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 6.w),
                        child: Text('المنطقة',style: TextStyle(
                          color: Colors.black,
                          height: 0.2.h,
                          fontSize: 13.sp,
                          fontFamily: 'Cairo',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                      SizedBox(
                        height: 8.h,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 0),
                          child: TextFormField(
                            textAlign: TextAlign.right,
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
                              hintText: controller.city.text,

                              hintStyle: TextStyle(
                                height: 0.2.h,
                                fontSize: 11.sp,
                                fontFamily: 'Cairo',
                                letterSpacing: 1,

                              ),

                              prefixIcon: GestureDetector(
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    position:
                                    RelativeRect.fromLTRB(0, 42.h, 10.w, 0),
                                    items: [
                                      "دمشق",
                                      "الزبداني",
                                    ].map((String city) {
                                      return PopupMenuItem(
                                        value: city,
                                        onTap: (){
                                          controller.updatecity(city);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              city,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
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
                    ],
                  ),
                  CheckboxListTile(
                    activeColor: AppColor.secondaryColor,
                    title:  Text(
                      'يفتح 24 ساعة',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        height: 0.2.h,
                        fontSize: 11.sp,
                        fontFamily: 'Cairo',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: controller.is24Hours,
                    onChanged: (newValue) {
                      controller.is24Hours = newValue!;
                      controller.update();
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                  controller.is24Hours?SizedBox():Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Padding(
                       padding: EdgeInsets.only(right: 5.w, top: 1.h),
                       child: Text(
                         'وقت الفتح',
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
                           controller: controller.open,
                           textAlign: TextAlign.right,
                           readOnly: true,
                           onTap: () {
                             Navigator.of(context).push(showPicker(
                                 is24HrFormat: false,
                                 iosStylePicker: true,
                                 hourLabel: '',
                                 minuteLabel: '',
                                 context: context,
                                 value: Time.fromTimeOfDay(TimeOfDay.now(), 1),
                                 sunrise: TimeOfDay(hour: 6, minute: 0),
                                 // optional
                                 sunset: TimeOfDay(hour: 18, minute: 0),
                                 // optional
                                 duskSpanInMinutes: 120,
                                 // optional
                                 onChange: (val) {
                                   DateTime currentTime = DateTime.now();
                                   DateTime selectedTime = DateTime(
                                       currentTime.year,
                                       currentTime.month,
                                       currentTime.day,
                                       val.hour,
                                       val.minute);
                                   String formattedTime =
                                   DateFormat.Hm('en_US').format(selectedTime);
                                   controller.open.text = formattedTime;
                                 }));
                           },
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
                             hintText: 'وقت الفتح ',
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
                         'وقت الإغلاق',
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
                           controller: controller.close,
                           textAlign: TextAlign.right,
                           readOnly: true,
                           onTap: () {
                             Navigator.of(context).push(showPicker(
                                 is24HrFormat: false,
                                 iosStylePicker: true,
                                 hourLabel: '',
                                 minuteLabel: '',
                                 context: context,
                                 value: Time.fromTimeOfDay(TimeOfDay.now(), 1),
                                 sunrise: const TimeOfDay(hour: 6, minute: 0),
                                 sunset: const TimeOfDay(hour: 18, minute: 0),
                                 duskSpanInMinutes: 120,
                                 // optional
                                 onChange: (val) {
                                   DateTime currentTime = DateTime.now();
                                   DateTime selectedTime = DateTime(
                                       currentTime.year,
                                       currentTime.month,
                                       currentTime.day,
                                       val.hour,
                                       val.minute);
                                   String formattedTime =
                                   DateFormat.Hm('en_US').format(selectedTime);
                                   controller.close.text = formattedTime;
                                 }));
                           },
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
                             hintText: 'وقت الإغلاق ',
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
                   ],
                 ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, top: 1.h),
                    child: Text(
                      ' سعر التوصيل',
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
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          prefix: Text('ل.س',style: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                          ),),
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
                      ' تقييم المطعم',
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
                        controller: controller.rate,
                        textAlign: TextAlign.right,
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
                          hintText: 'التقييم ',
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
                      'التصنيف ',
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
                        textAlign: TextAlign.right,
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
                          hintText: controller.typeRes.text,
                          hintStyle: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1,
                          ),
                          prefixIcon: GestureDetector(
                            onTap: () {
                              showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(0, 68.h, 0, 0),
                                items: controller.categories
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  Map<String, dynamic> categories = entry.value;

                                  return PopupMenuItem(
                                    onTap: () {

                                      myServices.sharedPreferences.setString(
                                          "categories_id",
                                          '${controller.categories[index]['categories_id']}');

                                      controller.updatetypeRes(controller.categories[index]['categories_name']);
                                    },
                                    value: categories['categories_name'],
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          categories['categories_name'],
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
                                                  '${AppLink.categories_image}/${categories['categories_image']}'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
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
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, top: 1.h),
                    child: Text(
                      'الأقسام المتوفرة ',
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
                        controller: controller.subcat,
                        textAlign: TextAlign.right,
                         style: TextStyle(
                           color: Colors.black54,
                           height: 0.2.h,
                           fontSize: 10.sp,
                           fontFamily: 'Cairo',
                         ),
                        onChanged: (String value) {
                          setState(() {
                            controller.subcat.text = value.replaceAll(' ', '-');
                            controller.subcat.selection = TextSelection.fromPosition(
                                TextPosition(offset: controller.subcat.text.length));

                                String text = controller.subcat.text.trim();
                                if (text.isNotEmpty) {
                                  List<String> newSubcategories = text.split(',');
                                  subcategories.addAll(newSubcategories);
                                }
                              });

                          controller.updatedCategory = subcategories[0].replaceAll('-', ',');
                          controller.updatedCategories(controller.updatedCategory.toString());
                        },
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
                          prefixIcon: IconButton(
                            icon: Icon(Icons.clear_all),
                            onPressed: () {
                              controller.subcat.clear();
                            },
                          ),
                          hintText: 'الاقسام المتوفرة في المطعم',
                          hintStyle: TextStyle(
                            height: 0.2.h,
                            fontSize: 11.sp,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: subcategories.map((subcat) => Text(subcat)).toList(),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                    height: 15.h,
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'صورة المطعم',
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
                                IconButton(
                                  icon: Icon(controller.background == null
                                      ?Icons.add:Icons.edit),
                                  onPressed: () async {
                                    controller
                                        .pickBackGroundImage(ImageSource.gallery);
                                  },
                                ),
                                Text(
                                  controller.background == null
                                      ? 'أضف صورة المطعم '
                                      : 'تمت اضافة الصورة ',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.grey,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                    height: 15.h,
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'لوغو المطعم',
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
                                IconButton(
                                  icon: Icon(controller.logo == null
                            ?Icons.add:Icons.edit),
                                  onPressed: () async {
                                    controller.pickLogo(ImageSource.gallery);
                                  },
                                ),
                                Text(
                                  controller.logo == null
                                      ? 'أضف لوغو المطعم '
                                      : 'تمت اضافة اللوغو ',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.grey,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                    height: 15.h,
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'موقع المطعم',
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
                                IconButton(
                                  icon:  Icon(controller.position == null
                                      ?Icons.add:Icons.edit),
                                  onPressed: () {
                                    controller.getCurrentLocation();
                                    Get.to(AddAddressScreen());
                                  },
                                ),
                                Text(
                                  controller.position != null
                                      ? 'تمت إضافة الموقع على الخريطة '
                                      :'أضف موقع المطعم',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.grey,
                                    fontSize: 11.sp,
                                  ),
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
                      buttonText: 'إضافة المطعم',
                      onPressed: () {
                        controller.background == null || controller.logo == null
                             ? Get.snackbar("أدخل صورة", "صورة ولوغو المطعم مطلوبة") :  controller.addrestaurants();
                      },
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
