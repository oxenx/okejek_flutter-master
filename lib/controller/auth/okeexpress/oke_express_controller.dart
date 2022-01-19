import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/result_resi/oke_express_data_found.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/result_resi/oke_express_data_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OkeExpressController extends GetxController {
  Dio dio = Dio();

  TextEditingController resiNumber = TextEditingController();
  var isLoading = false.obs;

  void onInit() {
    super.onInit();
  }

  void delete() {
    super.onDelete();
  }

  void createOrder() {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  void lacakPaket() async {
    isLoading.value = true;
    String url = OkejekBaseURL.apiUrl('express/orders/track/${resiNumber.text}');
    print(url);
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

      // not found
      if (!responseBody['success']) {
        Get.to(
            () => OkeExpressDataNotFound(
                  resiNumber: resiNumber.text,
                ),
            transition: Transition.rightToLeft);
      } else {
        // found result
        Get.to(() => OkeExpressDataFound(), transition: Transition.rightToLeft);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    isLoading.value = false;
  }
}
