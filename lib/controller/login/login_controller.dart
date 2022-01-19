import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:okejek_flutter/pages/auth/bottom_navigation_bar.dart';
import 'package:okejek_flutter/pages/input_phone_number.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inputPhoneController = TextEditingController();

  var isLoading = false.obs;
  var isLoginFailure = false.obs;
  var errorMessage = 'Pendaftaran akun gagal'.obs;
  String tokenId = '';
  Dio dio = Dio();

  void init() {
    super.onInit();
    initializeInterceptors();
  }

  void delete() {
    super.onDelete();
    resetController();
  }

  void resetController() {
    isLoading.value = false;
    isLoginFailure.value = false;
  }

  void loginViaEmail(String email, String password) async {
    isLoading.value = true;
    isLoginFailure.value = false;
    var url = OkejekBaseURL.apiUrl('login');

    var data = {
      "email": email,
      "password": password,
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

      // retype user activated data
      responseBody['data']['user']['activated'] == 1
          ? responseBody['data']['user']['activated'] = true
          : responseBody['data']['user']['activated'] = false;

      String userData = jsonEncode(BaseResponse.fromJson(responseBody));
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // storing to shareprefs -> json
      preferences.setString('user_data', userData);

      // storing session
      String? sessionJson = preferences.getString('user_data');
      var sessionDecode = jsonDecode(sessionJson!);
      preferences.setString('user_session', sessionDecode['data']['session']);

      // redirest to homepage
      Get.offAll(() => BottomNavigation());
    } on DioError catch (e) {
      isLoginFailure.value = true;

      print(e.message);
    }

    isLoading.value = false;
  }

  void getGoogleAccount() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((onError) {
      print(onError);
    });

    // print(googleUser);
    final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
    tokenId = googleAuth!.idToken!;
    checkIfAccountExist(googleUser, tokenId);
    print('********TOKEN********');
    print(tokenId);
  }

  void checkIfAccountExist(GoogleSignInAccount googleUser, String tokenIdParams) async {
    String url = OkejekBaseURL.apiUrl('account-check');

    var data = {
      "email": googleUser.email,
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

      responseBody['data']['existing_account'] == true
          ? loginGoogleAccount(googleUser, tokenIdParams)
          : navigateToInputPhone(googleUser);
    } on DioError catch (e) {
      print(e.message);
    }
  }

  navigateToInputPhone(GoogleSignInAccount googleUser) async {
    print('REGISTERED NEW USER');
    Get.offAll(
      () => InputPhoneNumberPage(
        googleUser: googleUser,
        tokenId: tokenId,
      ),
    );
  }

  loginGoogleAccount(GoogleSignInAccount googleUser, String tokenIdParams) async {
    isLoading.value = true;
    String url = 'https://qa.okejekdev.com/api/okejack/v1/login/google';

    var data = {
      "name": googleUser.displayName,
      "email": googleUser.email,
      "phone": inputPhoneController.text,
      "token_id": tokenIdParams,
    };

    print(googleUser.displayName);
    print(googleUser.email);
    print(inputPhoneController.text);
    print(tokenIdParams);

    try {
      var response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      var responseBody = response.data;
      print(responseBody);
      // check phone number condition
      if (!responseBody['success']) {
        errorMessage.value = responseBody['message'];

        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              errorMessage.value,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
        isLoading.value = false;
      } else {
        String userData = jsonEncode(responseBody);
        String session = jsonDecode(jsonEncode(responseBody['data']['session']));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        // storing to shareprefs -> json
        preferences.setString('user_data', userData);
        preferences.setString('user_session', session);

        // preferences.setString('user_session', sessionDecode['data']['session']);

        Get.offAll(() => BottomNavigation());
        isLoading.value = false;
      }
    } on DioError catch (e) {
      isLoading.value = false;
      failedSnackbar();
      print(e.message);
    }
  }

  void failedSnackbar() {
    final snackBar = SnackBar(
      backgroundColor: OkejekTheme.primary_color,
      content: Text(
        'Login Gagal',
        style: TextStyle(color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
      ),
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  getUser() async {
    print('USER ALREADY REGISTERED');
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
