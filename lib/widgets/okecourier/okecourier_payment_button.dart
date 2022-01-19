import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/controller/okeride_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OkeCourierPaymentButton extends StatelessWidget {
  final OkeRideController okeRideController = Get.put(OkeRideController());
  final OkeCourierController okeCourierController = Get.find();
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        SizedBox(height: SizeConfig.safeBlockVertical * 20 / 7.2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ongkir : ',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
            ),
            Text(
              currencyFormatter.format(okeCourierController.ongkir.value),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 3.89,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Metode Pembayaran : ',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
            ),

            // dropdown
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: OkejekTheme.primary_color,
                  size: SizeConfig.safeBlockHorizontal * 4.1,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 2.78,
                ),
                Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        'Pilih Metode',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                        ),
                      ),
                      iconEnabledColor: OkejekTheme.primary_color,
                      style: TextStyle(
                        color: OkejekTheme.primary_color,
                        fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                      ),
                      value: okeRideController.dropDownValue.value,
                      items: <String>[
                        'Cash',
                        'OkePoint',
                        'Link Aja',
                        'Shopee Pay',
                        'Faspay',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        okeRideController.setDropdownValue(value);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(
          () => FutureBuilder<bool>(
            future: okeRideController.queryAppsinstalled(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 10,
                  width: 10,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return snapshot.data!
                    ? SizedBox()
                    : Entry.all(
                        duration: Duration(milliseconds: 500),
                        xOffset: 50,
                        yOffset: 0,
                        scale: 1,
                        opacity: 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.orange,
                                  size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                ),
                                Text(
                                  'Aplikasi belum terinstall',
                                  style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kode Promo : ',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Masukkan Kode Promo',
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                  color: OkejekTheme.primary_color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.safeBlockVertical * 1.3),
        ElevatedButton(
          onPressed: () {
            print(okeCourierController.originLat);
            print(okeCourierController.originLng);
            print(okeCourierController.originLocation);
            print(okeCourierController.destinationLat);
            print(okeCourierController.destinationLng);
            print(okeCourierController.destinationLocation);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, SizeConfig.safeBlockVertical * 5.2),
            primary: OkejekTheme.primary_color,
          ),
          child: Text(
            'Pesan Sekarang',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            ),
          ),
        ),
      ],
    );
  }
}
