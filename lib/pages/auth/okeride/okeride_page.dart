import 'dart:async';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/okeride_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/widgets/okeride/destination_modal.dart';
import 'package:okejek_flutter/widgets/okeride/origin_modal.dart';
import 'package:okejek_flutter/widgets/okeride/payment_ride.dart';
import 'package:okejek_flutter/widgets/okeride/service_floating_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timelines/timelines.dart';

// ignore: must_be_immutable
class OkeRidePage extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();
  final OkeRideController okeRideController = Get.put(OkeRideController());
  final PanelController _pc = PanelController();

  late LatLng cp = LatLng(okeRideController.originLat.value, okeRideController.originLng.value);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Future.delayed(Duration(seconds: 2), () {
      _pc.open();
    });
    okeRideController.getCurrentPositionCamera();
    okeRideController.getNearestDriver();
    cp = LatLng(okeRideController.originLat.value, okeRideController.originLng.value);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          bool isOpenMap = okeRideController.isPickingfromMap.value;
          if (isOpenMap) {
            okeRideController.isPickingfromMap.value = false;
            _pc.open();
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              Obx(
                () => SlidingUpPanel(
                  controller: _pc,
                  body: GetBuilder<OkeRideController>(
                    builder: (okeRideController) {
                      return Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              zoom: 16.0,
                              target: LatLng(
                                okeRideController.initLat,
                                okeRideController.initLng,
                              ),
                            ),
                            myLocationEnabled: true,
                            markers: okeRideController.setMarker(),
                            compassEnabled: false,
                            onCameraMove: (position) {
                              cp = position.target;
                            },
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              okeRideController.getNearestDriver();
                            },
                          ),
                          Center(
                            child: okeRideController.isPickingfromMap.value
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BouncingWidget(
                                        onPressed: () => getCenterMap(),
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
                        ],
                      );
                    },
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  isDraggable: false,
                  maxHeight: Get.height * okeRideController.heightFactor.value,
                  minHeight: 0,
                  panel: okeRideController.isPickingfromMap.value
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Center(
                                child: Obx(
                                  () => Text(
                                    okeRideController.originLocation.value.isNotEmpty &&
                                            okeRideController.destLocation.value.isNotEmpty
                                        ? ''
                                        : 'Mau kemana hari ini?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                                    ),
                                  ),
                                ),
                              ),
                              okeRideController.originLocation.value.isNotEmpty &&
                                      okeRideController.destLocation.value.isNotEmpty
                                  ? SizedBox()
                                  : SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                              FixedTimeline.tileBuilder(
                                builder: TimelineTileBuilder.connected(
                                  itemCount: 2,
                                  nodePositionBuilder: (context, index) => 0.0,
                                  connectorBuilder: (context, index, type) {
                                    return SizedBox(
                                      height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 10 / 3.6),
                                        child: DashedLineConnector(
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    );
                                  },

                                  // text location
                                  contentsBuilder: (context, index) {
                                    return index == 0
                                        ? OriginModal(
                                            completerController: _controller,
                                            pc: _pc,
                                          )
                                        : DestinationModal(
                                            completerController: _controller,
                                            pc: _pc,
                                          );
                                  },

                                  // icon location
                                  indicatorBuilder: (context, index) {
                                    return index == 0
                                        ? Container(
                                            height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                                            width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.orange,
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                                right: SizeConfig.safeBlockHorizontal * 10 / 3.6),
                                            child: Icon(
                                              Icons.pedal_bike,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Container(
                                            height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                                            width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: OkejekTheme.primary_color,
                                            ),
                                            margin: EdgeInsets.only(
                                                top: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                                right: SizeConfig.safeBlockHorizontal * 10 / 3.6),
                                            child: Icon(
                                              Icons.pin_drop_outlined,
                                              color: Colors.white,
                                            ),
                                          );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              PaymentSectionRide(),
                            ],
                          ),
                        ),
                ),
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
                () => okeRideController.isLoading.value
                    ? Container(
                        height: Get.height,
                        width: Get.width,
                        color: Colors.black.withOpacity(0.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitFadingCircle(
                              color: Color(0xFFE7746A),
                              size: SizeConfig.safeBlockHorizontal * 50 / 3.6,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Obx(() => okeRideController.isPickingfromMap.value ? SizedBox() : ServiceFloatingButton()),
            ],
          ),
        ),
      ),
    );
  }

  void getCenterMap() async {
    // to get coordinate center of map

    print(cp);
    okeRideController.isPickingfromMap.value = false;

    if (okeRideController.destinationMapPick.value) {
      okeRideController.getDestinationPlacefromCoordinates(cp.latitude, cp.longitude);
      okeRideController.destinationMapPick.value = false;
      _pc.open();
    } else {
      okeRideController.getOriginPlacefromCoordinates(cp.latitude, cp.longitude);
      okeRideController.originMapPick.value = false;
      _pc.open();
    }
  }
}
