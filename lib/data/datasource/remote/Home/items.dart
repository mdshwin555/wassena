import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class ItemsData {
  Crud crud;

  ItemsData(this.crud);

  getdata(
    String id,
    String usersid,
  ) async {
    var response = await crud.postData(AppLink.items, {
      "id": id,
      "usersid": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getdetails(
      String items_id,
      ) async {
    var response = await crud.postData(AppLink.itemsdetils, {
      "items_id": items_id,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  itemsnoauth(
    String id,
  ) async {
    var response = await crud.postData(AppLink.itemsnoauth, {
      "id": id,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  addrate(
      String usersid,
      String itemsid,
      String rating,
      ) async {
    var response = await crud.postData(AppLink.itemsrating, {
      "usersid": usersid,
      "itemsid": itemsid,
      "rating": rating,
    }, {});
    return response.fold((l) => l, (r) => r);
  }
}
