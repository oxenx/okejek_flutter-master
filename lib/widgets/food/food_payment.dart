import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okefood/detail_outlet_controller.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_payment_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/widgets/food/payment_info.dart';

class FoodPayment extends StatelessWidget {
  final FoodVendor foodVendor;
  final int type;
  FoodPayment({
    required this.type,
    required this.foodVendor,
  });

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  final TextEditingController promoController = TextEditingController();
  final DetailOutletController outletController = Get.find();
  final OkefoodPaymentController foodPaymentController = Get.find();

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // estimasi pembayaran
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimasi Total Belanja',
                  style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                ),
                Obx(
                  () => Text(
                    currencyFormatter.format(outletController.total.value),
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockHorizontal * 2.78,
            ),
            Obx(() => foodPaymentController.fetchSucess.value
                ? Entry.all(
                    opacity: 0,
                    scale: 1,
                    yOffset: 0,
                    xOffset: 100,
                    duration: Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ongkir',
                          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.33),
                        ),
                        Obx(
                          () => Text(
                            currencyFormatter.format(foodPaymentController.ongkir.value),
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3.33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()),
            SizedBox(
              height: SizeConfig.safeBlockHorizontal * 2.78,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimasi Total Pembayaran',
                  style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                ),
                Obx(
                  () => Text(
                    foodPaymentController.totalPembayaran.value == 0
                        ? currencyFormatter.format(outletController.total.value)
                        : currencyFormatter.format(foodPaymentController.totalPembayaran.value),
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                      color: OkejekTheme.primary_color,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // payment method
        PaymentSection(
          foodVendor: foodVendor,
          type: type,
        ),
      ],
    );
  }
}
