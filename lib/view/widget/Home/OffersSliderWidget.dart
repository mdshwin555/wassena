// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../core/constant/imgaeasset.dart';
//
// class OffersSlider extends StatelessWidget {
//   const OffersSlider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 23.h,
//       width: 100.w,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: CarouselSlider.builder(
//         options: CarouselOptions(
//           height: 30.h,
//           autoPlay: true,
//           enableInfiniteScroll: true,
//           //viewportFraction: 0.7,
//           aspectRatio: 39 / 19,
//           enlargeCenterPage: true,
//           enlargeStrategy: CenterPageEnlargeStrategy.height,
//           viewportFraction: 0.7,
//           //enlargeFactor: 0.63,
//         ),
//         itemBuilder: (context, index, realIndex) {
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: Container(
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               width: 90.w,
//               height: 20.h,
//               margin: EdgeInsets.symmetric(
//                 vertical: 2.h,
//                 horizontal: 3.w,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 gradient: LinearGradient(colors: [
//                   Color(0xffecb490),
//                   Color(0xffFF7A2F),
//                 ]),
//                 borderRadius: BorderRadius.circular(15.sp),
//               ),
//               child: FittedBox(
//                 child: Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding:
//                           EdgeInsets.only(top: 2.h, right: 3.w),
//                           child: Text(
//                             'احصل على\nخصم 50%',
//                             style: TextStyle(
//                               fontSize: 13.sp,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'ElMessiri',
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding:
//                           EdgeInsets.only(right: 3.w, top: 2.h),
//                           child: RichText(
//                             textAlign: TextAlign.start,
//                             text: TextSpan(
//                               text: 'عند طلب بيتزا \n فصول من ',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontFamily: 'ElMessiri',
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: 'أكشن بيتزا',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Image.asset(
//                       AppImageAsset.pizza,
//                       height: 12.h,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         itemCount: 5,
//       ),
//     );
//   }
// }
