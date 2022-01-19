import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ShoppingDriverNote extends StatelessWidget {
  final TextEditingController driverNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DetailOrderShopController detailShopController = Get.find();
    return Obx(
      () => ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        reverse: true,
        children: [
          detailShopController.driverNote.value.isEmpty
              ? TextButton(
                  onPressed: () {
                    driverNoteDialog(detailShopController, context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: OkejekTheme.primary_color,
                        size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                      ),
                      Text(
                        'Pesan untuk driver',
                        style: TextStyle(
                          color: OkejekTheme.primary_color,
                          fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                      )
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    driverNoteDialog(detailShopController, context);
                  },
                  child: Container(
                    height: Get.height * 0.07,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 20 / 3.6),
                            child: Obx(
                              () => Text(
                                detailShopController.driverNote.value,
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
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
                            detailShopController.setDriverNote('');
                          },
                          icon: Icon(
                            Icons.close_outlined,
                            size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        ].reversed.toList(),
      ),
    );
  }

  Future<dynamic> driverNoteDialog(DetailOrderShopController detailShopController, BuildContext context) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          'Pesan untuk driver',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: driverNoteController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    SizeConfig.safeBlockHorizontal * 20 / 3.6,
                    SizeConfig.safeBlockHorizontal * 10 / 3.6,
                    SizeConfig.safeBlockHorizontal * 20 / 3.6,
                    SizeConfig.safeBlockHorizontal * 10 / 3.6),
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
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      color: OkejekTheme.primary_color,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (driverNoteController.text.isBlank!) {
                      Get.back();
                    } else {
                      detailShopController.setDriverNote(driverNoteController.text);
                      Get.back();
                    }
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
          ],
        ),
      ),
    );
  }
}
