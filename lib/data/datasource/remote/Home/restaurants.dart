import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class RestaurantsData {
  Crud crud;

  RestaurantsData(this.crud);

  getdata(
      String categoryid,
      ) async {
    var response = await crud.postData(AppLink.viewrestaurants, {
      "categoryid": categoryid,
    },{});
    return response.fold((l) => l, (r) => r);
  }

  getitems(
      String userid,
      String restaurantsid,
      ) async {
    var response = await crud.postData(AppLink.itemsrestaurants, {
      "userid": userid,
      "restaurantsid": restaurantsid,
    },{});
    return response.fold((l) => l, (r) => r);
  }

  getcatigories() async {
    var response = await crud.getData(AppLink.categories, {});
    return response.fold((l) => l, (r) => r);
  }

  itemsnoauth(
      String restaurantsid,
      ) async {
    var response = await crud.postData(AppLink.itemsrestaurantsnoauth, {
      "restaurantsid": restaurantsid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }


}
