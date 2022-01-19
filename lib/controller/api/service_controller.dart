import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/api/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesController extends GetxController {
  Dio dio = Dio();
  UserController userController = Get.put(UserController());

  var avaiableServices = {};
  var isServicesAvailable = false.obs;

  var isRideAvailable = false.obs;
  var isCourierAvailable = false.obs;
  var isShoppingAvailable = false.obs;
  var isFoodAvailable = false.obs;
  var isMartAvailable = false.obs;
  var isCarAvailable = false.obs;
  var isTrikeAvailable = false.obs;
  var isTrikeCourierAvailable = false.obs;

  void onInit() {
    super.onInit();
    getService();
  }

  void delete() {
    super.onDelete();
    dio.interceptors.clear();
  }

  void getService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await userController.getCurrentAddress();
    String? jsonServices = preferences.getString('nearestCity');

    if (jsonServices != null) {
      avaiableServices = jsonDecode(jsonServices);

      if (avaiableServices['data']['city'] != null) {
        isServicesAvailable.value = true;
        setAvailableServices();
      } else {
        print('nearest city data : null');
      }
    } else {
      print('nearest city sharedprefs : null');
    }
  }

  void setAvailableServices() {
    isRideAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_ride'];
    isCourierAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_courier'];
    isShoppingAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_shopping'];
    isFoodAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_food'];
    isMartAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_mart'];
    isCarAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_car'];
    isTrikeAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_trike'];
    isTrikeCourierAvailable.value = avaiableServices['data']['city']['original_config']['app_feature_trike_courier'];
  }
}
