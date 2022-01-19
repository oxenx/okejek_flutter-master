import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:device_apps/device_apps.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide FormData;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/history/history_controller.dart';
import 'package:okejek_flutter/controller/landing_controller.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/city_model.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OkeRideController extends GetxController {
  Set<Marker> _markers = {};
  final LandingController landingController = Get.find();
  final HistoryController historyController = Get.put(HistoryController());
  late Uint8List markerIcon;

  Dio dio = Dio();

  double initLat = -7.9826145;
  double initLng = 112.6286226;

  var originLat = 0.0.obs;
  var originLng = 0.0.obs;
  var destinationLat = 0.0.obs;
  var destinationLng = 0.0.obs;

  var driverLocation = [].obs;
  var isLoading = false.obs;
  var cityId = 0.obs;
  var orderType = 0.obs;
  var price = 0.obs;
  var originPrice = 0.obs;
  var originLocation = ''.obs;
  var originLocationDetail = ''.obs;
  var destLocation = ''.obs;
  var destLocationDetail = ''.obs;
  var couponCode = 'Masukkan Kupon'.obs;
  var modalTitle = 'Pilih Lokasi Penjemputan'.obs;

  var heightFactor = 0.27.obs;
  var isFecthingData = true.obs;
  var fetchSucess = false.obs;
  var isSubmitPickup = false.obs;
  var isSubmitDestination = false.obs;
  var isGeneratePayment = false.obs;
  var isSubmitPromo = false.obs;
  var isPickingfromMap = false.obs;
  var isSubmitOrder = false.obs;
  var preload = true.obs;

  var destinationMapPick = false.obs;
  var originMapPick = false.obs;
  var searhPlace = ''.obs;
  var errorMessage = 'Error Message'.obs;
  var appsInstalled = true.obs;

  var dropDownValue = 'Cash'.obs;
  var dropDownValueList = ['Cash', 'OkePoint', 'Link Aja', 'Shopee Pay', 'Faspay'];

  var currentService = 'Ojek'.obs;

  Set<Marker> setMarker() {
    driverLocation.forEach(
      (location) {
        List<String> locationSplit = location.split(',');

        _markers.add(
          Marker(
            markerId: MarkerId(location),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            position: LatLng(double.parse(locationSplit[0]), double.parse(locationSplit[1])),
          ),
        );
      },
    );
    update();
    return _markers;
  }

  @override
  void onInit() async {
    super.onInit();
    getCurrentPositionCamera();
    getCurrentUserAddress();
  }

  Future<bool> queryAppsinstalled() async {
    String payment = dropDownValue.value;

    String appPackages = '';
    payment == 'Shopee Pay'
        ? appPackages = 'com.shopee.id.int'
        : payment == 'Link Aja'
            ? appPackages = 'com.telkom.mwallet'
            : payment == 'Faspay'
                ? appPackages = 'ovo.id'
                : appPackages = '';

    bool isInstalled = appPackages == '' ? true : await DeviceApps.isAppInstalled(appPackages);
    print('is application packages $appPackages installed : $isInstalled');

    return isInstalled;
  }

  void getCurrentUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? currentAddress = preferences.getString('current_geocode_address');
    double? currentLat = preferences.getDouble('current_geocode_lat');
    double? currentLng = preferences.getDouble('current_geocode_lng');

    // set location if not null
    if (currentAddress != null) originLocation.value = currentAddress;
    if (currentLat != null && currentLng != null) {
      originLat.value = currentLat;
      originLng.value = currentLng;
    }

    print('origin lat lng (ride) : ${originLat.value},${originLng.value}');
  }

  void createOrder(var dialogError) async {
    isSubmitOrder.value = true;

    // String url = OkejekBaseURL.createOrder;
    String url = OkejekBaseURL.apiUrl('orders/new');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");
    String originLatLng = originLat.value.toString() + ',' + originLng.value.toString();
    String destinationLatLng = destinationLat.value.toString() + ',' + destinationLng.value.toString();

    String paymentProvider = dropDownValue.value == 'Cash'
        ? 'cash'
        : dropDownValue.value == 'OkePoint'
            ? 'okepoint'
            : dropDownValue.value == 'Link Aja'
                ? 'linkaja'
                : 'airpay';

    try {
      var queryParams = {
        'api_token': session,
      };

      var data = {
        'payment_provider': paymentProvider,
        'creation_code': '',
        'origin_latlng': originLatLng,
        'origin_address': '${originLocation.value}',
        'origin_address_detail': '${originLocationDetail.value}',
        'destination_latlng': destinationLatLng,
        'destination_address': '${destLocation.value}',
        'destination_address_detail': '${destLocationDetail.value}',
        'type': '${orderType.value}',
        'food_vendor_id': '',
        'info': '',
        'coupon_id': '',
        'shopping_items': '',
      };

      print(data);

      FormData formData = FormData.fromMap(data);

      var response = await dio.post(
        url,
        data: formData,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      var responseBody = response.data;
      print(responseBody);
      isSubmitOrder.value = false;

      if (response.statusCode == 200 || response.statusCode == 500) {
        if (responseBody['success']) {
          Get.back();

          // changing tab view to history page
          landingController.changeTab(1);
          historyController.resetController();
          historyController.fetchHistory();
          historyController.resetFilter();
        } else if (!responseBody['success']) {
          errorOrder(responseBody);
          dialogError(Get.context, errorMessage.value);
        }
      }
    } on DioError catch (e) {
      print(e.message);
      isSubmitOrder.value = false;
    }
  }

  void errorOrder(var responseBody) {
    if (responseBody['error'] == 'order_driver_not_available') {
      errorMessage.value = 'Tidak ada driver di sekitar area penjemputan';
    } else if (responseBody['error'] == 'user_banned') {
      errorMessage.value = 'Pengguna telah dibanned dari aplikasi';
    } else if (responseBody['error'] == 'user_phone_not_valid') {
      errorMessage.value = 'No.HP Pengguna tidak valid';
    } else if (responseBody['error'] == 'order_limit_reached') {
      errorMessage.value = 'Pengguna mempunyai beberapa order yang masih dalam proses';
    } else if (responseBody['error'] == 'create_order_request_not_valid') {
      errorMessage.value = 'Format Order tidak valid';
    } else if (responseBody['error'] == 'outside_service_area') {
      errorMessage.value = 'Order berada diluar area layanan Okejek';
    } else if (responseBody['error'] == 'service_disabled') {
      errorMessage.value = 'Layanan yang dipilih sedang dinonaktifkan';
    } else {
      errorMessage.value = 'Jarak yang ditempuh terlalu jauh';
    }

    print(responseBody);
    print('failed to create an order');
  }

  void autoCompleteOrigin(String place) async {
    List<AutoCompletePlace> listofPlace = [];
    // String url = OkejekBaseURL.autoComplete(originLat.value, originLng.value, place);
    String url = OkejekBaseURL.apiUrl('geo/autocomplete');
    print(url);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'lat': '${originLat.value}',
        'lng': '${originLng.value}',
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
      // print(responseBody);
      BaseResponse baseResponse = BaseResponse.fromJson(responseBody);
      listofPlace.addAll(baseResponse.data.autoComplete!.places);

      if (listofPlace.length != 0) {
        originLocation.value = listofPlace[0].name;
        originLocationDetail.value = listofPlace[0].address;
        originLat.value = listofPlace[0].location.lat;
        originLng.value = listofPlace[0].location.lng;
      } else {
        print('search autocomplete not found');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void autoCompleteDestination(String place) async {
    List<AutoCompletePlace> listofPlace = [];
    // String url = OkejekBaseURL.autoComplete(destinationLat.value, destinationLng.value, place);
    String url = OkejekBaseURL.apiUrl('geo/autocomplete');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      var queryParams = {
        'lat': '${destinationLat.value}',
        'lng': '${destinationLng.value}',
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
      print(responseBody);
      BaseResponse baseResponse = BaseResponse.fromJson(responseBody);
      listofPlace.addAll(baseResponse.data.autoComplete!.places);

      if (listofPlace.length != 0) {
        destLocation.value = listofPlace[0].name;
        destLocationDetail.value = listofPlace[0].address;
        destinationLat.value = listofPlace[0].location.lat;
        destinationLng.value = listofPlace[0].location.lng;

        // change size of slideup panel
        changeHeightFactor(0.65);
      } else {
        print('search autocomplete not found');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void getDestinationPlacefromCoordinates(double latitude, double longitude) async {
    print('set destination coordinates map');
    isLoading.value = true;
    destinationLat.value = latitude;
    destinationLng.value = longitude;

    // String url = OkejekBaseURL.reverseGeocoding(destinationLat.value, destinationLng.value);

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
        destLocation.value = place;
        destLocationDetail.value = '';

        if (destLocation.isNotEmpty && originLocation.isNotEmpty) heightFactor.value = 0.65;
      } else {
        print('result not found');
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
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
        originLocationDetail.value = '';

        if (destLocation.isNotEmpty && originLocation.isNotEmpty) heightFactor.value = 0.65;
      } else {
        print('result not found');
      }
      isLoading.value = false;
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

  void checkPrice() async {
    isFecthingData.value = true;
    fetchSucess.value = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    var queryParams = {
      'origin': '${originLat.value},${originLng.value}',
      'destination': '${destinationLat.value},${destinationLng.value}',
      'type': 0,
      'api_token': session,
    };

    // String url =
    //     OkejekBaseURL.getHarga(originLat.value, originLng.value, destinationLat.value, destinationLng.value, 0);

    String url = OkejekBaseURL.apiUrl('order/calculate');

    try {
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
      BaseResponse baseResponse = BaseResponse.fromJson(responseBody);
      print(responseBody);

      int fee = baseResponse.data.calculateRequest!.fee;
      originPrice.value = fee;
      fetchSucess.value = true;
      isFecthingData.value = false;
    } on DioError catch (e) {
      // showing failure text
      print(e.message);
    }
  }

  void orderCheck() async {
    orderType.value == 0
        ? markerIcon = await getBytesFromAsset('assets/icons/markers/ride.png', 100)
        : orderType.value == 4
            ? markerIcon = await getBytesFromAsset('assets/icons/markers/car.png', 100)
            : markerIcon = await getBytesFromAsset('assets/icons/markers/trike.png', 100);
  }

  void getCurrentPositionCamera() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    initLat = position.latitude;
    initLng = position.longitude;

    CameraPosition _newCameraposition = CameraPosition(
      target: LatLng(initLat, initLng),
      zoom: 16.0,
    );

    Completer<GoogleMapController> _controller = Completer();
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraposition),
    );

    update();
  }

  void getCityId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? cityJson = preferences.getString('nearestCity');

    var data = jsonDecode(cityJson!);
    City city = City.fromJson(data['data']['city']);

    cityId.value = city.id;
  }

  void getCouponCode(String couponCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    try {
      getCityId();

      // String url = OkejekBaseURL.getPromoCoupon(couponCode, 0, cityId.value);
      String url = OkejekBaseURL.apiUrl('coupon/search');

      var queryParams = {
        'code': '$couponCode',
        'service': 0,
        'city_id': '${cityId.value}',
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
      if (baseResponse.data.coupon!.id == 0) {
        Fluttertoast.showToast(msg: 'Kode tidak ditemukan', fontSize: 12);
        setPromoCode('');
        price.value = 0;
      } else {
        setPromoCode(couponCode);
        price.value = originPrice.value - baseResponse.data.coupon!.discountFee!;
        Fluttertoast.showToast(msg: 'Kode berhasil dipakai', fontSize: 12);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void getNearestDriver() async {
    driverLocation.clear();
    _markers.clear();
    isLoading.value = true;

    // create a loading
    Future.delayed(Duration(seconds: 2), () async {
      // checking order type for determine the icon
      orderCheck();

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? session = preferences.getString("user_session");

      // get from server
      try {
        getCityId();

        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        // String url = OkejekBaseURL.nearestDriver(position, orderType.value, cityId.value);

        String url = OkejekBaseURL.apiUrl('drivers-locations');

        var queryParams = {
          'city_id': '${cityId.value}',
          'service': '${orderType.value}',
          'location': '${position.latitude},${position.longitude}',
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

        driverLocation.addAll(responseBody['data']['driver_locations']);
        setMarker();
        isLoading.value = false;
      } on DioError catch (e) {
        print(e.message);
      }
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void resetController() {
    getCurrentUserAddress();
    preload.value = true;
    appsInstalled.value = true;
    searhPlace.value = '';
    isSubmitOrder.value = false;
    originLocationDetail.value = '';
    destLocationDetail.value = '';
    isPickingfromMap.value = false;
    destinationMapPick.value = false;
    originMapPick.value = false;

    isSubmitPromo.value = false;
    isLoading.value = false;
    isSubmitPickup.value = false;
    isSubmitDestination.value = false;
    isGeneratePayment.value = false;
    isSubmitPromo.value = false;
    heightFactor.value = 0.27;
    orderType.value = 0;
    price.value = 0;
    destLocation.value = '';
    currentService.value = 'Ojek';
    dropDownValue.value = 'Cash';
    couponCode.value = 'Masukkan Kupon';
    // setModalTitle('Pilih Lokasi Penjemputan');
  }

  void setPromoCode(String value) {
    couponCode.value = value;
  }

  void setDropdownValue(var value) {
    dropDownValue.value = value;
    print('dropdownvalue changed to : ' + dropDownValue.value.toString());
  }

  void setModalTitle(String title) {
    modalTitle.value = title;
  }

  void setDestLocation(String value) {
    destLocation.value = value;
  }

  void changeHeightFactor(double height) {
    heightFactor.value = height;
  }

  void changeSubmitPickup() {
    isSubmitPickup.value = true;
  }

  void resetSubmitPickup() {
    isSubmitPickup.value = false;
  }

  void changeSubmitDestination() {
    isSubmitDestination.value = true;
  }

  void resetSubmitDestination() {
    isSubmitDestination.value = false;
  }

  void changeGeneratePayment() {
    isGeneratePayment.value = true;
  }

  void resetGeneratePayment() {
    isGeneratePayment.value = false;
  }

  void changeSubmitPromo(bool value) {
    isSubmitPromo.value = value;
    print('changed submit promo to ' + isSubmitPromo.value.toString());
  }

  void changeService(String value) {
    currentService.value = value;
  }

  Future<bool> fetchDataDestination() => Future.delayed(
        Duration(seconds: 3),
        () {
          isFecthingData.value = false;
          return isFecthingData.value;
        },
      );

  Future<bool> fetchDataPickup() => Future.delayed(
        Duration(seconds: 3),
        () {
          isFecthingData.value = false;
          return isFecthingData.value;
        },
      );

  Future<bool> fetchDataPayment() => Future.delayed(
        Duration(milliseconds: 100),
        () {
          checkPrice();
          return isFecthingData.value;
        },
      );
}
