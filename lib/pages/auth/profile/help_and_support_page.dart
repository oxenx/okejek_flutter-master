import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/profile/profile_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: OkejekTheme.primary_color,
          ),
        ),
        title: Text(
          'Bantuan dan Support',
          style: TextStyle(
            fontFamily: OkejekTheme.font_family,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
            child: Column(
              children: [
                Text(
                  'Untuk mempermudah dalam komunikasi, kami menyarankan untuk menghubungi kami melalui:',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                ),
                ListTile(
                  onTap: () {
                    profileController.launchWhatsApp();
                  },
                  leading: Container(
                    height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/icons/other/whatsapp_icon.png'),
                      ),
                    ),
                  ),
                  title: Text(
                    'WhatsApp',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                ),
                ListTile(
                  onTap: () {
                    profileController.launchTelegram();
                  },
                  leading: Container(
                    height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/icons/other/telegram_icon.png'),
                      ),
                    ),
                  ),
                  title: Text(
                    'Telegram',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                ),
                ListTile(
                  onTap: () {
                    profileController.launchEmail();
                  },
                  leading: Container(
                    height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    child: Icon(
                      Icons.email,
                      color: OkejekTheme.primary_color,
                    ),
                  ),
                  title: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                ),
                ListTile(
                  onTap: () {
                    profileController.makeCall();
                  },
                  leading: Container(
                    height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.phone,
                      color: OkejekTheme.primary_color,
                      size: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                    ),
                  ),
                  title: Text(
                    'Telepon',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
