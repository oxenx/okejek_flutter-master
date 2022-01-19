import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/controller/auth/okeshop/okeshop_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ShoppingEstimasi extends StatelessWidget {
  ShoppingEstimasi({
    Key? key,
    required this.currencyFormatter,
  }) : super(key: key);

  final NumberFormat currencyFormatter;
  final DetailOrderShopController detailShopController = Get.find();
  final OkeShopController okeShopcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Generate Ongkir dan Jarak
        Obx(() {
          // detailShopController.setTotalPembayaran(okeShopcontroller.total.value);

          return detailShopController.pickUplocation.isNotEmpty && detailShopController.destLocation.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ongkir',
                          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
                        ),
                        Obx(
                          () => Text(
                            currencyFormatter.format(detailShopController.ongkir.value),
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 10 / 7.56,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jarak',
                          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
                        ),
                        Obx(
                          () => Text(
                            detailShopController.jarak.value.toString() + ' km',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 10 / 7.56,
                    ),
                  ],
                )
              : Container();
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Estimasi Total Belanja',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
            ),
            Obx(
              () => Text(
                currencyFormatter.format(okeShopcontroller.total.value),
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 10 / 7.56,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Estimasi Total Pembayaran',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
            ),
            Obx(
              () => Text(
                detailShopController.totalPembayaran.value == 0
                    ? currencyFormatter.format(okeShopcontroller.total.value)
                    : currencyFormatter.format(detailShopController.totalPembayaran.value),
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                  color: OkejekTheme.primary_color,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
