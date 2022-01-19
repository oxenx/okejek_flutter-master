import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/order/order_inprogress_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';
import 'package:okejek_flutter/widgets/order/detail/order_detail.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timelines/timelines.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  OrderDetailPage({
    required this.order,
  });

  final Completer<GoogleMapController> _controller = Completer();
  final PanelController _pc = new PanelController();

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-7.9826145, 112.6286226),
    zoom: 14.0,
  );
  @override
  Widget build(BuildContext context) {
    OrderInProgressController orderController = Get.find();
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SlidingUpPanel(
              controller: _pc,
              minHeight: Get.height * 0.4,
              maxHeight: Get.height * 0.85,
              isDraggable: false,
              body: GoogleMap(
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kInitialPosition,
                markers: orderController.setMarker(),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              panel: slidingPanel(orderController, context),
            ),
            Positioned(
              top: 10,
              left: 0,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: SizeConfig.blockSizeHorizontal * 10,
                  width: SizeConfig.blockSizeVertical * 10,
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
    );
  }

  Widget slidingPanel(OrderInProgressController orderController, BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.safeBlockHorizontal * 20 / 3.6,
          SizeConfig.safeBlockHorizontal * 10 / 3.6,
          SizeConfig.safeBlockHorizontal * 20 / 3.6,
          SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Obx(
            () => ListView(
              physics: orderController.showMore.value ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 20 / 7.56,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.safeBlockVertical * 30 / 3.6,
                          width: SizeConfig.safeBlockHorizontal * 30 / 3.6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: order.type == 0
                                    ? AssetImage('assets/icons/10-2021/ride.png')
                                    : order.type == 1
                                        ? AssetImage('assets/icons/10-2021/courier.png')
                                        : order.type == 2
                                            ? AssetImage('assets/icons/10-2021/shopping.png')
                                            : order.type == 3
                                                ? AssetImage('assets/icons/10-2021/food.png')
                                                : order.type == 4
                                                    ? AssetImage('assets/icons/10-2021/car.png')
                                                    : order.type == 100
                                                        ? AssetImage('assets/icons/10-2021/mart.png')
                                                        : order.type == 102
                                                            ? AssetImage('assets/icons/10-2021/trike.png')
                                                            : AssetImage('assets/icons/10-2021/trike_courier.png')),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.type == 0
                                  ? 'OkeRide'
                                  : order.type == 1
                                      ? 'Kurir'
                                      : order.type == 2
                                          ? 'Belanja'
                                          : order.type == 3
                                              ? 'Oke Food'
                                              : order.type == 4
                                                  ? 'Oke Car'
                                                  : order.type == 100
                                                      ? 'Oke Mart'
                                                      : order.type == 102
                                                          ? 'Ojek Roda 3'
                                                          : 'Kurir Barang',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                            ),
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                              width: SizeConfig.safeBlockHorizontal * 125 / 3.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Text(
                                  order.status == 0
                                      ? 'Sedang Mencari Driver'
                                      : order.status == 1
                                          ? 'Sedang Menjemput/Membeli'
                                          : order.status == 2
                                              ? 'Menuju Lokasi'
                                              : order.status == 10
                                                  ? 'Menunggu Merchant'
                                                  : 'Menunggu Pembayaran',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      order.payment == null ? '-' : currencyFormatter.format(order.payment!.amount),
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                FixedTimeline.tileBuilder(
                  builder: TimelineTileBuilder.connected(
                    itemCount: 2,
                    nodePositionBuilder: (context, index) => 0.0,
                    connectorBuilder: (context, index, type) {
                      return SizedBox(
                        height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        child: DashedLineConnector(
                          color: Colors.grey[300],
                        ),
                      );
                    },

                    // text location
                    contentsBuilder: (context, index) {
                      return index == 0
                          ? Padding(
                              padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 8 / 3.6),
                              child: Text(
                                order.originAddress.isEmpty ? '-' : order.originAddress,
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 11 / 3.6,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 8 / 3.6),
                              child: Text(
                                order.destinationAddress.isEmpty ? '-' : order.destinationAddress,
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 11 / 3.6,
                                  color: Colors.black54,
                                ),
                              ),
                            );
                    },

                    // icon location
                    indicatorBuilder: (context, index) {
                      return index == 0
                          ? Container(
                              height: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                              width: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                  right: SizeConfig.safeBlockHorizontal * 10 / 3.6),
                              child: Icon(
                                Icons.store,
                                color: OkejekTheme.primary_color,
                              ),
                            )
                          : Container(
                              height: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                              width: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                                  right: SizeConfig.safeBlockHorizontal * 10 / 3.6),
                              child: Icon(
                                Icons.pin_drop_outlined,
                                color: OkejekTheme.primary_color,
                              ),
                            );
                    },
                  ),
                ),

                // call and chat button
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 1.0,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 18 / 3.6),
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: OkejekTheme.primary_color,
                            size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                          ),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                          ),
                          Text(
                            'Call',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              color: OkejekTheme.primary_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 1.0,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 18 / 3.6),
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: OkejekTheme.primary_color,
                            size: SizeConfig.safeBlockHorizontal * 15 / 3.6,
                          ),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                              color: OkejekTheme.primary_color,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                ),

                // show more
                Obx(
                  () => orderController.showMore.value
                      ? TextButton(
                          onPressed: () {
                            orderController.showMore.value = false;
                            _pc.close();
                          },
                          child: Text(
                            'Lihat lebih sedikit',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                              fontWeight: FontWeight.bold,
                              color: OkejekTheme.primary_color,
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            orderController.showMore.value = true;
                            _pc.open();
                          },
                          child: Text(
                            'Lihat lebih banyak',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                              color: OkejekTheme.primary_color,
                            ),
                          ),
                        ),
                ),
                Divider(),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                ),
                Obx(
                  () => orderController.showMore.value
                      ? OrderDetail(
                          order: order,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
