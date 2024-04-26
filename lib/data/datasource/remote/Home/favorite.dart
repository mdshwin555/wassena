import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class FavoriteData {
  Crud crud;

  FavoriteData(this.crud);

  adddata(
    String usersid,
    String itemsid,
  ) async {
    var response = await crud.postData(AppLink.addfav, {
      "usersid": usersid,
      "itemsid": itemsid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  removedata(
      String usersid,
      String itemsid,
      ) async {
    var response = await crud.postData(AppLink.removefav, {
      "usersid": usersid,
      "itemsid": itemsid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getdata(
      String usersid,
      ) async {
    var response = await crud.postData(AppLink.viewfav, {
      "id": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }
}
