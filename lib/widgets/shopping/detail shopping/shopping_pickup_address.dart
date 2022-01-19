import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okeshop/map_pickup_page.dart';

class ShoppigPickUpAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailOrderShopController detailShopController = Get.find();
    return GestureDetector(
      onTap: () {
        Get.to(() => MapPickUpPage());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.store_outlined,
            color: OkejekTheme.primary_color,
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal * 20 / 3.6,
          ),
          Obx(
            () {
              print(detailShopController.originLocation.value);
              print(detailShopController.originLocationDetail.value);
              return Container(
                height: detailShopController.originLocation.value.isEmpty ? Get.height * 0.06 : Get.height * 0.12,
                width: Get.width * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                  color: detailShopController.originLocation.value.isEmpty ? Colors.grey[100] : Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 15 / 3.6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => detailShopController.originLocation.value.isEmpty
                            ? Container()
                            : Text(
                                detailShopController.originLocation.value,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                softWrap: true,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                      ),
                      Obx(
                        () => Text(
                          detailShopController.originLocation.value.isEmpty
                              ? 'Tentukan lokasi belanja'
                              : detailShopController.originLocationDetail.value,
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
                      GestureDetector(
                        onTap: () => print('tambahkan catatan'),
                        child: Obx(
                          () => detailShopController.originLocationDetail.isEmpty &&
                                  detailShopController.originLocation.isNotEmpty
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.post_add,
                                      color: Colors.grey,
                                      size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                    ),
                                    Text(
                                      'Tambah detail alamat',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
