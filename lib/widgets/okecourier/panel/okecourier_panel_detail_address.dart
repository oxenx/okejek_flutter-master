import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OkeCourierPanelDetailAddress extends StatelessWidget {
  OkeCourierPanelDetailAddress({
    required this.isOriginSection,
    required this.okeCourierController,
  });

  final bool isOriginSection;
  final OkeCourierController okeCourierController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: SizeConfig.safeBlockVertical * 60 / 7.2,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isOriginSection
              ? okeCourierController.originLocation.value.isEmpty
                  ? Colors.grey[100]
                  : Colors.white
              : okeCourierController.destinationLocation.value.isEmpty
                  ? Colors.grey[100]
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: isOriginSection ? Colors.orange : OkejekTheme.primary_color,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => isOriginSection
                            ? okeCourierController.originLocation.value.isEmpty
                                ? Text(
                                    'Pilih Lokasi...',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                    ),
                                  )
                                : Text(
                                    okeCourierController.originLocation.value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                    ),
                                  )
                            : okeCourierController.destinationLocation.value.isEmpty
                                ? Text(
                                    'Pilih Tujuan...',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                    ),
                                  )
                                : Text(
                                    okeCourierController.destinationLocation.value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                    ),
                                  ),
                      ),
                      Obx(
                        () => isOriginSection
                            ? okeCourierController.originLocation.value.isEmpty
                                ? SizedBox()
                                : SizedBox(
                                    height: SizeConfig.safeBlockVertical * 5 / 7.2,
                                  )
                            : okeCourierController.destinationDetailLocation.value.isEmpty
                                ? SizedBox()
                                : SizedBox(
                                    height: SizeConfig.safeBlockVertical * 5 / 7.2,
                                  ),
                      ),
                      Obx(
                        () => isOriginSection
                            ? okeCourierController.originLocation.isEmpty
                                ? SizedBox()
                                : okeCourierController.originDetailLocation.value.isEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          print('tambahkan alamt detail');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.post_add,
                                              size: 15,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: SizeConfig.safeBlockHorizontal * 10 / 7.2,
                                            ),
                                            Text(
                                              'Tambahkan detail alamat disini',
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        okeCourierController.originDetailLocation.value,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                            : okeCourierController.destinationLocation.isEmpty
                                ? SizedBox()
                                : okeCourierController.destinationDetailLocation.value.isEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          print('tambahkan tujuan alamt detail');
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.post_add,
                                              size: 15,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: SizeConfig.safeBlockHorizontal * 10 / 7.2,
                                            ),
                                            Text(
                                              'Tambahkan detail tujuan disini',
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        okeCourierController.destinationDetailLocation.value,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                      ),
                    ],
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
