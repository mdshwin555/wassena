import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class ItemsData {
  Crud crud;

  ItemsData(this.crud);

  viewitems(
    String id,
  ) async {
    var response = await crud.postData(
      AppLink.viewitems,
      {
        "id": id,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

  additems(
    String name,
    String namear,
    String desc,
    String descar,
    String count,
    String price,
    String discount,
    String catid,
    String subcatid,
    String datenow,
    String items_restaurants,
    String itemspricedisount,
    String rate,
    File files,
  ) async {
    var response = await crud.postFileAndData(
      AppLink.additems,
      {
        "name": name,
        "namear": namear,
        "desc": desc,
        "descar": descar,
        "count": count,
        "price": price,
        "discount": discount,
        "catid": catid,
        "subcatid": subcatid,
        "datenow": datenow,
        "items_restaurants": items_restaurants,
        "itemspricedisount": itemspricedisount,
        "rate": rate,
      },
      {},
      files,
    );
    return response.fold((l) => l, (r) => r);
  }

  edititems(
    String id,
    String name,
    String desc,
    String price,
    String discount,
    String subcatid,
      String imageold,
      [
    File? files,
  ]) async {
    var response;
    if (files == null) {
      response = await crud.postData(
        AppLink.edititems,
        {
          "id": id,
          "name": name,
          "desc": desc,
          "price": price,
          "discount": discount,
          "subcatid": subcatid,
          "imageold": imageold,
        },
        {},
      );
    }else{
      response = await crud.postFileAndData(
        AppLink.edititems,
        {
          "id": id,
          "name": name,
          "desc": desc,
          "price": price,
          "discount": discount,
          "subcatid": subcatid,
          "imageold": imageold,
        },
        {},
        files,
      );
    }

    return response.fold((l) => l, (r) => r);
  }

  deleteitems(
    String id,
    String imagename,
  ) async {
    var response = await crud.postData(
      AppLink.deleteitems,
      {
        "id": id,
        "imagename": imagename,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }
}
