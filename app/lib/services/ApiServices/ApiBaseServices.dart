import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:examtime/model/user.dart';
import 'package:examtime/services/SharedServices/Sharedservices.dart';

Dio dio = Dio();

class ApiBaseServices {
  static String baseURL = "https://examtime-altr.onrender.com";
  static String url({required String extendedURL}) {
    return "$baseURL$extendedURL";
  }

//for login and get all data//----------------------------------------------------------
  static Future<Response> loginUser({
    // ignore: non_constant_identifier_names
    required String Exturl,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      url(extendedURL: Exturl),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }

//http get function//-------------------------------------------------------------------------------
  static Future<Response> getRequest({
    required String endPoint,
  }) async {
    final response = await dio.get(
      url(extendedURL: endPoint),
    );
    return response;
  }

  //get requestwith headers
  static Future<Response> getRequestWithHeaders({
    required String endPoint,
  }) async {
    Map<String, String> newHeaders = {};
    Map<String, String> conentType = {'Content-Type': 'application/json'};
    newHeaders.addAll(conentType);
    if (SharedServices.isLoggedIn()) {
      UserModel? model = SharedServices.getLoginDetails();
      String token = model!.token.toString();
      newHeaders.addAll({'Authorization': token});
    }
    log("newheaders$newHeaders");
    final response = await dio.get(
      url(extendedURL: endPoint),
      options: Options(
        headers: newHeaders,
      ),
    );
    return response;
  }

//http post function//-----------------------------------------------------------------------------------
  static Future<Response> postRequest({
    required String endPoint,
    required Object body,
  }) async {
    log(
      url(extendedURL: endPoint),
    );
    final response = await dio.post(
      url(extendedURL: endPoint),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: jsonEncode(body),
    );
    return response;
  }

//  post request with header//----------------------------------------------------------------------------
  static Future<Response> postRequestWithHeader({
    required String endPoint,
    required Object body,
  }) async {
    Map<String, String> newHeaders = {};
    Map<String, String> conentType = {'Content-Type': 'application/json'};
    newHeaders.addAll(conentType);
    if (SharedServices.isLoggedIn()) {
      UserModel? model = SharedServices.getLoginDetails();
      String token = model!.token.toString();
      newHeaders.addAll({'Authorization': token});
    }
    log("newheaders$newHeaders");
    final response = await dio.post(
      url(extendedURL: endPoint),
      options: Options(
        headers: newHeaders,
      ),
      data: jsonEncode(body),
    );
    return response;
  }

//post requst without body but with header--------------------------------------------
  static Future<Response> postRequestWithoutBody({
    required String endPoint,
  }) async {
    Map<String, String> newHeaders = {};
    Map<String, String> conentType = {'Content-Type': 'application/json'};
    newHeaders.addAll(conentType);
    if (SharedServices.isLoggedIn()) {}
    log("newheaders$newHeaders");
    final response = await dio.post(
      url(extendedURL: endPoint),
      options: Options(
        headers: newHeaders,
      ),
      data: jsonEncode({}),
    );
    return response;
  }

//   //http update function//-----------------------------------------------------------------------------
  static Future<dynamic> updateRequest({
    required String endPoint,
    required Object body,
  }) async {
    final response = await dio.put(
      url(extendedURL: endPoint),
      data: jsonEncode(body),
    );
    return response;
  }

//   //http delete function//-----------------------------------------------------------------------------
  static Future<dynamic> deleteRequest({
    required String endPoint,
  }) async {
    final response = await dio.delete(
      url(extendedURL: endPoint),
      // headers: _getHeaders(),
    );
    return response;
  }
}
