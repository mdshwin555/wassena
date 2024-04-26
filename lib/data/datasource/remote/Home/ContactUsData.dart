import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class ContactUsData {
  Crud crud;

  ContactUsData(this.crud);

  postdata(
      String title,
      String subject,
      String id,
      ) async {
    var response = await crud.postData(
      AppLink.contactus,
      {
        "title": title,
        "subject": subject,
        "id": id,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }
}
