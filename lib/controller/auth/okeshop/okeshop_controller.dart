import 'package:get/get.dart';

class OkeShopController extends GetxController {
  // storing items to list
  var dummyData = [].obs;
  var total = 0.obs;

  void addItem(var mapData, int harga, int jumlah) {
    // add item to dummy data
    dummyData.add(mapData);

    // get total price per item
    int totalPerItem = harga * jumlah;

    // update total price
    total.value = total.value + totalPerItem;
  }

  void removeItem(int index) {
    // total harga yang dikurangi
    int removedTotal = dummyData[index]['harga'] * dummyData[index]['jumlah'];

    // hapus dari dummy data
    dummyData.removeAt(index);

    // remove action
    total.value = total.value - removedTotal;
  }
}
