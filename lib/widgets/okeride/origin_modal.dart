import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:okejek_flutter/controller/okeride_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/okeride/origin_search_header_modal.dart';
import 'package:okejek_flutter/widgets/okeride/origin_search_result_modal.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// Menampilakan sebuah modal / dialog destinasti penjemputan
class OriginModal extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final Completer<GoogleMapController> completerController;
  final PanelController pc;
  OriginModal({
    required this.completerController,
    required this.pc,
  });

  final OkeRideController okeRideController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        showPickUpModal(okeRideController);
      },
      child: Container(
        height: Get.height * 0.08,
        width: Get.width * 0.65,
        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeHorizontal * 2.7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: okeRideController.originLocation.value.isEmpty ? Colors.grey[50] : Colors.white,
        ),
        child: Obx(
          () => Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2.7,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  okeRideController.originLocation.value.isEmpty
                      ? 'Atur lokasi penjemputan kamu'
                      : okeRideController.originLocation.value,
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  softWrap: true,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
                Obx(
                  () => okeRideController.originLocationDetail.value.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                ),
                Obx(
                  () => okeRideController.originLocationDetail.value.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            print('tambah detail alamat penjemputan');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * 5 / 7.2,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.post_add,
                                  color: Colors.black45,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 5 / 3.6,
                                ),
                                Text(
                                  'Tambahkan detail alamat disini',
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
                          ),
                        )
                      : Text(
                          okeRideController.originLocationDetail.value,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showPickUpModal(OkeRideController controller) {
    return showMaterialModalBottomSheet(
      context: Get.context!,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Form(
          key: _formKey,
          child: FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              padding: EdgeInsets.all(20),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: Column(
                  children: [
                    OriginSearchHeaderModal(
                      formKey: _formKey,
                      pc: pc,
                    ),
                    OriginSearchResultModal(completerController: completerController),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
