import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapDestinationController extends GetxController {
  Dio dio = Dio();
  DetailOrderShopController detailOrderShopController = Get.find();

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var destinationAddress = ''.obs;
  var destLat = 0.0.obs;
  var destLng = 0.0.obs;
  var destLocation = ''.obs;
  var destLocationDetail = ''.obs;

  var isFetchingData = false.obs;
  var isSubmitLocation = false.obs;
  var isPickingFromMap = false.obs;
  var isLoading = false.obs;

  void onInit() {
    super.onInit();
    getCurrentUserAddress();
  }

  void delete() {
    super.onDelete();
  }

  void getCurrentUserAddress() async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double? currentLat = preferences.getDouble('current_geocode_lat');
    double? currentLng = preferences.getDouble('current_geocode_lng');

    // set location if not null
    if (currentLat != null && currentLng != null) {
      destLat.value = currentLat;
      destLng.value = currentLng;
    }
    print('current lat lng : ${destLat.value},${destLng.value}');
    isLoading.value = false;
  }

  void getDestinationPlacefromCoordinates(double latitude, double longitude) async {
    destLat.value = latitude;
    destLng.value = longitude;

    String url = OkejekBaseURL.apiUrl('geo/geocode');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'subject': '${destLat.value}, ${destLng.value}',
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
        destLocation.value = place;
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

  void setDestinationAddress(AutoCompletePlace place) {
    isSubmitLocation.value = false;
    destinationAddress.value = place.address;
    destLocation.value = place.name;
    destLocationDetail.value = place.address;
    destLat.value = place.location.lat;
    destLng.value = place.location.lng;

    // set for detail origin address shopping
    detailOrderShopController.destLat.value = destLat.value;
    detailOrderShopController.destLng.value = destLng.value;
    detailOrderShopController.destLocation.value = destLocation.value;
    detailOrderShopController.destLocationDetail.value = destLocationDetail.value;
  }

  void confirmAddress() {
    detailOrderShopController.destLocation.value = destLocation.value;
    detailOrderShopController.destLat.value = destLat.value;
    detailOrderShopController.destLng.value = destLng.value;

    bool isDetailEmpty = detailOrderShopController.destLocationDetail.value.isEmpty;
    if (isDetailEmpty) {
      detailOrderShopController.destLocationDetail.value = '';
    } else {
      detailOrderShopController.destLocationDetail.value = destLocationDetail.value;
    }
  }

  //==============

}
