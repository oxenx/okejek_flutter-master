import 'dart:async';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/okecourier/okecourier_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class OkeCourierMap extends StatelessWidget {
  LatLng cp;
  final PanelController panelController;
  OkeCourierMap({
    required this.cp,
    required this.panelController,
    required this.controller,
  });

  final Completer<GoogleMapController> controller;
  final OkeCourierController okeCourierController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            zoom: 16.0,
            target: LatLng(
              okeCourierController.originLat.value,
              okeCourierController.originLng.value,
            ),
          ),
          myLocationEnabled: false,
          compassEnabled: false,
          onCameraMove: (position) {
            cp = position.target;
          },
          onMapCreated: (GoogleMapController gcontroller) {
            controller.complete(gcontroller);
          },
        ),
        Positioned(
          top: SizeConfig.blockSizeVertical * 1.3,
          left: SizeConfig.blockSizeHorizontal * 2.78,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: SizeConfig.blockSizeVertical * 5.2,
              width: SizeConfig.blockSizeHorizontal * 11.1,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: OkejekTheme.primary_color,
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Center(
            child: okeCourierController.isOriginPickingFromMap.value ||
                    okeCourierController.isDestionationPickingFromMap.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BouncingWidget(
                        onPressed: () => getCenterMap(cp),
                        duration: Duration(milliseconds: 100),
                        scaleFactor: 1.5,
                        child: Container(
                          height: SizeConfig.safeBlockHorizontal * 40 / 3.6,
                          width: SizeConfig.safeBlockHorizontal * 120 / 3.6,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                ),
                                Text(
                                  'Pilih lokasi ini',
                                  style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                      ),
                      Container(
                        width: SizeConfig.safeBlockHorizontal * 80 / 3.6,
                        height: SizeConfig.safeBlockHorizontal * 80 / 3.6,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/markers/pin.png'),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ),
      ],
    );
  }

  void getCenterMap(LatLng cp) async {
    // to get coordinate center of map

    bool isPickOriginMap = okeCourierController.isOriginPickingFromMap.value;

    if (isPickOriginMap) {
      print(cp);
      okeCourierController.getOriginPlacefromCoordinates(cp.latitude, cp.longitude);
      okeCourierController.isOriginPickingFromMap.value = false;
      panelController.open();
    } else {
      print(cp);
      okeCourierController.getDestinationPlacefromCoordinates(cp.latitude, cp.longitude);
      okeCourierController.isDestionationPickingFromMap.value = false;
      panelController.open();
    }
  }
}
