import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class OrdersData {
  Crud crud;

  OrdersData(this.crud);

  getpending() async {
    var response = await crud.postData(AppLink.pending, {}, {});
    return response.fold((l) => l, (r) => r);
  }

  getpreparing() async {
    var response = await crud.postData(AppLink.getpreparing, {}, {});
    return response.fold((l) => l, (r) => r);
  }

  getonway() async {
    var response = await crud.postData(AppLink.getonway, {}, {});
    return response.fold((l) => l, (r) => r);
  }

  getarchive() async {
    var response = await crud.postData(AppLink.getarchive, {}, {});
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


  approve(
      String ordersid,
      String usersid,

      ) async {
    var response = await crud.postData(AppLink.approve, {
      "ordersid": ordersid,
      "usersid": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  prepare(
      String ordersid,
      String usersid,

      ) async {
    var response = await crud.postData(AppLink.prepare, {
      "ordersid": ordersid,
      "usersid": usersid,
      "ordertype": "0",
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  reject(
      String ordersid,
      String usersid,

      ) async {
    var response = await crud.postData(AppLink.reject, {
      "ordersid": ordersid,
      "usersid": usersid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }


  additem(
      String usersid,
      String itemsid,
      String orderid,
      ) async {
    var response = await crud.postData(AppLink.additem, {
      "usersid": usersid,
      "itemsid": itemsid,
      "orderid": orderid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  updateDeliveryPriceOrder(
      String order_id,
      String new_delivery_price,
      ) async {
    var response = await crud.postData(AppLink.new_delivery_price, {
      "order_id": order_id,
      "new_delivery_price": new_delivery_price,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

  removeitem(
      String usersid,
      String itemsid,
      String orderid,
      ) async {
    var response = await crud.postData(AppLink.removeitem, {
      "usersid": usersid,
      "itemsid": itemsid,
      "orderid": orderid,
    }, {});
    return response.fold((l) => l, (r) => r);
  }

}
