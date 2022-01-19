import 'package:flutter/material.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OrderPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kurir',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
            ),
            Text(
              'Rp6.000',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'OkeExpress',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
            ),
            Text(
              'Rp15.000',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Diskon',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
            ),
            Text(
              'Rp5.000',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kupon',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
            ),
            Text(
              'KIRIMTERUS',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: SizeConfig.safeBlockVertical * 40 / 7.2,
              width: SizeConfig.safeBlockHorizontal * 150 / 3.6,
              decoration: BoxDecoration(
                border: Border.all(
                  color: OkejekTheme.primary_color,
                ),
                borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 10 / 3.6),
              ),
              child: Center(
                child: Text(
                  'Tambahkan Kupon',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                    color: OkejekTheme.primary_color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
              ),
            ),
            Text(
              'Rp16.000',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Metode Pembayaran',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'LinkAja',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 100 / 7.2,
        ),
      ],
    );
  }
}
