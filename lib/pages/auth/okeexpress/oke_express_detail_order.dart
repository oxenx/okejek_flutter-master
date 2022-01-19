import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okeexpress/oke_express_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/oke_express_waiting_driver_page.dart';
import 'package:okejek_flutter/widgets/okeexpress/order_information.dart';
import 'package:okejek_flutter/widgets/okeexpress/order_payment.dart';

class OkeExpressDetailOrder extends StatelessWidget {
  final OkeExpressController okeExpressController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: OkejekTheme.primary_color,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Detail Order',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderInformation(),
                      OrderPayment(),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => OkeExpressWaitingDriver(), transition: Transition.rightToLeft);
                  okeExpressController.createOrder();
                },
                child: Container(
                  height: SizeConfig.safeBlockVertical * 50 / 7.2,
                  width: Get.width,
                  color: OkejekTheme.primary_color,
                  child: Center(
                    child: Text(
                      'Buat Pesanan',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
