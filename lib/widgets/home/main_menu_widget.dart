import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/api/service_controller.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/controller/auth/okeexpress/oke_express_controller.dart';
import 'package:okejek_flutter/controller/landing_controller.dart';
import 'package:okejek_flutter/controller/okeride_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/defaults/url.dart';
import 'package:okejek_flutter/pages/auth/okecourier/okecourier_page.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/oke_express_page.dart';
import 'package:okejek_flutter/pages/auth/okefood/okefood_page.dart';
import 'package:okejek_flutter/pages/auth/okemart/okemart_page.dart';
import 'package:okejek_flutter/pages/auth/okeride/okeride_page.dart';
import 'package:okejek_flutter/pages/auth/okeshop/okeshop_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

/// Beberapa item menu pada halaman home
class MainMenu extends StatelessWidget {
  final OkeRideController okeRideController = Get.put(OkeRideController());
  final OkeExpressController okeExpressController = Get.put(OkeExpressController());
  final OkeCourierController okeCourierController = Get.put(OkeCourierController());
  final ServicesController servicesController = Get.put(ServicesController());
  final LandingController landingController = Get.find();

  bool get isRideAvailable => servicesController.isRideAvailable.value;
  bool get isFoodAvailable => servicesController.isFoodAvailable.value;
  bool get isShoppingAvailable => servicesController.isShoppingAvailable.value;
  bool get isCourierAvailable => servicesController.isCourierAvailable.value;
  bool get isMartAvailable => servicesController.isMartAvailable.value;
  bool get isTrikeCourierAvailable => servicesController.isTrikeCourierAvailable.value;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Obx(
      () => servicesController.isServicesAvailable.value ? availableService(context) : outofService(),
    );
  }

  Widget availableService(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Utama',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeHorizontal * 3.3,
              ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        GridView.count(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          mainAxisSpacing: SizeConfig.blockSizeVertical * 3,
          children: <Widget>[
            Obx(
              () => isRideAvailable
                  ? menuItem('Ride', Image.asset('assets/icons/10-2021/ride.png'), () {
                      okeRideController.resetController();
                      pushNewScreen(
                        context,
                        withNavBar: false,
                        screen: OkeRidePage(),
                      );
                    })
                  : Container(),
            ),
            Obx(
              () => isFoodAvailable
                  ? menuItem('Food', Image.asset('assets/icons/10-2021/food.png'), () {
                      pushNewScreen(
                        context,
                        withNavBar: false,
                        screen: OkeFoodPage(),
                      );
                    })
                  : Container(),
            ),
            Obx(
              () => isShoppingAvailable
                  ? menuItem('Shopping', Image.asset('assets/icons/10-2021/shopping.png'), () {
                      pushNewScreen(
                        context,
                        withNavBar: false,
                        screen: OkeShopPage(),
                      );
                    })
                  : Container(),
            ),
            Obx(() => isCourierAvailable
                ? menuItem('Courier', Image.asset('assets/icons/10-2021/courier.png'), () {
                    okeCourierController.resetController();
                    pushNewScreen(
                      context,
                      withNavBar: false,
                      screen: OkeCourierPage(),
                    );
                  })
                : Container()),
            Obx(() => isCourierAvailable
                ? menuItem('Express', Image.asset('assets/icons/10-2021/courier.png'), () {
                    okeExpressController.resiNumber.clear();
                    pushNewScreen(
                      context,
                      withNavBar: false,
                      screen: OkeExpressPage(),
                    );
                  })
                : Container()),
            Obx(() => isMartAvailable
                ? menuItem('Mart', Image.asset('assets/icons/10-2021/mart.png'), () {
                    pushNewScreen(
                      context,
                      withNavBar: false,
                      screen: OkeMartPage(),
                    );
                  })
                : Container()),
            Obx(() => isTrikeCourierAvailable
                ? menuItem('Bentor', Image.asset('assets/icons/10-2021/trike_courier.png'), () {})
                : Container()),
            menuItem('Driver', Image.asset('assets/icons/10-2021/driver.png'), () {
              gotoDriverWeb();
            }),
          ],
        ),
      ],
    );
  }

  Widget outofService() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Utama',
          style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeHorizontal * 3.3,
              ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        GridView.count(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          mainAxisSpacing: SizeConfig.blockSizeVertical * 3,
          children: <Widget>[
            menuItem('Ride', Image.asset('assets/icons/10-2021/ride.png'), () {}),
            menuItem('Food', Image.asset('assets/icons/10-2021/food.png'), () {}),
            menuItem('Shopping', Image.asset('assets/icons/10-2021/shopping.png'), () {}),
            menuItem('Courier', Image.asset('assets/icons/10-2021/courier.png'), () {}),
            menuItem('Express', Image.asset('assets/icons/10-2021/courier.png'), () {}),
            menuItem('Mart', Image.asset('assets/icons/10-2021/mart.png'), () {}),
            menuItem('Bentor', Image.asset('assets/icons/10-2021/trike_courier.png'), () {}),
            menuItem('Driver', Image.asset('assets/icons/10-2021/driver.png'), () {}),
          ],
        ),
      ],
    );
  }

  Widget menuItem(String menuLabel, Image image, Function action) {
    return InkWell(
      onTap: () => action(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(10),
              height: SizeConfig.safeBlockHorizontal * 45,
              width: SizeConfig.blockSizeVertical * 45,
              child: image,
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              menuLabel,
              style: TextStyle(
                color: Colors.black87,
                fontSize: SizeConfig.safeBlockHorizontal * 2.8,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gotoDriverWeb() async {
    String url = OkejekBaseURL.registerDriver;

    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
