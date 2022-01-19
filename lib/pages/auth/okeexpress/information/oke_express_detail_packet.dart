import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/oke_express_detail_order.dart';

class OkeExpressDetailPacket extends StatelessWidget {
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
          'Kirim Barang',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 16 / 3.6,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Text(
                  'Detail Paket',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10 / 7.2,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Berat (max 5kg)',
                          hintStyle: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Berat (max 5kg)',
                          hintStyle: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10 / 7.2,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Lebar',
                          hintStyle: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Tinggi',
                          hintStyle: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10 / 7.2,
                ),
                TextField(
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    hintText: 'Isi Paket',
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10 / 7.2,
                ),
                TextField(
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    hintText: 'Nilai Barang',
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.28,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => OkeExpressDetailOrder(), transition: Transition.rightToLeft);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: OkejekTheme.primary_color,
                    fixedSize: Size(Get.width, SizeConfig.safeBlockVertical * 40 / 7.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 20 / 3.6),
                    ),
                  ),
                  child: Text(
                    'Lanjut',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
}
