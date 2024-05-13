import 'dart:developer';

import 'package:dio/dio.dart';

class DioErrorHandling {
  static String? handleDioError(DioException error) {
    String? errorMessage;
    if (error.response != null) {
      final res = error.response!;
      log("Error Response Data: ${res.data}");
      final responseData = res.data;

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        final dynamic messageValue = responseData['message'];
        if (messageValue is String) {
          errorMessage = messageValue;
          log("Error Message: $errorMessage");
        } else {
          log("Unexpected 'message' field type: $messageValue");
        }
      } else {
        log("Response does not contain a 'message' field");
      }
    }
    return errorMessage;
  }
}
