import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:okejek_flutter/pages/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  void logout() async {
    GoogleSignIn().signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.offAll(() => LandingPage());
    prefs.remove('user_data');
    prefs.remove('user_session');
  }
}
