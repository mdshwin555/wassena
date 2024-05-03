import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class HomeData {
  Crud crud;

  HomeData(this.crud);

  getdata() async {
    var response = await crud.getData(AppLink.home, {});
    return response.fold((l) => l, (r) => r);
  }

  getversion() async {
    var response = await crud.getData(AppLink.check_update, {});
    return response.fold((l) => l, (r) => r);
  }

  getnotifications(
      String usersid,
      ) async {
    var response = await crud.postData(AppLink.notification, {
      "id": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  search(
      String search,
      ) async {
    var response = await crud.postData(AppLink.search, {
      "search": search,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

}
