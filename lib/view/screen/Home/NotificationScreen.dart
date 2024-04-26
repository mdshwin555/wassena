import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/Home/HomeController.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imgaeasset.dart';
import '../MainScreen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

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
          title: const Text(
            'الإشعارات',
            style: TextStyle(
              color: AppColor.black,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: GetBuilder<HomeControllerImp>(
          builder: (controller) => controller.notifications.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Lottie.asset(
                        AppImageAsset.nonotifications,
                        height: 30.h,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'لا يوجد لديك إشعارات جديدة ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'ElMessiri',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: double.infinity,
                  child: ListView.builder(
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 0.8.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              border: Border.all(
                                  color: AppColor.greyLight, width: 0.5.w)),
                          child: ListTile(
                            title: Text(
                              '${controller.notifications[index]['notification_title']}',
                              style: TextStyle(
                                color: AppColor.black,
                                fontFamily: 'ElMessiri',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                            subtitle: Text(
                              '${controller.notifications[index]['notification_body']}',
                              style: TextStyle(
                                color: AppColor.grey,
                                fontFamily: 'ElMessiri',
                                fontSize: 9.sp,
                              ),
                            ),
                            leading: controller.notifications[index]
                                        ['notification_title'] ==
                                    'تم توصيل الطلب بنجاح'
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 35.sp,
                                  )
                                : controller.notifications[index]
                                            ['notification_title'] ==
                                        'بدء التوصيل'
                                    ? CircleAvatar(
                                        backgroundColor: Color(0xffFF7A2F),
                                        radius: 15.sp,
                                        child: Icon(
                                          Icons.directions_bike_rounded,
                                          color: Colors.white,
                                        ),
                                      )
                                    : controller.notifications[index]
                                                ['notification_title'] ==
                                            'بدء التحضير'
                                        ? CircleAvatar(
                                            backgroundColor:
                                                Colors.purple.withOpacity(0.75),
                                            radius: 15.sp,
                                            child: Icon(
                                              Icons.hourglass_bottom,
                                              color: Colors.white,
                                            ),
                                          )
                                        : controller.notifications[index]
                                                    ['notification_title'] ==
                                                'تم رفض الطلب'
                                            ? CircleAvatar(
                                                backgroundColor: Colors.red
                                                    .withOpacity(0.75),
                                                radius: 15.sp,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Image.asset(
                                                AppImageAsset.notification,
                                                height: 5.h,
                                              ),
                            trailing: Text(
                              ' ${Jiffy.parse('${controller.notifications[index]['notification_date']}').fromNow()}',
                              style: const TextStyle(
                                color: Color(0xffFF7A2F),
                                fontFamily: 'ElMessiri',
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ),
      ),
    );
  }
}
