import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:yumyum/core/class/statusrequest.dart';
import '../functions/checkinternet.dart';

class Crud {

  Future<Either<StatusRequest, Map>> postData(
      String linkurl, Map data, Map<String, String> headers) async {
    if (await checkInternet()) {
      var response =
          await http.post(Uri.parse(linkurl), body: data, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
      String linkurl, Map<String, String> headers) async {
    // if (await checkInternet()) {
    var response = await http.get(Uri.parse(linkurl), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);

      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
    // } else {
    //   return const Left(StatusRequest.offlinefailure);
    // }
  }
  postFileAndData(
      String linkUrl, Map data, Map<String, String> headers, File file) async {
    var request = http.MultipartRequest('Post', Uri.parse(linkUrl));
    int fileLength = await file.length();
    var streamData = http.ByteStream(file.openRead());
    var multiFile = http.MultipartFile('proofPhoto', streamData, fileLength,
        filename: basename(file.path));
    request.files.add(multiFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    request.headers.addAll(headers);

    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);


      return Right(responsebody);
    } else {

      return const Left(StatusRequest.serverfailure);
    }
  }

  postFileAndDataSignUp(String linkUrl, Map data, Map<String, String> headers, File file, File idFile) async {
    var request = http.MultipartRequest('Post', Uri.parse(linkUrl));
    int fileLength = await file.length();
    int idFileLength = await idFile.length();
    var streamData = http.ByteStream(file.openRead());
    var idStreamData = http.ByteStream(idFile.openRead());
    var multiFile = http.MultipartFile('proofPhoto', streamData, fileLength, filename: basename(file.path));
    var idMultiFile = http.MultipartFile('idPhoto', idStreamData, idFileLength, filename: basename(idFile.path));
    request.files.add(multiFile);
    request.files.add(idMultiFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    request.headers.addAll(headers);

    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);

      //print("postMultiData1============ $responsebody");

      return Right(responsebody);
    } else {
      if (response.statusCode == 405) {
        Map responsebody = jsonDecode(response.body);
        //print("postMultiData1============ $responsebody");

        return Left(responsebody);
      }
    }
  }


}
