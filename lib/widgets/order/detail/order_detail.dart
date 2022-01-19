import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/order/order_inprogress_controller.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';
import 'package:okejek_flutter/models/item_model.dart';

class OrderDetail extends StatelessWidget {
  final Order order;

  OrderDetail({required this.order});
  final OrderInProgressController controller = Get.find();

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rincianBarang(),

        rincianPesanan(),

        // button
        order.status == 0 || order.status == 1
            ? ElevatedButton(
                onPressed: () {
                  showAlertDialog();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.white,
                  minimumSize: Size(Get.width, 50),
                ),
                child: Text(
                  'Batalkan Pesanan',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(),

        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
        ),
      ],
    );
  }

  Widget rincianBarang() {
    return order.items.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              // list item if exist
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  Item item = Item.fromJson(order.items[index]);
                  double subTotal = double.parse(item.price) * item.qty.toDouble();

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
                                  currencyFormatter.format(subTotal),
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
                },
              ),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),

              // sub total belanja
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
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 30 / 3.6,
              ),
              Divider(),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
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
          height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
        ),

        // ongkir
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diskon : ',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
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
          ],
        ),

        // total belanja
        order.items.length == 0
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),

        Divider(),

        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
      ],
    );
  }

  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Tidak",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Batalkan",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        controller.cancelOrder(order.id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Batalkan"),
      content: Text(
        "Kamu yakin ingin membatalkan pesanan ini?",
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
