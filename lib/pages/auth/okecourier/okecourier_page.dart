import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/okecourier/panel/okecourier_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OkeCourierPage extends StatelessWidget {
  final OkeCourierController okeCourierController = Get.put(OkeCourierController());
  final PanelController pc = PanelController();
  final formKey = GlobalKey<FormState>();
  final Completer<GoogleMapController> mapcontroller = Completer();

  final TextEditingController namaPengirimController = TextEditingController();
  final TextEditingController namaPenerimaController = TextEditingController();
  final TextEditingController noHPPengirimController = TextEditingController();
  final TextEditingController noHPPenerimaController = TextEditingController();
  final TextEditingController detailBarangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Future.delayed(Duration(milliseconds: 1800), () {
      if (okeCourierController.preload.value) {
        pc.open();
        okeCourierController.preload.value = false;
      }
    });

    LatLng cp = LatLng(okeCourierController.originLat.value, okeCourierController.originLng.value);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return willPopPage();
        },
        child: Form(
          key: formKey,
          child: SafeArea(
            child: OkeCourierPanel(
              namaPenerimaController: namaPenerimaController,
              detailBarangController: detailBarangController,
              namaPengirimController: namaPengirimController,
              noHPPengirimController: noHPPengirimController,
              noHPPenerimaController: noHPPenerimaController,
              mapcontroller: mapcontroller,
              pc: pc,
              cp: cp,
              formKey: formKey,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> willPopPage() async {
    bool willPop = false;
    bool isOpenMap =
        okeCourierController.isOriginPickingFromMap.value || okeCourierController.isDestionationPickingFromMap.value;
    bool isOriginSection = okeCourierController.isOriginSection.value;
    if (isOriginSection) {
      willPop = true;
    } else {
      if (okeCourierController.showSummary.value) {
        return willPop = true;
      } else {
        pc.close();
        await Future.delayed(Duration(seconds: 1), () {
          print('EXCUTE');
          okeCourierController.isOriginSection.value = true;
          pc.open();
        });
        return willPop = false;
      }
    }

    if (isOpenMap) {
      okeCourierController.isOriginPickingFromMap.value = false;
      okeCourierController.isDestionationPickingFromMap.value = false;
      pc.open();
      willPop = false;
    } else {
      willPop = true;
    }

    print(willPop);
    return willPop;
  }
}
