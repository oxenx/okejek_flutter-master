import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_payment_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okefood/map_okefood_page.dart';

/// Detail outlet yang menampilkan nama dan alamat resto / mart
class DetailOutletPayment extends StatelessWidget {
  final String nameOutlet;
  final String addressOutlet;

  DetailOutletPayment({
    required this.addressOutlet,
    required this.nameOutlet,
  });

  final OkefoodPaymentController foodPaymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          height: SizeConfig.safeBlockVertical * 70 / 7.2,
          child: Row(
            children: [
              Icon(
                Icons.store_outlined,
                color: OkejekTheme.primary_color,
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 5.56,
              ),

              // outlet info
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameOutlet,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockHorizontal * 2.8,
                    ),
                    Text(
                      addressOutlet,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 2.8,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 1.3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2.64,
        ),

        // tujuan
        Container(
          height: SizeConfig.safeBlockVertical * 70 / 7.2,
          child: Row(
            children: [
              Icon(
                Icons.pin_drop_outlined,
                color: OkejekTheme.primary_color,
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 5.56,
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => MapOkeFoodPage());
                  },
                  child: Obx(
                    () => Container(
                      height: Get.height * 0.06,
                      width: Get.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: foodPaymentController.destLocation.value.isEmpty ? Colors.grey[100] : Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: foodPaymentController.destLocation.value.isEmpty
                              ? SizeConfig.safeBlockHorizontal * 20 / 3.6
                              : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                foodPaymentController.destLocation.value.isEmpty
                                    ? 'Tentukan lokasi tujuan'
                                    : foodPaymentController.destLocation.value,
                                style: TextStyle(
                                  fontSize: foodPaymentController.destLocation.value.isEmpty
                                      ? SizeConfig.safeBlockHorizontal * 10 / 3.6
                                      : SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                  color:
                                      foodPaymentController.destLocation.value.isEmpty ? Colors.black45 : Colors.black,
                                  fontWeight: foodPaymentController.destLocation.value.isEmpty
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                softWrap: true,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Obx(
                              () => foodPaymentController.destLocation.value.isEmpty
                                  ? SizedBox()
                                  : SizedBox(
                                      height: SizeConfig.safeBlockHorizontal * 2.8,
                                    ),
                            ),
                            Obx(
                              () => foodPaymentController.destLocation.value.isEmpty
                                  ? SizedBox()
                                  : Obx(
                                      () => foodPaymentController.destinationAddress.value.isEmpty
                                          ? GestureDetector(
                                              onTap: () {
                                                print('tambahkan detail alamat');
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.post_add,
                                                    size: 15,
                                                    color: Colors.black54,
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                                  ),
                                                  Text(
                                                    'Tambahkan detail alamat dsini',
                                                    style: TextStyle(
                                                      fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                                      color: Colors.black45,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    softWrap: true,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text(
                                              foodPaymentController.destinationAddress.value,
                                              style: TextStyle(
                                                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                                color: Colors.black45,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              softWrap: true,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                            ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: Get.height * 0.05,
        ),
      ],
    );
  }
}
