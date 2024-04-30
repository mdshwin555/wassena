import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/controller/Home/HomeController.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/linkapi.dart';

class ListCatigoriesHome extends GetView<HomeControllerImp> {
  const ListCatigoriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0.w, 2.h, 5.w, 0),
      child: SizedBox(
        height: 15.h,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {

                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundColor:
                      AppColor.secondaryColor.withOpacity(0.60),
                      child: Image.network(
                        '${AppLink.categories_image}/${controller.categories[index]['categories_image']}',
                        height: 6.h,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      controller.categories[index]
                      ['categories_name_ar'],
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black,
                        fontFamily: 'ElMessiri',
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 3.w,
              );
            },
          ),
        ),
      ),
    );
  }
}
