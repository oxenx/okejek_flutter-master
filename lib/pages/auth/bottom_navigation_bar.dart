import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/api/user_controller.dart';
import 'package:okejek_flutter/controller/landing_controller.dart';
import 'package:okejek_flutter/controller/logout/logout_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/history/history_page.dart';
import 'package:okejek_flutter/pages/auth/home_page.dart';
import 'package:okejek_flutter/pages/auth/news/tabbar_news.dart';
import 'package:okejek_flutter/pages/auth/profile/profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavigation extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final LandingController landingController = Get.put(LandingController());
  final LogoutController logoutController = Get.put(LogoutController());

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      HistoryPage(),
      TabbarNews(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home_outlined,
          size: SizeConfig.safeBlockHorizontal * 6,
        ),
        textStyle: TextStyle(fontFamily: OkejekTheme.font_family, fontSize: SizeConfig.blockSizeHorizontal * 2.5),
        title: ("Home"),
        activeColorPrimary: OkejekTheme.primary_color,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.timer_outlined,
          size: SizeConfig.safeBlockHorizontal * 6,
        ),
        textStyle: TextStyle(fontFamily: OkejekTheme.font_family, fontSize: SizeConfig.blockSizeHorizontal * 2.5),
        title: ("Riwayat"),
        activeColorPrimary: OkejekTheme.primary_color,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.wysiwyg_outlined,
          size: SizeConfig.safeBlockHorizontal * 6,
        ),
        title: ("Berita"),
        textStyle: TextStyle(fontFamily: OkejekTheme.font_family, fontSize: SizeConfig.blockSizeHorizontal * 2.5),
        activeColorPrimary: OkejekTheme.primary_color,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person_outline,
          size: SizeConfig.safeBlockHorizontal * 6,
        ),
        title: ("Akun"),
        textStyle: TextStyle(fontFamily: OkejekTheme.font_family, fontSize: SizeConfig.blockSizeHorizontal * 2.5),
        activeColorPrimary: OkejekTheme.primary_color,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (landingController.isOutdated.value) showAlertUpdate();
    checkingSession();

    SizeConfig().init(context);
    return Scaffold(
      body: DoubleBack(
        message: "Tap lagi untuk keluar",
        textStyle: TextStyle(fontSize: 12, color: Colors.white),
        child: PersistentTabView(
          context,
          navBarHeight: SizeConfig.safeBlockHorizontal * 15,
          controller: landingController.controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          onItemSelected: (value) {
            landingController.changeCurrentTab(value);
          },
          navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
        ),
      ),
    );
  }

  void checkingSession() async {
    if (!await userController.checkingUserSession()) showSessionAlertUpdate();
  }

  void showAlertUpdate() {
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        // set up the button
        Widget okButton = TextButton(
          child: Text(
            "Update",
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            landingController.updateVersion();
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text(
            "Update",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Versi terbaru telah tersedia, silakan update aplikasi Okejek di PlayStore",
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
          ),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
    );
  }

  void showSessionAlertUpdate() {
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) {
        // set up the button
        Widget okButton = TextButton(
          child: Text(
            "Keluar",
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            logoutController.logout();
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text(
            "Sesi Habis",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Sesi anda telah berakhir. Silahkan login kembali untuk melanjutkan",
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
          ),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
    );
  }
}
