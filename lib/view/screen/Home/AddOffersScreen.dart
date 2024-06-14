import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/OffersController.dart';
import 'package:yumyum/core/class/handlingdataview.dart';
import '../../../controller/Home/CategoriesController.dart';
import '../../../core/constant/color.dart';
import '../../../core/services/services.dart';
import '../../widget/Auth/AuthButton.dart';

class AddOffersScreen extends StatelessWidget {
  const AddOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OffersControllerImp());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'إضافة إعلان',
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
        body: GetBuilder<OffersControllerImp>(
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
                      height: 3.h,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                      height: 15.h,
                      width: 100.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'صورة الإعلان',
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
                                    icon:  Icon(controller.Imagefile != null
                                        ? Icons.edit:Icons.add),
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
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  suffixIcon: GestureDetector(
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: AuthButton(
                        buttonText: 'إضافة',
                        onPressed: () {
                          controller.Imagefile != null ?  controller.addoffers() :   Get.snackbar("أدخل صورة", "صورة الإعلان مطلوبة");
                        },
                      ),
                    )
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
