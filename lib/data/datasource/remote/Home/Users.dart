import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class UsersData {
  Crud crud;

  UsersData(this.crud);


  viewusers(

  ) async {
    var response = await crud.postData(
      AppLink.users,
      {
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

  blockusers(
      String id,
      String block,
      ) async {
    var response = await crud.postData(
      AppLink.blockusers,
      {
        "id": id,
        "block": block,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

  singleotification(
      String title,
      String body,
      String userid,
      ) async {
    var response = await crud.postData(
      AppLink.singleotification,
      {
        "title": title,
        "body": body,
        "userid": userid,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

  allotifications(
      String title,
      String body,
      ) async {
    var response = await crud.postData(
      AppLink.allotifications,
      {
        "title": title,
        "body": body,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

}
