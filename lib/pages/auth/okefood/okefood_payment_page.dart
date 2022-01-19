import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okefood/detail_outlet_controller.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_payment_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';
import 'package:okejek_flutter/widgets/food/food_payment.dart';
import 'package:okejek_flutter/widgets/food/cart_list.dart';
import 'package:okejek_flutter/widgets/food/detail_outlet_payment.dart';

class OkeFoodPaymentPage extends StatelessWidget {
  final int type;
  final FoodVendor foodVendor;
  final int totalBelanja;
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  final TextEditingController driverNoteController = TextEditingController();

  OkeFoodPaymentPage({
    required this.totalBelanja,
    required this.foodVendor,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    // parsing outlet lat lng to double
    final outletLatLng = foodVendor.latlng.split(",");
    double outletLat = double.parse(outletLatLng[0]);
    double outletLng = double.parse(outletLatLng[1]);

    DetailOutletController outletController = Get.find();
    OkefoodPaymentController foodPaymentController = Get.put(OkefoodPaymentController(
      outletLat: outletLat,
      outletLng: outletLng,
      totalBelanja: totalBelanja,
    ));
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Rincian Pesanan',
          style: TextStyle(
            fontFamily: OkejekTheme.font_family,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 5,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: SizeConfig.safeBlockVertical * 5.3,
            width: SizeConfig.safeBlockHorizontal * 11.11,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5.56),
            child: outletController.cartQtyMap.length == 0
                ? SizedBox()
                : itemList(outletController, foodPaymentController, context),
          ),
        ),
      ),
    );
  }

  Widget itemList(
      DetailOutletController outletController, OkefoodPaymentController foodPaymentController, BuildContext context) {
    return Column(
      children: [
        // outlet information
        Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailOutletPayment(addressOutlet: foodVendor.address, nameOutlet: foodVendor.name),
              CartList(),

              // pesan driver
              Obx(
                () => ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  reverse: true,
                  children: [
                    foodPaymentController.driverNote.value.isEmpty
                        ? TextButton(
                            onPressed: () {
                              driverNoteDialog(foodPaymentController, context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  color: OkejekTheme.primary_color,
                                  size: SizeConfig.safeBlockHorizontal * 4.1,
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 2.78,
                                ),
                                Text(
                                  'Pesan untuk driver',
                                  style: TextStyle(
                                    color: OkejekTheme.primary_color,
                                    fontSize: SizeConfig.safeBlockHorizontal * 2.78,
                                  ),
                                )
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              driverNoteDialog(foodPaymentController, context);
                            },
                            child: Container(
                              height: Get.height * 0.07,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 2.64),
                                      child: Obx(
                                        () => Text(
                                          foodPaymentController.driverNote.value,
                                          style: TextStyle(
                                            fontSize: SizeConfig.safeBlockHorizontal * 3.33,
                                            color: Colors.black54,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      driverNoteController.clear();
                                      foodPaymentController.setDriverNote('');
                                    },
                                    icon: Icon(
                                      Icons.close_outlined,
                                      size: SizeConfig.safeBlockHorizontal * 4.167,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                  ].reversed.toList(),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3.96,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3.96,
              ),
              FoodPayment(
                type: type,
                foodVendor: foodVendor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> driverNoteDialog(OkefoodPaymentController foodPaymentController, BuildContext context) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          'Pesan untuk driver',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 4.1,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: driverNoteController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    SizeConfig.safeBlockHorizontal * 5.56,
                    SizeConfig.safeBlockHorizontal * 2.78,
                    SizeConfig.safeBlockHorizontal * 5.56,
                    SizeConfig.safeBlockHorizontal * 2.78),
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
              height: SizeConfig.blockSizeVertical * 3.96,
            ),
            Row(
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
                    if (driverNoteController.text.isBlank!) {
                      Get.back();
                    } else {
                      foodPaymentController.setDriverNote(driverNoteController.text);
                      Get.back();
                    }
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
          ],
        ),
      ),
    );
  }
}
