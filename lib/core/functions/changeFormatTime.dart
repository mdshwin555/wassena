// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// changeFormatTime(TimeOfDay time) {
//   return DateFormat('hh:00 a').format(DateTime(DateTime.now().year,
//       DateTime.now().month, DateTime.now().day, time.hour, time.minute));
// }
//
// changeFormatTimeForBackEnd(TimeOfDay time) {
//   return DateFormat('HH:00').format(DateTime(DateTime.now().year,
//       DateTime.now().month, DateTime.now().day, time.hour, time.minute));
// }
//
// changeFormatDateForBackEnd(DateTime date) {
//   return DateFormat('yyyy-MM-dd').format(date);
// }
//
// changeFormatDate(DateTime date) {
//   return DateFormat('yyyy/MM/dd').format(date);
// }
//
// String getHours(String time) {
//   //print(DateFormat('HH:mm:ss').parse(time).hour);
//   int res = 0;
//   if (DateFormat('HH:mm:ss').parse(time).hour - DateTime.now().hour > 0) {
//     res = DateFormat('HH:mm:ss').parse(time).hour - DateTime.now().hour-1;
//   }
//   return res.toString();
// }
//
// String getMinutes(String time) {
//   int res = 0;
//   if (  DateFormat('HH:mm:ss').parse(time).difference(DateFormat('HH:mm:ss')
//       .parse(
//       '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'))
//       .inMinutes.remainder(60)>0) {
//     res =   DateFormat('HH:mm:ss').parse(time).difference(DateFormat('HH:mm:ss')
//         .parse(
//         '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'))
//         .inMinutes.remainder(60);
//   }
//   return res.toString();
// }
