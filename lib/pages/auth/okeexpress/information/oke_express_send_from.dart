import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/okejek_theme.dart';
import 'package:okejek_flutter/defaults/size_config.dart';
import 'package:okejek_flutter/pages/auth/okeexpress/information/oke_express_send_to.dart';

class OkeExpressSendFrom extends StatelessWidget {
  final String provinsiAsal = '';
  final List provinsiList = [
    "DKI Jakarta",
    "Jawa Barat",
    "Jawa Tengah",
    "Jawa Timur",
  ];

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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Text(
                  'Asal',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 14 / 3.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 10 / 7.2,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: SizeConfig.safeBlockVertical * 50 / 7.2,
                      maxWidth: SizeConfig.safeBlockHorizontal * 50 / 3.6,
                    ),
                    prefixIcon: Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        VerticalDivider(
                          indent: 5,
                          endIndent: 5,
                        ),
                      ],
                    ),
                    hintText: 'Alamat asal',
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                ),
                DropdownButtonFormField(
                  hint: Text(
                    'Provinsi Asal',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                  ),
                  items: provinsiList.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                ),
                DropdownButtonFormField(
                  hint: Text(
                    'Kota Asal',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  items: provinsiList.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
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
                    hintText: 'Nama Pengirim',
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 20 / 7.2,
                ),
                TextField(
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
                    hintText: 'Nomor Telepon Pengirim',
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 100 / 7.2,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => OkeExpressSendTo(), transition: Transition.rightToLeft);
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
