import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_categories_model.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OkeMartController extends GetxController {
  var adUrl = 'https://okejek.id/'.obs;
  Dio dio = Dio();

  void onInit() {
    super.onInit();
  }

  void delete() {
    super.onDelete();
  }

  void openInBrowser() async {
    await canLaunch(adUrl.value) ? await launch(adUrl.value) : throw 'Could not launch ';
  }

  Future<List<FoodVendorCategories>> getCategories() async {
    // String url = OkejekBaseURL.getMartCategories;
    String url = OkejekBaseURL.apiUrl('vendors/categories');

    List<FoodVendorCategories> categories = [];

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? session = preferences.getString("user_session");

      var queryParams = {
        'outlet_type': 'mart',
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

      BaseResponse responseData = BaseResponse.fromJson(responseBody);
      categories.addAll(responseData.data.foodVendorCategories!);
      return categories;
    } on DioError catch (e) {
      print(e.message);
      return categories;
    }
  }

  Future<List<FoodVendor>> getFoodVendor() async {
    // String url = OkejekBaseURL.getFoodVendor;
    String url = OkejekBaseURL.apiUrl('vendors/lists');
    List<FoodVendor> foodVendors = [];

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? session = preferences.getString("user_session");

      var queryParams = {
        'outlet_type': 'mart',
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

      BaseResponse responseData = BaseResponse.fromJson(responseBody);

      foodVendors.addAll(responseData.data.foodVendor!);

      return foodVendors;
    } on DioError catch (e) {
      print(e.message);
      return foodVendors;
    }
  }
}
