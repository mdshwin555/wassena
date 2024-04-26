import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class CouponData {
  Crud crud;

  CouponData(this.crud);

  checkcoupon(
      String couponname,
      ) async {
    var response = await crud.postData(AppLink.checkcoupon, {
      "couponname": couponname,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

}
