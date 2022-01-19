import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okeshop/okeshop_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ShoppingListCart extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    OkeShopController okeShopcontroller = Get.find();
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: okeShopcontroller.dummyData.length,
      itemBuilder: (context, index) {
        var nama = okeShopcontroller.dummyData[index]['nama_barang'];
        var jumlah = okeShopcontroller.dummyData[index]['jumlah'];
        var deskripsi = okeShopcontroller.dummyData[index]['deskripsi'];
        var harga = okeShopcontroller.dummyData[index]['harga'];
        return Column(
          children: [
            Row(
              children: [
                Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.85,
                  margin: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockHorizontal * 20 / 3.6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 10 / 3.6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                jumlah.toString(),
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      nama,
                                      style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockHorizontal * 5 / 3.6,
                                    ),
                                    Expanded(
                                      child: Text(
                                        deskripsi,
                                        style: TextStyle(
                                          fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                          color: Colors.black54,
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currencyFormatter.format(harga),
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Text(
                            currencyFormatter.format(harga * jumlah),
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              color: OkejekTheme.primary_color,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
