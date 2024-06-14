import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class CategoriesData {
  Crud crud;

  CategoriesData(this.crud);

  viewcategories() async {
    var response = await crud.postData(AppLink.viewcategories, {}, {});
    return response.fold((l) => l, (r) => r);
  }
  deleteresturant(
      String id,
      String logo,
      String background,
      ) async {
    var response = await crud.postData(
      AppLink.deleteresturant,
      {
        "id": id,
        "logo": logo,
        "background": background,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }
  addcategories(
    String name,
    String namear,
    File files,
  ) async {
    var response = await crud.postFileAndData(
      AppLink.addcategories,
      {
        "name": name,
        "namear": namear,
      },
      {},
      files,
    );
    return response.fold((l) => l, (r) => r);
  }

  editcategories(
    String id,
    String name,
    String namear,
    String imageold, [
    File? files,
  ]) async {
    var response;
    if (files == null) {
      response = await crud.postData(
        AppLink.editcategories,
        {
          "id": id,
          "name": name,
          "namear": namear,
          "imageold": imageold,
        },
        {},
      );
    } else {
      response = await crud.postFileAndData(
        AppLink.editcategories,
        {
          "id": id,
          "name": name,
          "namear": namear,
          "imageold": imageold,
        },
        {},
        files,
      );
    }
    return response.fold((l) => l, (r) => r);
  }

  deletecategories(
    String id,
    String imagename,
  ) async {
    var response = await crud.postData(
      AppLink.deletecategories,
      {
        "id": id,
        "imagename": imagename,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }
}
