import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class OffersData {
  Crud crud;

  OffersData(this.crud);

  getoffers() async {
    var response = await crud.getData(AppLink.offers, {});
    return response.fold((l) => l, (r) => r);
  }
}
