import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class CartData {
  Crud crud;

  CartData(this.crud);

  adddata(
      String usersid,
      String itemsid,
      ) async {
    var response = await crud.postData(AppLink.addtocart, {
      "usersid": usersid,
      "itemsid": itemsid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  removedata(
      String usersid,
      String itemsid,
      ) async {
    var response = await crud.postData(AppLink.removefromcart, {
      "usersid": usersid,
      "itemsid": itemsid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getdata(
      String usersid,
      ) async {
    var response = await crud.postData(AppLink.viewcart, {
      "usersid": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }
}
