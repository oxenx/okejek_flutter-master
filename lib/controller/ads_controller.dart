import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/ads_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdsController extends GetxController {
// ad_placement_front: Iklan carousel di halaman depan
// ad_placement_food: Iklan carousel di halaman food
// ad_placement_mart: Iklan carousel di halaman mart
  Dio dio = Dio();
  var frontAds = false.obs;
  var frontAdsCode = ''.obs;
  var foodAds = false.obs;
  var foodAdsCode = ''.obs;
  var martAds = false.obs;
  var martAdsCode = ''.obs;
  var cityId = 1.obs;

  void onInit() {
    super.onInit();
    getAdsFromInit();
    getAdsBanner('food');
  }

  void getAdsFromInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? initDataJSON = preferences.getString('initData');
    String? nearestCityJSON = preferences.getString('nearestCity');

    if (initDataJSON != null) {
      Map<String, dynamic> initData = jsonDecode(initDataJSON);
      Map<String, dynamic> nearestCity = jsonDecode(nearestCityJSON!);
      cityId.value = nearestCity['data']['city']['id'];
      frontAdsCode.value = initData['data']['app_configs']['ad_placements_front'];
      foodAdsCode.value = initData['data']['app_configs']['ad_placements_food'];
      martAdsCode.value = initData['data']['app_configs']['ad_placements_mart'];
    }
  }

  Future<List<Ads>> getAdsBanner(String code) async {
    List<Ads> bannerData = [];
    String url = OkejekBaseURL.apiUrl('ads');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {'api_token': session, 'code': code, 'city_id': cityId.value};

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
      BaseResponse responseData = BaseResponse.fromJson(responseBody);
      bannerData.addAll(responseData.data.ads!);
    } on DioError catch (e) {
      print(e.message);
    }

    return bannerData;
  }
}
