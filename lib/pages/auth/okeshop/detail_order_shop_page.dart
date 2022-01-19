import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/controller/auth/okeshop/okeshop_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/shopping/detail%20shopping/shopping_destionation_address.dart';
import 'package:okejek_flutter/widgets/shopping/detail%20shopping/shopping_driver_note.dart';
import 'package:okejek_flutter/widgets/shopping/detail%20shopping/shopping_estimasi.dart';
import 'package:okejek_flutter/widgets/shopping/detail%20shopping/shopping_list_cart.dart';
import 'package:okejek_flutter/widgets/shopping/detail%20shopping/shopping_map_route.dart';
import 'package:okejek_flutter/widgets/shopping/detail%20shopping/shopping_payment_method.dart';
import 'package:okejek_flutter/widgets/shopping/detail%20shopping/shopping_pickup_address.dart';
import 'package:okejek_flutter/widgets/shopping/empty_cart_shopping.dart';

class DetailOrderShopPage extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);

  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-7.9826145, 112.6286226),
    zoom: 12.0,
  );

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destiController = TextEditingController();
  final TextEditingController promoController = TextEditingController();
  final TextEditingController driverNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OkeShopController okeShopController = Get.find();
    DetailOrderShopController detailShopController = Get.find();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Detail Shopping',
          style: TextStyle(
            fontFamily: OkejekTheme.font_family,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: SizeConfig.safeBlockHorizontal * 40 / 3.6,
            width: SizeConfig.safeBlockHorizontal * 40 / 3.6,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: OkejekTheme.primary_color,
              ),
            ),
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // daftar belanja
              okeShopController.dummyData.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: EmptyCartShopping(),
                    )
                  : listItem(context, okeShopController, detailShopController),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(
      BuildContext context, OkeShopController okeShopcontroller, DetailOrderShopController detailShopController) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailShopController.pickUplocation.value.isNotEmpty && detailShopController.destLocation.value.isNotEmpty
              ? ShoppingMapRoute(kInitialPosition: _kInitialPosition, controller: _controller)
              : Container(),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // pickup
                ShoppigPickUpAddress(),

                Obx(
                  () => SizedBox(
                    height:
                        detailShopController.originLocation.value.isEmpty ? SizeConfig.safeBlockVertical * 20 / 7.2 : 0,
                  ),
                ),
                // destionation
                ShoppingDestinationAddress(),

                SizedBox(
                  height: Get.height * 0.05,
                ),
                Text(
                  'Daftar Belanja',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    color: Colors.black45,
                  ),
                ),

                // item list
                ShoppingListCart(),

                // pesan untuk driver
                ShoppingDriverNote(),

                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                ),

                // total estimasi
                ShoppingEstimasi(currencyFormatter: currencyFormatter),

                // payment method
                ShoppingPaymentMethod(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
