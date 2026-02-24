import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/app.dart';
import 'package:project/ui/controllers/auth_controller.dart';
import 'package:project/ui/screens/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final Response response = await get(uri).timeout(Duration(seconds: 15));
      printResponse(url, response);
      return _handleResponse(response);
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      printResponse(url, response);

      return _handleResponse(response);
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    }
  }

  static void printRequest(
    String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  ) {
    debugPrint('REQUEST:\nURL:$url\nBODY: $body\nHEADERS:$headers');
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL:$url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}',
    );
  }

  static NetworkResponse _handleResponse(Response response) {
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      if (decodeData['status'] == 'fail') {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodeData['data'],
        );
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated!',
        );
      }
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        resposeData: decodeData,
      );
    } else {
      return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
    }
  }

  static Future<void> _moveToLogin() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (p) => false,
    );
  }
}
