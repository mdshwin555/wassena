import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class SignUpData {
  Crud crud;

  SignUpData(this.crud);

  postdata(
      String name,
      String email,
      String password,
      String phone,
      String gender,
      String city,
      ) async {
    var response = await crud.postData(
        AppLink.signUp,
        {
          "username": name,
          "email": email,
          "password": password,
          "phone": phone,
          "gender": gender,
          "city": city,
        },
        {},
    );
    return response.fold((l) => l, (r) => r);
  }
}
