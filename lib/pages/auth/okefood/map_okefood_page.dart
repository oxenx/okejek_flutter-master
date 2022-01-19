import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/okefood/map_okefood_controller.dart';
import 'package:okejek_flutter/controller/auth/okefood/okefood_payment_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/food/map/map_food_panel.dart.dart';
import 'package:okejek_flutter/widgets/food/map/map_food_panel_shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class MapOkeFoodPage extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  final MapOkefoodController mapOkefoodController = Get.put(MapOkefoodController());
  final OkefoodPaymentController foodPaymentController = Get.find();
  final PanelController pc = PanelController();
  late LatLng cp = LatLng(mapOkefoodController.latitude.value, mapOkefoodController.longitude.value);

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-7.9615508, 112.6309772),
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1500), () {
      pc.open();
    });
    SizeConfig().init(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          bool isOpenMap = mapOkefoodController.isPickfromMap.value;
          if (isOpenMap) {
            pc.open();
            mapOkefoodController.isPickfromMap.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: Obx(
            () => SlidingUpPanel(
              controller: pc,
              isDraggable: false,
              maxHeight: mapOkefoodController.isPickfromMap.value ? 0 : Get.height * 0.2,
              minHeight: 0,
              panel: Obx(
                () => mapOkefoodController.isPickfromMap.value
                    ? Container()
                    : mapOkefoodController.isLoading.value
                        ? MapFoodPanelShimmer()
                        : MapFoodPanel(
                            panelController: pc,
                          ),
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kInitialPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (position) {
                      cp = position.target;
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
                    () => mapOkefoodController.isPickfromMap.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => getCenterMap(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 5 / 3.6,
                                      ),
                                      Text(
                                        'Pilih lokasi',
                                        style: TextStyle(
                                          fontSize: SizeConfig.blockSizeHorizontal * 10 / 3.6,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  width: SizeConfig.safeBlockHorizontal * 110 / 3.6,
                                  height: SizeConfig.safeBlockHorizontal * 40 / 3.6,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                              ),
                              Center(
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 80 / 3.6,
                                  height: SizeConfig.safeBlockHorizontal * 80 / 3.6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/icons/markers/pin.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getCenterMap() async {
    // to get coordinate center of map
    print('get center of map');
    pc.open();
    print(cp);
    mapOkefoodController.isPickfromMap.value = false;
    mapOkefoodController.getDestinationPlacefromCoordinates(cp.latitude, cp.longitude);
  }
}
