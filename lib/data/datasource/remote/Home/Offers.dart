import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class OffersData {
  Crud crud;

  OffersData(this.crud);

  viewoffers() async {
    var response = await crud.postData(AppLink.viewoffers, {}, {});
    return response.fold((l) => l, (r) => r);
  }

  addoffers(
    File offers_image,
      String city,
  ) async {
    var response =
        await crud.postFileAndData(AppLink.addoffers, {
          "city": city,
        }, {}, offers_image);
    return response.fold((l) => l, (r) => r);
  }

  deleteoffers(
    String offers_id,
    String offers_image,
  ) async {
    var response = await crud.postData(AppLink.deleteoffers, {
      "offers_id": offers_id,
      "offers_image": offers_image,
    }, {});
    return response.fold((l) => l, (r) => r);
  }
}
