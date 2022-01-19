import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class ShoppingMapRoute extends StatelessWidget {
  const ShoppingMapRoute({
    Key? key,
    required CameraPosition kInitialPosition,
    required Completer<GoogleMapController> controller,
  })  : _kInitialPosition = kInitialPosition,
        _controller = controller,
        super(key: key);

  final CameraPosition _kInitialPosition;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    DetailOrderShopController detailShopController = Get.find();
    return Column(
      children: [
        Container(
          height: Get.height * 0.25,
          width: Get.width,
          child: GoogleMap(
            mapType: MapType.normal,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _kInitialPosition,
            markers: Set<Marker>.of(detailShopController.markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
        ),
      ],
    );
  }
}
