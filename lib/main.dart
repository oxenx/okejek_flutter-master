import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/messages.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(OkejekApp());
  });
}

class OkejekApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      themeMode: ThemeMode.dark,
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      theme: setupTheme(),
      home: SplashPage(),
    );
  }

  ThemeData setupTheme() {
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: OkejekTheme.bg_color,
      textTheme: TextTheme(
        button: TextStyle(fontFamily: OkejekTheme.font_family, fontSize: OkejekTheme.font_size),
        headline1: TextStyle(fontFamily: OkejekTheme.font_family),
        headline3: TextStyle(fontFamily: OkejekTheme.font_family),
        headline4: TextStyle(fontFamily: OkejekTheme.font_family, color: Colors.black),
        bodyText1: TextStyle(
          fontFamily: OkejekTheme.font_family,
          // fontSize: OkejekTheme.font_size
        ),
        bodyText2: TextStyle(fontFamily: OkejekTheme.font_family, fontSize: OkejekTheme.font_size),
        subtitle1: TextStyle(
          fontFamily: OkejekTheme.font_family,
        ),
        subtitle2: TextStyle(
          fontFamily: OkejekTheme.font_family,
        ),
        caption: TextStyle(
          fontFamily: OkejekTheme.font_family,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(fontFamily: OkejekTheme.font_family, fontSize: OkejekTheme.font_size)),
    );
  }
}
