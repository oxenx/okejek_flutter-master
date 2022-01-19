import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/api/user_controller.dart';
import 'package:okejek_flutter/controller/auth/profile/profile_controller.dart';
import 'package:okejek_flutter/controller/logout/logout_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/pages/auth/profile/edit_profile_page.dart';
import 'package:okejek_flutter/pages/auth/profile/help_and_support_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final LogoutController logoutController = Get.find();
  final UserController userController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 30 / 7.56,
                      ),

                      // profile info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              maxRadius: SizeConfig.safeBlockHorizontal * 35 / 3.6,
                              backgroundColor: OkejekTheme.primary_color,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                          ),
                          Container(
                            height: Get.height * 0.14,
                            width: Get.width * 0.63,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    userController.name.value,
                                    style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal * 5 / 3.6,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      color: Colors.grey,
                                      size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                    ),
                                    Obx(
                                      () => Text(
                                        userController.email.value,
                                        style: TextStyle(
                                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                          color: Colors.black54,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.safeBlockHorizontal * 5 / 3.6,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      color: Colors.grey,
                                      size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                    ),
                                    Obx(
                                      () => Text(
                                        userController.contactMobile.value,
                                        style: TextStyle(
                                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                          color: Colors.black54,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Divider(),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 30 / 7.56,
                      ),
                      menuItem('Edit Profil', Icons.person_outline_outlined, () {
                        pushNewScreen(context, screen: EditProfilePage(), withNavBar: false);
                        profileController.resetController();
                      }),
                      menuItem('Bantuan dan Support', Icons.support_agent, () {
                        pushNewScreen(context, screen: HelpSupportPage(), withNavBar: false);
                      }),
                      becomeMerchant('Menjadi Merchant', () {
                        showAlertDialog(context);
                      }),

                      menuItem('Kebijakan Privasi', Icons.sticky_note_2_outlined, () {
                        profileController.openBrowserPrivacy();
                      }),
                      menuItem('Kebijakan Layanan', Icons.sticky_note_2_outlined, () {
                        profileController.openBrowserTermsAndCondition();
                      }),
                      logout(),
                      SizedBox(
                        height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: SizeConfig.safeBlockHorizontal * 50 / 3.6,
                left: SizeConfig.safeBlockHorizontal * 100 / 3.6,
                right: SizeConfig.safeBlockHorizontal * 100 / 3.6,
                child: Center(
                  child: Text(
                    'Versi Aplikasi 5.00',
                    style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6, color: Colors.black45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(String label, IconData icon, Function callback) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: OkejekTheme.primary_color,
                size: SizeConfig.safeBlockHorizontal * 30 / 3.6,
              ),
            ],
          ),
          title: Text(
            label,
            style: TextStyle(
              color: Colors.black54,
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            ),
          ),
          onTap: () => callback(),
        ),
      ],
    );
  }

  Widget becomeMerchant(String label, Function callback) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/icons/white/ic_service_merchant.png'),
                  ),
                ),
              )
            ],
          ),
          title: Text(
            label,
            style: TextStyle(
              // ignore: unrelated_type_equality_checks
              color: Colors.black54,
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            ),
          ),
          onTap: () => callback(),
        ),
      ],
    );
  }

  Widget logout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.exit_to_app_outlined,
                color: Colors.red,
                size: SizeConfig.safeBlockHorizontal * 30 / 3.6,
              ),
            ],
          ),
          title: Text(
            'Keluar',
            style: TextStyle(
              color: Colors.red,
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            ),
          ),
          onTap: () {
            showLogoutDialog();
          },
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget cancel = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ),
      onPressed: () {
        gotoMerchantWeb();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("OkeMerchant"),
      content: Text(
        "Silahkan download aplikasi OkeMerchant dari Playstore / Appstore",
        style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
      ),
      actions: [
        cancel,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLogoutDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Batalkan",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          color: Colors.black54,
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );

    Widget logoutButton = TextButton(
      child: Text(
        "Keluar",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          color: OkejekTheme.primary_color,
        ),
      ),
      onPressed: () {
        logoutController.logout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Keluar"),
      content: Text(
        "Keluar dari akun ini?",
        style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
      ),
      actions: [
        okButton,
        logoutButton,
      ],
    );

    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void gotoMerchantWeb() async {
    String url = OkejekBaseURL.registerMerchant;

    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
