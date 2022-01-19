import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/login/login_controller.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:okejek_flutter/pages/auth/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController telphoneController = TextEditingController();
  LoginController loginController = Get.find();

  var isLoading = false.obs;
  var isRegisterFailure = false.obs;
  Dio dio = Dio();

  void onInit() {
    super.onInit();
    initializeInterceptors();
  }

  void delete() {
    super.onDelete();
    print('delete');
  }

  void register(Function failureSnackbar) async {
    isLoading.value = true;

    var url = OkejekBaseURL.apiUrl('register');

    var data = {
      "name": namaController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "contact_phone": telphoneController.text,
    };

    try {
      var response = await dio.post(url,
          options: Options(
            headers: {
              'Accepts': 'application/json',
            },
          ),
          data: data);

      var responseBody = response.data;

      // failed register
      if (!responseBody['success']) {
        isRegisterFailure.value = true;
        failureSnackbar();
      } else {
        // process to login process
        // loginController.loginViaEmail(emailController.text, passwordController.text);

        String session = responseBody['data']['session'];
        SharedPreferences preferences = await SharedPreferences.getInstance();

        // storing to shareprefs -> json
        preferences.setString('user_session', session);
        print(preferences.getString('user_session'));
        getProfil();
      }
    } on DioError catch (e) {
      print(e.message);
    }

    isLoading.value = false;
  }

  void getProfil() async {
    String url = OkejekBaseURL.apiUrl('profile');

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? session = preferences.getString("user_session");

      var queryParams = {
        'api_token': session,
      };

      var response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      var responseBody = response.data;

      // retype user activated data
      responseBody['data']['user']['activated'] == 1
          ? responseBody['data']['user']['activated'] = true
          : responseBody['data']['user']['activated'] = false;

      String userData = jsonEncode(BaseResponse.fromJson(responseBody));

      // storing to shareprefs -> json
      preferences.setString('user_data', userData);

      // redirest to homepage
      Get.offAll(() => BottomNavigation());
    } on DioError catch (e) {
      print(e.message);
    }
  }

  initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          print(e.response);
        },
        onRequest: (options, request) {
          print('on request');

          request.next(options);
        },
        onResponse: (response, handler) {
          print('on response');

          handler.next(response);
        },
      ),
    );
    return dio;
  }
}
