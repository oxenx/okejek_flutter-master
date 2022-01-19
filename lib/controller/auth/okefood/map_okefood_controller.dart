import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_payment_controller.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapOkefoodController extends GetxController {
  OkefoodPaymentController okefoodPaymentController = Get.find();

  Dio dio = Dio();
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var destinationAddress = ''.obs;
  var destinationLocation = ''.obs;
  var isFetchingData = false.obs;
  var isSubmitLocation = false.obs;
  var isPickfromMap = false.obs;
  var isLoading = false.obs;
  var searchPlace = ''.obs;
  var isSubmitDestination = false.obs;

  void onInit() {
    super.onInit();
    getCurrentUserAddress();
  }

  void delete() {
    super.onDelete();
  }

  void setDestinationAddress(String value, double lat, double lng) {
    destinationAddress.value = value;
    latitude.value = lat;
    longitude.value = lng;
  }

  void getCurrentUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? currentAddress = preferences.getString('current_geocode_address');
    double? currentLat = preferences.getDouble('current_geocode_lat');
    double? currentLng = preferences.getDouble('current_geocode_lng');

    bool destinationEmpty = okefoodPaymentController.destinationAddress.value.isEmpty;

    // set destination to default if its not empty
    if (destinationEmpty) {
      // set location if not null
      destinationLocation.value = currentAddress!;
      latitude.value = currentLat!;
      longitude.value = currentLng!;
      getDestinationPlacefromCoordinates(latitude.value, longitude.value);
    } else {
      destinationLocation.value = okefoodPaymentController.destLocation.value;
      destinationAddress.value = okefoodPaymentController.destinationAddress.value;
      latitude.value = okefoodPaymentController.destLat.value;
      longitude.value = okefoodPaymentController.destLng.value;
    }
  }

  void autoCompleteDestination(String place) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    // String url = OkejekBaseURL.autoComplete(latitude.value, longitude.value, place);
    String url = OkejekBaseURL.apiUrl('geo/autocomplete');

    try {
      var queryParams = {
        'lat': '${latitude.value}',
        'lng': '${longitude.value}',
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
      destinationLocation.value = resultPlace[0].name;
      destinationAddress.value = resultPlace[0].address;
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

  void getDestinationPlacefromCoordinates(double latitudeparam, double longitudeparam) async {
    isLoading.value = true;
    latitude.value = latitudeparam;
    longitude.value = longitudeparam;

    // String url = OkejekBaseURL.reverseGeocoding(latitude.value, longitude.value);
    String url = OkejekBaseURL.apiUrl('geo/geocode');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'subject': '${latitude.value}, ${longitude.value}',
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
        print(baseResponse.data.geocodeResult!.places[0].name);
        print(baseResponse.data.geocodeResult!.places[0].location.lat);
        print(baseResponse.data.geocodeResult!.places[0].location.lng);
        destinationLocation.value = place;
      } else {
        print('result not found');
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<bool> fetchDataDestination() => Future.delayed(
        Duration(seconds: 3),
        () {
          isFetchingData.value = false;
          return isFetchingData.value;
        },
      );
}
