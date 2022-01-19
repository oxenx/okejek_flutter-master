import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_categories_model.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/models/base_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OkeFoodController extends GetxController {
  Dio dio = Dio();

  List<Map<String, dynamic>> dummyData = [
    {
      'nama_makanan': 'Nasi Goreng Seafood',
      'harga': 'Rp19.000',
      'potongan': '0',
      'harga_potongan': 'Rp19.000',
      'jarak': '2.3 km',
      'imageUrl':
          'https://www.masakapahariini.com/wp-content/uploads/2018/04/cara-membuat-nasi-goreng-seafood-500x300.jpg'
    },
    {
      'nama_makanan': 'Salad',
      'harga': 'Rp35.000',
      'potongan': 'Rp5.000',
      'harga_potongan': 'Rp30.000',
      'jarak': '0.4 km',
      'imageUrl':
          'https://awsimages.detik.net.id/community/media/visual/2021/05/12/resep-salad-buah-thai_43.jpeg?w=700&q=90',
    },
    {
      'nama_makanan': 'Bakmi Aceh',
      'harga': 'Rp20.000',
      'potongan': 'Rp5.000',
      'harga_potongan': 'Rp15.000',
      'jarak': '2.1 km',
      'imageUrl':
          'https://asset.kompas.com/crops/S-qPoLB89t3T-R8pqe0kSyGTbNY=/26x0:926x600/750x500/data/photo/2019/11/27/5dddef90a93b3.jpg',
    },
  ].obs;

  List<Map<String, dynamic>> nearbyEateries = [
    {
      'nama_makanan': 'Restoran Mie Rasa cab. Asia Afrika',
      'harga': 'Rp15.000',
      'jarak': '0.2 km',
      'imageUrl':
          'https://selerasa.com/wp-content/uploads/2015/05/images_mie_Mie_ayam_14-mie-ayam-kampung-1200x798.jpg',
    },
    {
      'nama_makanan': 'Mie Gacoan',
      'harga': 'Rp20.000',
      'jarak': '0.1 km',
      'imageUrl':
          'https://d1sag4ddilekf6.azureedge.net/compressed/merchants/IDGFSTI00003m4d/hero/977a9a87d67c4e9e95e1dcadbac41225_1593147160597014795.jpeg',
    },
    {
      'nama_makanan': 'Jank Jank Delivery Wings',
      'harga': 'Rp20.000',
      'jarak': '0.3 km',
      'imageUrl':
          'https://d1sag4ddilekf6.azureedge.net/compressed/merchants/IDGFSTI00000xpp/hero/13_d177eaa3c42e4540bd240bbde5f8363f_1551851079280275748.jpg',
    },
  ].obs;

  var adUrl = 'https://okejek.id/'.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void delete() {
    super.onDelete();
  }

  void openInBrowser() async {
    await canLaunch(adUrl.value) ? await launch(adUrl.value) : throw 'Could not launch ';
  }

  Future<List<FoodVendorCategories>> getCategories() async {
    // String url = OkejekBaseURL.getFoodCategories;
    String url = OkejekBaseURL.apiUrl('vendors/categories');

    List<FoodVendorCategories> categories = [];

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? session = preferences.getString("user_session");

      var queryParams = {
        'outlet_type': 'food',
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
      categories.addAll(responseData.data.foodVendorCategories!);
      return categories;
    } on DioError catch (e) {
      print(e.message);
      return categories;
    }
  }

  Future<List<FoodVendor>> getFoodVendor() async {
    // String url = OkejekBaseURL.getFoodVendor;
    String url = OkejekBaseURL.apiUrl('vendors/lists');
    List<FoodVendor> foodVendors = [];

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? session = preferences.getString("user_session");

      var queryParams = {
        'outlet_type': 'food',
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

      foodVendors.addAll(responseData.data.foodVendor!);

      return foodVendors;
    } on DioError catch (e) {
      print(e.message);
      return foodVendors;
    }
  }
}
