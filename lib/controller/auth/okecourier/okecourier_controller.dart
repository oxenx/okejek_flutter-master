import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OkeCourierController extends GetxController {
  Dio dio = Dio();
  var originLat = 0.0.obs;
  var originLng = 0.0.obs;
  var originLocation = ''.obs;
  var originDetailLocation = ''.obs;
  var destinationLat = 0.0.obs;
  var destinationLng = 0.0.obs;
  var destinationLocation = ''.obs;
  var destinationDetailLocation = ''.obs;
  var isOriginSection = true.obs;
  var isLoading = false.obs;
  var isOriginPickingFromMap = false.obs;
  var isDestionationPickingFromMap = false.obs;
  var isSubmitOrigin = false.obs;
  var isSubmitDestination = false.obs;
  var willPopPage = false.obs;
  var searchOriginPlace = ''.obs;
  var searchDestinationPlace = ''.obs;
  var showSummary = false.obs;
  var preload = true.obs;
  var ongkir = 0.obs;

  void onInit() async {
    super.onInit();
    getCurrentUserAddress();
  }

  void delete() {
    super.onDelete();
  }

  void resetController() {
    getCurrentUserAddress();
    preload.value = true;
    isSubmitDestination.value = false;
    showSummary.value = false;
    willPopPage.value = false;
    isOriginSection.value = true;
    originLocation.value = '';
    originDetailLocation.value = '';
    destinationLat.value = 0.0;
    destinationLng.value = 0.0;
    searchDestinationPlace.value = '';
    destinationLocation.value = '';
    destinationDetailLocation.value = '';
    isLoading.value = false;
    isOriginPickingFromMap.value = false;
    isDestionationPickingFromMap.value = false;
    ongkir.value = 0;
  }

  void checkPrice() async {
    isLoading.value = true;

    String url = OkejekBaseURL.apiUrl('order/calculate');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'origin': '${originLat.value}, ${originLng.value}',
        'destination': '${destinationLat.value}, ${destinationLng.value}',
        'type': 1,
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
      ongkir.value = responseBody['data']['calculated_request']['fee'];
    } on DioError catch (e) {
      print(e.message);
    }

    isLoading.value = false;
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

    print('current lat lng (courier): ${originLat.value},${originLng.value}');
    isLoading.value = false;
  }

  Future<List<AutoCompletePlace>>? getCoordinatesfromPlace(String place) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double? currentLat = preferences.getDouble('current_geocode_lat');
    double? currentLng = preferences.getDouble('current_geocode_lng');

    // String url = OkejekBaseURL.autoComplete(currentLat!, currentLng!, place);
    String url = OkejekBaseURL.apiUrl('geo/autocomplete');
    String? session = preferences.getString("user_session");
    try {
      var queryParams = {
        'lat': '$currentLat',
        'lng': '$currentLng!',
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

      isLoading.value = false;
      return resultPlace;
    } on DioError catch (e) {
      print(e.message);
      return [];
    }
  }

  void getOriginPlacefromCoordinates(double latitude, double longitude) async {
    print('set pickup coordinates map');
    isLoading.value = true;
    originLat.value = latitude;
    originLng.value = longitude;

    // String url = OkejekBaseURL.reverseGeocoding(originLat.value, originLng.value);
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
        originDetailLocation.value = '';
      } else {
        print('result not found');
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void getDestinationPlacefromCoordinates(double latitude, double longitude) async {
    print('set pickup coordinates map');
    isLoading.value = true;
    destinationLat.value = latitude;
    destinationLng.value = longitude;

    // String url = OkejekBaseURL.reverseGeocoding(originLat.value, originLng.value);
    String url = OkejekBaseURL.apiUrl('geo/geocode');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'subject': '${destinationLat.value}, ${destinationLng.value}',
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
        destinationLocation.value = place;
        destinationDetailLocation.value = '';
      } else {
        print('result not found');
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
