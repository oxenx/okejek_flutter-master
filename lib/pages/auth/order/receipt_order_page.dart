import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/order/order_receipt_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';
import 'package:okejek_flutter/widgets/order/receipt/driver_info.dart';
import 'package:okejek_flutter/widgets/order/receipt/receipt.dart';

class ReceiptOrderDetail extends StatelessWidget {
  final Order order;

  ReceiptOrderDetail({
    required this.order,
  });

  final OrderReceiptController orderController = Get.find();
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  final DateFormat formattedDate = DateFormat('dd-MM-yyyy – kk:mm');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
            orderController.resetController();
          },
          icon: Icon(
            Icons.arrow_back,
            color: OkejekTheme.primary_color,
          ),
        ),
        title: Text(
          'Pesanan Selesai',
          style: TextStyle(
            fontFamily: OkejekTheme.font_family,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 20 / 3.6),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DriverInfo(order: order),
                    Divider(),
                    Receipt(order: order),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
