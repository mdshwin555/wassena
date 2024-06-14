import 'dart:io';
import '../../../../core/class/crud.dart';
import '../../../../core/constant/linkapi.dart';

class RestaurantsData {
  Crud crud;

  RestaurantsData(this.crud);


  viewrestaurants(
    String id,

  ) async {
    var response = await crud.postData(
      AppLink.viewrestaurants,
      {
        "id": id,
      },
      {},
    );
    return response.fold((l) => l, (r) => r);
  }

  addrestaurants(
      String restaurants_name,
      String restaurants_type,
      String restaurants_open,
      String restaurants_close,
      String restaurants_is24,
      String restaurants_deliveryprice,
      String datenow,
      String cat,
      String rate,
      String lat,
      String long,
      File logo,
      File backgroundImage,
      String city,
      String subcat
      ) async {
    var response = await crud.postFileAndtwoFiles(
      AppLink.addrestaurants,
      {
        "restaurants_name": restaurants_name,
        "restaurants_type": restaurants_type,
        "restaurants_open": restaurants_open,
        "restaurants_close": restaurants_close,
        "restaurants_is24": restaurants_is24,
        "restaurants_deliveryprice": restaurants_deliveryprice,
        "datenow": datenow,
        "cat": cat,
        "rate": rate,
        "lat": lat,
        "long": long,
        "city": city,
        "subcat": subcat,
      },
      {},
      logo,
      backgroundImage,
    );
    return response.fold((l) => l, (r) => r);
  }
  editrestaurants(
      String id,
      String name,
      String type,
      String open,
      String close,
      String deliveryprice,
      String lat,
      String long,
      String subcat,
      String city,
      String is24,
      String active,
      String imageoldlogo,
      String imageoldbackground,
      [
        File? files,
        File? files2,
      ]

      ) async {
    var response;

   if (files!=null && files2!=null){
     response = await crud.postFileAndtwoFiles(
       AppLink.editrestaurants,
       {
         "id": id,
         "name": name,
         "type": type,
         "open": open,
         "close": close,
         "deliveryprice": deliveryprice,
         "lat": lat,
         "long": long,
         "subcat": subcat,
         "city": city,
         "is24": is24,
         "active": active,
         "imageoldlogo": imageoldlogo,
         "imageoldbackground": imageoldbackground,
       },
       {},
       files!,
       files2!,
     );
   }else if (files == null && files2 ==null ){
     response = await crud.postData(
       AppLink.editrestaurants,
       {
         "id": id,
         "name": name,
         "type": type,
         "open": open,
         "close": close,
         "deliveryprice": deliveryprice,
         "lat": lat,
         "long": long,
         "subcat": subcat,
         "city": city,
         "is24": is24,
         "active": active,
         "imageoldlogo": imageoldlogo,
         "imageoldbackground": imageoldbackground,
       },
       {},

     );
   }else if (files == null && files2 !=null ){
     response = await crud.postFile2AndData(
       AppLink.editrestaurants,
       {
         "id": id,
         "name": name,
         "type": type,
         "open": open,
         "close": close,
         "deliveryprice": deliveryprice,
         "lat": lat,
         "long": long,
         "subcat": subcat,
         "city": city,
         "is24": is24,
         "active": active,
         "imageoldlogo": imageoldlogo,
         "imageoldbackground": imageoldbackground,
       },
       {},
       files2!,
     );
   }else if (files != null && files2 ==null ){
     response = await crud.postFileAndData(
       AppLink.editrestaurants,
       {
         "id": id,
         "name": name,
         "type": type,
         "open": open,
         "close": close,
         "deliveryprice": deliveryprice,
         "lat": lat,
         "long": long,
         "subcat": subcat,
         "city": city,
         "is24": is24,
         "active": active,
         "imageoldlogo": imageoldlogo,
         "imageoldbackground": imageoldbackground,
       },
       {},
       files!,
     );
   }


    return response.fold((l) => l, (r) => r);
  }
  // editrestaurants(
  //     String id,
  //     String name,
  //     String type,
  //     String open,
  //     String close,
  //     String deliveryprice,
  //     String lat,
  //     String long,
  //     String subcat,
  //     String city,
  //     String is24,
  //     String active,
  //     String imageoldlogo,
  //     String imageoldbackground,
  //     [
  //       File? files,
  //       File? files2,
  //     ]
  //
  //     ) async {
  //   var response;
  //   if (files == null && files2==null) {
  //     response = await crud.postData(
  //       AppLink.editrestaurants,
  //       {
  //         "id": id,
  //         "name": name,
  //         "type": type,
  //         "open": open,
  //         "close": close,
  //         "deliveryprice": deliveryprice,
  //         "lat": lat,
  //         "long": long,
  //         "subcat": subcat,
  //         "city": city,
  //         "is24": is24,
  //         "active": active,
  //         "imageoldlogo": imageoldlogo,
  //         "imageoldbackground": imageoldbackground,
  //
  //       },
  //       {},
  //     );
  //   }else{
  //     response = await crud.postFileAndtwoFiles(
  //       AppLink.editrestaurants,
  //       {
  //         "id": id,
  //         "name": name,
  //         "type": type,
  //         "open": open,
  //         "close": close,
  //         "deliveryprice": deliveryprice,
  //         "lat": lat,
  //         "long": long,
  //         "subcat": subcat,
  //         "city": city,
  //         "is24": is24,
  //         "active": active,
  //         "imageoldlogo": imageoldlogo,
  //         "imageoldbackground": imageoldbackground,
  //       },
  //       {},
  //       files!,
  //       files2!,
  //     );
  //   }
  //
  //   return response.fold((l) => l, (r) => r);
  // }


}
