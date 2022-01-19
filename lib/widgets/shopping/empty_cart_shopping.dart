import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class EmptyCartShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Belanja',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 3.89,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 8.3,
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.1),
              height: Get.height * 0.2,
              width: Get.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                  image: AssetImage('assets/images/empty_cart.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockHorizontal * 8.3,
            ),
            Container(
              child: Center(
                child: Text(
                  'Keranjang belanja kosong',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal * 3.89,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
            ),
            Center(
              child: Text(
                'Tambahkan beberapa barang yang ingin kamu beli dulu',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
