import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class OrdersData {
  Crud crud;

  OrdersData(this.crud);

  checkout(
      String usersid,
      String addressid,
      String orderstype,
      String    pricedelivery,
      String    ordersprice,
      String    couponid,
      String paymentmethod,
      String    coupondiscount,
      String    rating,
      String    comment,
      String    description,
      String    orders_datetime,
      ) async {
    var response = await crud.postData(AppLink.checkout, {
      "usersid": usersid,
      "addressid": addressid,
      "orderstype": orderstype,
      "pricedelivery": pricedelivery,
      "ordersprice": ordersprice,
      "couponid": couponid,
      "paymentmethod": paymentmethod,
      "coupondiscount": coupondiscount,
      "rating": rating,
      "comment": comment,
      "description": description,
      "orders_datetime": orders_datetime,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  rateorders(
      String id,
      String rating,
      String comment,

      ) async {
    var response = await crud.postData(AppLink.rating, {
      "id": id,
      "rating": rating,
      "comment": comment,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  removedata(
      String usersid,
      String itemsid,
      ) async {
    var response = await crud.postData(AppLink.removefromcart, {
      "usersid": usersid,
      "itemsid": itemsid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }


  removeorder(
      String orderid,
      ) async {
    var response = await crud.postData(AppLink.removeorder, {
      "id": orderid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getPinding(
      String usersid,
      ) async {
    var response = await crud.postData(AppLink.pinding, {
      "id": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getOnWay(
      String usersid,
      ) async {
    var response = await crud.postData(AppLink.onway, {
      "id": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getArchive(
      String usersid,
      ) async {
    var response = await crud.postData(AppLink.archive, {
      "id": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  getdetails(
      String ordersid,
      ) async {
    var response = await crud.postData(AppLink.details, {
      "id": ordersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }
}
