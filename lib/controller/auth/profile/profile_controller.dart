import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:okejek_flutter/controller/api/user_controller.dart';
import 'package:okejek_flutter/defaults/okejek_strings.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  Dio dio = Dio();
  UserController userController = Get.find();
  var isLoading = false.obs;
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var contactPhone = ''.obs;

  void onInit() {
    super.onInit();
  }

  void ondelete() {
    super.onClose();
  }

  void resetController() {
    name.value = '';
    email.value = '';
    password.value = '';
    contactPhone.value = '';
    isLoading.value = false;
  }

  void editProfil() async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? session = preferences.getString("user_session");

    String? data = preferences.getString('user_data');
    var userData = jsonDecode(data!);
    print(userData);

    try {
      String url = OkejekBaseURL.apiUrl('profile/edit');

      var queryParams = {
        'api_token': session,
      };

      var data = {
        "name": '${name.value}',
        "email": '${email.value}',
        "password": '${password.value}',
        "contact_phone": '${contactPhone.value}',
      };

      FormData formData = FormData.fromMap(data);

      var response = await dio.post(
        url,
        queryParameters: queryParams,
        data: formData,
        options: Options(
          headers: {
            'Accepts': 'application/json',
          },
        ),
      );

      print(response.data);
      String jsonResponse = jsonEncode(response.data);
      preferences.setString('user_data', jsonResponse);
      userController.getUser();
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void openBrowserPrivacy() async {
    String url = OkejekBaseURL.privacyPolicy;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openBrowserTermsAndCondition() async {
    String url = OkejekBaseURL.termsCondition;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchWhatsApp() async {
    String message = 'Halo, Admin';
    String number = OkejekStrings.information_phone_number;

    String url = OkejekBaseURL.whatsAppUrl(number, message);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchTelegram() async {
    String url = OkejekBaseURL.telegram;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmail() async {
    // final mailto = Mailto(
    //   to: ['info@okejek.id'],
    // );
    String email = OkejekStrings.information_email;

    await launch('mailto:$email');
  }

  void makeCall() async {
    String phoneNumber = OkejekStrings.information_phone_number;

    launch('tel://$phoneNumber');
  }
}
