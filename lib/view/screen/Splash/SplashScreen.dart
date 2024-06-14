// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';
// import '../../../core/constant/imgaeasset.dart';
// import '../../../core/services/services.dart';
// import '../Auth/signIn.dart';
// import '../Home/HomeScreen.dart';
//
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     )..forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     MyServices myServices = Get.find();
//
//     return SafeArea(
//       child: Stack(
//         children: [
//           AnimatedSplashScreen(
//             splashIconSize: Get.height,
//             splash: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Positioned(
//                   child: Center(
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         Colors.black.withOpacity(0.7),
//                         BlendMode.srcATop,
//                       ),
//                       child: Image.asset(
//                         AppImageAsset.splash,
//                         height: 100.h,
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   child: Center(
//                     child: Hero(
//                       tag: 'logoTag',
//                       child: ScaleTransition(
//                         scale: Tween<double>(begin: 100.0, end: 1.0).animate(
//                           CurvedAnimation(
//                             curve: Interval(0.5, 1, curve: Curves.easeInOut),
//                             parent: _animationController,
//                           ),
//                         ),
//                         child: SlideTransition(
//                           position: Tween<Offset>(
//                             begin: Offset(0.0, 0.0),
//                             end: Offset(0.0, 0.0),
//                           ).animate(
//                             CurvedAnimation(
//                               curve: Interval(0.5, 1, curve: Curves.easeInOut),
//                               parent: _animationController,
//                             ),
//                           ),
//                           child: ColorFiltered(
//                             colorFilter: ColorFilter.mode(
//                               Colors.white.withOpacity(1),
//                               BlendMode.srcATop,
//                             ),
//                             child: Image.asset(AppImageAsset.logo),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 FutureBuilder(
//                   future:
//                       Future.delayed(Duration(milliseconds: 1000), () => true),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       // If the delay is complete, display the donation widget
//                       return Positioned(
//                         child: Center(
//                           child: Hero(
//                             tag: 'donateTag',
//                             child: SlideTransition(
//                               position: Tween<Offset>(
//                                 begin: Offset(10.0, 0.0),
//                                 end: Offset(0.0, 0.0),
//                               ).animate(
//                                 CurvedAnimation(
//                                   curve:
//                                       Interval(0.5, 1, curve: Curves.easeInOut),
//                                   parent: _animationController,
//                                 ),
//                               ),
//                               child: Image.asset(AppImageAsset.donate),
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       // While waiting for the delay, you can return a loading state or an empty container
//                       return Container();
//                     }
//                   },
//                 ),
//                 FutureBuilder(
//                   future:
//                       Future.delayed(Duration(milliseconds: 1250), () => true),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       // If the delay is complete, display the donation widget
//                       return Positioned(
//                         bottom: 2.h,
//                         child: Column(
//                           children: [
//                             Transform.scale(
//                               scaleY: 0.6,
//                               child: Lottie.asset(
//                                 AppImageAsset.loading,
//                                 width: 100.w,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 1.5.h,
//                             ),
//                             Text(
//                               'version 1.0.0',
//                               style: TextStyle(
//                                 color: Colors.white60,
//                                 fontFamily: 'Cairo',
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       // While waiting for the delay, you can return a loading state or an empty container
//                       return Container();
//                     }
//                   },
//                 ),
//               ],
//             ),
//             nextScreen: myServices.sharedPreferences.getString("token")==null?SignInScreen():HomeScreen(),
//             splashTransition: SplashTransition.fadeTransition,
//             duration: 5000,
//           ),
//         ],
//       ),
//     );
//   }
// }
