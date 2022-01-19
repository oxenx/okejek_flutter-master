import 'package:get/get.dart';

class HomeController extends GetxController {
  var carouselIndex = 0.obs;

  void changeTabIndex(int index) {
    carouselIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
  }

  void dispose() {
    super.dispose();
  }
}
