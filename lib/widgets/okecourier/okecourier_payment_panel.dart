import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/okecourier/loading_payment_shimmer.dart';
import 'package:okejek_flutter/widgets/okecourier/okecourier_payment_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OkeCourierPaymentPanel extends StatelessWidget {
  final PanelController pc;
  final TextEditingController namaPengirimController;
  final TextEditingController namaPenerimaController;
  final TextEditingController noHPPengirimController;
  final TextEditingController noHPPenerimaController;
  final TextEditingController detailBarangController;

  OkeCourierPaymentPanel({
    required this.pc,
    required this.detailBarangController,
    required this.namaPenerimaController,
    required this.namaPengirimController,
    required this.noHPPenerimaController,
    required this.noHPPengirimController,
  });

  final OkeCourierController okeCourierController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical * 30 / 7.2,
            ),
            information(
              Colors.orange,
              'Pengirim',
              namaPengirimController.text,
              noHPPengirimController.text,
              detailBarangController.text,
              okeCourierController.originLocation.value,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 30 / 7.2,
            ),
            information(
              OkejekTheme.primary_color,
              'Penerima',
              namaPenerimaController.text,
              noHPPenerimaController.text,
              '',
              okeCourierController.destinationLocation.value,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 10 / 7.2,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: OkejekTheme.primary_color,
                    size: 15,
                  ),
                  Text(
                    ' Tambah catatan',
                    style: TextStyle(
                      color: OkejekTheme.primary_color,
                      fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 10 / 7.2,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 10 / 7.2,
            ),
            Obx(() => okeCourierController.isLoading.value ? LoadingPaymentShimmer() : OkeCourierPaymentButton()),
          ],
        ),
      ),
    );
  }

  Widget information(Color color, String label, String nama, String noHP, String detailBarang, String alamat) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Icon(
              Icons.location_on_outlined,
              color: color,
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                ),
                Text(
                  '$nama $noHP',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10 / 7.2,
                ),
                detailBarang.isEmpty
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 10 / 7.2,
                          ),
                          Text(
                            'Detail Barang : $detailBarang',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                Text(
                  '$alamat',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10 / 7.2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
