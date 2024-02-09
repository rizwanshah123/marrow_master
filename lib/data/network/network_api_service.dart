// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../app_exception.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiServices {
//*..................................GET API....................................

  @override
  Future<dynamic> getApi({
    required String url,
    Map<String, String>? header,
  }) async {
    dynamic responseJson;
    try {
      print("inside Try block");
      print(url);
      final response = await http
          .get(
            Uri.parse(url),
            headers: header,
          )
          .timeout(const Duration(seconds: 40));
      print(response.statusCode);
      responseJson = returnResponseJson(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimoutException {
      throw RequestTimoutException();
    } on http.ClientException {
      throw ConnectionClosedException();
    } catch (e) {
      print(e);
    }
    //print(responseJson);
    return responseJson;
  }

//*..................................POST API...................................
  @override
  Future postApi(
      {required dynamic data,
      Map<String, String>? header,
      required String url}) async {
    dynamic responseJson;
    var imagePath = File(data);
    try {
      /// print("inside try block ");
      // print(url);

      // print(data);
      // print("inside postApi getting the image path$imagePath");
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('image', imagePath.path));
      var streamedResponse = await request.send();
      //print("stream response $streamedResponse");
      var responseString = await streamedResponse.stream.bytesToString();
      //// print("response from api  when hitted\n$responseString");

      // print("stream response status code $streamedResponse.statusCode");

      var jsonResponse = jsonDecode(responseString);

      if (streamedResponse.statusCode == 200) {
        responseJson = jsonResponse;
        //  print(responseJson);
      } else {
        throw FetchDataException(
            "Error while communicating  : ${streamedResponse.statusCode.toString()}");
      }
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimoutException();
    } on http.ClientException {
      throw ConnectionClosedException();
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

//* ------------------------------PUT API----------------------------------------
  @override
  Future putApi(
      {required dynamic data,
      Map<String, String>? header,
      required String url}) async {
    dynamic responseJson;
    try {
      final response = await http
          .put(Uri.parse(url), headers: header, body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponseJson(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimoutException {
      throw RequestTimoutException();
    } on http.ClientException {
      throw ConnectionClosedException();
    }
    return responseJson;
  }

  returnResponseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;

      case 201:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;

      case 400:
        throw InvalidUrlException(response.body);
      case 401:
        throw InvalidTokenException(response.body);
      case 500:
        throw ServerException();
      default:
        throw FetchDataException(
            "Error while communicating  : ${response.statusCode.toString()}");
    }
  }
}
