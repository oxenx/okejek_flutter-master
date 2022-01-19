import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';
import 'package:okejek_flutter/models/item_model.dart';
import 'package:timelines/timelines.dart';

class Receipt extends StatelessWidget {
  final Order order;
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);

  Receipt({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rincianBarang(),
        rincianPesanan(),
      ],
    );
  }

  Widget rincianBarang() {
    return order.items.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
              ),
              Text(
                'Rincian Barang',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {
                    Item item = Item.fromJson(order.items[index]);
                    double price = double.parse(item.price);
                    num subtotal = price * item.qty;

                    return Container(
                      margin: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockHorizontal * 20 / 3.6,
                      ),
                      width: Get.width,
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        item.qty.toString(),
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    currencyFormatter.format(subtotal),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
              order.items.length == 0
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Subtotal : ',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                        Text(
                          currencyFormatter.format(double.parse(order.totalShopping)),
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 15 / 3.6,
              ),
              Divider(),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 15 / 3.6,
              ),
            ],
          );
  }

  Widget rincianPesanan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rincian Pesanan',
          style: TextStyle(
            color: Colors.black87,
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
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
                                                  : AssetImage('assets/icons/10-2021/trike_courier.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                ),
                Text(
                  order.type == 0
                      ? 'Ride'
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
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              currencyFormatter.format(order.payment!.amount),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: FixedTimeline.tileBuilder(
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
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          order.originAddress,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          order.destinationAddress,
                          style: TextStyle(
                            fontSize: 11,
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
        ),

        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ongkir : ',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
            ),
            Text(
              currencyFormatter.format(double.parse(order.fee)),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),

        // diskon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Diskon : ',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                color: Colors.green,
              ),
            ),
            Text(
              '- ' + currencyFormatter.format(order.discount),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                color: Colors.green,
              ),
            ),
          ],
        ),

        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),

        // belanja
        order.items.length == 0
            ? Container()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Belanja : ',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        ),
                      ),
                      Text(
                        currencyFormatter.format(double.parse(order.totalShopping)),
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                  ),
                ],
              ),

        //total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total : ',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
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
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
        ),
      ],
    );
  }
}
