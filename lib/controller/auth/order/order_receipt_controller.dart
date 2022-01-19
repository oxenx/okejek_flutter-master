import 'package:get/get.dart';

class OrderReceiptController extends GetxController {
  var orderDummyData = [
    {
      "service": "Okecourier",
      "pickup_location": {
        "latitude": -7.9615508,
        "longitude": 112.6309772,
        "address": "Jl. Tawangmangu No.23A, Lowokwaru, Kec. Lowokwaru, Kota Malang",
      },
      "destination_location": {
        "latitude": -8.0140047,
        "longitude": 112.6264473,
        "address": "Jodipan Malang",
      },
      "courier_detail_information": {
        "item_name": "Pupuk Kandang (20Kg)",
        "sender_name": "Sriwedari",
        "sender_phone": "081956833334",
        "receiver_name": "Puji Astuti",
        "receiver_phone": "081352552221",
      },
      "ongkir": 20000,
      "diskon": 5000,
      "total": 15000,
    },
  ].obs;

  var shoppingOrderDummyData = [
    {
      "service": "Okeshopping",
      "pickup_location": {
        "latitude": -7.9615508,
        "longitude": 112.6309772,
        "address": "Jl. Tawangmangu No.23A, Lowokwaru, Kec. Lowokwaru, Kota Malang",
      },
      "destination_location": {
        "latitude": -8.0140047,
        "longitude": 112.6264473,
        "address": "Jodipan Malang",
      },
      "shopping_detail_information": [
        {
          "nama_barang": "Kepiting Rebus",
          "jumlah": 2,
          "harga": 35000,
          "subtotal": 75000,
        },
        {
          "nama_barang": "Paha Ayam",
          "jumlah": 3,
          "harga": 18000,
          "subtotal": 54000,
        },
      ],
      "total_belanja": 129000,
      "ongkir": 15000,
      "diskon": 5000,
      "total": 139000,
    }
  ];

  var kecepatan = false.obs;
  var ketepatan = false.obs;
  var keramahan = false.obs;

  void onInit() {
    super.onInit();
  }

  void dipose() {
    super.onDelete();
  }

  void close() {
    super.onClose();
  }

  void resetController() {
    kecepatan.value = false;
    ketepatan.value = false;
    keramahan.value = false;
  }

  void changeValue(RxBool value) {
    value.value = !value.value;
  }
}
