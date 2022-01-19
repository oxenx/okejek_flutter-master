import 'dart:async';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:okejek_flutter/controller/auth/okeshop/detail_order_controller.dart';
import 'package:okejek_flutter/controller/auth/okeshop/map_destination_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/okeride/auto_complete_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class MapDestinationPage extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  final TextEditingController destTextController = TextEditingController();
  final MapDestinationController destinationController = Get.put(MapDestinationController());
  final DetailOrderShopController orderShopController = Get.find();
  final PanelController pc = PanelController();

  @override
  Widget build(BuildContext context) {
    LatLng cp = LatLng(destinationController.destLat.value, destinationController.destLat.value);
    print('current CP : $cp');
    Future.delayed(Duration(seconds: 1), () async {
      pc.open();
    });
    SizeConfig().init(context);

    return Scaffold(
      body: Obx(
        () => destinationController.isLoading.value
            ? Container(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SafeArea(
                child: SlidingUpPanel(
                  controller: pc,
                  isDraggable: false,
                  maxHeight: Get.height * 0.2,
                  minHeight: 0,
                  panel: Padding(
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
                    child: GestureDetector(
                      onTap: () {
                        print('open modal');
                        showModalLokasi(destinationController, pc);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
                                  color: Colors.grey[100],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 15 / 3.6),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.pin_drop_outlined,
                                        color: OkejekTheme.primary_color,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                                      ),
                                      Flexible(
                                        child: Obx(
                                          () => Text(
                                            destinationController.destLocation.value.isEmpty
                                                ? 'Lokasi Tujuan...'
                                                : destinationController.destLocation.value,
                                            style: TextStyle(
                                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                              color: Colors.black45,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            softWrap: true,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 20 / 7.56,
                          ),
                          confirmButton(orderShopController, destinationController),
                        ],
                      ),
                    ),
                  ),
                  body: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(destinationController.destLat.value, destinationController.destLng.value),
                          zoom: 16,
                        ),
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMove: (position) {
                          cp = position.target;
                        },
                      ),
                      Obx(
                        () => destinationController.isPickingFromMap.value
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BouncingWidget(
                                      onPressed: () {
                                        getCenterMap(cp);
                                      },
                                      duration: Duration(milliseconds: 100),
                                      scaleFactor: 1.5,
                                      child: Container(
                                        height: SizeConfig.safeBlockHorizontal * 40 / 3.6,
                                        width: SizeConfig.safeBlockHorizontal * 140 / 3.6,
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
                                ),
                              )
                            : Container(),
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  showModalLokasi(MapDestinationController destinationController, PanelController pc) {
    final _formKey = GlobalKey<FormState>();
    return showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      isDismissible: true,
      builder: (context) {
        return Form(
          key: _formKey,
          child: FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  TextFormField(
                    controller: destTextController,
                    validator: RequiredValidator(errorText: 'Alamat tidak boleh kosong'),
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        destinationController.isSubmitLocation.value = true;
                      } else {
                        destinationController.isSubmitLocation.value = false;
                      }
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Cari lokasi pasar...',
                      hintStyle: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        color: Colors.black54,
                      ),
                      prefixIcon: Icon(
                        Icons.store_outlined,
                        color: OkejekTheme.primary_color,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 20 / 3.6),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockVertical * 10 / 7.56,
                          horizontal: SizeConfig.safeBlockHorizontal * 20 / 3.6),
                    ),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 20 / 3.6,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        pc.close();
                        destinationController.isPickingFromMap.value = true;
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_searching,
                            ),
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                            ),
                            Text(
                              'Pilih lokasi dari map',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 20 / 3.6,
                  ),

                  // pickup fetch data
                  Obx(
                    () => destinationController.isSubmitLocation.value
                        ? FutureBuilder<List<AutoCompletePlace>>(
                            future: destinationController.getDestinationCoordinatesfromPlace(destTextController.text),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                // on fetch loading animation
                                return loadingAnimation();
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    AutoCompletePlace place = snapshot.data![index];

                                    // AutoCompletePlace place = AutoCompletePlace.fromJson(snapshot.data![index]);
                                    return ListView(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      children: [
                                        InkWell(
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            Navigator.pop(context);
                                            destTextController.text = place.address;
                                            destinationController.setDestinationAddress(place);
                                          },
                                          child: Container(
                                            height: Get.height * 0.08,
                                            width: Get.width,
                                            margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 20 / 3.6),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        place.name,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                                        ),
                                                      ),
                                                      Text(
                                                        place.address,
                                                        style: TextStyle(
                                                          fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget loadingAnimation() {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE7E7E7),
          Color(0xFFF4F4F4),
          Color(0xFFE7E7E7),
        ],
        stops: [
          0.4,
          0.5,
          0.6,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.8),
        tileMode: TileMode.clamp,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  SizeConfig.safeBlockHorizontal * 20 / 3.6,
                  SizeConfig.safeBlockHorizontal * 10 / 3.6,
                  SizeConfig.safeBlockHorizontal * 100 / 3.6,
                  SizeConfig.safeBlockHorizontal * 10 / 3.6),
              height: Get.height * 0.02,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  SizeConfig.safeBlockHorizontal * 20 / 3.6,
                  SizeConfig.safeBlockHorizontal * 10 / 3.6,
                  SizeConfig.safeBlockHorizontal * 30 / 3.6,
                  SizeConfig.safeBlockHorizontal * 30 / 3.6),
              height: Get.height * 0.015,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget confirmButton(DetailOrderShopController orderShopController, MapDestinationController destinationController) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          destinationController.destLocation.value.isEmpty
              ? print('do nothing')
              : confirm(orderShopController, destinationController);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: destinationController.destLocation.value.isEmpty ? Colors.grey : OkejekTheme.primary_color,
            borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
          ),
          width: Get.width,
          height: Get.height * 0.06,
          child: Center(
            child: Text(
              'Konfirmasi',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void confirm(DetailOrderShopController orderShopController, MapDestinationController destinationController) {
    destinationController.confirmAddress();
    Get.back();
  }

  void getCenterMap(LatLng latlng) {
    destinationController.isPickingFromMap.value = false;
    pc.open();
    print('********');
    if (latlng == LatLng(0.0, 0.0)) {
      latlng = LatLng(destinationController.destLat.value, destinationController.destLng.value);
    }
    print(latlng);

    destinationController.getDestinationPlacefromCoordinates(latlng.latitude, latlng.longitude);
  }
}
