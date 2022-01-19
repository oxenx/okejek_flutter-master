import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/controller/auth/order/order_receipt_controller.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/models/auth/order_model.dart';

class DriverInfo extends StatelessWidget {
  final Order order;

  DriverInfo({required this.order});

  final OrderReceiptController orderController = Get.find();
  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp', decimalDigits: 0);
  final DateFormat formattedDate = DateFormat('dd-MM-yyyy – kk:mm');
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order: ',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
            ),
            Text(
              order.id.toString(),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 10 / 7.56,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Waktu: ',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
            ),
            Text(
              formattedDate.format(order.createdAt),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 30 / 7.56,
        ),
        // driver info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Container(
                    height: SizeConfig.safeBlockHorizontal * 45 / 3.6,
                    width: SizeConfig.safeBlockHorizontal * 45 / 3.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/icons/10-2021/driver.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                  ),
                  Flexible(
                    child: Text(
                      order.driver != null ? order.driver!.name : '-',
                      style: TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                order.driver != null ? order.driver!.vehiclePlate : '-',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: SizeConfig.safeBlockVertical * 30 / 7.56,
        ),
        Text(
          'Rating',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.56,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 10 / 7.56,
        ),
        Text(
          'Beri rating untuk driver: ',
          style: TextStyle(
            color: Colors.black54,
            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          ),
        ),

        SizedBox(height: SizeConfig.blockSizeVertical * 12 / 7.56),
        // rating
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          direction: Axis.horizontal,
          children: [
            Obx(
              () => GestureDetector(
                onTap: () {
                  orderController.changeValue(orderController.kecepatan);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: SizeConfig.safeBlockVertical * 40 / 7.56,
                  width: SizeConfig.safeBlockHorizontal * 100 / 3.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: orderController.kecepatan.value ? OkejekTheme.primary_color : Colors.white,
                    border: Border.all(
                      color: OkejekTheme.primary_color,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Kecepatan',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        color: orderController.kecepatan.value ? Colors.white : OkejekTheme.primary_color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () {
                  orderController.changeValue(orderController.ketepatan);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: SizeConfig.safeBlockVertical * 40 / 7.56,
                  width: SizeConfig.safeBlockHorizontal * 100 / 3.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 40 / 3.6),
                    color: orderController.ketepatan.value ? OkejekTheme.primary_color : Colors.white,
                    border: Border.all(
                      color: OkejekTheme.primary_color,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Ketepatan',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        color: orderController.ketepatan.value ? Colors.white : OkejekTheme.primary_color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () {
                  orderController.changeValue(orderController.keramahan);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: SizeConfig.safeBlockVertical * 40 / 7.56,
                  width: SizeConfig.safeBlockHorizontal * 100 / 3.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 40 / 3.6),
                    color: orderController.keramahan.value ? OkejekTheme.primary_color : Colors.white,
                    border: Border.all(
                      color: OkejekTheme.primary_color,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Keramahan',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        color: orderController.keramahan.value ? Colors.white : OkejekTheme.primary_color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: SizeConfig.safeBlockVertical * 30 / 7.56,
        ),

        Text(
          'Komentar untuk driver: ',
          style: TextStyle(color: Colors.black54, fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 10 / 7.56,
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
              borderSide: BorderSide(color: OkejekTheme.primary_color),
            ),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 3, //Normal textInputField will be displayed
          maxLines: 3,
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            color: Colors.black54,
          ), // when user presses enter it will adapt to it
        ),

        SizedBox(
          height: SizeConfig.blockSizeVertical * 30 / 7.56,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: OkejekTheme.primary_color,
            minimumSize: Size(Get.width, SizeConfig.safeBlockVertical * 40 / 7.56),
          ),
          onPressed: () {
            showSnackbar();
            orderController.resetController();
            Get.back();
          },
          child: Text(
            'Kirim Rating',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 30 / 7.56,
        ),
      ],
    );
  }

  showSnackbar() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          'Rating telah diberikan',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
          ),
        ),
      ),
    );
  }
}
