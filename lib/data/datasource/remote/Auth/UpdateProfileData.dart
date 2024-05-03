import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class UpdateProfileData {
  Crud crud;

  UpdateProfileData(this.crud);

  updatedata(
      String user_id,
      String username,
      String city,
      String gender,

      ) async {
    var response = await crud.postData(
        AppLink.update_profile,
        {
          "user_id": user_id,
          "username": username,
          "gender": gender,
          "city": city,
        },
        {},
    );
    return response.fold((l) => l, (r) => r);
  }
}
