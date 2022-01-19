import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/models/auth/food/menu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailOutletController extends GetxController {
  Dio dio = Dio();
  var cartQtyMap = {}.obs;
  var itemMap = {}.obs;
  var cartList = [].obs;
  var indexList = [].obs;
  var total = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void delete() {
    super.onDelete();
  }

  void addToCart(int id, int price, Menu menu) {
    // add to cart with qty = 1
    print('tambahkan barang ke dalam keranjang');

    total.value = total.value + price;

    cartQtyMap.putIfAbsent(id, () => 1);
    itemMap.putIfAbsent(id, () => menu);

    indexList.add(id);
    print(cartQtyMap);
    print(itemMap);
    print(indexList);
  }

  void removeFromCart(int id, int price, Menu menu) {
    print('hapus barang dari keranjang');
    cartQtyMap.remove(id);
    itemMap.removeWhere((key, value) => key == id);
    total.value = total.value - price;

    indexList.remove(id);
  }

  void addQtyItem(int id, int price) {
    cartQtyMap.update(id, (value) => ++value);
    total.value = total.value + price;
    print('tambahkan qty barang');
    print(cartQtyMap);
    print(itemMap);
    print(indexList);
  }

  void subsQtyItem(int id, int price) {
    cartQtyMap.update(id, (value) => --value);
    total.value = total.value - price;
    print('kurangi qty barang');
    print(cartQtyMap);
    print(itemMap);
    print(indexList);

    cartQtyMap.keys.forEach((element) {
      print(element);
    });
  }

  Future<FoodVendor?> getDetailOutlet(id) async {
    // String url = OkejekBaseURL.getDetailOutlet(id);
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
      FoodVendor foodVendor = FoodVendor.fromJson(responseBody['data']['food_vendor']);

      return foodVendor;
    } on DioError catch (e) {
      print(e.message);
      return null;
    }
  }
}
