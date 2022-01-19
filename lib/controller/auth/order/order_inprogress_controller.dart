import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderInProgressController extends GetxController {
  Set<Marker> _markers = {};
  Dio dio = Dio();
  var showMore = false.obs;

  void onInit() {
    super.onInit();
  }

  void onDispose() {
    super.onClose();
  }

  void delete() {
    super.onDelete();
    print('close on delete');
  }

  Set<Marker> setMarker() {
    _markers.add(
      Marker(
        markerId: MarkerId('pickup location'),
        position: LatLng(-7.9615508, 112.6309772),
      ),
    );

    _markers.add(
      Marker(
        markerId: MarkerId('destination location'),
        position: LatLng(-8.0140047, 112.6264473),
      ),
    );

    return _markers;
  }

  void cancelOrder(int id) async {
    // show loading process
    Get.back();
    showLoading();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      // String url = OkejekBaseURL.cancelOrder(id);
      String url = OkejekBaseURL.apiUrl('orders/cancel/$id');

      var queryParams = {
        'api_token': session,
      };

      await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      successCancel();
    } on DioError catch (e) {
      print(e.message);
      failedToCancel();
    }
  }

  void showLoading() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  successCancel() {
    final snackBar = SnackBar(
      content: Text(
        'Pesanan telah dibatalkan',
        style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
      ),
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

    Get.close(2);
  }

  failedToCancel() {
    final snackBar = SnackBar(
      content: Text(
        'Pesanan tidak bisa dibatalkan',
        style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
      ),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    Get.close(2);
  }
}
