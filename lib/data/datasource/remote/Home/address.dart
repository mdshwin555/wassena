import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class AddressData {
  Crud crud;

  AddressData(this.crud);

  adddata(
      String usersid,
      String name,
      String city,
      String street,
      String lat,
      String long,
      ) async {
    var response = await crud.postData(AppLink.addaddress, {
      "usersid": usersid,
      "name": name,
      "city": city,
      "street": street,
      "lat": lat,
      "long": long,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  removedata(
      String addressid,
      ) async {
    var response = await crud.postData(AppLink.removeaddress, {
      "addressid": addressid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getdata(
      String usersid,
      ) async {
    var response = await crud.postData(AppLink.viewaddress, {
      "usersid": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }


}
