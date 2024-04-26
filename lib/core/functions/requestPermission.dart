// import 'package:permission_handler/permission_handler.dart';
//
// bool isPermission = true;
//
// Future<void> requestPermission() async {
//   Map<Permission, PermissionStatus> statuses = await [
//     Permission.phone,
//     Permission.sms,
//     Permission.storage,
//   ].request();
//   statuses.forEach((permission, status) async {
//     // final result = await permission.request();
//     if (status.isGranted) {
//       // Permission is granted
//     } else if (status.isDenied) {
//       // Permission is denied
//       isPermission = false;
//     } else if (status.isPermanentlyDenied) {
//       // Permission is permanently denied
//       isPermission = false;
//       openAppSettings();
//     }
//   });
//   if (statuses[Permission.phone]!.isGranted &&
//       statuses[Permission.sms]!.isGranted &&
//       statuses[Permission.storage]!.isGranted) {
//     isPermission = true;
//   }
// }
