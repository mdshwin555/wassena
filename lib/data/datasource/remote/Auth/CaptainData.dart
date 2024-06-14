import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class CaptainUpData {
  Crud crud;

  CaptainUpData(this.crud);

  viewcaptains(

      ) async {
    var response = await crud.postData(
      AppLink.all_captains,
      {
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

  viewonlinecaptains(

      ) async {
    var response = await crud.postData(
      AppLink.online_captains,
      {
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

  postdata(
      String name,
      String email,
      String password,
      String phone,
      ) async {
    var response = await crud.postData(
      AppLink.create_captain,
      {
        "username": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }
}
