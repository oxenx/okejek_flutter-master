import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/okefood/detail_outlet_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/food/menu_model.dart';

/// Berisi list untuk menampilkan daftar belanja
class CartList extends StatelessWidget {
  final DetailOutletController outletController = Get.find();
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Belanja',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 3.3,
            color: Colors.black45,
          ),
        ),
        ListView.builder(
          itemCount: outletController.itemMap.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            Menu menu = outletController.itemMap[outletController.indexList[index]];
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: Get.height * 0.1,
                      width: Get.width * 0.85,
                      margin: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockHorizontal * 5.56),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // qty items
                                  Text(
                                    outletController.cartQtyMap[outletController.indexList[index]].toString(),
                                    style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.safeBlockHorizontal * 8.3,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          menu.name,
                                          style: TextStyle(
                                            fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            menu.description,
                                            style: TextStyle(
                                              fontSize: SizeConfig.safeBlockHorizontal * 2.8,
                                              color: Colors.black54,

                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 2,
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
                            width: SizeConfig.safeBlockHorizontal * 2.8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currencyFormatter.format(menu.price),
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                currencyFormatter.format(
                                  menu.price * outletController.cartQtyMap[outletController.indexList[index]],
                                ),
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 3.3,
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
        ),
      ],
    );
  }
}
