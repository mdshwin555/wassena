import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "username") {
    if (!RegExp(r'^[A-Za-z\u0600-\u06FF\s]+$').hasMatch(val)) {
      return 'يجب إدخال الاسم';
    }
  }
  // Add other validation logic for different types if needed

  if (type == "name") {
    if (!GetUtils.isUsername(val)) {
      return 'أدخل اسم مستخدم صالح';
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return 'أدخل بريد إلكتروني صالح';
    }
  }

  if (type == "phone") {
    if (!val.startsWith('09') && val.length == 10) {
      return 'أدخل رقم موبايل صالح';
    }
  }

  if (val.isEmpty) {
    return "يجب إدخال رقم الموبايل";
  }

  if (val.length < min) {
    return "لا يمكن أن يكون أقل من $min";
  }

  if (val.length > max) {
    return "لا يمكن أن يكون أكثر من $min";
  }
}
