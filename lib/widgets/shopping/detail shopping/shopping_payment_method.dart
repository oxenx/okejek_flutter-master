import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/controller/auth/okeshop/okeshop_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ShoppingPaymentMethod extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  final TextEditingController promoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    OkeShopController okeShopcontroller = Get.find();
    DetailOrderShopController detailShopController = Get.find();
    return Obx(
      () => detailShopController.pickUplocation.isNotEmpty && detailShopController.destLocation.isNotEmpty
          ? FutureBuilder(
              future: detailShopController.fetchDataPayment(okeShopcontroller.total.value),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                      ),
                      LinearProgressIndicator(),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 30 / 3.6,
                      ),
                    ],
                  ));
                } else {
                  return Column(
                    children: [
                      SizedBox(height: SizeConfig.safeBlockVertical * 15 / 7.56),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * 10 / 7.56),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Metode Pembayaran : ',
                            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
                          ),

                          // dropdown
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: OkejekTheme.primary_color,
                                size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                              ),
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                              ),
                              Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      'Pilih Metode',
                                      style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                      ),
                                    ),
                                    iconEnabledColor: OkejekTheme.primary_color,
                                    style: TextStyle(
                                      color: OkejekTheme.primary_color,
                                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                    ),
                                    value: detailShopController.dropDownValue.value,
                                    items: <String>[
                                      'Cash',
                                      'OkePoint',
                                      'Link Aja',
                                      'Shopee Pay',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      detailShopController.setDropdownValue(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kode Promo : ',
                            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
                          ),
                          TextButton(
                            onPressed: () {
                              detailShopController.changeSubmitPromo(false);
                              dialog(detailShopController, context);
                            },
                            child: Obx(
                              () => Text(
                                detailShopController.promoCode.value.isEmpty
                                    ? 'Masukkan Kode Promo'
                                    : detailShopController.promoCode.value,
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                  color: OkejekTheme.primary_color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * 10 / 7.56),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total : ',
                            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
                          ),
                          Text(
                            currencyFormatter.format(detailShopController.totalPembayaran.value),
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 30 / 7.56,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, SizeConfig.safeBlockVertical * 40 / 7.56),
                          primary: OkejekTheme.primary_color,
                        ),
                        child: Text(
                          'Pesan Sekarang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.56,
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            )
          : Container(),
    );
  }

  Future<dynamic> dialog(DetailOrderShopController detailShopController, BuildContext context) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          'Masukkan Kode Promo',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: promoController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    SizeConfig.safeBlockHorizontal * 20 / 3.6,
                    SizeConfig.safeBlockHorizontal * 10 / 3.6,
                    SizeConfig.safeBlockHorizontal * 20 / 3.6,
                    SizeConfig.safeBlockHorizontal * 10 / 3.6),
                hintText: 'Contoh : KODEPROMO17',
                hintStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
            ),
            Obx(
              () => detailShopController.isSubmitPromo.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(
                              color: OkejekTheme.primary_color,
                            ),
                          ),
                          child: Text(
                            'Batalkan',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              color: OkejekTheme.primary_color,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            detailShopController.changeSubmitPromo(true);
                            Future.delayed(Duration(seconds: 3), () {
                              detailShopController.changeSubmitPromo(false);
                              detailShopController.setPromoCode(promoController.text);
                              Get.back();
                              showSnackbar(context);
                            });
                          },
                          child: Text(
                            'Masukkan',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green[400],
        content: Text(
          'Kode Promo berhasil digunakan',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          ),
        ),
        behavior: SnackBarBehavior.floating, // Add this line
      ),
    );
  }
}
