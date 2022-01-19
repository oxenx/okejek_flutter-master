import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/okecourier/okecourier_map.dart';
import 'package:okejek_flutter/widgets/okecourier/okecourier_payment_panel.dart';
import 'package:okejek_flutter/widgets/okecourier/panel/okecourier_panel_detail.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OkeCourierPanel extends StatelessWidget {
  final PanelController pc;
  final LatLng cp;
  final Completer<GoogleMapController> mapcontroller;
  final GlobalKey<FormState> formKey;
  final TextEditingController namaPengirimController;
  final TextEditingController namaPenerimaController;
  final TextEditingController noHPPengirimController;
  final TextEditingController noHPPenerimaController;
  final TextEditingController detailBarangController;

  OkeCourierPanel({
    required this.pc,
    required this.cp,
    required this.formKey,
    required this.mapcontroller,
    required this.namaPenerimaController,
    required this.namaPengirimController,
    required this.detailBarangController,
    required this.noHPPengirimController,
    required this.noHPPenerimaController,
  });

  final OkeCourierController okeCourierController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => SlidingUpPanel(
        controller: pc,
        isDraggable: false,
        minHeight: 0,
        maxHeight: okeCourierController.showSummary.value
            ? SizeConfig.safeBlockVertical * 500 / 7.2
            : okeCourierController.isOriginSection.value
                ? SizeConfig.safeBlockVertical * 410 / 7.2
                : SizeConfig.safeBlockVertical * 350 / 7.2,
        panel: okeCourierController.showSummary.value
            ? OkeCourierPaymentPanel(
                pc: pc,
                detailBarangController: detailBarangController,
                namaPenerimaController: namaPenerimaController,
                namaPengirimController: namaPengirimController,
                noHPPenerimaController: noHPPenerimaController,
                noHPPengirimController: noHPPengirimController,
              )
            : OkeCourierPanelDetail(
                mapcontroller: mapcontroller,
                namaPenerimaController: namaPenerimaController,
                detailBarangController: detailBarangController,
                namaPengirimController: namaPengirimController,
                noHPPengirimController: noHPPengirimController,
                noHPPenerimaController: noHPPenerimaController,
                pc: pc,
                formKey: formKey,
              ),
        body: OkeCourierMap(
          cp: cp,
          panelController: pc,
          controller: mapcontroller,
        ),
      ),
    );
  }
}
