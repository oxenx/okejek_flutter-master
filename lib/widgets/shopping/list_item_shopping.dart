import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/controller/auth/okeshop/okeshop_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ListItemShopping extends StatelessWidget {
  final OkeShopController controller = Get.find();
  final DetailOrderShopController detailShopController = Get.find();

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: controller.dummyData.length,
              itemBuilder: (context, index) {
                var nama = controller.dummyData[index]['nama_barang'];
                var deskripsi = controller.dummyData[index]['deskripsi'];
                var jumlah = controller.dummyData[index]['jumlah'];
                var harga = controller.dummyData[index]['harga'];

                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockHorizontal * 5.56),
                      height: Get.height * 0.15,
                      width: Get.width,
                      // color: Colors.red,
                      child: Wrap(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nama,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockHorizontal * 1.389,
                                    ),
                                    Text(
                                      deskripsi,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: SizeConfig.safeBlockHorizontal * 2.78,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockHorizontal * 1.389,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Jumlah : ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          TextSpan(
                                            text: jumlah.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockHorizontal * 1.389,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: currencyFormatter.format(harga),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' (Estimasi)',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockHorizontal * 1.389,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currencyFormatter.format(jumlah * harga),
                                      style: TextStyle(
                                        color: OkejekTheme.primary_color,
                                        fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showAlertDelete(context, controller, index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: OkejekTheme.primary_color,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: Get.height * 0.2),
        ],
      ),
    );
  }

  void showToast(context, String text) async {
    await showTextToast(
      margin: EdgeInsets.only(bottom: SizeConfig.safeBlockHorizontal * 22.22),
      text: text,
      style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3.3),
      context: context,
    );
  }

  showAlertDelete(BuildContext context, OkeShopController controller, int index) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(
          color: OkejekTheme.primary_color,
        ),
      ),
      child: Text(
        "Batalkan",
        style: TextStyle(
          fontSize: 12,
          color: OkejekTheme.primary_color,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: OkejekTheme.primary_color,
      ),
      child: Text(
        "Hapus",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        controller.removeItem(index);
        Navigator.pop(context);
        showToast(context, 'Item telah dihapus');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hapus item?"),
      content: Text(
        "Kamu yakin ingin menghapus item ini?",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 3.3,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
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
}
