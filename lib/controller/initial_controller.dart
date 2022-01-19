import 'dart:convert';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:okejek_flutter/pages/auth/bottom_navigation_bar.dart';
import 'package:okejek_flutter/pages/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitController extends GetxController {
  var url = OkejekBaseURL.apiUrl('init');
  Dio dio = Dio();

  void onInit() async {
    super.onInit();
    initializeInterceptors();
  }

  void delete() {
    super.onDelete();
    dio.interceptors.clear();
  }

  void isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString('user_session');

    session == null
        ? Get.off(() => LandingPage(), transition: Transition.fade)
        : await checkingUserSession()
            ? Get.off(() => BottomNavigation(), transition: Transition.rightToLeft)
            : sessioNotValid();
  }

  Future<bool> checkingUserSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var session = preferences.getString('user_session');
    String url = OkejekBaseURL.apiUrl('profile');

    try {
      print('CHECKING SESSION...');

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

      if (responseBody['success']) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  void sessioNotValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GoogleSignIn().signOut();
    print('USER SESSION IS NOT VALID');
    print('REDIRECTING TO LANDING PAGE');
    prefs.remove('user_data');
    prefs.remove('user_session');
    prefs.clear();
    Get.off(() => LandingPage(), transition: Transition.fade);
  }

  Future getInitRequest() async {
    try {
      var response = await dio.get(url);

      var responseBody = response.data;

      SharedPreferences preferences = await SharedPreferences.getInstance();

      // storing to shareprefs
      String init = jsonEncode(BaseResponse.fromJson(responseBody));
      preferences.setString('initData', init);
      return init;
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
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
