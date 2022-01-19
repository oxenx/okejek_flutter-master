import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/okeride_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:shimmer/shimmer.dart';

/// Widget yang berkaitan dengan pembayaran Okeride
class PaymentSectionRide extends StatelessWidget {
  final TextEditingController promoController = TextEditingController();
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    OkeRideController okeRideController = Get.find();
    SizeConfig().init(context);
    return Obx(
      () => okeRideController.originLocation.value.isNotEmpty && okeRideController.destLocation.value.isNotEmpty
          ? FutureBuilder(
              future: okeRideController.fetchDataPayment(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return loadingPayment();
                } else {
                  return Obx(
                    () => okeRideController.fetchSucess.value
                        ? Column(
                            children: [
                              Divider(thickness: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pembayaran : ',
                                    style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                                  ),

                                  // dropdown
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            'Pilih Metode',
                                            style: TextStyle(
                                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                            ),
                                          ),
                                          // onTap: () => okeRideController.queryAppsinstalled(),
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
                                    ],
                                  ),
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
                                    'Kode Kupon : ',
                                    style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      okeRideController.changeSubmitPromo(false);
                                      dialog(okeRideController, context);
                                    },
                                    child: Obx(
                                      () => Text(
                                        okeRideController.couponCode.value.isEmpty
                                            ? 'Masukkan Kupon'
                                            : okeRideController.couponCode.value,
                                        style: TextStyle(
                                          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                          color: OkejekTheme.primary_color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total : ',
                                    style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
                                  ),

                                  // if coupon is applied
                                  Obx(
                                    () => okeRideController.price.value != 0
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Entry.all(
                                                opacity: 0,
                                                scale: 1,
                                                yOffset: 0,
                                                xOffset: 100,
                                                duration: Duration(milliseconds: 500),
                                                child: Text(
                                                  currencyFormatter.format(okeRideController.originPrice.value),
                                                  style: TextStyle(
                                                    fontSize: SizeConfig.safeBlockHorizontal * 2.7,
                                                    decoration: TextDecoration.lineThrough,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: SizeConfig.safeBlockHorizontal * 2.7,
                                              ),
                                              Entry.all(
                                                opacity: 0,
                                                scale: 1,
                                                yOffset: 0,
                                                xOffset: 100,
                                                delay: Duration(milliseconds: 500),
                                                duration: Duration(milliseconds: 500),
                                                child: Text(
                                                  currencyFormatter.format(okeRideController.price.value),
                                                  style: TextStyle(
                                                    fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                                                    fontWeight: FontWeight.bold,
                                                    color: OkejekTheme.primary_color,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Entry.all(
                                            opacity: 0,
                                            scale: 1,
                                            yOffset: 0,
                                            xOffset: 100,
                                            child: Text(
                                              currencyFormatter.format(okeRideController.originPrice.value),
                                              style: TextStyle(
                                                fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Obx(
                                () => okeRideController.isSubmitOrder.value
                                    ? Center(
                                        child: Container(
                                          height: SizeConfig.safeBlockHorizontal * 2.7,
                                          width: SizeConfig.safeBlockHorizontal * 2.7,
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          okeRideController.createOrder(showAlertDialog);
                                          // showAlertDialog(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(Get.width, Get.height * 0.06),
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
                              )
                            ],
                          )
                        : loadingPayment(),
                  );
                }
              },
            )
          : Container(),
    );
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Pesanan Gagal",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Tidak dapat melakukan pesanan saat ini dikarenakan $message",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget loadingPayment() {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE7E7E7),
          Color(0xFFF4F4F4),
          Color(0xFFE7E7E7),
        ],
        stops: [
          0.4,
          0.5,
          0.6,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.8),
        tileMode: TileMode.clamp,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => Column(
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 5 / 3.6,
                ),
                Divider(thickness: 1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.02,
                      width: Get.width * 0.45,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: Get.height * 0.02,
                      width: Get.width * 0.1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.06,
          ),
          Container(
            height: Get.height * 0.05,
            width: Get.width,
            color: Colors.grey[100],
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialog(OkeRideController okeRideController, BuildContext context) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          'Masukkan Kode Kupon',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: promoController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Contoh : KUPON17',
                hintStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Obx(
              () => okeRideController.isSubmitPromo.value
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
                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                              color: OkejekTheme.primary_color,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            okeRideController.changeSubmitPromo(true);
                            Future.delayed(Duration(seconds: 3), () {
                              okeRideController.changeSubmitPromo(false);
                              okeRideController.getCouponCode(promoController.text);
                              Get.back();
                            });
                          },
                          child: Text(
                            'Masukkan',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
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
}
