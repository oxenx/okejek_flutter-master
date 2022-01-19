import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailOrderShopController extends GetxController {
  List<Marker> markers = [];

  var pickUplocation = ''.obs;
  var driverNote = ''.obs;
  var promoCode = 'Masukkan Promo'.obs;

  var isSubmitPickup = false.obs;
  var isSubmitDestination = false.obs;
  var isFecthingData = true.obs;
  var isGeneratePayment = false.obs;
  var isSubmitPromo = false.obs;

  var ongkir = 6500.obs;
  var jarak = 2.obs;
  var totalPembayaran = 0.obs;

  var pickUpLat = 0.0.obs;
  var pickUpLng = 0.0.obs;

  var originLat = 0.0.obs;
  var originLng = 0.0.obs;
  var originLocation = ''.obs;
  var originLocationDetail = ''.obs;
  var destLat = 0.0.obs;
  var destLng = 0.0.obs;
  var destLocation = ''.obs;
  var destLocationDetail = ''.obs;

  var dropDownValue = 'Cash'.obs;
  var dropDownValueList = [
    'Cash',
    'OkePoint',
    'Link Aja',
    'Shopee Pay',
  ];

  void initState() {
    super.onInit();
    print(totalPembayaran.value);
  }

  void delete() {
    resetController();
    super.onDelete();
  }

  void setDriverNote(String value) {
    driverNote.value = value;
  }

  void addMarker(String value, double lat, double lng) {
    markers.add(
      Marker(
        markerId: MarkerId(value + ' location'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: value + ' location'),
      ),
    );

    print('added marker to ' + lat.toString() + ' ' + lng.toString());
    print(markers);
  }

  void setTotalPembayaran(int totalBelanja) {
    totalPembayaran.value = ongkir.value + totalBelanja;
    print('total pembayaran : ' + totalPembayaran.value.toString());
  }

  void setDestCoordinates(double lat, double lng) {
    destLat.value = lat;
    destLng.value = lng;

    addMarker('destination', destLat.value, destLng.value);
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

  void setDestLocation(String value) {
    destLocation.value = value;
  }

  void changeGeneratePayment() {
    isGeneratePayment.value = true;
  }

  void resetController() {
    pickUplocation.value = '';
    destLocation.value = '';
    isSubmitPickup.value = false;
    isSubmitDestination.value = false;
    isGeneratePayment.value = false;
    isSubmitPromo.value = false;
    totalPembayaran.value = 0;
    dropDownValue.value = 'Cash';
    promoCode.value = 'Masukkan Promo';
    driverNote.value = '';
    pickUpLat.value = 0.0;
    pickUpLng.value = 0.0;
    destLat.value = 0.0;
    destLng.value = 0.0;
  }

  void setDropdownValue(var value) {
    dropDownValue.value = value;
    print('dropdownvalue changed to : ' + dropDownValue.value.toString());
  }

  void changeSubmitPromo(bool value) {
    isSubmitPromo.value = value;
    print('changed submit promo to ' + isSubmitPromo.value.toString());
  }

  void setPromoCode(String value) {
    promoCode.value = value;
  }

  Future<bool> fetchDataPayment(int totalBelanja) => Future.delayed(
        Duration(seconds: 2),
        () {
          setTotalPembayaran(totalBelanja);
          isFecthingData.value = false;
          return isFecthingData.value;
        },
      );

  Future<bool> fetchDataDestination() => Future.delayed(
        Duration(seconds: 3),
        () {
          isFecthingData.value = false;
          return isFecthingData.value;
        },
      );
}
