import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OkeExpressDataNotFound extends StatelessWidget {
  final String resiNumber;

  OkeExpressDataNotFound({
    required this.resiNumber,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: OkejekTheme.primary_color,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Track Order',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.safeBlockHorizontal * 20 / 3.6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.safeBlockHorizontal * 100 / 3.6,
              height: SizeConfig.safeBlockVertical * 100 / 7.2,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: SizeConfig.safeBlockHorizontal * 80 / 3.6,
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 20 / 7.2,
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 250 / 3.6,
              height: SizeConfig.safeBlockVertical * 30 / 7.2,
              child: Center(
                child: Text(
                  'Pesanan Tidak Ada',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 20 / 7.2,
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Transaksi dengan nomor resi ',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: resiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      ),
                    ),
                    TextSpan(
                      text: ' tidak ditemukan',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
