import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:examtime/common_widget/dio_error.dart';
import 'package:examtime/model/user.dart';
import 'package:examtime/services/ApiServices/ApiBaseServices.dart';
import 'package:examtime/services/SharedServices/Sharedservices.dart';

import 'package:flutter/material.dart';

class Apiservices {
  static Future<bool> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool res = false;
    UserModel node = UserModel();
    try {
      final response = await ApiBaseServices.loginUser(
        Exturl: "/user/login",
        email: email,
        password: password,
      );
      log("heloo");
      log(jsonEncode(response.data));
      if (response.statusCode == 201 || response.statusCode == 200) {
        node = userModelFromJson(jsonEncode(response.data));
        SharedServices.setLoginDetails(node);

        res = true;
      }
      return res;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
      return false;
    }
  }

//---------------------------------------------------------------------------------------------------------
//signup-user
  static Future<Map<String, dynamic>> signupUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool isSign = false;
    String? token;

    try {
      Response res = await ApiBaseServices.postRequest(
        endPoint: "/user/register",
        body: {
          "username": name,
          "email": email,
          "password": password,
        },
      );

      log("Response Data: ${res.data['token']}");
      log(res.statusCode.toString());

      if (res.statusCode == 200) {
        isSign = true;
        token = res.data['token'];
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }

      isSign = false;
    }

    return {
      'isSign': isSign,
      'token': token,
    };
  }

  static Future<Response> fetchUserData() async {
    Response res = await ApiBaseServices.getRequestWithHeaders(
      endPoint: "/user/get",
    );
    return res;
  }

  static Future<Response> fetchNotes() async {
    Response res = await ApiBaseServices.getRequestWithHeaders(
      endPoint: "/note",
    );
    return res;
  }

  static Future<bool> sendOtp(BuildContext context, String token) async {
    bool isSend = false;
    try {
      final res = await ApiBaseServices.getRequestWithHeaderFromFun(
          gettoken: token, endPoint: "/user/sendotp");
      if (res.statusCode == 200) {
        isSend = true;
      }
    } catch (e) {
      isSend = false;
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
    }
    return isSend;
  }

  static Future<bool> verifyOtp(
      BuildContext context, String otp, String token) async {
    bool isverify = false;
    try {
      final res = await ApiBaseServices.postRequestWithHeaderFromFun(
          endPoint: "/user/verifyotp", gettoken: token, body: {"otp": otp});
      if (res.statusCode == 200) {
        isverify = true;
      }
    } catch (e) {
      isverify = false;
      if (e is DioException) {
        final errorMessage = DioErrorHandling.handleDioError(e);
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage.toString())));
        });
      } else {
        log("Exception: $e");
      }
    }
    return isverify;
  }
}
