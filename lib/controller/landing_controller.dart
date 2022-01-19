import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/history/history_controller.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_controller.dart';
import 'package:okejek_flutter/controller/auth/order/order_inprogress_controller.dart';
import 'package:okejek_flutter/controller/auth/store/store_controller.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:okejek_flutter/pages/auth/okefood/detail_outlet_page.dart';
import 'package:okejek_flutter/pages/auth/order/order_detail_page.dart';
import 'package:okejek_flutter/pages/deeplink_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingController extends GetxController {
  var versionBuild = "43060".obs;
  var versionName = "4.3.4".obs;
  var isOutdated = false.obs;
  var currentTab = 0.obs;
  var deeplinkUrl = ''.obs;
  var isLoading = false.obs;
  var deepLinkId = ''.obs;
  var deepLinkType = ''.obs;
  Dio dio = Dio();
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void onInit() {
    super.onInit();
    deepLink();
    getVersion();
    getPermission();
  }

  void getPermission() async {
    if (await Permission.location.request().isGranted) {
      print('location permission granted');
    }
  }

  void changeCurrentTab(value) {
    print('changed to $value');
    if (value == 1) {
      HistoryController historyController = Get.put(HistoryController());
      historyController.resetController();
      historyController.fetchHistory();
      historyController.resetFilter();
    }
  }

  Future<Map<String, bool>> checkTransactionStatus(var id, String type) async {
    print('checking transaction..');
    Map<String, bool> mapData = {};
    String url = 'https://qa.okejekdev.com/api/okejack/v1/payment/check-transaction/94';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'api_token': session,
      };

      var response = await dio.post(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      var responseBody = response.data;
      print(responseBody);
      print(responseBody['data']['payment_request_status']);
      // mapData.putIfAbsent(responseBody['data']['payment_request_status'], () => type);
      mapData.putIfAbsent(type, () => responseBody['data']['payment_request_status']);
      print(mapData);
      return mapData;
    } on DioError catch (e) {
      print(e.message);
      return mapData;
    }
  }

  void deepLink() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final initialLink = await getInitialLink();
      if (initialLink != null) deeplinkUrl.value = initialLink;

      log('initlink : $initialLink');
      debugPrint(deeplinkUrl.isNotEmpty.toString());

      if (preferences.getString('user_session') != null) {
        if (deeplinkUrl.isNotEmpty) {
          var uri = Uri.parse(initialLink!);
          List<String> path = uri.path.split('/');

          print(path);

          if (path[2] == 'outlets') {
            String id = path[3];
            deepLinkId.value = id;
            deepLinkType.value = 'outlets';
          } else {
            String id = uri.queryParameters['order']!;
            deepLinkId.value = id;
            deepLinkType.value = 'order';
            Get.to(() => DeeplinkPage());
          }
          Future.delayed(Duration(seconds: 1), () {
            Get.to(() => DeeplinkPage());
          });
        }
      }
    } on PlatformException catch (exception) {
      log(exception.message!);
    }
  }

  void deeplinkOutlet(String id) async {
    isLoading.value = true;

    // String url = OkejekBaseURL.getDetailOutletById(id);
    String url = OkejekBaseURL.apiUrl('vendors/view/$id');
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
      BaseResponse responseData = BaseResponse.fromJson(responseBody);
      FoodVendor foodVendor = responseData.data.detailVendor!;

      /* For differentiate between market and food, create a condition based on type */
      Get.put(OkeFoodController());
      Get.put(StoreController());
      Get.to(() => DetailOutletPage(foodVendor: foodVendor, type: 3))?.then((value) {
        deeplinkUrl.value = '';
        print(deeplinkUrl.value);
      });
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
      isLoading.value = false;
    }
  }

  void deeplinkOrder(String id) async {
    isLoading.value = true;

    // String url = OkejekBaseURL.getDetaikOrderById(id);
    String url = OkejekBaseURL.apiUrl('orders/view/$id');
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

      print(responseBody);
      print(responseBody['data']['order']['user']['activated']);
      responseBody['data']['order']['user']['activated'] == 1
          ? responseBody['data']['order']['user']['activated'] = true
          : responseBody['data']['order']['user']['activated'] = false;
      BaseResponse responseData = BaseResponse.fromJson(responseBody);
      Order order = responseData.data.orders!;

      Get.put(OrderInProgressController());

      /* For differentiate between inProgress and finished, create a condition with order type */

      Get.to(() => OrderDetailPage(
            order: order,
          ))?.then((value) {
        deeplinkUrl.value = '';
        print(deeplinkUrl.value);
      });
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
      isLoading.value = false;
    }
  }

  getVersion() {}

  updateVersion() async {
    String url = 'https://play.google.com/store/apps/details?id=id.okejack.okejackapp';

    if (await canLaunch(url)) {
      print(url);
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void changeTab(int tabIndex) {
    controller.index = tabIndex;
  }
}
