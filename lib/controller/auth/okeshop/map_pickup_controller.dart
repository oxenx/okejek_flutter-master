import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPickupController extends GetxController {
  Dio dio = Dio();
  DetailOrderShopController detailOrderShopController = Get.find();

  var pickupAddress = ''.obs;
  var originLat = 0.0.obs;
  var originLng = 0.0.obs;
  var originLocation = ''.obs;
  var originLocationDetail = ''.obs;

  var isFetchingData = false.obs;
  var isSubmitLocation = false.obs;
  var isPickingFromMap = false.obs;
  var isLoading = false.obs;

  void onInit() async {
    getCurrentUserAddress();
    super.onInit();
  }

  void getCurrentUserAddress() async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double? currentLat = preferences.getDouble('current_geocode_lat');
    double? currentLng = preferences.getDouble('current_geocode_lng');

    // set location if not null
    if (currentLat != null && currentLng != null) {
      originLat.value = currentLat;
      originLng.value = currentLng;
    }
    print('current lat lng : ${originLat.value},${originLng.value}');
    isLoading.value = false;
  }

  void getDestinationPlacefromCoordinates(double latitude, double longitude) async {
    originLat.value = latitude;
    originLng.value = longitude;

    String url = OkejekBaseURL.apiUrl('geo/geocode');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'subject': '${originLat.value}, ${originLng.value}',
        'is_reverse': 1,
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
      BaseResponse baseResponse = BaseResponse.fromJson(responseBody);
      if (baseResponse.data.geocodeResult!.places.length != 0) {
        String place = baseResponse.data.geocodeResult!.places[0].name;
        originLocation.value = place;
      } else {
        print('result not found');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<List<AutoCompletePlace>>? getDestinationCoordinatesfromPlace(String place) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double? currentLat = preferences.getDouble('current_geocode_lat');
    double? currentLng = preferences.getDouble('current_geocode_lng');

    // String url = OkejekBaseURL.autoComplete(currentLat!, currentLng!, place);
    String url = OkejekBaseURL.apiUrl('geo/autocomplete');
    String? session = preferences.getString("user_session");
    try {
      var queryParams = {
        'lat': '$currentLat',
        'lng': '$currentLng',
        'q': '$place',
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
      BaseResponse baseResponse = BaseResponse.fromJson(responseBody);
      List<AutoCompletePlace> resultPlace = baseResponse.data.autoComplete!.places;

      return resultPlace;
    } on DioError catch (e) {
      print(e.message);
      return [];
    }
  }

  void setOriginAddress(AutoCompletePlace place) {
    isSubmitLocation.value = false;
    pickupAddress.value = place.address;
    originLocation.value = place.name;
    originLocationDetail.value = place.address;
    originLat.value = place.location.lat;
    originLng.value = place.location.lng;

    // set for detail origin address shopping
    detailOrderShopController.originLat.value = originLat.value;
    detailOrderShopController.originLng.value = originLng.value;
    detailOrderShopController.originLocation.value = originLocation.value;
    detailOrderShopController.originLocationDetail.value = originLocationDetail.value;
  }

  void confirmAddress() {
    detailOrderShopController.originLocation.value = originLocation.value;
    detailOrderShopController.originLat.value = originLat.value;
    detailOrderShopController.originLng.value = originLng.value;

    bool isDetailEmpty = detailOrderShopController.originLocationDetail.value.isEmpty;
    if (isDetailEmpty) {
      detailOrderShopController.originLocationDetail.value = '';
    } else {
      detailOrderShopController.originLocationDetail.value = originLocationDetail.value;
    }
  }
}
