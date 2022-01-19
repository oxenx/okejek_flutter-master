import 'dart:io';

class OkejekBaseURL {
  static final _urlOkejek = 'qa.okejekdev.com';
  static final _path = 'api/okejack/v1';

  static String apiUrl(String path, {Map<String, dynamic> queryParameter = const {}}) {
    String pathApi = OkejekBaseURL._path + '/' + path;

    final uri = Uri.https(_urlOkejek, pathApi, queryParameter);
    return uri.toString();
  }

  /* EXTERNAL API or MEDIA  */
  static String telegram = 'https://t.me/OkeJekID';
  static String registerDriver = 'https://okejek.id/cara-mendaftar-mitra-driver-okejek/';
  static String registerMerchant = 'https://okejek.id/merchant/';
  static String privacyPolicy = 'https://okejek.id/privacy-policy/';
  static String termsCondition = 'https://okejek.id/terms-and-condition/';
  static String whatsAppUrl(String number, String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$number/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$number=${Uri.parse(message)}"; // new line
    }
  }

  /* AUTH API  */
  // static String initUrl = '$_baseUrl/init';
  // static String loginEmailUrl = '$_baseUrl/login';
  // static String accountCheck = '$_baseUrl/account-check';
  // static String registerUrl = '$_baseUrl/register';

  /* PROFILE */
  // static String getProfile = '$_baseUrl/profile';
  // static String editProfil = '$_baseUrl/profile/edit';

  /* HOMEPAGE API */
  // static String getHomePageNews = '$_baseUrl/news/cached-news-items';

  /* GEOCODE or LOCATION API */
  // static String nearestCity(double latitude, double longitude) {
  //   return '$_baseUrl/nearest-city?latlng=$latitude,$longitude';
  // }

  // static String getHarga(
  //     double originLat, double originLng, double destinationLat, double destinationLng, int ordertype) {
  //   return '$_baseUrl/order/calculate?origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&type=$ordertype';
  // }

  // static String reverseGeocoding(double latitude, double longitude) {
  //   return '$_baseUrl/geo/geocode?subject=$latitude,$longitude&is_reverse=1';
  // }

  // static String autoComplete(double latitude, double longitude, String place) {
  //   return '$_baseUrl/geo/autocomplete?lat=$latitude&lng=$longitude&q=$place';
  // }

  // static String nearestDriver(Position position, int service, int cityId) {
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;
  //   return '$_baseUrl/drivers-locations?city_id=$cityId&service=$service&location=$latitude,$longitude';
  // }

  /* FOOR and MART */
  // static String getFoodVendor = '$_baseUrl/vendors/lists?outlet_type=food';
  // static String getMartVendor = '$_baseUrl/vendors/lists?outlet_type=mart';
  // static String getFoodCategories = '$_baseUrl/vendors/categories?outlet_type=food';
  // static String getMartCategories = '$_baseUrl/vendors/categories?outlet_type=mart';
  // static String getDetailOutletById(String id) {
  //   return '$_baseUrl/vendors/view/$id';
  // }

  // static String getDetailOutlet(int outletId) {
  //   return '$_baseUrl/vendors/view/$outletId';
  // }

  /* HISTORY */
  // static String historyUrl(String status) {
  //   return "$_baseUrl/orders?status=$status";
  // }

  /* ORDER */
  // static String createOrder = '$_baseUrl/orders/new';
  // static String getDetaikOrderById(String id) {
  //   return '$_baseUrl/orders/view/$id';
  // }

  // static String cancelOrder(int id) {
  //   return '$_baseUrl/orders/cancel/$id';
  // }

  // static String getPromoCoupon(String code, int service, int cityid) {
  //   return '$_baseUrl/coupon/search?code=$code&service=$service&city_id=$cityid';
  // }

  // static String checkTransactionStatusUrl(var id) {
  //   return '$_baseUrl/payment/check-transaction/$id';
  // }

  /* NEWS */
  // static String listNotificationAPI = '$_baseUrl/news/all';
}
