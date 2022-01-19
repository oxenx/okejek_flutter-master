import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/okecourier/panel/okecourier_location_result.dart';
import 'package:okejek_flutter/widgets/okecourier/panel/okecourier_location_search.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OkeCourierPick extends StatelessWidget {
  final Completer<GoogleMapController> mapcontroller;

  final PanelController pc;

  OkeCourierPick({
    required this.pc,
    required this.mapcontroller,
  });
  final formKey = GlobalKey<FormState>();
  final OkeCourierController okeCourierController = Get.find();
  bool get isOriginSection => okeCourierController.isOriginSection.value;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: isOriginSection ? Colors.orange : OkejekTheme.primary_color,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                OkeCourierLocationSearch(
                  formKey: formKey,
                  pc: pc,
                  isOriginSection: isOriginSection,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 30 / 7.2,
                ),
                OkeCourierLocationResult(
                  completerController: mapcontroller,
                  isOriginSection: isOriginSection,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
