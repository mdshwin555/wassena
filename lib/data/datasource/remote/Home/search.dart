import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class SearchData {
  Crud crud;

  SearchData(this.crud);

  search(
      String search,
      String type,
      ) async {
    var response = await crud.postData(AppLink.searchAll, {
      "search": search,
      "type": type,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

}
