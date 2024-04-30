import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yumyum/view/screen/Home/OrdersScreen.dart';
import '../../controller/Home/HomeController.dart';
import '../../core/constant/color.dart';
import 'Home/FavoriteScreen.dart';
import 'Home/HomeScreen.dart';
import 'Home/ProfileScreen.dart';

import 'Home/RestaurantsScreen.dart';

class MainScreen extends StatelessWidget {
  List bottomnavigationbaritems = [
    'طلباتي',
    'المفضلة',
    'المتاجر',
    'الحساب',
  ];

  List icons_outline = [
    EneftyIcons.a_3d_cube_outline,
    EneftyIcons.heart_outline,
    EneftyIcons.shop_outline,
    EneftyIcons.profile_circle_outline,
  ];

  List icons_bold = [
    EneftyIcons.a_3d_cube_bold,
    EneftyIcons.heart_bold,
    EneftyIcons.shop_bold,
    EneftyIcons.profile_circle_bold,
  ];

  final List<Widget> screens = [
    const OrdersScreen(),
    const FavoriteScreen(),
    const RestaurantScreen(),
    const ProfileScreen(),
  ];

  List titleAppBar = [
    'طلباتي',
    'المفضلة',
    'المتاجر',
    'الحساب',
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp controller = Get.put(HomeControllerImp());
    return Obx(
      () => Scaffold(
        key: controller.form,
        resizeToAvoidBottomInset: false,
        body: controller.home == true
            ? HomeScreen()
            : screens[controller.bottomNavIndex.value],
        floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.sp)),
            onPressed: () {
              controller.bottomNavIndex.value = 5;
              controller.updateisHome(true);
            },
            backgroundColor: AppColor.primaryColor,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                AppColor.secondaryColor,
                BlendMode.srcIn,
              ),
              child: Transform.scale(
                scale: controller.home == true ? 0.9 : 0.7,
                child: Image.asset(
                  'assets/images/icon.png',
                ),
              ),
            )),
        appBar: controller.home == false
            ? AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  titleAppBar[controller.bottomNavIndex.value],
                  style: TextStyle(
                      color: AppColor.black,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                ),
              )
            : AppBar(
                toolbarHeight: 0.1,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: icons_outline.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ?  AppColor.secondaryColor : Colors.grey;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // index == 0
                //     ? controller.notifications.length == 0
                //         ? Icon(
                //             icons[index],
                //             size: 24,
                //             color: color,
                //           )
                //         : badges.Badge(
                //             badgeAnimation: badges.BadgeAnimation.rotation(
                //                 animationDuration: Duration(milliseconds: 0)),
                //             badgeContent: Text(
                //               '${controller.notifications.length}',
                //               style: TextStyle(color: Colors.white),
                //             ),
                //             child: Icon(
                //               icons[index],
                //               size: 24,
                //               color: color,
                //             ),
                //           )
                //     :
                Icon(
                  isActive ? icons_bold[index] : icons_outline[index],
                  size: isActive ? 23.sp : 18.sp,
                  color: color,
                ),
                SizedBox(height: 0.1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    bottomnavigationbaritems[index],
                    maxLines: 1,
                    style: TextStyle(
                        color: color,
                        fontSize: isActive ? 9.sp : 8.sp,
                        fontFamily: 'ElMessiri',
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal),
                  ),
                )
              ],
            );
          },
          activeIndex: controller.bottomNavIndex.value,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            //print('//////////////////${controller.bottomNavIndex.value}');
            controller.updateisHome(false);
            controller.bottomNavIndex.value = index;
          },
        ),
      ),
    );
  }
}
